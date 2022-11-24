import Taro, { Component } from '@tarojs/taro'
import {View, Image, Text} from '@tarojs/components';
import {AtTag, AtButton} from 'taro-ui';
import 'taro-ui/dist/style/index.scss';
import './battle.scss';
const BATTLE = {
  STATUS: {
    SCHEDULED: 0,
    ONGOING: 1,
    FINISHED: 2
  }
};

export default class Battle extends Component {
  state = {
    txtD:"选择辩手",
    _id:"aaaaaaaaaa",
    status: BATTLE.STATUS.SCHEDULED,
    time: "0706",
    loc: "教学楼三楼302",
    title: "于卓浩能不能找到人生目标",
    wl:2,
    data: {
      teamClaim:{
        name:"人大附中",
        imgUrl:"https://jdc.jd.com/img/100",
        point:""
      },
      teamCounterClaim:{
        name:"北大附中",
        imgUrl:"https://jdc.jd.com/img/100",
        point:"",
      }
    }
  };

  constructor(){
    super(...arguments);
  }

  componentDidMount () {
    this.setState({
      _id:this.props.Id
    });
    let p = this;
    let db = Taro.cloud.database({ env:"factory-1"});
    db.collection("battle").where({env: Taro.getStorageSync("env"),_id:this.props.Id}).get({
      success:function (res) {
        let nameA,imgA,nameB,imgB;
        db.collection("team").where({env: Taro.getStorageSync("env"),_id:res.data[0].data.teamClaim.Id}).get({
          success:function (res1) {
            nameA=res1.data[0].name;
            imgA=res1.data[0].imgUrl;
            db.collection("team").where({env: Taro.getStorageSync("env"),_id:res.data[0].data.teamCounterClaim.Id}).get({
              success:function (res2) {
                nameB=res2.data[0].name;
                imgB=res2.data[0].imgUrl;
                p.setState({
                  status: res.data[0].status,
                  time:   res.data[0].time,
                  loc:    res.data[0].loc,
                  title:  res.data[0].title,
                  wl:     res.data[0].wl,
                  data: {
                    teamClaim:{
                      name: nameA,
                      imgUrl:imgA,
                      point: res.data[0].data.teamClaim.point
                    },
                    teamCounterClaim:{
                      name:nameB,
                      imgUrl:imgB,
                      point: res.data[0].data.teamCounterClaim.point
                    }
                  }
                })
              },
            });
          },
        });
      }
    })
    let _this = this;
    Taro.cloud.database({env:"factory-1"}).collection("battle-debaters-selection").where({env: Taro.getStorageSync("env"),
      battleId: _this.props.Id,
      teamId: Taro.getStorageSync("teamId")
    }).get({
      success: res5 => {
        if(res5.data.length!==0) {
          _this.setState({
            txtD: "修改选择"
          });
        }
      }
    })
  }
  componentDidShow () {}
  componentDidHide () {}
  componentDidCatchError () {}
/*
 * status,time,loc,title,data{teamClaim{name,imgUrl,point,wl},teamCounterClaim{name,imgUrl,point,wl}}
 * status:
 * 0:scheduled: 计划 未开始
 * 1:ongoing: 正在进行 （目前阶段&用时）
 * 2:finished: 已经结束（得票 结果）
 *
 * wl: 0正方赢 1反方赢 2未开始/结束
 */
  handleTagClick(){
    this.props.onStartJudging&&this.props.onStartJudging(this.state._id);
  }
  handleTagClick1(){
    this.props.onStartSelecting&&this.props.onStartSelecting(this.state._id);
  }
  render () {
    let {status,data,title,time,loc,wl} = this.state;
    let wlStyle = [wl==="1"?"team-loss":"team-win",wl==="0"?"team-loss":"team-win"];
    if(wl==="2"){
      wlStyle=["",""]
    }
    let txt = status===BATTLE.STATUS.FINISHED?"已结束":"";
    return (
      <View className={'container'}>
        <View className={'battle-all'}>
          <View className={'title-bar'}>
            <Text className={'debateTheme'}>{title}</Text>
            <View className={'bar-btn '+(Taro.getStorageSync('userType')==='judge'?"":"invisible")}>
              <AtTag type='primary' onClick={this.handleTagClick.bind(this)} active circle size='small'>开始此场裁决</AtTag>
            </View>
            <View className={'bar-btn '+(Taro.getStorageSync('userType')==='mentor'?"":"invisible")}>
              <AtTag type='primary' onClick={this.handleTagClick1.bind(this)} active={this.state.txtD==="选择辩手"} circle size='small'>{this.state.txtD}</AtTag>
            </View>
          </View>
          <View className={'below'}>
            <View className={'left'}>
              <View className={'team '+wlStyle[0]}>
                <View className={'teamC'}>
                  <Image className={'teamIcon'} src={data.teamClaim.imgUrl}/>
                  <Text className={'teamName'}>{data.teamClaim.name}</Text>
                  <View className={'tag'}>
                    <AtTag type='primary' active size='small' circle>正方</AtTag>
                  </View>
                </View>
                <Text className={'point'}>{data.teamClaim.point}</Text>
              </View>
              <View className={'team '+wlStyle[1]}>
                <View className={'teamC'}>
                  <Image className={'teamIcon'} src={data.teamCounterClaim.imgUrl}/>
                  <Text className={'teamName'}>{data.teamCounterClaim.name}</Text>
                  <View className={"tag"}>
                    <AtTag size='small' circle>反方</AtTag></View>
                </View>
                <Text className={'point'}>{data.teamCounterClaim.point}</Text>
              </View>
            </View>
            <View className={'time'}>
              <View>{txt}</View>
              <View className={'dd'}>{time}</View>
              <View className={'dd'}>{loc}</View>
            </View>
          </View>
        </View>
      </View>
    )
  }
}

