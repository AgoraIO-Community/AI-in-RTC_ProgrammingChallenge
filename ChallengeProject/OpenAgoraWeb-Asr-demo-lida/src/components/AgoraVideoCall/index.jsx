import React from 'react'
import { merge } from 'lodash'
import * as Cookies from 'js-cookie'
import AgoraRTC from 'agora-rtc-sdk'
import HiddenCanvas from '../canvas';
import Dictate from '../../lib/dictate'
import SocketParam from '../../utils/dictate'

import './canvas.css'
import '../../assets/fonts/css/icons.css'

const tile_canvas = {
  '1': ['span 12/span 24'],
  '2': ['span 12/span 12/13/25', 'span 12/span 12/13/13'],
  '3': ['span 6/span 12', 'span 6/span 12', 'span 6/span 12/7/19'],
  '4': ['span 6/span 12', 'span 6/span 12', 'span 6/span 12', 'span 6/span 12/7/13'],
  '5': ['span 3/span 4/13/9', 'span 3/span 4/13/13', 'span 3/span 4/13/17', 'span 3/span 4/13/21', 'span 9/span 16/10/21'],
  '6': ['span 3/span 4/13/7', 'span 3/span 4/13/11', 'span 3/span 4/13/15', 'span 3/span 4/13/19', 'span 3/span 4/13/23', 'span 9/span 16/10/21'],
  '7': ['span 3/span 4/13/5', 'span 3/span 4/13/9', 'span 3/span 4/13/13', 'span 3/span 4/13/17', 'span 3/span 4/13/21', 'span 3/span 4/13/25', 'span 9/span 16/10/21'],
}


/**
 * @prop appId uid
 * @prop transcode attendeeMode videoProfile channel baseMode
 */
class AgoraCanvas extends React.Component {
  constructor(props) {
    super(props)
    this.client = {}
    this.localStream = {}
    this.state = {
      displayMode: 'pip',
      streamList: [],
      readyState: false,
      visible: false,
      showRoleList: false,
      asrResult: ''
    }
    this.hiddenCanvas = React.createRef();
  }

  componentWillMount() {
    const self = this ;
    this.dictateSocket = new Dictate({
        server : SocketParam.server ,
        key: SocketParam.key ,
        interval: 200 ,
        recorderWorkerPath : 'lib/recorderWorker.js',
        onReadyForSpeech : function() {
        },
        onEndOfSpeech : function() {
        },
        onEndOfSession : function() {
        },
        onPartialResults : function(hypos) {
          self.setState({
            asrResult: hypos
          })
        },
        onResults : function(hypos) {
          self.setState({
            asrResult: hypos
          })
        },
        onError : function(code, data) {
          // TODO: show error in the GUI
        },
        onEvent : function(code, data) {
          // console.log(data);
        }
    });
    this.dictateSocket.init((mediaStream)=> {
      const newStream = this.hiddenCanvas.current.processStream(mediaStream);
      const audioSource = newStream.getAudioTracks()[0];
      const videoSource = newStream.getVideoTracks()[0];
      const config = {
        audioSource,
        videoSource
      }
      this.createClientInit(config);
    });
    
    
  }

  componentDidMount() {
    // add listener to control btn group
    let canvas = document.querySelector('#ag-canvas')
    let btnGroup = document.querySelector('.ag-btn-group')
    canvas.addEventListener('mousemove', () => {
      if (global._toolbarToggle) {
        clearTimeout(global._toolbarToggle)
      }
      btnGroup.classList.add('active')
      global._toolbarToggle = setTimeout(function () {
        btnGroup.classList.remove('active')
      }, 2000)
    })
  }

