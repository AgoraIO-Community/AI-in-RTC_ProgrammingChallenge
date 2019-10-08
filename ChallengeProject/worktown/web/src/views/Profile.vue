<template>
  <div>
    <el-row>
      <el-col :sm="24" :md="12" :lg="8">
          <el-form ref="form" label-width="80px">
            <el-form-item
              label="姓名">
              <el-input
                v-model="user.name"
                placeholder="请输入用于显示的名称"
                minlength="1"
                maxlength="10"
                show-word-limit
                clearable
                @keyup.enter.native="userSave()">
                <el-button
                  slot="append"
                  @click="userSave()">保存</el-button>
              </el-input>
            </el-form-item>
            <el-form-item
              label="密码">
              <el-input
                v-model="user.password"
                placeholder="请输入密码"
                minlength="1"
                maxlength="10"
                show-word-limit
                clearable
                showPassword
                @keyup.enter.native="userSave()">
                <el-button
                  slot="append"
                  @click="userSave()">保存</el-button>
              </el-input>
            </el-form-item>
            <el-form-item label="编码" style="text-align:left;">
              <span> {{ user.code }} </span>
            </el-form-item>
            <el-divider/>
            <el-form-item label="团队" v-if="team.code">
              <h2 v-if="team">{{ team.name }}</h2>
              <span v-if="user.code !== team.creator">{{ team.desc }}</span>
              <el-input
                v-else
                v-model="team.desc"
                placeholder="请输入团队简介"
                maxlength="100"
                show-word-limit
                clearable
                @keyup.enter.native="teamSave()">
                <el-button
                  slot="append"
                  @click="teamSave()">保存</el-button>
              </el-input>
            </el-form-item>
            <el-form-item v-if="team.code">
              <el-table
                :data="members"
                :show-header="false"
                :header-cell-style="{color: 'gray'}">
                <el-table-column
                  type="index"
                  label="#"/>
                <el-table-column
                  prop="name"
                  label="成员">
                  <template slot-scope="scope">
                  <span :title="scope.row.code"> {{ scope.row.name }} </span>
                  <i
                    v-if="scope.row.code === team.creator"
                    class="el-icon-medal-1" title="创建者"/>
                  <i
                    v-if="scope.row.code === user.code"
                    class="el-icon-caret-left" title="我"/>
                  </template>
                </el-table-column>
                <el-table-column
                  v-if="user.code === team.creator"
                  align="right"
                  label="操作">
                  <template slot-scope="scope">
                    <el-button
                      :disabled="scope.row.code === team.creator"
                      type="danger"
                      size="mini"
                      icon="el-icon-delete"
                      circle
                      plain
                      @click="memberQuit(scope.row)"/>
                    <el-button
                      type="info"
                      size="mini"
                      icon="el-icon-upload2"
                      circle
                      plain
                      @click="memberMoveUp(scope.row.code)"/>
                    <el-button
                      type="info"
                      size="mini"
                      icon="el-icon-download"
                      circle
                      plain
                      @click="memberMoveDown(scope.row.code)"/>
                  </template>
                </el-table-column>
                </el-table>
                <el-input
                  v-if="user.code === team.creator"
                  placeholder="请输入要追加成员的编码"
                  minlength="1"
                  maxlength="20"
                  show-word-limit
                  clearable
                  v-model="newMemberCode"
                  @keyup.enter.native="memberAdd()">
                <el-button
                  slot="append"
                  @click="memberAdd()">添加成员</el-button>
                </el-input>
            </el-form-item>
            <el-form-item v-if="team.code">
              <el-button
                v-if="user.code === team.creator"
                type="danger"
                @click="teamDelete()">解散团队</el-button>
                <el-button
                v-else
                type="danger"
                @click="memberQuit(user)">退出团队</el-button>
            </el-form-item>
            <el-form-item label="团队" v-if="!team.code">
              <el-alert type="warning" :closable="false" style="text-align:left;">
                尚未加入团队，你可以等待其他团队创建者将你添加至他的团队中，或者创建自己的团队。
              </el-alert>
            </el-form-item>
            <el-form-item v-if="!team.code">
              <el-input
                placeholder="请输入要创建团队的名称"
                minlength="1"
                maxlength="20"
                show-word-limit
                clearable
                v-model="newTeamName"
                @keyup.enter.native="teamAdd()">
                <el-button
                  slot="append"
                  @click="teamAdd()">创建团队</el-button>
              </el-input>
            </el-form-item>
          </el-form>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import api from '@/api.js'
