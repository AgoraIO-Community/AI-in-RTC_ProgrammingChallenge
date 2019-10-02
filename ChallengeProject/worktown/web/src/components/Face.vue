<template>
    <div :style="myStyle">
        <el-alert v-show="!fixed" type="warning" center :title="msg" :closable="false"></el-alert>
        <div id="box" v-show="fixed" :style="myStyle"/>
        <canvas id='pic' style="width:200px;height:200px;display:none;"/>
    </div>
</template>
<script>
import api from '@/api.js'
import { mapState } from 'vuex'
export default {
    name: 'Face',
    props: {
        width: {
            type: String,
            default: '60px'
        },
        height: {
            type: String,
            default: '60px'
        },
        timeSpan: {
            type: Number,
            default: 5000
        }
    },
    computed: {
        myStyle () {
            return 'width:' + this.width + ';height:' + this.height + ';'
        }
    },
    data () {
        return {
            timer: null,
            videoDom: null,
            picDom: null,
            fixed: false,
            msg: '正在打开音视频采集设备……'
        }
    },
    created () {
        let _this = this
        this.stream = AgoraRTC.createStream({
            streamID: 'myface',
            audio: false,
            video: true,
            screen: false
        })
    },
    mounted () {
        let _this = this
        _this.picDom = document.getElementById('pic')
        this.stream.init(() => {
            _this.stream.play('box', {fit: 'cover'}, err => {
                if (!err) {
                    console.log(err)
                    _this.msg = '音视频采集失败：' + err
                    return
                }
                _this.videoDom = document.getElementById('videomyface')
                if (_this.videoDom) {
                    _this.videoDom.style.position = null
                    _this.fixed = true
                }
            })
        })
        this.timer = setInterval(this.searchFace, this.timeSpan);
    },
    beforeDestroy () {
        clearInterval(this.timer)
    },
    methods: {
        searchFace () {
            let _this = this
            if (_this.videoDom) {
                _this.picDom.getContext('2d').drawImage(_this.videoDom, 0, 0, _this.picDom.width, _this.picDom.height)
                let imgData = _this.picDom.toDataURL("image/png").substring(22)
                this.$emit('snap', imgData)
            }
        }
    }
}
</script>