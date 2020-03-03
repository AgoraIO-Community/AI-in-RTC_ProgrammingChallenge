import React from 'react'
import './style.css'


export default class App extends React.Component{
    constructor(props){
        super(props)
        this.videoRef = React.createRef();
        this.canvasRef = React.createRef();
    }
    componentDidMount(){
        this.ctx = this.canvasRef.current.getContext('2d');
        this.init(this.ctx);
    }
    init (canvas){
        canvas.font = '10px serif';
        canvas.textAlign = 'center';
        canvas.fillStyle = '#fff';
    }
    bindPlay (video){
        video.addEventListener('play', ()=> {
            this.width = video.videoWidth ;
            this.height = video.videoHeight ;
            
            this.timerCallback();
        }, false);
    }
    timerCallback (){
        const video = this.videoRef.current ;
        if(!video){
            return
        }
        if (video.paused || video.ended) {
            return;
          }
        this.computeFrame(video);
        let self = this;
        setTimeout(function() {
            self.timerCallback();
        }, 0);
    }
    computeFrame(video) {
        const text = this.props.text ;
        this.ctx.drawImage(video, 0, 0, this.width, this.height);
        this.ctx.fillText(text, this.width/2, this.height -10)
    }
    processStream (mediaStream){
        const video = this.videoRef.current ;
        video.srcObject = mediaStream; 
        this.bindPlay(video);
        setTimeout(()=>{
            video.play();
        },200)
        return this.canvasRef.current.captureStream(30);
    }
    render(){
        return (
            <div className='canvas-component'>
                <video ref={this.videoRef} muted></video>
                <canvas ref={this.canvasRef} width='640' height='480'></canvas>
            </div>
        )
    }
} 