  componentDidUpdate() {
    console.log('agora-video-module: is updated')
    // rerendering
    let canvas = document.querySelector('#ag-canvas')
    // pip mode (can only use when less than 4 people in channel)
    if (this.state.displayMode === 'pip') {
      let no = this.state.streamList.length
      if (no > 4) {
        this.setState({ displayMode: 'tile' })
        return
      }
      this.state.streamList.map((item, index) => {
        let id = item.getId()
        let dom = document.querySelector('#ag-item-' + id)
        if (!dom) {
          dom = document.createElement('section')
          dom.setAttribute('id', 'ag-item-' + id)
          dom.setAttribute('class', 'ag-item')
          canvas.appendChild(dom)
          item.play('ag-item-' + id)
        }
        if (index === no - 1) {
          dom.setAttribute('style', `grid-area: span 12/span 24/13/25`)
        }
        else {
          dom.setAttribute('style', `grid-area: span 3/span 4/${4 + 3 * index}/25;
                    z-index:1;width:calc(100% - 20px);height:calc(100% - 20px)`)
        }

        item.player && item.player.resize && item.player.resize()


      })
    }
    // tile mode
    else if (this.state.displayMode === 'tile') {
      let no = this.state.streamList.length
      this.state.streamList.map((item, index) => {
        let id = item.getId()
        let dom = document.querySelector('#ag-item-' + id)
        if (!dom) {
          dom = document.createElement('section')
          dom.setAttribute('id', 'ag-item-' + id)
          dom.setAttribute('class', 'ag-item')
          canvas.appendChild(dom)
          item.play('ag-item-' + id)
        }
        dom.setAttribute('style', `grid-area: ${tile_canvas[no][index]}`)
        item.player.resize && item.player.resize()


      })
    }
    // screen share mode (tbd)
    else if (this.state.displayMode === 'share') {

    }
  }

  componentWillUnmount () {
    this.client && this.client.unpublish(this.localStream)
    this.localStream && this.localStream.close()
    this.client && this.client.leave(() => {
      console.log('Client succeed to leave.')
    }, () => {
      console.log('Client failed to leave.')
    })
    this.dictateSocket.cancel();

  }
  createClientInit = (config)=> {
    ////////////////
    let $ = this.props
    // init AgoraRTC local client
    this.client = AgoraRTC.createClient({ codec: $.transcode, mode: $.baseMode })
    this.client.init($.appId, () => {
      console.log("AgoraRTC client initialized")
      this.subscribeStreamEvents()
      this.client.join($.appId, $.channel, $.uid, (uid) => {
        console.log("User " + uid + " join channel successfully")
        console.log('At ' + new Date().toLocaleTimeString())
        // create local stream
        // It is not recommended to setState in function addStream
        this.localStream = this.streamInit(uid, $.attendeeMode, $.videoProfile, config)
        this.localStream.init(() => {
          if ($.attendeeMode !== 'audience') {
            this.addStream(this.localStream, true)
            this.client.publish(this.localStream, err => {
              console.log("Publish local stream error: " + err);
            })
          }
          this.setState({ readyState: true },()=>{
            this.dictateSocket.startListening();
          })
        },
          err => {
            console.log("getUserMedia failed", err)
            this.setState({ readyState: true })
          })
      })
    })
  }
  streamInit = (uid, attendeeMode, videoProfile, config) => {
    let defaultConfig = {
      streamID: uid,
      audio: true,
      video: true,
      screen: false,
    }

    switch (attendeeMode) {
      case 'audio-only':
        defaultConfig.video = false
        break;
      case 'audience':
        defaultConfig.video = false
        defaultConfig.audio = false
        break;
      default:
      case 'video':
        break;
    }

    let stream = AgoraRTC.createStream(merge(defaultConfig, config))
    stream.setVideoProfile(videoProfile)
    return stream
  }
  subscribeStreamEvents = () => {
    let rt = this
    rt.client.on('stream-added', function (evt) {
      let stream = evt.stream
      console.log("New stream added: " + stream.getId())
      console.log('At ' + new Date().toLocaleTimeString())
      console.log("Subscribe ", stream)
      rt.client.subscribe(stream, function (err) {
        console.log("Subscribe stream failed", err)
      })
    })

    rt.client.on('peer-leave',  (evt)=> {
      const id = evt.uid ;
      console.log("Peer has left: " + id)
      console.log(new Date().toLocaleTimeString())
      console.log(evt)
      rt.removeStream(id)
      if (id === 1002) {
        rt.shareEnd();
      }
    })

    rt.client.on('stream-subscribed', function (evt) {
      let stream = evt.stream
      console.log("Got stream-subscribed event")
      console.log(new Date().toLocaleTimeString())
      console.log("Subscribe remote stream successfully: " + stream.getId())
      console.log(evt)
      rt.addStream(stream)
    })

    rt.client.on("stream-removed", function (evt) {
      let stream = evt.stream
      const id = stream.getId();
      console.log("Stream removed: " + id)
      console.log(new Date().toLocaleTimeString())
      console.log(evt)
      rt.removeStream(id)
      if (id === 1002) {
        rt.shareEnd();
      }
    })
  }

