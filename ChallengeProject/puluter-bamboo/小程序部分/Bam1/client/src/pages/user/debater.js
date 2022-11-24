import Taro, { Component } from '@tarojs/taro'
import { View, Text, Button } from '@tarojs/components'
import './debater.less'
import {AtForm, AtInput, AtButton, AtImagePicker, AtAvatar} from 'taro-ui';
import md5 from 'js-md5';

export default class Debater extends Component {

  config = {
  };



  constructor() {
    super(...arguments);
    this.state = {
      files: [],
      classList1: ['','invisible1'],
      name : ""
    };
  }

  componentWillMount () {
    this.setState({
      name:Taro.getStorageSync("username")
    });
    let pop = this;
    Taro.cloud.database({env:"factory-1"}).collection("debater").where({env: Taro.getStorageSync("env"),
      name: Taro.getStorageSync("username")
    }).get({
      success: res1 => {
        Taro.cloud.database({env: "factory-1"}).collection("debater-tmp-img").where({env: Taro.getStorageSync("env"),
          debaterId:res1.data[0]._id
        }).get({
          success: res => {
            if(res.data.length!==0) {
              let url = res.data[0].imgUrl;
              Taro.cloud.downloadFile({
                fileID: url,
                success: res2 => {
                  // get temp file path
                  pop.setState({
                    imgUrl: res2.tempFilePath,
                    classList1: ['invisible1',"cd"]
                  })
                }
              })
            }
            else {
              pop.setState({
                classList1: ['','invisible1']
              })
            }
          }
        })
      }
    });
  }

  componentDidMount () { }

  componentWillUnmount () { }

  componentDidShow () { }

  componentDidHide () { }

  onChange (files) {
    if(this.state.files.length===1) {
      Taro.showToast({
        title: '最多只能选择一张',
        icon: 'none',
        duration: 2000
      });
      return ;
    }
    this.setState({
      files
    });
  }
  onFail (mes) {
    console.log(mes)
  }
  onImageClick (index, file) {
    console.log(index, file)
  }

  right(mainStr, lngLen){
    if(mainStr.length-lngLen>=0&&mainStr.length>=0&&mainStr.length-lngLen<=mainStr.length){
      return mainStr.substring(mainStr.length-lngLen,mainStr.length)}
    else{return null}
  }

  onSubmit(){
    let pop = this;
    if(this.state.files.length===0){
      Taro.showToast({
        title: '请选择一张照片！',
        icon: 'none',
        duration: 2000
      });
    }
    else {
      Taro.cloud.uploadFile({
        cloudPath: 'img-debater/'+Taro.getStorageSync("userId")+this.right(this.state.files[0].url,4),
        //TODO: 改成debaterId
        filePath: this.state.files[0].url, // 文件路径
        success: res => {
          Taro.cloud.database({env:"factory-1"}).collection("debater").where({env: Taro.getStorageSync("env"),
            name: Taro.getStorageSync("username")
          }).get({
            success: res1 => {
              //TODO: 查看下是否已有图片
              Taro.cloud.database({env:"factory-1"}).collection("debater-tmp-img").add({
                data:{env: Taro.getStorageSync("env"),
                  imgUrl: res.fileID,
                  debaterId: res1.data[0]._id
                },
                success: res2 => {
                  Taro.showToast({
                    title:"成功",
                    duration:2000
                  });
                  Taro.cloud.downloadFile({
                    fileID: res.fileID,
                    success: res => {
                      // get temp file path
                      pop.setState({
                        imgUrl: res.tempFilePath,
                        classList1: ['invisible1',"cd"]
                      })
                    },
                    fail: err => {
                      // handle error
                    }
                  })
                }
              })
            }
          })
        },
        config: {env:"factory-1"},
        fail: console.error
      })
    }
  }

  render () {
    return (
      <View>
        <View className="cd">
          <View className='at-article'>
            <View className='at-article__h1'>
              欢迎您！辩手 {this.state.name}
            </View>
          </View>
        </View>
        <View className={this.state.classList1[0]}>
          <AtImagePicker
            length={3}
            files={this.state.files}
            onChange={this.onChange.bind(this)}
            onFail={this.onFail.bind(this)}
            onImageClick={this.onImageClick.bind(this)}
            multiple={false}
          />
          <AtButton onClick={this.onSubmit.bind(this)} className={'b'}>提交照片</AtButton>
        </View>
        <View className={this.state.classList1[1]}>
          <AtAvatar image={this.state.imgUrl} size={'large'}/>
        </View>
      </View>
    )
  }
}
