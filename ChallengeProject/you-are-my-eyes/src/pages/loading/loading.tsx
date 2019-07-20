
const AgoraMiniappSDK = require('../../lib/Agora_Miniapp_SDK_for_WeChat.js');
import Taro, { Component, Config } from '@tarojs/taro'
import { View, Text, LivePusher } from '@tarojs/components'
import './loading.scss'

export default class Loading extends Component {

  /**
   * 指定config的类型声明为: Taro.Config
   *
   * 由于 typescript 对于 object 类型推导只能推出 Key 的基本类型
   * 对于像 navigationBarTextStyle: 'black' 这样的推导出的类型是 string
   * 提示和声明 navigationBarTextStyle: 'black' | 'white' 类型冲突, 需要显示声明类型
   */
  config: Config = {

  }

  componentWillMount () { }

  componentDidMount () { }

  componentWillUnmount () { }

  componentDidShow () { }

  componentDidHide () { }

  render () {
    return (
      <View className='loading'>
          <LivePusher url='url' mode='RTC' />
          <Text>等待志愿者链接中……</Text>
      </View>
    )
  }
}
