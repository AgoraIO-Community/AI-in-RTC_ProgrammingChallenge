<template>
  <div>
    <el-row>
      <el-col :sm="24" :md="12" :lg="8">
        <face width="100%" height="250px" @snap="loginByFace"/>
        <el-alert v-if="errMsg" type="warning" :closable="false"> {{ errMsg }} </el-alert>
      </el-col>
      <el-col :sm="24" :md="12" :lg="8">
        <el-form v-if="!registered" :model="user" :rules="rules" ref="userForm" label-width="80px">
          <el-form-item
            label="姓名"
            prop="name">
            <el-input
            v-model="user.name"
            placeholder="请输入用于显示的名称"
            minlength="1"
            maxlength="10"
            show-word-limit
            clearable/>
          </el-form-item>
          <el-form-item
            label="登录名"
            prop="loginName">
            <el-input
            v-model="user.loginName"
            placeholder="请输入登录名"
            minlength="1"
            maxlength="20"
            show-word-limit
            clearable/>
          </el-form-item>
          <el-form-item
            label="密码"
            prop="password">
            <el-input
            v-model="user.password"
            type="password"
            placeholder="请输入密码"
            minlength="1"
            maxlength="10"
            show-word-limit
            show-password
            clearable/>
          </el-form-item>
          <el-form-item>
            <el-button
              type="primary"
              @click="userSave()">保存</el-button>
            <el-button
              type="info"
              @click="$router.push({name: 'login'})">返回</el-button>
          </el-form-item>
        </el-form>
        <div v-if="registered" style="padding:20px;margin-top:50px;">
          <el-alert type="warning" :closable="false"> 检测到您已经注册过了，请返回首页登录吧！</el-alert>
          <p>
          <el-button
            type="primary"
            @click="$router.push({name: 'login'})">返回</el-button>
          </p>
        </div>
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
        name: '',
        loginName: '',
        password: '',
        imgData: null,
        group: Const.DEFAULT_GROUP
      },
      rules: {
        name: [
            {required: true, message: '请输入显示姓名', trigger: 'blur'},
            {min: 1, max: 10, message: '长度在1~10个字符', trigger: 'blur'}
        ],
        loginName: [
            {required: true, message: '请输入登录名', trigger: 'blur'},
            {min: 1, max: 20, message: '长度在1~20个字符', trigger: 'blur'}
        ],
        password: [
            {required: true, message: '请输入密码', trigger: 'blur'},
            {min: 1, max: 10, message: '长度在1~10个字符', trigger: 'blur'}
        ]
      },
      errMsg: null,
      registered: false
    }
  },
  methods: {
    loginByFace (imgData) {
      let _this = this
      api.loginByFace({
        url: null,
        paras: {image: imgData, group_id: Const.DEFAULT_GROUP, topn: 1}
      }).then(token => {
        _this.registered = true
        _this.errMsg = null
      }).catch(err => {
        if (err.code === 1) {
          _this.errMsg = '未检测到人脸，请调正姿势或摄像头角度！'
          _this.user.imgData = null
          _this.registered = false
        } else {
          _this.errMsg = null
          _this.user.imgData = imgData
        }
        console.log(err)
      })
    },
    userSave () {
      let _this = this
      this.$refs.userForm.validate(valid => {
        if (valid) {
          if (!this.user.imgData) {
            _this.$message.error('未检测到人脸，请调整姿势或摄像头角度！')
            return
          }
          api.regMember(_this.user).then( user => {
            _this.$message.success('注册成功，请登录！')
            _this.$router.push({name: 'login'})
          }).catch(err => {
            _this.$message.error(err.message)
          })
        }
      })
    }
  }
}
</script>
<style scoped>

</style>