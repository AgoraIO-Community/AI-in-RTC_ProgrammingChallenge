<template>
  <div id="app">
    <el-container>
      <el-header>
        <el-row>
          <el-col
            :span="12"
            style="">
            <a href="#/">
              <img src="./assets/logo.png" style="float:left;margin:5px;" width="50px;"/>
              <h3>办公小镇&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<el-tag v-if="team" type="warning" effect="dark" size="medium ">{{ team.name }}</el-tag></h3>
            </a>
          </el-col>
          <el-col
            :span="12"
            style="text-align:right">
            <h5 v-if="loginUser">
              <span>
                {{ loginUser.name }}
              </span>
              &nbsp;
              <el-button
                v-if="$route.name !== 'profile'"
                type="info"
                size="mini"
                icon="el-icon-setting"
                title='个人设置'
                @click="$router.push({name: 'profile'})"/>
              <el-button
                v-if="$route.name !== 'office'"
                type="info"
                size="mini"
                icon="el-icon-mouse"
                title='办公室'
                @click="$router.push({name: 'office'})"/>
              &nbsp;
              <el-button
                type="danger"
                size="mini"
                icon="el-icon-switch-button"
                title="退出登录"
                circle
                @click="logout"/>
            </h5>
            <h5 v-else>&nbsp;</h5>
          </el-col>
        </el-row>
      </el-header>
      <el-main>
        <router-view/>
      </el-main>
      <el-footer>
        <el-divider>&copy; 2019 办公小镇</el-divider>
      </el-footer>
    </el-container>
  </div>
</template>
<script>
  import { mapState } from 'vuex'
  import Const from './Const'
  export default {
    computed: {
        ...mapState([
        'loginUser',
        'team'
      ])
    },
    created () {
      let _this = this
      this.$bus.on(Const.MESSAGE_KICK_OUT, rst => {
        _this.$message({
          showClose: true,
          duration: 0,
          message: '检测到您在其它客户端重复登录，此处自动登出!',
          type: 'error'
        })
        _this.$store.commit('logout')
        _this.$router.push({name: 'login'})
      })
    },
    methods: {
      logout () {
        let _this = this
        this.$confirm('确实要退出吗?', '操作确认', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          if (!_this.loginUser) {
            return
          }
          _this.$socket.logout()
          _this.$store.commit('logout')
          _this.$router.push({name: 'login'})
        })
      }
    }
  }
</script>
<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 0px;
}
.el-header {
  background-color: dimgray;
  color: white;
  text-align: left;
}
.el-header a {
  color:white;
  text-decoration: none;
}
</style>
