import Taro, { Component } from '@tarojs/taro'
import { View, Text, Button } from '@tarojs/components'
import 'taro-ui/dist/style/index.scss'
const AgoraMiniappSDK = require('../../Agora_Miniapp_SDK_for_WeChat.js');
// import '../../Agora_Miniapp_SDK_for_WeChat';

export default class Test extends Component {

  config = {
    navigationBarTitleText: '选择辩手 | 辩 · 竹'
  };

  constructor() {
    super(...arguments);
    this.state = {
      debaters: [],
      selections : [],
      checkboxOption: [],
      checkedList: [],
      hasData: false
    };
  }

  componentWillMount () {
    this.client.init("f33f6802fc82413c8609626bfe36ae59",function () {
      console.log("success")
    },function () {
      console.log("error")
    });
    console.log("???")
  }

  componentDidMount () { }

  componentWillUnmount () { }

  componentDidShow () {}

  componentDidHide () { }

  render () {
    return (
      <View> 123
      </View>
    )
  }
}