  removeStream = (uid) => {
    this.state.streamList.map((item, index) => {
      if (item.getId() === uid) {
        item.close()
        let element = document.querySelector('#ag-item-' + uid)
        if (element) {
          element.parentNode.removeChild(element)
        }
        let tempList = [...this.state.streamList]
        tempList.splice(index, 1)
        this.setState({
          streamList: tempList
        })
      }

    })
  }

  addStream = (stream, push = false) => {
    let repeatition = this.state.streamList.some(item => {
      return item.getId() === stream.getId()
    })
    if (repeatition) {
      return
    }
    if (push) {
      this.setState({
        streamList: this.state.streamList.concat([stream])
      })
    }
    else {
      this.setState({
        streamList: [stream].concat(this.state.streamList)
      })
    }

  }

  handleCamera = (e) => {
    e.currentTarget.classList.toggle('off')
    this.localStream.isVideoOn() ?
      this.localStream.disableVideo() : this.localStream.enableVideo()
      if (this.localStream2){

        this.localStream2.isVideoOn() ?
          this.localStream2.disableVideo() : this.localStream2.enableVideo()
      }
  }

  handleMic = (e) => {
    e.currentTarget.classList.toggle('off')
    if ( this.localStream.isAudioOn() ){
      this.dictateSocket.stopListening();
      this.localStream.disableAudio()
    }else{
      this.dictateSocket.startListening();
      this.localStream.enableAudio()
    }
    if (this.localStream2){

      this.localStream2.isAudioOn() ?
        this.localStream2.disableAudio() : this.localStream2.enableAudio()
    }
  }

  switchDisplay = (e) => {
    if (e.currentTarget.classList.contains('disabled') || this.state.streamList.length <= 1) {
      return
    }
    if (this.state.displayMode === 'pip') {
      this.setState({ displayMode: 'tile' })
    }
    else if (this.state.displayMode === 'tile') {
      this.setState({ displayMode: 'pip' })
    }
    else if (this.state.displayMode === 'share') {
      // do nothing or alert, tbd
    }
    else {
      console.error('Display Mode can only be tile/pip/share')
    }
  }
  //隐藏和显示远端流
  hideRemote = (e) => {
    console.log(this.localStream.getId())
    // this.showModal();
    return ;
    if (e.currentTarget.classList.contains('disabled') || this.state.streamList.length <= 1) {
      return
    }
    let list
    let id = this.state.streamList[this.state.streamList.length - 1].getId()
    list = Array.from(document.querySelectorAll(`.ag-item:not(#ag-item-${id})`))
    list.map(item => {
      if (item.style.display !== 'none') {
        item.style.display = 'none'
      }
      else {
        item.style.display = 'block'
      }
    })

  }

