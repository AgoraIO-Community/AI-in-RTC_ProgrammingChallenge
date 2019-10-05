import Taro, { Component } from '@tarojs/taro'
import { View, Text, Button } from '@tarojs/components'
import './judgeInit.less'
import {AtForm, AtInput, AtButton} from 'taro-ui';
import md5 from 'js-md5';

export default class JudgeInit extends Component {

  config = {
    navigationBarTitleText: '裁判后台 - 初始化'
  };

  state = {
    username:"",
    password:"",
    password2:"",
    name : ""
  };

  componentWillMount () {
    this.setState({
      name: Taro.getStorageSync('name')
    });
    console.log(Taro.getStorageSync('name'));
    Taro.cloud.database({env:"factory-1"}).collection("judge").doc(Taro.getStorageSync("judgeId")).get({
      success: res => {
        if(res.data.hasInit==="1") Taro.redirectTo({
          url: "./judge"
        })
      }
    })
  }

  componentDidMount () { }

  componentWillUnmount () { }

  componentDidShow () { }

  componentDidHide () { }


  handleChangeU(){
    this.setState({
      username: arguments[0]
    })
  }
  handleChangeP(){
    this.setState({
      password: arguments[0]
    })
  }
  handleChangeP2(){
    this.setState({
      password2: arguments[0]
    })
  }

  onSubmit() {
    let {username,password,password2} = this.state;
    if(password !== password2){
      Taro.showToast({
        title: '两次密码输入不同\n请重新输入',
        icon: 'none',
        duration: 2000
      });
      this.setState({
        password2: "",
        password: ""
      })
    }
    else {
      let col = Taro.cloud.database({env:"factory-1"}).collection('judge');
      col.where({env: Taro.getStorageSync("env"),
        username: username
      }).get({
        success: res => {
          if(res.data.length!==0){
            Taro.showToast({
              title: '您的用户名已被占用\n请重新输入',
              icon: 'none',
              duration: 2000
            });
            this.setState({
              username: ""
            })
          }
          else {
            col.add({
              data: {env: Taro.getStorageSync("env"),
                username: username,
                password: md5(password),
                hasInit: '1',
                name: Taro.getStorageSync('name')
              },
              success: res1 => {
                console.log(res1);
                Taro.cloud.database({env:"factory-1"}).collection("judgeHasInited").add({
                  data: {env: Taro.getStorageSync("env"),
                    hasInitedJId: Taro.getStorageSync("judgeId"),
                    hasInitedUId: Taro.getStorageSync("userId")
                  },
                  success: console.log,
                  fail: console.error
                });//TODO: 写后端 每10分钟执行一次删除操作
                Taro.setStorageSync("judgeId",res1._id);
                console.log(2);
                Taro.cloud.database({env:"factory-1"}).collection('judge').doc(res1._id).get({
                  success: res2 => {
                    console.log(1);
                    Taro.setStorageSync("username",res2.data.username);
                    Taro.setStorageSync("name",res2.data.name);
                    Taro.setStorageSync("userType",'judge');
                    console.log(res2);
                    Taro.cloud.database({env:"factory-1"}).collection("web-login").add({
                      data: {env: Taro.getStorageSync("env"),
                        username: username,
                        password: md5(password),
                        userType: "judge"
                      },
                      success: res3 => {
                        Taro.setStorageSync('userId',res3._id);
                        console.log(res3);
                        Taro.showToast({
                          title: '成功初始化',
                          duration: 2000
                        }).then(r=>{
                          Taro.redirectTo({url: './judge'});
                          return r;
                        });
                      },
                      fail: console.error
                    })
                  },
                  fail: console.error
                });
              }
            })
          }
        }
      })
    }
  }

  render () {
    let {name} = this.state;
    return (
      <View className='container'>
        <View className='at-article'>
          <View className='at-article__h1'>
            这里是裁判的初始化页面，请在确定您的信息后输入一个新用户名和新密码。
          </View>
          <View className='at-article__content'>
            <View className='at-article__section'>
              <View className='at-article__h2'>姓名</View>
              <View className='at-article__p'>{name}</View>
            </View>
          </View>
        </View>

        <View className={'contain'}>

          <AtForm
            onSubmit={this.onSubmit.bind(this)}
            className={'contain'}
          >
            <AtInput
              name='username'
              title='用户名'
              type='text'
              placeholder='请输入用户名'
              value={this.state.username}
              onChange={this.handleChangeU.bind(this)}
            />
            <AtInput
              name='password'
              title='密码'
              type='password'
              placeholder='请输入密码'
              value={this.state.password}
              onChange={this.handleChangeP.bind(this)}
            />
            <AtInput
              name='password'
              title='请重复密码'
              type='password'
              placeholder='请再输入一次密码'
              value={this.state.password2}
              onChange={this.handleChangeP2.bind(this)}
            />
            <AtButton formType='submit' type={'primary'}>提交</AtButton>
          </AtForm>
        </View>
      </View>
    )
  }
}
