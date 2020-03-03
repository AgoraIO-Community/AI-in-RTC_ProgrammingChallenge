(function(window){

	// Defaults
	var SERVER = "ws://bark.phon.ioc.ee:82/dev/duplex-speech-api/ws/speech";
	var SERVER_STATUS = "ws://bark.phon.ioc.ee:82/dev/duplex-speech-api/ws/status";
	var REFERENCE_HANDLER = "http://bark.phon.ioc.ee:82/dev/duplex-speech-api/dynamic/reference";
	var CONTENT_TYPE = 'Content-type=' + encodeURIComponent('audio/wav; samplerate=16000');
	// Send blocks 4 x per second as recommended in the server doc.
	var INTERVAL = 250;
	var TAG_END_OF_SENTENCE = "";
	var RECORDER_WORKER_PATH = 'recorderWorker.js';

	// Error codes (mostly following Android error names and codes)
	var ERR_NETWORK = 2;
	var ERR_AUDIO = 3;
	var ERR_SERVER = 4;
	var ERR_CLIENT = 5;

	// Event codes
	var MSG_WAITING_MICROPHONE = 1;
	var MSG_MEDIA_STREAM_CREATED = 2;
	var MSG_INIT_RECORDER = 3;
	var MSG_RECORDING = 4;
	var MSG_SEND = 5;
	var MSG_SEND_EMPTY = 6;
	var MSG_SEND_EOS = 7;
	var MSG_WEB_SOCKET = 8;
	var MSG_WEB_SOCKET_OPEN = 9;
	var MSG_WEB_SOCKET_CLOSE = 10;
	var MSG_STOP = 11;
	var MSG_SERVER_CHANGED = 12;

	// Server status codes
	// from https://github.com/alumae/kaldi-gstreamer-server
	var SERVER_STATUS_CODE = {
		0: 'Success', // Usually used when recognition results are sent
		1: 'No speech', // Incoming audio contained a large portion of silence or non-speech
		2: 'Aborted', // Recognition was aborted for some reason
		9: 'No available', // Recognizer processes are currently in use and recognition cannot be performed
	};

	var Dictate = function(cfg) {
		var config = cfg || {};
		config.server = config.server || SERVER;
		config.audioSourceId = config.audioSourceId;
		config.serverStatus = config.serverStatus || SERVER_STATUS;
		config.referenceHandler = config.referenceHandler || REFERENCE_HANDLER;
		config.contentType = config.contentType || CONTENT_TYPE;
		config.interval = config.interval || INTERVAL;
		config.recorderWorkerPath = config.recorderWorkerPath || RECORDER_WORKER_PATH;
		config.onReadyForSpeech = config.onReadyForSpeech || function() {};
		config.onEndOfSpeech = config.onEndOfSpeech || function() {};
		config.onPartialResults = config.onPartialResults || function(data) {};
		config.onResults = config.onResults || function(data) {};
		config.onEndOfSession = config.onEndOfSession || function() {};
		config.onEvent = config.onEvent || function(e, data) {};
		config.onError = config.onError || function(e, data) {};
		config.rafCallback = config.rafCallback || function(time) {};
		if (config.onServerStatus) {
			monitorServerStatus();
		}

		// Initialized by init()
		var audioContext;
		var recorder;
		// Initialized by startListening()
		var ws;
		var intervalKey;
		// Initialized during construction
		var wsServerStatus;
		var self = this ;
		// Returns the configuration
		this.getConfig = function() {
			return config;
		}

		// Set up the recorder (incl. asking permission)
		// Initializes audioContext
		// Can be called multiple times.
		// TODO: call something on success (MSG_INIT_RECORDER is currently called)
		this.init = function() {
			var audioSourceConstraints = {};
			config.onEvent(MSG_WAITING_MICROPHONE, "Waiting for approval to access your microphone ...");
			try {
				window.AudioContext = window.AudioContext || window.webkitAudioContext;
				window.URL = window.URL || window.webkitURL;
				audioContext = new AudioContext();
			} catch (e) {
				// Firefox 24: TypeError: AudioContext is not a constructor
				// Set media.webaudio.enabled = true (in about:config) to fix this.
				config.onError(ERR_CLIENT, "Error initializing Web Audio browser: " + e);
			}
			if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
				if(config.audioSourceId) {
					audioSourceConstraints.audio = {
						optional: [{ sourceId: config.audioSourceId }]
					};
				} else {
					audioSourceConstraints.audio = true;
				}
				navigator.mediaDevices.getUserMedia(audioSourceConstraints).then(
					function(mediaStream){
						startUserMedia(mediaStream)
					}
				).catch(
					function(e) {
					config.onError(ERR_CLIENT, "No live audio input in this browser: " + e);
				}
				);
			} else {
				alert("No user media support")
				config.onError(ERR_CLIENT, "No user media support");
			}
		}

		// Start recording and transcribing
		this.startListening = function(param) {
			if (! recorder) {
				config.onError(ERR_AUDIO, "Recorder undefined");
				return;
			}
			audioContext.resume()
			if (ws) {
				self.cancel();
			}

			try {
				ws = createWebSocket(param);
			} catch (e) {
				config.onError(ERR_CLIENT, "No web socket support in this browser!");
			}
		}

		// Stop listening, i.e. recording and sending of new input.
		this.stopListening = function() {
			// Stop the regular sending of audio
			clearInterval(intervalKey);
			// Stop recording
			if (recorder) {
				recorder.stop();
				config.onEvent(MSG_STOP, 'Stopped recording');
				// Push the remaining audio to the server
				recorder.export16kMono(function(blob) {
					socketSend(blob);
					socketSend(TAG_END_OF_SENTENCE);
					recorder.clear();
				}, 'audio/x-raw');
				audioContext.suspend()
				config.onEndOfSpeech();
				
			} else {
				config.onError(ERR_AUDIO, "Recorder undefined");
			}

			if (ws) {
				ws.close();
				ws = null;
			}
		}

		// Cancel everything without waiting on the server
		this.cancel = function() {
			// Stop the regular sending of audio (if present)
			clearInterval(intervalKey);
			if (recorder) {
				recorder.stop();
				recorder.clear();
				config.onEvent(MSG_STOP, 'Stopped recording');
			}
			if (ws) {
				ws.close();
				ws = null;
			}
		}

		// Sets the URL of the speech server
		this.setServer = function(server) {
			config.server = server;
			config.onEvent(MSG_SERVER_CHANGED, 'Server changed: ' + server);
		}

		// Sets the URL of the speech server status server
		this.setServerStatus = function(serverStatus) {
			config.serverStatus = serverStatus;

			if (config.onServerStatus) {
				monitorServerStatus();
			}

			config.onEvent(MSG_SERVER_CHANGED, 'Server status server changed: ' + serverStatus);
		}

		// Sends reference text to speech server
		this.submitReference = function submitReference(text, successCallback, errorCallback) {
			var headers = {}
			if (config["user_id"]) {
				headers["User-Id"] = config["user_id"]
			}
			if (config["content_id"]) {
				headers["Content-Id"] = config["content_id"]
			}
			$.ajax({
				url: config.referenceHandler,
				type: "POST",
				headers: headers,
				data: text,
				dataType: "text",
				success: successCallback,
				error: errorCallback,
			});
		}

		// Private methods
		function startUserMedia(stream) {
			var input = audioContext.createMediaStreamSource(stream);
			config.onEvent(MSG_MEDIA_STREAM_CREATED, 'Media stream created');
                        //Firefox loses the audio input stream every five seconds
                        // To fix added the input to window.source
                        window.source = input;
                        
			// make the analyser available in window context
			window.userSpeechAnalyser = audioContext.createAnalyser();
			input.connect(window.userSpeechAnalyser);

			config.rafCallback();

			recorder = new Recorder(input, { workerPath : config.recorderWorkerPath });
			config.onEvent(MSG_INIT_RECORDER, 'Recorder initialized');
			self.startListening();
		}

		function socketSend(item) {
			if (ws) {
				var state = ws.readyState;
				if (state == 1) {
					// If item is an audio blob
					if (item instanceof Blob) {
						if (item.size > 0) {
							ws.send(item);
							config.onEvent(MSG_SEND, 'Send: blob: ' + item.type + ', ' + item.size);
						} else {
							config.onEvent(MSG_SEND_EMPTY, 'Send: blob: ' + item.type + ', EMPTY');
						}
					// Otherwise it's the EOS tag (string)
					} else {
						ws.send(item);
						config.onEvent(MSG_SEND_EOS, 'Send tag: ' + item);
					}
				} else {
					config.onError(ERR_NETWORK, 'WebSocket: readyState!=1: ' + state + ": failed to send: " + item);
				}
			} else {
				config.onError(ERR_CLIENT, 'No web socket connection: failed to send: ' + item);
			}
		}


		function createWebSocket(lan) {
			// TODO: do we need to use a protocol?
			//var ws = new WebSocket("ws://127.0.0.1:8081", "echo-protocol");
			// var url = config.server ;
			var url = config.server + '&from=' + lan + '&' + config.contentType +
			'&ApiKey=' + config.key ;
			// if (config["user_id"]) {
			// 	url += '&user-id=' + config["user_id"]
			// }
			// if (config["content_id"]) {
			// 	url += '&content-id=' + config["content_id"]
			// }
			var ws = new WebSocket(url);
			
			ws.onmessage = function(e) {
				var data = JSON.parse(e.data);

				if (data.final) {
					config.onResults(data.text);
				} else {
					config.onPartialResults(data.text);
				}
					
			}

			// Start recording only if the socket becomes open
			ws.onopen = function(e) {
				intervalKey = setInterval(function() {
					recorder.export16kMono(function(blob) {
						socketSend(blob);
						recorder.clear();
					}, 'audio/wav');
				}, config.interval);
				// Send audio config
				// var ac = {"Content-type": 'audio/wav' , samplerate:16000 ,ApiKey:'18QNAAQrw1z3sf2XWOCsOXgkcJakSR' } ;
				// ws.send(JSON.stringify(ac));
				// Start recording
				recorder.record();
				config.onReadyForSpeech();
				config.onEvent(MSG_WEB_SOCKET_OPEN, e);
			};

			// This can happen if the blob was too big
			// E.g. "Frame size of 65580 bytes exceeds maximum accepted frame size"
			// Status codes
			// http://tools.ietf.org/html/rfc6455#section-7.4.1
			// 1005:
			// 1006:
			ws.onclose = function(e) {
				console.log(e);
				var code = e.code;
				var reason = e.reason;
				var wasClean = e.wasClean;

				if (code == 1000)
					reason = "Normal closure, meaning that the purpose for which the connection was established has been fulfilled.";
				else if (code == 1001)
					reason = "An endpoint is \"going away\", such as a server going down or a browser having navigated away from a page.";
				else if (code == 1002)
					reason = "An endpoint is terminating the connection due to a protocol error";
				else if (code == 1003)
					reason = "An endpoint is terminating the connection because it has received a type of data it cannot accept (e.g., an endpoint that understands only text data MAY send this if it receives a binary message).";
				else if (code == 1004)
					reason = "Reserved. The specific meaning might be defined in the future.";
				else if (code == 1005)
					reason = "No status code was actually present.";
				else if (code == 1006)
					reason = "The connection was closed abnormally, e.g., without sending or receiving a Close control frame";
				else if (code == 1007)
					reason = "An endpoint is terminating the connection because it has received data within a message that was not consistent with the type of the message (e.g., non-UTF-8 [http://tools.ietf.org/html/rfc3629] data within a text message).";
				else if (code == 1008)
					reason = "An endpoint is terminating the connection because it has received a message that \"violates its policy\". This reason is given either if there is no other sutible reason, or if there is a need to hide specific details about the policy.";
				else if (code == 1009)
					reason = "An endpoint is terminating the connection because it has received a message that is too big for it to process.";
				else if (code == 1010) // Note that this status code is not used by the server, because it can fail the WebSocket handshake instead.
					reason = "An endpoint (client) is terminating the connection because it has expected the server to negotiate one or more extension, but the server didn't return them in the response message of the WebSocket handshake. <br /> Specifically, the extensions that are needed are: " + reason;
				else if (code == 1011)
					reason = "A server is terminating the connection because it encountered an unexpected condition that prevented it from fulfilling the request.";
				else if (code == 1015)
					reason = "The connection was closed due to a failure to perform a TLS handshake (e.g., the server certificate can't be verified).";
				else
					reason = "Unknown reason";

				// The server closes the connection (only?)
				// when its endpointer triggers.
				config.onEndOfSession();
				config.onEvent(MSG_WEB_SOCKET_CLOSE, e.code + "/" + reason + "/" + wasClean);
			};

			ws.onerror = function(e) {
				console.log(e);
				var data = e.data;
				config.onError(ERR_NETWORK, data);
			}

			return ws;
		}


		function monitorServerStatus() {
			if (wsServerStatus) {
				wsServerStatus.close();
			}
			wsServerStatus = new WebSocket(config.serverStatus);
			wsServerStatus.onmessage = function(evt) {
				config.onServerStatus(JSON.parse(evt.data));
			};
		}


		function getDescription(code) {
			if (code in SERVER_STATUS_CODE) {
				return SERVER_STATUS_CODE[code];
			}
			return "Unknown error";
		}

	};

	// Simple class for persisting the transcription.
	// If isFinal==true then a new line is started in the transcription list
	// (which only keeps the final transcriptions).
	var Transcription = function(cfg) {
		var index = 0;
		var list = [];

		this.add = function(text, isFinal) {
			list[index] = text;
			if (isFinal) {
				index++;
			}
		}

		this.toString = function() {
			return list.join('. ');
		}
	}

	window.Dictate = Dictate;
	window.Transcription = Transcription;

})(window);
