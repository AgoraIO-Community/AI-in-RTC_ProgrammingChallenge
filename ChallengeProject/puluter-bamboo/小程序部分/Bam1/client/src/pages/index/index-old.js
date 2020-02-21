import Taro, { Component } from '@tarojs/taro'
import { View } from '@tarojs/components'
import './index.less'
import {AtButton, AtForm, AtInput, AtTabs, AtTabsPane} from 'taro-ui';
import Debater from '../user/debater';
import Battle from "../../components/battle";
import md5 from 'js-md5';
export default class Index extends Component {
  config = {
    navigationBarTitleText: '辩 · 竹',
  };

  state = {
    current: 0,
    idList: [],
    username:"",
    password:"",
    classList: ["container","c invisible","invisible","invisible"]
  };

  componentWillMount () {
    let {env} = this.$router.params;
    console.log(env);
    if(env === undefined&&Taro.getStorageSync("env") === "") console.log(10);
    Taro.setStorageSync("env",env);
    let p = this;
    let skpD = 0;
    Taro.cloud.database({env:"factory-1"}).collection("other").where({
      env: Taro.getStorageSync("env"),
      isSkpD : true
    }).get({
      success: res1 => {
        console.log(res1);
        skpD = res1.data[0].skpD;
        Taro.cloud.database({env:"factory-1"}).collection("battle").where({env: Taro.getStorageSync("env")}).skip(skpD).limit(12).get({
          success:function (res) {
            console.log(res);
            let idL = p.state.idList;
            res.data.map((item,index)=>{
              idL.push(item._id);
            });
            p.setState({
              idList: idL
            })
          },
          fail: console.error
        });
      },
      fail: console.error
    });
    if(Taro.getStorageSync('userType')==='judge') {
      this.setState({
        classList: ["container invisible","c","invisible","invisible"]
      })
    }
    else if(Taro.getStorageSync('userType')==='debater') {
      this.setState({
        classList: ["container invisible","c invisible","d","invisible"]
      })
    }
    else if(Taro.getStorageSync('userType')==='mentor') {
      this.setState({
        classList: ["container invisible","c invisible","d invisible","c"]
      })
    }
  }
  handleClick (value) {
    this.setState({
      current: value
    })
  }
  onSubmit(){
    let {username,password} = this.state;
    let pop = this;
    Taro.cloud.database({env:"factory-1"})
      .collection("web-login")
      .where({env: Taro.getStorageSync("env"),
      username: username,
      password: md5(password)
    }).get({
      success: function (res) {
        if(res.data.length!==0){
          Taro.showToast({
            title: '登录成功！',
            icon: 'success',
            duration: 2000
          });
          Taro.setStorageSync("userId",res.data[0]._id);
          Taro.setStorageSync("username",res.data[0].username);
          Taro.setStorageSync("name",res.data[0].username);
          Taro.setStorageSync("userType",res.data[0].userType);
          if(res.data[0].userType==="judge"){
            Taro.cloud.database({env:"factory-1"}).collection("judge").where({env: Taro.getStorageSync("env"),
              username: res.data[0].username
            }).get({
              success: res1 => {
                Taro.setStorageSync("name", res1.data[0].name);
                Taro.setStorageSync("judgeId", res1.data[0]._id);
                console.log(res1);
                if(res1.data[0].hasInit === "0") Taro.navigateTo({url:"../user/judgeInit"});
                pop.setState({
                  classList : ["container invisible","c","d invisible","d invisible"]
                })
              },
              fail: console.error
            });
          }
          else if(res.data[0].userType==="debater"){
            pop.setState({
              classList : ["container invisible","c invisible","d ","invisible"]
            })
          }
          else if(res.data[0].userType==="mentor"){
            pop.setState({
              classList : ["container invisible","c invisible","d invisible","c"]
            })
          }
          Taro.reLaunch({url:"../index/index"})
        }
        else {
          Taro.showToast({
            title: '用户名或密码错误，请重试！',
            icon: 'none',
            duration: 2000
          });
          Taro.removeStorageSync("userId");
          Taro.removeStorageSync("username");
          Taro.removeStorageSync("name");
          Taro.removeStorageSync("userType");
          Taro.removeStorageSync("battleId");
          Taro.removeStorageSync("judgeId");
        }
      },
      error: console.error
    });
  }
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
  startJudging(battleId){
    Taro.setStorageSync('battleId',battleId);
    Taro.navigateTo({
      url:"../user/judge"
    });
  }
  startSelecting(battleId){
    Taro.setStorageSync('battleId',battleId);
    Taro.navigateTo({
      url:"../user/selectDebaters"
    });
  }

  logout(){
    Taro.removeStorageSync("userId");
    Taro.removeStorageSync("username");
    Taro.removeStorageSync("name");
    Taro.removeStorageSync("userType");
    Taro.removeStorageSync("battleId");
    Taro.removeStorageSync("judgeId");
    this.setState({
      classList : ["container","c invisible","d invisible"]
    })
  }

  onPullDownRefresh(){
    // this.componentWillMount();
  }



  render () {
    const tabList = [{ title: '日程' },  { title: '我' }];//{ title: '排名' },
    return (

      <View className='index'>

        <AtTabs current={this.state.current} tabList={tabList} onClick={this.handleClick.bind(this)}>
          <AtTabsPane current={this.state.current} index={0} >
            <View style='' >
              {this.state.idList.map((item,index)=>{
                return (<Battle key={index} onStartJudging={this.startJudging.bind(this,item)}
                                onStartSelecting={this.startSelecting.bind(this,item)} Id={item}/>)
              })}
            </View>
          </AtTabsPane>
          {/*<AtTabsPane current={this.state.current} index={1}>*/}
          {/*  <View style='padding: 100px 50px;background-color: #FAFBFC;text-align: center;'>标签页二的内容</View>*/}
          {/*</AtTabsPane>*/}
          <AtTabsPane current={this.state.current} index={1}>
            <View style=''>
              <View className={this.state.classList[0]}>
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
                  <AtButton formType='submit' type={'primary'} className={'formBtn'}>提交</AtButton>
                </AtForm>
              </View>
              <View className={this.state.classList[1]}>
                {/*欢迎您 裁判___ 您可以在左边部分选择主裁场次进行裁决*/}
                <View className='at-article'>
                  <View className='at-article__h1'>
                    欢迎您！裁判 {Taro.getStorageSync("name")}
                  </View>
                  <View className='at-article__content'>
                    <View className='at-article__section'>
                      <View className='at-article__h2'>您可以在左边部分选择主裁场次进行裁决</View>
                    </View>
                    <AtButton type={"primary"} onClick={this.logout.bind(this)} size={'normal'} className={'b'}>登出</AtButton>
                  </View>
                </View>
              </View>
              <View className={this.state.classList[2]}>
                <Debater />
                <AtButton type={"primary"} onClick={this.logout.bind(this)} size={'normal'} className={'b'}>登出</AtButton>
                <View className={'e'}> </View>
              </View>
              <View className={this.state.classList[3]}>
                <View className='at-article'>
                  <View className='at-article__h1'>
                    欢迎您！导师 {Taro.getStorageSync("name")}
                  </View>
                  <View className='at-article__content'>
                    <View className='at-article__section'>
                      <View className='at-article__h2'>您可以在左边部分选择辩手出战</View>
                    </View>
                    <AtButton type={"primary"} onClick={this.logout.bind(this)} size={'normal'} className={'b'}>登出</AtButton>
                  </View>
                </View>
              </View>
              <View className={'e'}> </View>

            </View>
          </AtTabsPane>
        </AtTabs>
      </View>
    )
  }
}
