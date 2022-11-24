import Taro, { Component } from '@tarojs/taro'
import { View, Text, Button, ScrollView } from '@tarojs/components'
import './judge.less'
import {AtForm, AtInputNumber, AtInput, AtButton, AtModal, AtNoticebar} from 'taro-ui';

export default class Judge extends Component {
  config = {
    navigationBarTitleText: '裁判后台'
  };
  state = {
    username:"",
    password:"",
    rule: "3,,,0,;0,C1,,240,申论;1,CC2,C1,150,质询;0,CC1,,240,申论;1,C3,CC1,150,质询;0,C2,,180,申论;1,CC3,C2,150,质询;0,CC2,,180,申论;1,C1,CC2,150,质询;0,C3,,180,申论;1,CC1,C3,150,质询;0,CC3,,180,申论;1,C2,CC3,150,质询;0,C4,,120,小结;0,CC4,,120,小结;2,,,240,自由辩论;0,C4,,210,结辩;0,CC4,,210,结辩;",
    rules: [],
    posList : ["","正方一辩","正方二辩","正方三辩","正方四辩","反方一辩","反方二辩","反方三辩","反方四辩",],
    pointList: [[],["","","",""],["","","",""],["","","",""],["","","",""],["","","",""],["","","",""],["","","",""],["","","",""]],//单人都是30分 双人各20分 自由辩各30分 整体立论30分
    //[申论，质询，答辩，自由辩] [小结，自由辩，结辩]
    pointTmp : [-1,"","","",""],
    desc : [0,"介绍","","",""],
    placeHolder: [0,"介绍(开始比赛后点击下一阶段即可)","","",""],
    className : [0,"","invisible","invisible","invisible","invisible"],
    idNow : 0,
    idFree : -1,
    classOfForms: ["contain","contain invisible"],
    isOpen1:false,
    isOpen2:false,
    debaterPList: [],
    teamPList: [4],
    battleInfo: ""
  };
  right(mainStr, lngLen){
    if(mainStr.length-lngLen>=0&&mainStr.length>=0&&mainStr.length-lngLen<=mainStr.length){
      return mainStr.substring(mainStr.length-lngLen,mainStr.length)}
    else{return null}
  }
  componentWillMount () {
    // Taro.setStorageSync("userId","9afd9b6a5d2c45570800eacd3a7e78bb");
    // Taro.setStorageSync("username","hly");
    // Taro.setStorageSync("userType","judge");
    // Taro.setStorageSync("judgeId","3e1ef27b5d2c45570800e4735318608d");
    // Taro.setStorageSync("name","郝良瑀");
    // Taro.setStorageSync("battleId","5366659c-9992-4a0d-be94-c5ed1bec8a10");
    Taro.cloud.database({env:"factory-1"}).collection("battle").doc(Taro.getStorageSync("battleId")).get({
      success: res => {
        let {title,time} = res.data;
        this.setState({
          battleInfo: `辩题：${title}  时间：${time}`
        })
      }
    });
    let rule_arr=this.state.rule.split(";"),rules=[];
    for(let i =0;i< rule_arr.length;i++){
      rules[i]=rule_arr[i].split(",");
    }
    console.log(rules);
    this.setState({
      rules: rules
    });
  }
  componentDidMount () {
  }
  changeStatusTo(id) {
    let {rules, posList, desc, placeHolder, pointTmp, pointList} = this.state;
    desc = [];
    let [type,u1,u2,time,str]=rules[id];
    let str1 = "", str2 = "",uid1=0,uid2=0;
    this.setState({idNow: id});
    pointTmp = [-1,"","","",""];
    if(type === "0"){
      if(u1.length===2) str1 = posList[uid1=parseInt(this.right(u1,1))];
      else str1 = posList[uid1=parseInt(this.right(u1,1))+4];
      desc[1] = str1;
      if(str==="小结") placeHolder[1] = str+"分数(20为满分)",pointTmp = [-1,pointList[uid1][0],"","",""];
      else if(str==="申论") placeHolder[1] = str+"分数(30为满分)",pointTmp = [-1,pointList[uid1][0],"","",""];
      else if(str==="结辩") placeHolder[1] = str+"分数(30为满分)",pointTmp = [-1,pointList[uid1][2],"","",""];

      this.setState({
        className: ["","","invisible","invisible","invisible","invisible",],
        desc : desc,
        placeHolder: placeHolder,
        pointTmp : pointTmp
      });
    }
    else if(type === "1"){
      if(u1.length===2) str1 = posList[uid1=parseInt(this.right(u1,1))];
      else str1 = posList[uid1=parseInt(this.right(u1,1))+4];
      if(u2.length===2) str2 = posList[uid2=parseInt(this.right(u2,1))];
      else str2 = posList[uid2=parseInt(this.right(u2,1))+4];
      desc[1] = str1;
      desc[2] = str2;
      placeHolder[1] = str+"分数(20为满分)";
      placeHolder[2] = "答辩分数(20为满分)";//TODO: 别写死它
      if(pointList[uid1][0]!== undefined && pointList[uid2][0]!== undefined) pointTmp = [-1,pointList[uid1][1],pointList[uid2][2],"",""];
      this.setState({
        className: ["","","","invisible","invisible","invisible",],
        desc : desc,
        placeHolder: placeHolder,
        pointTmp : pointTmp
      })
    }
    else if(type === "2"){
      placeHolder= ["","自由辩论分数(30为满分)","自由辩论分数(30为满分)","自由辩论分数(30为满分)","自由辩论分数(30为满分)"];
      this.setState({
        className: ["","","","","","",],
        desc : posList,
        placeHolder: placeHolder,
        pointTmp : [-1,pointList[1][3],pointList[2][3],pointList[3][3],pointList[4][1],pointList[5][3],pointList[6][3],pointList[7][3],pointList[8][1]]
      })
    }
    else if(type === "3"){
      console.log(1);
      placeHolder= ["","介绍"];
      this.setState({
        className: ["","","invisible","invisible","invisible","invisible",],
        desc : ["","介绍"],
        placeHolder: placeHolder,
        pointTmp : [-1,"","","","","","","",""]
      })
    }
  }
  handleChange(id,event){
    let {pointTmp} = this.state;
    pointTmp[id] = event;
    this.setState({
      pointTmp: pointTmp
    })
  }
  onSubmit(){
    let {rules,pointList,pointTmp} = this.state;
    let [type,u1,u2,time,str]=rules[this.state.idNow];
    if(type==="0") {
      if(u1.length===2) u1 =parseInt(this.right(u1,1));
      else u1 = parseInt(this.right(u1,1))+4;
      if(str === "申论"||str === "小结") pointList[u1][0]=pointTmp[1];
      else pointList[u1][2]=pointTmp[1];
      this.setState({
        pointList: pointList
      });
    }
    else if(type==="1") {
      if(u1.length===2) u1 =parseInt(this.right(u1,1));
      else u1 = parseInt(this.right(u1,1))+4;
      if(u2.length===2) u2 =parseInt(this.right(u2,1));
      else u2 = parseInt(this.right(u2,1))+4;
      pointList[u1][1]=pointTmp[1];
      pointList[u2][2]=pointTmp[2];
      this.setState({
        pointList: pointList
      });
    }
    else if(type==="2") {
      for(let i=1;i<=8;i++){
        if(i!==4&&i!==8) pointList[i][3]=pointTmp[i];
        else pointList[i][1]=pointTmp[i];
      }
      this.setState({
        pointList: pointList
      });
    }
    if(this.state.idNow<this.state.rules.length-2) this.changeStatusTo(this.state.idNow+1);
    else {
      console.log(this.state.pointList);
      this.setState({
        classOfForms: ["contain invisible","contain"]
      });
      let {pointList,teamPList,debaterPList} = this.state, pointTmpD=0,pointTmpT=0;
      for(let i =1;i<=8;i++){
        for(let j=0;j<=3;j++){
          if((i===4||i===8)&&j===3) continue;
          pointTmpD += parseInt(pointList[i][j]);
        }
        debaterPList[i] = pointTmpD;
        pointTmpT += pointTmpD;
        if(i===4) {teamPList[0] = pointTmpT; pointTmpT=0;}
        if(i===8) teamPList[1] = pointTmpT;
        pointTmpD = 0;

      }
      this.setState({
        teamPList: teamPList,
        debaterPList: debaterPList
      })
    }
  }
  onReset(){
    if(this.state.idNow!==0) this.changeStatusTo(this.state.idNow-1);
    if(this.state.classOfForms[0]==="contain invisible") {
      this.setState({
        classOfForms: ["contain","contain invisible"]
      });
      this.changeStatusTo(this.state.rules.length-2);
    }
  }
  onRealSubmit() {
    this.setState({
      isOpen1: true
    })
  }
  handleCancel1() {
    this.setState({
      isOpen1: false
    })
  }
  handleCancel2() {
    this.setState({
      isOpen1: false
    })
  }
  handleConfirm1(){
    this.setState({
      isOpen1: false,
      isOpen2: true
    })
  }
  handleConfirm2(){
    let {posList,teamPList,debaterPList} = this.state;
    this.setState({
      isOpen2: false
    });
    let str = this.state.pointList.map((item,index)=>{
      if(index===0) return;
      return (posList[index]+":"+item.join(",")+"; 总分为："+debaterPList[index]+"分");
    });
    str = str+"正方总分为："+teamPList.join(",反方总分为：")+"。";
    Taro.cloud.database({env:"factory-1"}).collection("battleJudgePoints").add({
      data: {env: Taro.getStorageSync("env"),
        battleId: Taro.getStorageSync("battleId"),
        debaters: debaterPList,
        desc: str,
        judgeId: Taro.getStorageSync("judgeId"),
        totalC: teamPList[0],
        totalCC: teamPList[1]
      }
    });
    Taro.showToast({
      title: '成功提交！',
      duration: 2000
    }).then(res=> {
      Taro.redirectTo({url:"../index/index"});
    });
  }
  render () {
    let {desc,placeHolder,className,classOfForms,posList,teamPList,debaterPList,battleInfo} = this.state;
    return (
      <View className={'container'}>
        <AtNoticebar>{battleInfo}</AtNoticebar>
        <AtForm
          onSubmit={this.onSubmit.bind(this)}
          onReset={this.onReset.bind(this)}
          className={classOfForms[0]}
        >
          <View className='at-article'>
            <View className='at-article__h1'>
              {desc[1]}
            </View></View>
          <AtInputNumber
            name='1'
            type='number'
            max={30}
            value={this.state.pointTmp[1]}
            onChange={this.handleChange.bind(this,1)}
            className={className[1]}
          />
          {/*<AtInput*/}
          {/*  name='1'*/}
          {/*  title={desc[1]}*/}
          {/*  type='number'*/}
          {/*  placeholder={placeHolder[1]}*/}
          {/*  value={this.state.pointTmp[1]}*/}
          {/*  onChange={this.handleChange.bind(this,1)}*/}
          {/*  className={className[1]}*/}
          {/*/>*/}
          <AtInput
            name='2'
            title={desc[2]}
            type='number'
            placeholder={placeHolder[2]}
            value={this.state.pointTmp[2]}
            onChange={this.handleChange.bind(this,2)}
            className={className[2]}
          />
          <AtInput
            name='3'
            title={desc[3]}
            type='number'
            placeholder={placeHolder[3]}
            value={this.state.pointTmp[3]}
            onChange={this.handleChange.bind(this,3)}
            className={className[3]}
          />
          <AtInput
            name='4'
            title={desc[4]}
            type='number'
            placeholder={placeHolder[4]}
            value={this.state.pointTmp[4]}
            onChange={this.handleChange.bind(this,4)}
            className={className[4]}
          />
          <AtInput
            name='5'
            title={desc[5]}
            type='number'
            placeholder="自由辩论分数(30为满分)"
            value={this.state.pointTmp[5]}
            onChange={this.handleChange.bind(this,5)}
            className={className[5]}
          />
          <AtInput
            name='6'
            title={desc[6]}
            type='number'
            placeholder="自由辩论分数(30为满分)"
            value={this.state.pointTmp[6]}
            onChange={this.handleChange.bind(this,6)}
            className={className[5]}
          />
          <AtInput
            name='7'
            title={desc[7]}
            type='number'
            placeholder="自由辩论分数(30为满分)"
            value={this.state.pointTmp[7]}
            onChange={this.handleChange.bind(this,7)}
            className={className[5]}
          />
          <AtInput
            name='8'
            title={desc[8]}
            type='number'
            placeholder="自由辩论分数(30为满分)"
            value={this.state.pointTmp[8]}
            onChange={this.handleChange.bind(this,8)}
            className={className[5]}
          />
          <View className={'bottomBtn'}>
            <AtButton formType='reset' type={'primary'} className={'btnA btnB'}>上一阶段</AtButton>
            <AtButton formType='submit' type={'primary'} className={'btnA'}>下一阶段</AtButton>
          </View>
        </AtForm>
        <AtForm
          onSubmit={this.onRealSubmit.bind(this)}
          onReset={this.onReset.bind(this)}
          className={classOfForms[1]}
        >
          <text>[申论，质询，答辩，自由辩]
            \n[小结，自由辩，结辩]</text>
          {this.state.pointList.map((item,index)=>{
            return (<text key={index}>{posList[index]+":"+item.join(",")+"; 总分为："+debaterPList[index]+"分"}\n</text>);
          })}
          {"正方总分为："+teamPList.join(",反方总分为：")+"。"}

          <View className={'bottomBtn'}>
            <AtButton formType='reset' type={'primary'} className={'btnA btnB'}>上一阶段</AtButton>
            <AtButton formType='submit' type={'secondary'} className={'btnA'}>提交</AtButton>
          </View>
        </AtForm>

        <AtModal
          isOpened={this.state.isOpen1}
          title='确认提交成绩'
          cancelText='取消'
          confirmText='确认'
          onClose={ this.handleCancel1.bind(this) }
          onCancel={ this.handleCancel1.bind(this) }
          onConfirm={ this.handleConfirm1.bind(this) }
          content='您确定您填写的分数无误吗？'
        />
        <AtModal
          isOpened={this.state.isOpen2}
          title='再次确认提交成绩'
          cancelText='取消'
          confirmText='确认'
          onClose={ this.handleCancel2.bind(this) }
          onCancel={ this.handleCancel2.bind(this) }
          onConfirm={ this.handleConfirm2.bind(this) }
          content='请再次确认！！您确定您填写的分数无误吗？'
        />

      </View>
    )
  }
}
