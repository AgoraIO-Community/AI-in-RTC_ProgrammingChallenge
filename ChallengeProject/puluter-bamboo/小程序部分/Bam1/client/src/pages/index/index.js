import Taro, { Component } from '@tarojs/taro'
import { View, Text, Picker, Image } from '@tarojs/components'
import { AtButton } from "taro-ui"
import "./index.less"

export default class Index extends Component {
  config = {
    navigationBarTitleText: "选择比赛",
  };
  state = {
    selectorChecked: '点击这里来进行选择',
    envs: [],
    envs_d :[],
    env_img_url: "https://6661-factory-1-1259507417.tcb.qcloud.la/basicprofile.jpeg?sign=ed79e6ff6990fc7642a3322ad2602e14&t=1569049725"
  }
  componentWillMount() {
    let _this = this;
    Taro.cloud.database({env:"factory-1"}).collection("envs").get({
      success: res => {
        let arr = [],arr1=[];
        res.data.map((item)=>{
          arr.push(item.cName);
          arr1[item.cName]=item;
        })
        _this.setState({envs:arr,envs_d:arr1});
        console.log(arr1);
      }
    })
  }
  onEnter(){
    let _this = this;
    console.log(_this.state.envs_d[_this.state.selectorChecked].name)
    Taro.navigateTo({
      url:"../schedule/schedule?env="+_this.state.envs_d[_this.state.selectorChecked].name+"&cName="+_this.state.envs_d[_this.state.selectorChecked].cName
    })
  }
  onChange = e => {
    this.setState({
      selectorChecked: this.state.envs[e.detail.value],
      env_img_url: this.state.envs_d[this.state.envs[e.detail.value]].imgUrl
    })
    console.log(this.state.envs_d[this.state.envs[e.detail.value]])
  }
  render () {
    return (
      <View className='container'>
        <View className='logo'>
          <Image src={this.state.env_img_url} className='logo' />
        </View>
        <View className='select'>
            <Picker mode='selector' range={this.state.envs} onChange={this.onChange}>
              {this.state.selectorChecked}
            </Picker>
        </View>

        <View className='btnn'>
          <AtButton type='primary' onClick={this.onEnter.bind(this)}>进入主页</AtButton>
        </View>

      </View>
    )
  }
}
