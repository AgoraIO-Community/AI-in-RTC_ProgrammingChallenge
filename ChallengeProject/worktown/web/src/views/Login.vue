<template>
  <div class="home">
    <el-row>
      <el-col :offset="3" :span="9">
        <img alt="Vue logo" src="../assets/background.jpg" width="90%;">
      </el-col>
      <el-col :span="6">
        <p v-if="!showFace" style="margin:100px 0px 50px 0px;">办公小镇是一个远程虚拟办公环境<br>致力于解决团队远程合作的考勤与沟通问题。</p>
        <p v-if="showFace">
          <face width="100%" height="250px" @snap="loginByFace"/>
        </p>
        <el-alert v-if="errMsg" type="warning" :closable="false"> {{ errMsg }} </el-alert>
        <p v-if="showInput">
          <el-input
            v-model="user.loginName"
            style="width:200px;"
            type="text"
            placeholder="请输入用户名"
          />
        </p>
        <p v-if="showInput">
          <el-input
            v-model="user.password"
            type="password"
            style="width:200px;"
            placeholder="请输入密码"
            @keyup.enter.native="login"
          />
        </p>    
        <el-button type="primary" @click="showFace = !showFace; showInput = !showFace;">登录</el-button>
        <el-button type="primary" @click="$router.push({name: 'regist'})">注册</el-button>
      </el-col>
    </el-row>
  </div>
</template>
<script>
  import api from '@/api.js'
  import Const from '../Const'
  import Face from '../components/Face'
  export default {
    components: {
      face: Face
    },
    data () {
      return {
        user: {
          loginName: '',
          password: ''
        },
        showFace: false,
        showInput: false,
        timer: null,
        errMsg: null,
        errTimes: 0
      }
    },
    methods: {
      loginByFace (imgData) {
        let _this = this
        this.$message.closeAll()
        api.loginByFace({
          url: null,
          paras: {image: imgData, group_id: Const.DEFAULT_GROUP, topn: 1}
        }).then(token => {
         _this.$store.commit('login', token)
          return api.getCurrentUser()
        }).then(user => {
          if (!this.$store.state.loginUser) {
            _this.$store.commit('user', user)
          }
          return api.getConfig()
        }).then(config => {
          _this.$store.commit('config', config)
          _this.$socket.login(_this.$store.state.loginUser, config.socketServer)
          _this.$message.closeAll()
          _this.$router.push({name: 'office'})
        }).catch(err => {
          _this.errTimes++
          _this.$store.commit('logout')
          if (err.code === 1 && _this.errTimes > 2) {
            _this.errMsg = '未检测到人脸，请调整姿势或摄像头角度！'
          } else if (_this.errTimes > 2) {
            _this.errMsg = '检测到您尚未注册，请点击【注册】按钮开始注册吧！'
          } else {
            _this.errMsg = '正在识别您的信息，请耐心等候……'
          }
          console.log(err)
        })
      },
      login () {
        let _this = this
        this.$message.closeAll()
        if (!this.user.loginName || this.user.loginName.trim() === '') {
          this.$message.error('请输入用户名!')
          return
        }
        if (this.user.password === '') {
          this.$message.error('请输入密码!')
          return
        }
        api.login({loginName: this.user.loginName, password: this.user.password}).then(token => {
          _this.$store.commit('login', token)
          return api.getCurrentUser()
        }).then(user => {
          _this.$store.commit('user', user)
          return api.getConfig()
        }).then(config => {
          _this.$store.commit('config', config)
          _this.$socket.login(_this.$store.state.loginUser, config.socketServer)
          _this.$message.closeAll()
          _this.$router.push({name: 'office'})
        }).catch(err => {
          _this.$store.commit('logout')
          if (err.message) {
            _this.$message.error(err.message)
          } else {
            if (err !== 'cancel') {
              _this.$message.error(err)
            }
          }
        })
      }
    }
  }
</script>
<style scoped>
  .home {
    background-color:#F6F6F6;
    padding-top: 100px;
    }
  .el-row {
      margin: 20px;
  }
</style>
