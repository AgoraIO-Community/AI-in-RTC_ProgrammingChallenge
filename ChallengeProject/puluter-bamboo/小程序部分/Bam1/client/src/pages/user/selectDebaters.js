import Taro, { Component } from '@tarojs/taro'
import { View, Text, Button } from '@tarojs/components'
import './selectDebaters.less'
import 'taro-ui/dist/style/index.scss'
import {AtForm, AtCheckbox , AtButton, AtNoticebar} from 'taro-ui';
import md5 from 'js-md5';

export default class SelectDebaters extends Component {

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
    let _this = this;
    Taro.cloud.database({env:"factory-1"}).collection("mentor").where({env: Taro.getStorageSync("env"),
      userId:Taro.getStorageSync("userId")
    }).get({
      success: res => {
        Taro.setStorageSync("teamId",res.data[0].teamId);
        Taro.cloud.database({env:"factory-1"}).collection("battle-debaters-selection").where({env: Taro.getStorageSync("env"),
          battleId:Taro.getStorageSync("battleId"),
          teamId: Taro.getStorageSync("teamId")
        }).get({
          success: res2 => {
            Taro.cloud.database({env:"factory-1"}).collection('debater').where({env: Taro.getStorageSync("env"),
              teamId: res.data[0].teamId
            }).get({
              success: res1 => {
                let {checkboxOption} = _this.state;
                res1.data.map((item,index)=>{
                  checkboxOption[checkboxOption.length]={
                    label: item.name,
                    value: item._id
                  };
                });
                _this.setState({
                  checkboxOption:checkboxOption
                })
              }
            });
            if(res2.data.length!==0){
              _this.setState({
                checkedList:res2.data[0].data,
                hasData: true,
                dataId: res2.data[0]._id
              });
            }
          }
        })
      }
    })
    let dataC = [];
    Taro.cloud.database({env:"factory-1"}).collection("battle").doc(Taro.getStorageSync("battleId")).get({
      success: res4 => {
        let {title,time} = res4.data;
        _this.setState({
          battleInfo: `辩题：${title}  时间：${time}`
        });
        dataC=res4.data.data;
        if(dataC.teamClaim.Id!==Taro.getStorageSync("teamId")&&
          dataC.teamCounterClaim.Id!==Taro.getStorageSync("teamId")){
          Taro.reLaunch({url:"../index/index"});
        }
      }
    });
  }

  componentDidMount () { }

  componentWillUnmount () { }

  componentDidShow () {}

  componentDidHide () { }

  right(mainStr, lngLen){
    if(mainStr.length-lngLen>=0&&mainStr.length>=0&&mainStr.length-lngLen<=mainStr.length){
      return mainStr.substring(mainStr.length-lngLen,mainStr.length)}
    else{return null}
  }

  handleChange(value){
    console.log(value);
    if(value.length>4){
      Taro.showToast({
        title:"只能上四个人",
        icon: "none",
        duration: 2000
      })
    }
    else this.setState({
      checkedList: value
    })
  }

  onSubmit(){
    let {hasData,checkedList,dataId}=this.state;
    if(!hasData){
      Taro.cloud.database({env:"factory-1"}).collection("battle-debaters-selection").where({env: Taro.getStorageSync("env"),
        data: {
          teamId: Taro.getStorageSync("teamId"),
          battleId: Taro.getStorageSync("battleId"),
          data: checkedList
        },
        success: res => {
          Taro.showToast({
            title:"成功！",
            duration: 2000
          });
          Taro.navigateBack();
        }
      })
    }
    else {
      Taro.cloud.database({env:"factory-1"}).collection("battle-debaters-selection").doc(dataId)
        .update({
          data: {
            data: checkedList
          },
          success: res => {
            Taro.showToast({
              title:"成功！",
              duration: 2000
            }).then((res)=>{
              Taro.navigateBack();
            });

          }
        })
    }
  }

  render () {
    return (
      <View>
        <AtNoticebar>{this.state.battleInfo}</AtNoticebar>
        <View className='at-article'>
          <View className='at-article__h1'>
            欢迎您！导师 {Taro.getStorageSync("name")}
          </View>
        <AtCheckbox
          options={this.state.checkboxOption}
          selectedList={this.state.checkedList}
          onChange={this.handleChange.bind(this)}
        />
        <AtButton className={'b'} onClick={this.onSubmit.bind(this)}
          type={'primary'}>提交选择</AtButton>
        </View>
      </View>
    )
  }
}
