import React from 'react';
import AgoraRTC from 'agora-rtc-sdk'
import {
    Form,
    Select,
    Button,
  } from 'antd';

const { Option } = Select;

class AudioVideoOptions extends React.Component {
    constructor (props){
      super(props)
      this.state = {
        devices: []
      }
    }
    componentDidMount(){
      AgoraRTC.getDevices((devices)=> {
        this.setState ({
          devices
        })
      });
    }
    componentDidUpdate(){
        console.log('设备模块 也更新了')
    }
    handleSubmit = (e)=> {
        e.preventDefault();
        this.props.form.validateFields((err, values) => {
            if (!err) {
              this.state.devices.some((item) => {
                if (item.deviceId === values.microphoneId ) {
                    values.microphoneName = item.label || values.microphoneId ;
                }
                if (item.deviceId === values.cameraId ) {
                    values.cameraName = item.label || values.cameraId ;
                }
              })
              this.props.addRolesMsg(values);
              this.props.form.resetFields();
            }
        });
    }
    render (){
        const { getFieldDecorator } = this.props.form;
        const formItemLayout = {
        labelCol: { span: 6 },
        wrapperCol: { span: 14 },
        };
      return (
            <Form {...formItemLayout} onSubmit={this.handleSubmit}>
                <Form.Item label="角色类型">
                {getFieldDecorator('uid', {
                    initialValue: '1001',
                    rules: [{ required: true, message: '请选择角色类型' }],
                })(
                    <Select>
                        <Option value="1001">原音</Option>
                        <Option value="1002">译音</Option>
                    </Select>,
                )}
                </Form.Item>

                <Form.Item label="音频设备">
                {getFieldDecorator('microphoneId', {
                    initialValue: '',
                    rules: [
                    { required: true, message: '请选择音频设备', },
                    ],
                })(
                    <Select >
                        {
                        this.state.devices.map((item) => {
                            if (item.kind === 'audioinput') {
                            return ( <Option key={item.deviceId} value={item.deviceId} >{ item.label || item.deviceId } </Option>
                            )
                            }
                        })
                        }
                    </Select>,
                )}
                </Form.Item>
                <Form.Item label="视频设备">
                {getFieldDecorator('cameraId', {
                    initialValue: '',
                    rules: [
                    { required: true, message: '请选择视频设备', },
                    ],
                })(
                    <Select >
                        {
                        this.state.devices.map((item) => {
                            if (item.kind === 'videoinput') {
                              return ( <Option key={item.deviceId} value={item.deviceId} >{ item.label || item.deviceId } </Option>
                              )
                            }
                          })
                        }
                    </Select>,
                )}
                </Form.Item>
                <Form.Item wrapperCol={{ span: 12, offset: 6 }}>
                    <Button type="primary" htmlType="submit">
                        创建
                    </Button>
                </Form.Item>
            </Form>
          
      )
    }
  }
  
  export default Form.create({ name: 'validate_other' })(AudioVideoOptions)