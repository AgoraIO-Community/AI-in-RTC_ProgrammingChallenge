import Vue from 'vue'
import Router from 'vue-router'
import store from './store'
// import Home from './views/Home.vue'
import Login from './views/Login.vue'
import Regist from './views/Regist.vue'
import Profile from './views/Profile.vue'
import Office from './views/Office.vue'
// import Report from './views/Report.vue'

Vue.use(Router)

let router = new Router({
  routes: [
    // {
    //   path: '/',
    //   name: 'home',
    //   component: Home,
    //   meta: {
    //     requiresAuth: false
    //   }
    // },
    {
      path: '/',
      name: 'login',
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/regist',
      name: 'regist',
      component: Regist,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: '/profile',
      name: 'profile',
      component: Profile,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/office',
      name: 'office',
      component: Office,
      meta: {
        requiresAuth: true
      }
    }//,
    // {
    //   path: '/report',
    //   name: 'report',
    //   component: Report,
    //   meta: {
    //     requiresAuth: true
    //   }
    // },
    // {
    //   path: '/about',
    //   name: 'about',
    //   // route level code-splitting
    //   // this generates a separate chunk (about.[hash].js) for this route
    //   // which is lazy-loaded when the route is visited.
    //   component: () => import(/* webpackChunkName: "about" */ './views/About.vue'),
    //   meta: {
    //     requiresAuth: true
    //   }
    // }
  ]
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(r => r.meta.requiresAuth)) {
    if (store.state.token) {
      next()
    } else {
      next({
        path: '/',
        query: {redirect: to.fullPath}
      })
    }
  } else {
    if (to.matched.some(r => r)) {
      if (store.state.token) {
        next({
          path: '/office'
        })
      } else {
        next()
      }
    } else {
      next({
        path: '/err',
        query: {redirect: to.fullPath}
      })
    }
  }
})

export default router

