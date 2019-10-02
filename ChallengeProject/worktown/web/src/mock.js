/* eslint-disable no-console */
import md5 from 'js-md5'

// 引入mockjs
const Mock = require('mockjs')
// 获取 mock.Random 对象
const Random = Mock.Random
// mock一组数据


// 返回值结构
const GetDefaultResult = function (obj, forceObj) {
  let rst = obj
  if (!forceObj) {
    if (obj instanceof Array) {
      rst = {
        pageindex: 1,
        pageSize: 10,
        items: obj
      }
    }
  }
  return {
    code: 0,
    message: '',
    context: rst
  }
}
const GetErrResult = function (msg) {
  return {
    code: 1,
    message: msg,
    context: null
  }
}

// ************************** 用户 ************************** /
let members = [
  {userName: 'u1', password: '1', code: '0001', name: '郭德纲', teamCode: 'dys', orderIndex: 1},
  {userName: 'u2', password: '1', code: '0002', name: '于谦', teamCode: 'dys', orderIndex: 2},
  {userName: 'u3', password: '1', code: '0003', name: '岳云鹏', teamCode: 'dys', orderIndex: 3},
  {userName: 'u4', password: '1', code: '0004', name: '孙越', teamCode: 'dys', orderIndex: 4},
  {userName: 'u5', password: '1', code: '0005', name: '郭麒麟', teamCode: 'dys', orderIndex: 5},
  {userName: 'u6', password: '1', code: '0006', name: '曹云金', teamCode: 'dys', orderIndex: 6},
  {userName: 'u7', password: '1', code: '0007', name: '路人甲', teamCode: null, orderIndex: 1}
]
const getMembers = function (para) {
  console.log(para)
  let userName = /\?userName=(.*)/i.exec(para.url)[1]
  if (userName) {
    let rst = []
    for (let i = 0; i < members.length; i++) {
      const member = members[i];
      if (member.userName === userName) {
        rst.push(member)
      }
    }
    return GetDefaultResult(rst)
  }
  return GetDefaultResult(members)
}
const getMember = function (para) {
  let code = para.url.split('/')[3]
  if (!code && para.body) {
    let newMem = JSON.parse(para.body)
    newMem.code = Random.id()
    members.push(newMem)
    return GetDefaultResult(newMem)
  }
  for (let i = 0; i < members.length; i++) {
    const member = members[i]
    if (member.code === code) {
      if (para.body) {
        let newMem = JSON.parse(para.body)
        members.splice(i, 1, newMem)
        return GetDefaultResult(newMem)
      }
      return GetDefaultResult(member)
    }
  }
  return GetDefaultResult(null)
}
let currentUser = {}
const login = function (para) {
  currentUser = JSON.parse(para.body)
  let success = false
  for (let i = 0; i < members.length; i++) {
    const member = members[i];
    if (member.userName === currentUser.loginName && member.password === currentUser.password) {
      success = true
      break
    }
  }
  if (success) {
    return GetDefaultResult('eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySW5mbyI6eyJsb2dpbk5hbWUiOiJkb2N0b3IxIiwicGFzc3dvcmQiOiIqIiwiZGlzcGxheU5hbWUiOiLnrqHnkIblkZgiLCJlbmFibGVkIjp0cnVlLCJ1c2VyVHlwZURpY3QiOiIxIiwidHlwZUNvZGUiOiIwN0UxQThBNjVEMDhBRTcwIiwic3JjVXNlciI6eyJpZCI6MTIsImNvZGUiOiIwN0UxQThBNjVEMDhBRTcwIiwibmFtZSI6IueuoeeQhuWRmCIsInBvc2l0aW9uRGljdCI6IjIzMSIsImhvc3BpdGFsQ29kZSI6IkU1MkUzMzZFQjg2QkY4QTQiLCJob3NwaXRhbE5hbWUiOiLnpZ7lqIHmtYvor5XljLvpmaIyIiwiZGVwdENvZGUiOiIwNCIsImRlcHROYW1lIjoi5aSW56eRIn19LCJleHAiOjE1NjcxNzMxNjZ9.V1kgubvMJhz4douKbDgKqOiDPHSPvSExSF24sLv423Q')
  } else {
    return GetErrResult('用户名或密码错误！')
  }
}
const token = function (para) {
  console.log(para)
  return GetDefaultResult('eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySW5mbyI6eyJsb2dpbk5hbWUiOiJkb2N0b3IxIiwicGFzc3dvcmQiOiIqIiwiZGlzcGxheU5hbWUiOiLnrqHnkIblkZgiLCJlbmFibGVkIjp0cnVlLCJ1c2VyVHlwZURpY3QiOiIxIiwidHlwZUNvZGUiOiIwN0UxQThBNjVEMDhBRTcwIiwic3JjVXNlciI6eyJpZCI6MTIsImNvZGUiOiIwN0UxQThBNjVEMDhBRTcwIiwibmFtZSI6IueuoeeQhuWRmCIsInBvc2l0aW9uRGljdCI6IjIzMSIsImhvc3BpdGFsQ29kZSI6IkU1MkUzMzZFQjg2QkY4QTQiLCJob3NwaXRhbE5hbWUiOiLnpZ7lqIHmtYvor5XljLvpmaIyIiwiZGVwdENvZGUiOiIwNCIsImRlcHROYW1lIjoi5aSW56eRIn19LCJleHAiOjE1NjcxNzcwMTd9.fnxzTmSyvAiAWhrezmxiRimax7nvHUbh82Tz6U_omNY')
}
const GetCurrentUser = function () {
  for (let i = 0; i < members.length; i++) {
    const member = members[i]
    if (member.userName === currentUser.loginName) {
        return GetDefaultResult(member)
    }
  }
  return GetDefaultResult({
    code: Random.id(),
    name: Random.cname(),
  })
}

