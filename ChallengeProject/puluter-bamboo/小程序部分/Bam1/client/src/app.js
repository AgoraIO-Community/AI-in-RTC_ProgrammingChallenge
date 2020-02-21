import Taro, { Component } from '@tarojs/taro'
import Index from './pages/index'
import 'taro-ui/dist/style/index.scss'
import './app.less'

const AgoraMiniappSDK = require('./mini-app-sdk-production.js');
// import AgoraMiniappSDK from './mini-app-sdk-production.js';

// 如果需要在 h5 环境中开启 React Devtools
// 取消以下注释：
// if (process.env.NODE_ENV !== 'production' && process.env.TARO_ENV === 'h5')  {
//   require('nerv-devtools')
// }

class App extends Component {

  config = {
    pages: [
      'pages/index/index',
      'pages/schedule/schedule',
      'pages/user/judge',
      'pages/user/judgeInit',
      'pages/user/selectDebaters',
    ],
    window: {
      backgroundTextStyle: 'light',
      navigationBarBackgroundColor: '#fff',
      navigationBarTitleText: 'WeChat',
      navigationBarTextStyle: 'black'
    },
    cloud: true,
    plugins: {

    }
  };

  componentDidMount () {
    if (process.env.TARO_ENV === 'weapp') {
      Taro.cloud.init()
    }
    // let client = new AgoraMiniappSDK.Client();
    // client.init("f33f6802fc82413c8609626bfe36ae59",function () {
    //   console.log("success")
    // },function () {
    //   console.log("error")
    // });
    // console.log("???")
  }

  componentDidShow () {}

  componentDidHide () {}

  componentDidCatchError () {}

  // 在 App 类中的 render() 函数没有实际作用
  // 请勿修改此函数
  render () {
    return (
      <Index />
    )
  }
}

Taro.render(<App />, document.getElementById('app'))
