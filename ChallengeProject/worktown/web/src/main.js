import Vue from 'vue'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import bus from 'vue-bus'
import router from './router'
import store from './store'
import socket from './socket'
import App from './App.vue'

Vue.config.productionTip = false
// // 引入mockjs
// require('./mock.js')

Vue.use(bus)

Vue.use(ElementUI);

Vue.use(socket)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
