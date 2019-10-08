<template>
  <div>
    <el-row>
      <el-col :span="8" :key="member.code" v-for="member in members">
        <el-card :body-style="{ padding: '10px' }" style="margin:10px;min-height:265px;">
          <div style="padding: 10px;">
            <b>{{ member.name }}</b>&nbsp;&nbsp;&nbsp;<el-tag :type="member.state.type">{{ member.state.msg }}</el-tag>
          </div>
          <!-- <img v-if="!member.isOpen" :src="imgScr(member)"> -->
          <img v-if="!member.isOnline" src="../assets/noone.png"/>
          <img v-if="member.isOnline && !member.isOpen && member.gender==='女' && member.state.msg==='不在座位'" src="../assets/woman_running.png"/>
          <img v-else-if="member.isOnline && !member.isOpen && member.gender==='女'" src="../assets/woman.png"/>
          <img v-else-if="member.isOnline && !member.isOpen && member.state.msg==='不在座位'" src="../assets/man_running.png"/>
          <img v-else-if="member.isOnline && !member.isOpen" src="../assets/man.png"/>
          <div v-bind:id="member.code" v-show="member.isOnline && member.isOpen" class="image"/>
          <div style="padding: 14px;">
            <div class="bottom clearfix">
              <el-switch
                :disabled="member.index === myIndex || !member.isOnline || member.isChanging"
                v-model="member.isOpen"
                active-color="#13ce66"
                inactive-color="#ff4949"
                @change="switchShow(member)">
              </el-switch>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <canvas id='pic' style="width:200px;height:200px;display:none;"/>
  </div>
