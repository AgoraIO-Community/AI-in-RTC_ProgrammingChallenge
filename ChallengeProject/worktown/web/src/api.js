/* eslint-disable no-console */
import axios from 'axios'
import Qs from 'qs'
import socket from '@/socket.js'
import store from '@/store'
import router from '@/router'

axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'

// 请求拦截器
axios.interceptors.request.use(function (config) {
  if (store.state.token) { // 判断是否存在token，如果存在的话，则每个http header都加上token
    config.headers.Authorization = `token ${store.state.token}`
    refreshToken()
  }
  return config
}, function (error) {
  return Promise.reject(error)
})
// 响应拦截器
axios.interceptors.response.use(function (response) {
  return response
}, function (error) {
  if (error.response) {
    switch (error.response.status) {
    case 401:
      // 返回 401 清除token信息并跳转到登录页面
      socket.logout()
      store.commit('logout')
      router.replace({
        path: '/',
        query: {redirect: router.currentRoute.fullPath}
      })
    }
  }
  return Promise.reject(error)
})

let tokenIsRefreshing = false
function refreshToken () {
  // 刷新条件：存在过期时间，当前时间尚未过期，当前时间距离过期不到10分钟
  if (!tokenIsRefreshing && store.state.tokenExp && (new Date() > new Date(Number(store.state.tokenExp) - (1000 * 60 * 10))) && (new Date() < new Date(Number(store.state.tokenExp)))) {
    console.log('刷新token，过期时间' + new Date(store.state.tokenExp))
    tokenIsRefreshing = true
    return new Promise((resolve, reject) => {
      api.token().then(token => {
        store.commit('login', token)
        tokenIsRefreshing = false
        resolve(token)
        console.log('刷新成功！')
      }).catch((error) => {
        reject(error)
      })
    })
  }
}

// const notTreatmentDoctorErr = new Error('求助者不能操作医师工作站！')

// 封装axios的post请求
export function post (url, params) {
  return new Promise((resolve, reject) => {
    axios.post(url, params).then(response => {
      if (response.data.code === 0) {
        resolve(response.data.context)
      } else {
        reject(response.data)
      }
    }).catch((error) => {
      reject(error)
    })
  })
}
// 封装axios的get请求
export function get (url, params) {
  return new Promise((resolve, reject) => {
    if (params && params.pageIndex) {
      params.pageIndex -= 1
    }
    axios.get(url, {
      params: params,
      paramsSerializer: params => {
        return Qs.stringify(params, { indices: false })
      }
    }).then(response => {
      if (response.data.code === 0) {
        if (response.data.context && (response.data.context.index || response.data.context.index === 0)) {
          response.data.context.index += 1
        }
        resolve(response.data.context)
      } else {
        reject(response.data)
      }
    }).catch((error) => {
      reject(error)
    })
  })
}
// 封装axios的put请求
export function put (url, params) {
  return new Promise((resolve, reject) => {
    axios.put(url, params).then(response => {
      if (response.data.code === 0) {
        resolve(response.data.context)
      } else {
        reject(response.data)
      }
    }).catch((error) => {
      reject(error)
    })
  })
}
// 封装axios的delete请求
export function del (url, params) {
  return new Promise((resolve, reject) => {
    axios.delete(url, params).then(response => {
      if (response.data.code === 0) {
        resolve(response.data.context)
      } else {
        reject(response.data)
      }
    }).catch((error) => {
      reject(error)
    })
  })
}

let api = {
  // 登录
  login (params) {
    return post('/api/login', params)
  },
  // 刷新token
  token () {
    return get('/api/login/token')
  },
  // 取得当前配置
  getConfig () {
    return get('/api/login/config', {})
  },
  // 取得当前用户
  getCurrentUser () {
    return get('/api/login/currentUser', {})
  },
  // ================== 用户 =====================

  // 查询用户列表 (查询条件)
  queryMember (params) {
    return get('/api/member', params)
  },
  // 取得单一用户（编码）
  getMember (code) {
    return get('/api/member/' + code)
  },
  saveMember (member) {
    if (member.code) {
      return put('/api/member/' + member.id , member)
    } else {
      return post('/api/member', member)
    }
  },
  regMember (member) {
    return post('/api/member/reg', member)
  },
  // ================== 团队==================
  // 取得单一团队
  getTeam (code) {
    return get('/api/team/' + code)
  },
  saveTeam (team) {
    if (team.id) {
      return put('/api/team/' + team.id , team)
    } else {
      return post('/api/team', team)
    }
  },
  deleteTeam (id) {
    return del('/api/team/' + id)
  },
  // ================== 腾讯==================
  tencent (para) {
    return post('/api/proxy/tencent', para)
  },
  loginByFace (para) {
    return post('/api/proxy/login', para)
  }
}
export default api