// ************************** 配置 ************************** /
const GetConfig = function () {
  return GetDefaultResult({
    socketServer: 'ws://192.168.0.101:8800',
    videoServer: '0cd0b77c887f48c5911eef9bbcf28b4a',
    defaultPageSize: 20,
    reconnectOverTime: 60
  })
}

// ************************** 团队 ************************** /
let teams = [
  {code: 'dys', name: '德云社', creator: '0001', desc: '牛逼的相声社团'},
  {code: 'wk', name: '悟空', creator: 'w0001', desc: '师徒四人'},
  {code: 'snk', name: '斯内克', creator: 's0001', desc: '特工集团'},
  {code: 'gkb', name: '过客帮', creator: 'g0001', desc: '挥挥衣袖不带走一片云巢'},
  {code: 'jyt', name: '加油团', creator: 'j0001', desc: '啦啦队'},
  {code: 'hlb', name: '红萝卜', creator: 'h0001', desc: '撸兔子'}
]
// const getTeams = function (para) {
//   console.log(para)
//   return GetDefaultResult(teams)
// }
const getTeam = function (para) {
  console.log(para)
  let code = para.url.split('/')[3]
  if (!code && para.body) {
    let newTeam = JSON.parse(para.body)
    newTeam.code = Random.id()
    teams.push(newTeam)
    return GetDefaultResult(newTeam)
  }
  for (let i = 0; i < teams.length; i++) {
    const team = teams[i]
    if (team.code === code) {
      if (para.body) {
        let newTeam = JSON.parse(para.body)
        teams.splice(i, 1, newTeam)
        return GetDefaultResult(newTeam)
      }
      return GetDefaultResult(team)
    }
  }
  return GetDefaultResult(null)
}
const getTeamMembers = function (para) {
  console.log(para)
  let code = para.url.split('/')[3]
  let rst = []
  for (let i = 0; i < members.length; i++) {
    const member = members[i]
    if (member.teamCode === code) {
      rst.push(member)
    }
  }
  return GetDefaultResult(rst)
}
const deleteTeam = function (para) {
  let code = para.url.split('/')[3]
  for (let i = 0; i < members.length; i++) {
    const member = members[i]
    if (member.teamCode === code) {
      member.teamCode = null
    }
  }
  for (let i = 0; i < teams.length; i++) {
    const team = teams[i];
    if (team.code === code) {
      teams.splice(i, 1)
      break
    }
  }
  return GetDefaultResult(true)
}
const proxy = function (para) {
  console.log(para)
  let ps = para.url.split('?')[1]
  let psarray = ps.split('&')
  let rst = psarray.sort().join('&')
  rst += '&app_key=hz8ujcHHTyDmIJQT'
  rst = md5(rst).toUpperCase()
  return GetDefaultResult({sign: rst})
}

// ************************** 方法匹配 ************************** /
// Mock.mock( url, post/get , 返回的数据)；
Mock.mock(/\/api\/member\?.*/, 'get', getMembers)
Mock.mock(/\/api\/member\/.*?$/, 'get', getMember)
Mock.mock(/\/api\/member$/, 'post', getMember)
Mock.mock(/\/api\/member\/.*?$/, 'put', getMember)
// Mock.mock(/\/api\/team$/, 'get', getTeams)
Mock.mock(/\/api\/team\/.*?\/members$/, 'get', getTeamMembers)
Mock.mock(/\/api\/team\/.*?$/, 'get', getTeam)
Mock.mock(/\/api\/team\/.*?$/, 'put', getTeam)
Mock.mock(/\/api\/team$/, 'post', getTeam)
Mock.mock(/\/api\/team\/.*?$/, 'delete', deleteTeam)

Mock.mock(/\/api\/login$/, 'post', login)
Mock.mock(/\/api\/login\/currentUser$/, 'get', GetCurrentUser)
Mock.mock(/\/api\/login\/config$/, 'get', GetConfig)
Mock.mock(/\/api\/login\/token$/, 'get', token)

Mock.mock(/\/api\/proxy\?.*/, 'get', proxy)