  handleExit = (e) => {
    if (e.currentTarget.classList.contains('disabled')) {
      return
    }
    try {
      this.shareEnd();
      this.dictateSocket.cancel();
      this.client2 && this.client2.unpublish(this.localStream2)
      this.localStream2 && this.localStream2.close()
      this.client2 && this.client2.leave(() => {
        console.log('Client succeed to leave.')
      }, () => {
        console.log('Client failed to leave.')
      })
      this.client && this.client.unpublish(this.localStream)
      this.localStream && this.localStream.close()
      this.client && this.client.leave(() => {
        console.log('Client succeed to leave.')
      }, () => {
        console.log('Client failed to leave.')
      })
      
    }
    finally {
      this.setState({ readyState: false })
      this.client = null
      this.localStream = null
      // redirect to index
      window.location.hash = ''
    }
  }
  handleShare = ()=> {
    if (this.shareClient) {
      this.shareEnd();
    } else {
      this.shareStart();
    }
  }
  shareStart = (e) => {
    let $ = this.props
    // init AgoraRTC local client
    this.shareClient = AgoraRTC.createClient({ codec: $.transcode, mode: $.baseMode });
    let config = {
      screen: true,
      video: false,
      audio: true,
      mediaSource: 'screen'
    };
    this.shareClient.init($.appId, () => {
      this.shareClient.join($.appId, $.channel, 1002, (uid) => {
        console.log("User " + uid + " join channel successfully")
        console.log('At ' + new Date().toLocaleTimeString())
        // create local stream
        // It is not recommended to setState in function addStream
        this.shareStream = this.streamInit(uid, $.attendeeMode, $.videoProfile, config)
        this.shareStream.setScreenProfile('480p_1');
        this.shareStream.setVideoProfile('480p_1');
        this.shareStream.init(
          () => {
            this.shareStream.on('stopScreenSharing', () => {
              this.shareEnd();
            });
            this.shareClient.publish(this.shareStream, err => {

            });
          },
          err => {
            this.shareEnd();
          }
        );
      })
    })
    
  }
  shareEnd = () => {
    try {
      this.shareClient && this.shareClient.unpublish(this.shareStream);
      this.shareStream && this.shareStream.close();
      this.shareClient &&
        this.shareClient.leave(
          () => {
          },
          () => {
          }
        );
    } finally {
      this.shareClient = null;
      this.shareStream = null;
    }
  }


  /**
   * 增加新角色处理方式
   *  */  
  showModal = () => {
    this.setState({
      visible: true,
    });
  };