import { mapState } from 'vuex'
export default {
  data () {
    return {
      user: {},
      team: {},
      members: [],
      newMemberCode: null,
      newTeamName: null
    }
  },
  computed: {
    ...mapState([
      'loginUser'
    ])
  },
  created () {
    let _this = this
    api.getMember(this.loginUser.code).then( user => {
      _this.user = user
    })
    if (this.loginUser.teamCode) {
      api.getTeam(this.loginUser.teamCode).then( team => {
        if (team) {
          _this.team = team
          return api.queryMember({teamCode: team.code})
        }
      }).then( members => {
        _this.members = members.items
      })
    }
  },
  methods: {
    userSave() {
      let _this = this
      api.saveMember(this.user).then(rst => {
        _this.$message.success('已保存！')
        _this.$store.commit('user', rst)
        for (let i = 0; i < _this.members.length; i++) {
            const member = _this.members[i];
            if (member.code === rst.code) {
                _this.members.splice(i, 1, rst)
                break
            }
        }
      })
    },
    memberAdd () {
      let _this = this
      api.getMember(this.newMemberCode).then(member => {
        if (_this.members.length >= 6) {
          throw new Error('成员数已达上限！')  
        } else if (!member) {
          throw new Error('用户不存在！')
        } else if (member.teamCode && member.teamCode === _this.team.code) {
          throw new Error('用户已经是' + _this.team.name + '的成员！')
        } else if (member.teamCode) {
          throw new Error('用户已加入其它团队！')
        }
        member.teamCode = _this.team.code
        member.orderIndex = _this.members.length + 1
        return api.saveMember(member)
      }).then(member => {
        _this.$message.success('已添加成员！')
        _this.members.push(member)
        _this.newMemberCode = null
      }).catch(err => {
        _this.$message.error(err.message)
      })
    },
    memberQuit (member) {
      let _this = this
      this.$confirm(member.name + '将离开' + this.team.name + '，是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        return api.getMember(member.code)
      }).then(member => {
        member.teamCode = null
        return api.saveMember(member)
      }).then(member => {
        if (member.code === _this.user.code) {
          _this.user = member
          _this.team = {}
          _this.members = []
          _this.$store.commit('user', member)
          _this.$store.commit('team', null)
          _this.$message.success('已退出团队！')
        } else {
          for (let i = 0; i < _this.members.length; i++) {
            const mem = _this.members[i];
            if (mem.code === member.code) {
                _this.members.splice(i, 1)
                break
            }
          }
          _this.$message.success('已移除成员！')
        }
      }).catch(err => {
        if (err) console.log(err)
      })
    },
    memberMoveUp (code) {
        
    },
    memberMoveDown (code) {
        
    },
    teamDelete () {
      let _this = this
      this.$prompt(this.team.name + '将会解散，是否继续? 请输入团队名称确认操作！', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
      }).then((rst) => {
        if (this.team.name === rst.value) {
          return api.deleteTeam(this.team.code)
        } else {
          throw new Error('名称不一致，操作取消！')
        }
      }).then(rst => {
        console.log('team deleted!')
        _this.team = {}
        _this.members = []
        _this.user.teamCode = null
        _this.$store.commit('user', _this.user) 
        _this.$store.commit('team', null)
        _this.$message.success('已解散团队！')
      }).catch(err => {
        if (err !== 'cancel') {
          _this.$message.error(err.message)
        }
      })
    },
    teamAdd (name) {
      let _this = this
      api.saveTeam({
        name: this.newTeamName,
        creator: this.user.code
      }).then(rst => {
        _this.user.teamCode = rst.code
        _this.user.orderIndex = 1
        _this.team = rst
        return api.saveMember(_this.user)
      }).then(member => {
        _this.$store.commit('user', member)
        _this.members.push(member)
        _this.$store.commit('team', _this.team)
        _this.$message.success('已创建团队！')
      }).catch(err => {
        _this.$message.error(err)
      })
    },
    teamSave () {
      let _this = this
      api.saveTeam(this.team).then(rst => {
        _this.$message.success('已保存！')
      })
    },
  }
}
</script>