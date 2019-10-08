/* eslint-disable no-console */

import Vue from 'vue'
import router from './router'
import store from './store'
import { mapState } from 'vuex'
import Const from './Const'

const socketInit = function (user, server, clientId) {
  let host = server || location.host
  let socket = new WebSocket(host + '/online?code=' + user.code + '&team=' + user.teamCode + '&clientId=' + clientId)
  console.log('socket_login: ' + clientId)
  socket.onmessage = socketOnMessage // socket 绑定事件处理
  socket.onclose = e => {
    console.log(e)
    me.$bus.emit('socketOff') // 交给 app.vue 处理
  }
  socket.onerror = e => {
    console.error(e)
  }
  return socket
}

const socketOnMessage = function (event) {
  console.log(event)
  let msg = JSON.parse(event.data)
  if (msg.err) {
    return
  }
  switch (msg.act) {
  case Const.MESSAGE_IN:
    me.$bus.emit(Const.MESSAGE_IN, msg)
    break
  case Const.MESSAGE_OUT:
    me.$bus.emit(Const.MESSAGE_OUT, msg)
    break
  case Const.MESSAGE_STATE:
    me.$bus.emit(Const.MESSAGE_STATE, msg)
    break
  case Const.MESSAGE_TALK:
    me.$bus.emit(Const.MESSAGE_TALK, msg)
    break
  case Const.MESSAGE_KICK_OUT:
    me.$bus.emit(Const.MESSAGE_KICK_OUT, msg)
    break
  default:
    console.log('no handle socketMsg: ' + msg)
    break
  }
}

const me = new Vue({
  router,
  store,
  data () {
    return {
      info: '',
      socket: null,
      loading: null,
      clientId: (Math.random() * 10000).toString()
    }
  },
  computed: {
    ...mapState([
      'config',
      'loginUser'
    ])
  },
  created: function () {
  },
  methods: {
    install (Vue) {
      Vue.prototype.$socket = this
    },
    login (user, server) { // 登录
      if (!user || !user.code || !user.teamCode) {
        this.$message.error('当前用户未设置，Socket登录取消!')
        return false
      }
      this.socket = socketInit(user, server, this.clientId)
      return true
    },
    logout () { // 登出
      this.$store.commit('logout')
      try {
        this.socket.close()
        this.socket = null
      } catch (e) {
        console.log(e)
      }
    },
    changeState (state) {
      this.socketSend({
        act: Const.MESSAGE_STATE,
        tagString: JSON.stringify(state)
      })
    },
    talk (code) {
      this.socketSend({
        act: Const.MESSAGE_TALK,
        targetCode: code
      })
    },
    socketSend (msg) { // 发送消息（共通）
      try {
        if (this.socket.readyState === this.socket.OPEN) {
          this.socket.send(JSON.stringify(msg))
        }
      } catch (err) {
        console.error(err)
      }
    }
  }
})

export default me