  handleCancel = e => {
    this.setState({
      visible: false,
    });
  };
  getRole = (values)=> {
    this.handleCancel();
    if ( this.role.uid === values.uid ){
      Cookies.remove('role');
      Cookies.set('role', JSON.stringify(values));
      this.setDevice(this.client, this.localStream, values, true)
    }else if ( this.role2 && this.role2.uid === values.uid){
      Cookies.remove('role2');
      Cookies.set('role2', JSON.stringify(values));
      this.setDevice(this.client2, this.localStream2, values, false)
    }else{
      Cookies.set('role2', JSON.stringify(values))
      this.addNewRole(values);
    }
  }
  //处理第二角色信息
  addNewRole = (values)=> {
    let $ = this.props
    // init AgoraRTC local client
    this.client2 = AgoraRTC.createClient({ codec: $.transcode, mode: $.baseMode })
    this.client2.init($.appId, () => {
      console.log("AgoraRTC client2 initialized")
      this.client2.join($.appId, $.channel, Number(values.uid), (uid) => {
        console.log("User " + uid + " join channel successfully")
        console.log('At ' + new Date().toLocaleTimeString())
        // create local stream
        // It is not recommended to setState in function addStream
        values.video = false ;
        this.localStream2 = this.streamInit(uid, $.attendeeMode, $.videoProfile, values)
        this.localStream2.init(() => {
          this.localStream2.addTrack(this.localStream.getVideoTrack());
          if ($.attendeeMode !== 'audience') {
            this.client2.publish(this.localStream2, err => {
              console.log("Publish local stream error: " + err);
            })
          }
          },
          err => {
            console.log("getUserMedia failed", err)
        })
      })
    })
  }
  // Set Device
  setDevice = (client, stream, values, push ) => {
    let $ = this.props ;
    if (!stream) {
      throw Error('Stream not existed!');
    }
    
    return new Promise((resolve, reject) => {
      let id = stream.getId();
      client.unpublish(stream);
      stream.stop();
      stream.close();
      this.removeStream(id);
      stream = this.streamInit(id, $.attendeeMode, $.videoProfile, values) ;
      stream.init(
        () => {
          if ($.attendeeMode !== 'audience') {
            client.publish(stream);
          }
          this.addStream(stream, push)
          resolve();
        },
        err => {
          console.log('getUserMedia failed', err);
          reject(err);
        }
      );
    });
  }
  /***
   * 增加角色列表
   *  */
  showList = ()=>{
    this.setState({
      showRoleList: true
    })
  }
  hideList = ()=> {
    this.setState({
      showRoleList: false
    })
  }
  exitOne = (role)=> {

  }
  render() {
    console.log('agora-video : is rendered')
    const style = {
      display: 'grid',
      gridGap: '10px',
      alignItems: 'center',
      justifyItems: 'center',
      gridTemplateRows: 'repeat(12, auto)',
      gridTemplateColumns: 'repeat(24, auto)'
    }
    const videoControlBtn = this.props.attendeeMode === 'video' ?
      (<span
        onClick={this.handleCamera}
        className="ag-btn videoControlBtn"
        title="Enable/Disable Video">
        <i className="ag-icon ag-icon-camera"></i>
        <i className="ag-icon ag-icon-camera-off"></i>
      </span>) : ''

    const audioControlBtn = this.props.attendeeMode !== 'audience' ?
      (<span
        onClick={this.handleMic}
        className="ag-btn audioControlBtn"
        title="Enable/Disable Audio">
        <i className="ag-icon ag-icon-mic"></i>
        <i className="ag-icon ag-icon-mic-off"></i>
      </span>) : ''

    const switchDisplayBtn = (
      <span
        onClick={this.switchDisplay}
        className={this.state.streamList.length > 4 ? "ag-btn displayModeBtn disabled" : "ag-btn displayModeBtn"}
        title="Switch Display Mode">
        <i className="ag-icon ag-icon-switch-display"></i>
      </span>
    )
    const hideRemoteBtn = (
      <span
        className={this.state.streamList.length > 4 || this.state.displayMode !== 'pip' ? "ag-btn disableRemoteBtn disabled" : "ag-btn disableRemoteBtn"}
        onClick={this.hideRemote}
        title="Add New Role">
        <i className="ag-icon ag-icon-remove-pip"></i>
      </span>
    )
    const exitBtn = (
      <span
        onClick={this.handleExit}
        className={this.state.readyState ? 'ag-btn exitBtn' : 'ag-btn exitBtn disabled'}
        title="Exit">
        <i className="ag-icon ag-icon-leave"></i>
      </span>
    )
      const roleArr = [] ;
      if (Cookies.get('role')){
        roleArr.push(JSON.parse(Cookies.get("role")))
      }
      if (Cookies.get('role2')){
        roleArr.push(JSON.parse(Cookies.get("role2")))
      }
    return (
      <div id="ag-canvas" style={style}>
        <HiddenCanvas ref={this.hiddenCanvas} text={this.state.asrResult} />
        <div className="ag-btn-group">
          {exitBtn}
          {videoControlBtn}
          {audioControlBtn}
          {/* <span onClick={this.handleShare} className="ag-btn shareScreenBtn" title="Share Screen">
              <i className="ag-icon ag-icon-screen-share"></i>
          </span>
          {switchDisplayBtn}
          {hideRemoteBtn} */}
        </div>
      </div>
    )
  }
}

export default AgoraCanvas