</template>
<script>  
import api from '@/api.js'
import { mapState } from 'vuex'
import Const from '../Const'
const fixDomCss = (code) => {
  let dom = document.getElementById('video' + code)
  if (dom) {
    dom.style.position = null
  }
}
const clearDom = (code) => {
  let dom = document.getElementById(code)
  if (dom) {
    dom.innerHTML = ''
  }
}
export default {
  data () {
    return {
      client: AgoraRTC.createClient({ mode: 'live' }),
      team: null,
      members: [],
      myIndex: 0,
      imgData: null,
      para: null,
      timer: null,
      picDom: null,
      videoDom: null,
      leaveTimes: 0
    }
  },
  computed: {
    ...mapState([
      'loginUser',
      'config'
    ])
  },
  created () {
    if (!this.loginUser.teamCode) {
      this.$router.push({name: 'profile'})
      return
    }
    let _this = this
    _this.client.on('peer-online', function (evt) {
      let member = _this.getMember(evt.uid)
      _this.$set(member, 'isOnline', true)
    })
    _this.client.on('peer-leave', function (evt) {
      let member = _this.getMember(evt.uid)
      _this.$set(member, 'stream', null)
      _this.$set(member, 'isOpen', false)
      
      clearDom(member.code)
    })
    _this.$bus.on(Const.MESSAGE_OUT, evt => {
       let member = _this.getMember(evt.userCode)
       _this.$set(member, 'stream', null)
      _this.$set(member, 'isOpen', false)
      _this.$set(member, 'isOnline', false)
      clearDom(member.code)
      _this.setState(member, 0)
    })
    _this.client.on('stream-added', function (evt) {
      var stream = evt.stream;
      console.log("New stream added: " + stream.getId());
      let member = _this.getMember(stream.getId())
      _this.$set(member, 'stream', stream)
      _this.client.subscribe(stream, function (err) {
        console.log("Subscribe stream failed", err)
      })
    })
    _this.client.on("stream-subscribed", function(evt) {
      var stream = evt.stream
      let member = _this.getMember(stream.getId())
      member.stream.play(member.code, {fit: 'cover'}, err => {
        fixDomCss(member.code)
        console.log(err)
       _this.$set(member, 'isOpen', false)
       _this.setState(member, 1)
      })
    })
    _this.client.on("stream-removed", function(evt) {
      var stream = evt.stream
      stream.stop()
      let member = _this.getMember(stream.getId())
      _this.$set(member, 'stream', null)
      _this.$set(member, 'isOpen', false)
      clearDom(member.code)
    })
    _this.$bus.on(Const.MESSAGE_STATE, evt => {
      let member = _this.getMember(evt.userCode)
      member.state = JSON.parse(evt.tagString)
    })
    api.getTeam(this.loginUser.teamCode).then(team => {
      _this.team = team
      _this.$store.commit('team', team)
      return api.queryMember({teamCode: _this.loginUser.teamCode})
    }).then( rst => {
      if (rst.items && rst.items.length > 1) {
        rst.items.sort((a, b) => {
          if (!a.orderIndex) a.orderIndex = 0
          if (!b.orderIndex) b.orderIndex = 0
          return a.orderIndex - b.orderIndex
        })
      }
      let index = 0
      rst.items.forEach(mem => {
        mem.isOpen = false
        mem.isChanging = false
        mem.index = index++
        mem.gender = ''
        mem.glass = 0
        _this.setState(mem, 0)
      });
      _this.members = rst.items
      let member = _this.getMember(_this.loginUser.code)
      _this.myIndex = member.index
      _this.setState(member, 1)
      member.isOnline = true
      this.client.init(this.config.videoServer, () => {
        console.log("AgoraRTC client initialized")
        _this.client.join(null, _this.loginUser.teamCode, _this.loginUser.code, (usrCode) => {
          console.log("user " + usrCode + " join")
          member.stream = AgoraRTC.createStream({
            streamID: _this.loginUser.code,
            audio: true,
            video: true,
            screen: false
            })
          member.stream.init(() => {
            member.stream.play(_this.loginUser.code, {fit: 'cover'}, err => {
              fixDomCss(_this.loginUser.code)
              _this.videoDom = document.getElementById('video' + _this.loginUser.code)
              _this.$set(member, 'isOpen', true)
              _this.leaveTimes = 0
              console.log(err)
            })
            _this.client.publish(member.stream, err => {
              console.log("Publish local stream error: " + err);
            })
          })
        })
      })
    }).catch( err => {
      console.log(err)
    })
  },
  mounted () {
    this.picDom = document.getElementById('pic')
    this.timer = setInterval(this.searchFace, 5000);
  },
  beforeDestroy () {
    clearInterval(this.timer)
    this.client.leave()
  },
  methods: {
    getMember(code) {
      for (let i = 0; i < this.members.length; i++) {
        if (this.members[i].code === code) {
          return this.members[i]
        }
      }
    },
    switchShow (member) {
      if (member.index  !== this.myIndex) {
        if (member.isOpen) {
          this.$socket.talk(member.code)
        }
        return
      }
      if (member.isOpen) {
        member.isOpen = false
        this.$set(member, 'isChanging', true)
        member.stream.play(member.code, {fit: 'cover'}, err => {
          fixDomCss(member.code)
          console.log(err)
          member.isOpen = true
        })
        this.client.publish(member.stream)
        setTimeout(() => {
          member.isChanging = false
        }, 3000)
      } else {
        this.$set(member, 'isChanging', true)
        this.client.unpublish(member.stream)
        member.stream.stop(err => {
          console.log(err)
        })
        setTimeout(() => {
          member.isChanging = false
        }, 3000)
      }
    },
    searchFace () {
      let _this = this
      if (_this.videoDom && _this.picDom) {
        _this.picDom.getContext('2d').drawImage(_this.videoDom, 0, 0, _this.picDom.width, _this.picDom.height)
        let imgData = _this.picDom.toDataURL("image/png").substring(22)
        if (!_this.loginUser.gender) {
          _this.detectFace(imgData)
        }
        api.tencent({
          url: 'https://api.ai.qq.com/fcgi-bin/face/face_faceidentify',
          paras: {
            group_id: Const.DEFAULT_GROUP,
            topn: 1,
            image: imgData
          }
        }).then( rst => {
          let result = JSON.parse(rst)
          let currentMember = _this.members[_this.myIndex]
          if (result.ret === 0) {
            if (result.data.candidates.length && result.data.candidates[0].person_id === _this.loginUser.code) {
              if (currentMember.state.msg !== 2) {
                _this.setState(currentMember, 2)
                _this.$socket.changeState(currentMember.state)
              }
              _this.leaveTimes = 0
              return 
            } 
          }
          _this.leaveTimes++
          if (_this.leaveTimes > 3 && currentMember.state.code !== 3) {
            _this.setState(currentMember, 3)
            _this.$socket.changeState(currentMember.state)
          }
        })
      }
    },
    detectFace (imgData) {
      let _this = this
      api.tencent({
        url:'https://api.ai.qq.com/fcgi-bin/face/face_detectface',
        paras: {image: imgData, mode: 0}
      }).then(jsonRst => {
        let rst = JSON.parse(jsonRst)
        if (rst.ret === 0) {
          if (rst.data.face_list && rst.data.face_list.length) {
            let face = rst.data.face_list[0]
            if (face.gender > 50) {
              _this.loginUser.gender = '男'
            } else {
              _this.loginUser.gender = '女'
            }
            _this.loginUser.glass = face.glass
            _this.$store.commit('user', _this.loginUser)
            _this.members[_this.myIndex].gender = _this.loginUser.gender
            _this.members[_this.myIndex].glass = _this.loginUser.glass
          }
        }
      })
    },
    setState (member, state) {
      if (!member.state) {
        member.state = {}
      }
      member.state.code = state
      switch (state) {
        case 1:
          member.state.msg = '上班'
          member.state.type = 'warning'
          break;
        case 2:
          member.state.msg = '在座位'
          member.state.type = 'success'
          break;
        case 3:
          member.state.msg = '不在座位'
          member.state.type = 'danger'
          break;
        default:
          member.state.msg = '下班'
          member.state.type = 'info'
          break;
      }
    }
  }
}
</script>
<style scoped>
.image {
  margin: 0 auto;
  width: 128px;
  height: 128px;
}
</style>