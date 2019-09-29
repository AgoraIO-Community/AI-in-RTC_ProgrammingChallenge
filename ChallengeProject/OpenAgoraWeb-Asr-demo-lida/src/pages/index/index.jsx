import React from 'react'
import * as Cookies from 'js-cookie'
// import AgoraRTC from 'agora-rtc-sdk'
import { Modal } from 'antd'
import RoleAdd from '../../components/devices';
// import AgoraVideoCall from "../../components/AgoraVideoCall";
import '../../assets/fonts/css/icons.css'
import Validator from '../../utils/Validator'
import { RESOLUTION_ARR } from '../../utils/Settings'
import { AGORA_APP_ID } from "../../agora.config";
import './index.css'

class Index extends React.Component {
  constructor(props) {
    super(props)
    this.appId = AGORA_APP_ID;
    this.state = {
      joinBtn: false,
      channel: '',
      baseMode: 'rtc',
      transcode: 'h264',
      attendeeMode: 'video',
      videoProfile: '480p_4',
      roles: [],
      visible: false
    }
  }

  componentDidMount() {
    window.addEventListener('keypress', (e) => {
      e.keyCode === 13 && this.handleJoin()
    })
  }

  /**
   * 
   * @param {String} val 0-9 a-z A-Z _ only 
   * @param {Boolean} state 
   */
  handleChannel = (val, state) => {
    this.setState({
      channel: val,
      joinBtn: state
    })
  }
  getRole = (values)=> {
    Cookies.set('channel', this.state.channel)
    Cookies.set('baseMode', this.state.baseMode)
    Cookies.set('transcode', this.state.transcode)
    Cookies.set('attendeeMode', this.state.attendeeMode)
    Cookies.set('videoProfile', this.state.videoProfile)
    Cookies.set('role', JSON.stringify(values))
    window.location.hash = "meeting"
    return 
    // if (this.state.roles.some((item)=> item.uid == values.uid )){
    //   this.state.roles.map((item) => {
    //     Object.assign(item, values)
    //     return item
    //   })
    //   this.setState({
    //     roles: [...this.state.roles],
    //     visible: false
    //   },()=>{
    //     console.log(this.state.roles)
    //   })
    //   return
    // }
    // this.setState({
    //   roles: this.state.roles.concat([values]),
    //   visible: false
    // },()=>{
    //   console.log(this.state.roles)
    // })
  }
  handleJoin = () => {
    if (!this.state.joinBtn) {
      return
    }
    this.showModal();
    console.log(this.state)
    
  }
  showModal = () => {
    this.setState({
      visible: true,
    });
  };

  handleCancel = e => {
    this.setState({
      visible: false,
    });
  };
  render() {
    return (
      <div className="wrapper index">
        <div className="ag-header">
          新译科技直播平台
        </div>
        <div className="ag-main">
          <div>

            <section className="login-wrapper">
              <div className="login-header">
                {/* <img src={require('../../assets/images/ag-logo.png')} alt="" /> */}
                <p className="login-title">AgoraWeb</p>
                {/* <p className="login-subtitle">Powering Real-Time Communications</p> */}
              </div>
              <div className="login-body">
                <div className="columns">
                  <div className="column is-12">
                    <InputChannel onChange={this.handleChannel} placeholder="Input a room name here"></InputChannel>
                  </div>
                </div>
                <div className="columns">
                  <div className="column is-7">
                    <BaseOptions
                      onChange={val => this.setState({ baseMode: val })}>
                    </BaseOptions>
                  </div>
                  <div className="column is-5">
                    <AdvancedOptions
                      onRadioChange={val => this.setState({ transcode: val })}
                      onSelectChange={val => this.setState({ videoProfile: val })}>
                    </AdvancedOptions>
                  </div>
                </div>
                <div className="columns">
                  <div className="column">
                    <div id="attendeeMode" className="control">
                      <label className="radio">
                        <input onChange={e => this.setState({ attendeeMode: e.target.value })}
                          value="video" type="radio"
                          name="attendee" defaultChecked />
                        <span className="radio-btn">
                        </span>
                        <span className="radio-img video">
                        </span>
                        <span className="radio-msg">Video Call : join with video call</span>
                      </label>
                      <br />
                      <label className="radio">
                        <input onChange={e => this.setState({ attendeeMode: e.target.value })}
                          value="audio-only" type="radio"
                          name="attendee" />
                        <span className="radio-btn">
                        </span>
                        <span className="radio-img audio">
                        </span>
                        <span className="radio-msg">Audio-only : join with audio call</span>
                      </label>
                      <br />
                      <label className="radio">
                        <input onChange={e => this.setState({ attendeeMode: e.target.value })}
                          value="audience" type="radio"
                          name="attendee" />
                        <span className="radio-btn">
                        </span>
                        <span className="radio-img audience">
                        </span>
                        <span className="radio-msg">Audience : join as an audience</span>
                      </label>
                    </div>
                  </div>
                </div>
              </div>
              <div className="login-footer">
                <a id="joinBtn"
                  onClick={this.handleJoin}
                  disabled={!this.state.joinBtn}
                  className="ag-rounded button is-info">添加角色
                    </a>
              </div>
            </section>
          </div>
          {/* <div className='ag-container-parent'>
            {
              this.state.roles.length > 0 &&
              this.state.roles.map((item)=>{
                return ( <div className="ag-container" key={item.uid}>
                <AgoraVideoCall
                videoProfile={this.state.videoProfile}
                channel={this.state.channel}
                attendeeMode={this.state.attendeeMode}
                transcode={this.state.transcode}
                baseMode={this.state.baseMode}
                appId={this.appId}
                config= {item}
                uid={item.uid}
              />
              </div>)
              })
            }
          </div> */}
          
            
        </div>
        <Modal
          title="添加角色"
          visible={this.state.visible}
          onCancel={this.handleCancel}
          footer={null}
        >
          <RoleAdd addRolesMsg={this.getRole} />
        </Modal>
        <div className="ag-footer">
          <a className="ag-href" href="https://www.agora.io">
            <span>Powered By Agora</span>
          </a>
          <div>
            <span>Interested in Agora video call SDK? Contact </span>
            <span className="ag-contact">sales@agora.io</span>
          </div>
        </div>
      </div>
    )
  }
}

class InputChannel extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      errorMsg: '',
      state: ''
    }
  }
  componentDidUpdate(){
    console.log('channel input is updated')
  }

  validate = (val) => {
    this.setState({
      state: '',
      errorMsg: ''
    })
    if (Validator.isNonEmpty(val.trim())) {
      this.setState({
        errorMsg: 'Cannot be empty!',
        state: 'is-danger'
      })
      return false
    }
    else if (Validator.minLength(val.trim(), 1)) {
      this.setState({
        errorMsg: 'No shorter than 1!',
        state: 'is-danger'
      })
      return false
    }
    else if (Validator.maxLength(val.trim(), 16)) {
      this.setState({
        errorMsg: 'No longer than 16!',
        state: 'is-danger'
      })
      return false
    }
    else if (Validator.validChar(val.trim())) {
      this.setState({
        state: 'is-danger',
        errorMsg: 'Only capital or lower-case letter, number and "_" are permitted!'
      })
      return false
    }
    else {
      this.setState({
        state: 'is-success'
      })
      return true
    }
  }

  handleChange = (e) => {
    let state = this.validate(e.target.value)
    this.props.onChange(e.target.value, state)
  }

  render() {
    let validateIcon = ''
    switch (this.state.state) {
      default:
      case '':
        validateIcon = ''; break;
      case 'is-success':
        validateIcon = (<i className="ag-icon ag-icon-valid"></i>); break;
      case 'is-danger':
        validateIcon = (<i className="ag-icon ag-icon-invalid"></i>); break;
    }

    return (
      <div className="channel-wrapper control has-icons-left">
        <input onInput={this.handleChange}
          id="channel"
          className={'ag-rounded input ' + this.state.state}
          type="text"
          placeholder={this.props.placeholder} />
        <span className="icon is-small is-left">
          <img src={require('../../assets/images/ag-login.png')} alt="" />
        </span>
        <span className="validate-icon">
          {validateIcon}
        </span>
        <div className="validate-msg">
          {this.state.errorMsg}
        </div>
      </div>
    )
  }
}

class BaseOptions extends React.Component {
  constructor(props) {
    super(props)
    this._options = [
      {
        label: 'Agora Video Call',
        value: 'rtc',
        content: 'One to one and group calls'
      },
      {
        label: 'Agora Live',
        value: 'live',
        content: 'Enabling real-time interactions between the host and the audience'
      }
    ]
    this.state = {
      active: false,
      message: 'Agora Video Call',

    }
  }

  handleSelect = (item) => {
    let msg = item.label
    let val = item.value
    this.setState({
      'message': msg,
      'active': false
    })
    console.log(val)
    this.props.onChange(val)
  }

  render() {
    const options = this._options.map((item, index) => {
      return (
        <div className="dropdown-item"
          key={index}
          onClick={(e) => this.handleSelect(item, e)}>
          <p>{item.label}</p>
          <hr />
          <p>{item.content}</p>
        </div>
      )
    })

    return (
      <div className={this.state.active ? 'dropdown is-active' : 'dropdown'}>
        <div className="dropdown-trigger"
          onClick={() => this.setState({ 'active': !this.state.active })}>
          <a id="baseMode" className="ag-rounded button" aria-haspopup="true" aria-controls="baseModeOptions">
            <span id="baseOptionLabel">{this.state.message}</span>
            <span className="icon is-small">
              <i className="ag-icon ag-icon-arrow-down" aria-hidden="true"></i>
            </span>
          </a>
        </div>
        <div className="dropdown-menu" id="baseModeOptions" role="menu">
          <div className="dropdown-content">
            {options}
          </div>
        </div>
      </div>
    )
  }
}

class AdvancedOptions extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      active: false,
    }
  }

  handleRadio = (e) => {
    this.props.onRadioChange(e.target.value)
  }

  handleSelect = (e) => {
    this.props.onSelectChange(e.target.value)
  }

  render() {
    const options = Object.entries(RESOLUTION_ARR).map((item, index) => {
      return (
        <option key={index} value={item[0].split(",")[0]}>{item[1][0]}x {item[1][1]}, {item[1][2]}fps, {item[1][3]}kbps</option>
      )
    })
    return (
      <div className={this.state.active ? 'dropdown is-active' : 'dropdown'}>
        <div className="dropdown-trigger"
          onClick={() => this.setState({ 'active': !this.state.active })}>
          <a id="advancedProfile" className="ag-rounded button" aria-haspopup="true" aria-controls="advancedOptions">
            <span>Advanced</span>
          </a>
        </div>
        <div className="dropdown-menu" id="advancedOptions" role="menu">
          <div className="dropdown-content">
            <div className="dropdown-item">
              <div className="control">
                <label className="radio">
                  <input value="vp8" type="radio" name="transcode" onChange={this.handleRadio} />
                  <span>VP8</span>
                </label>
                <label className="radio">
                  <input value="h264" type="radio" defaultChecked onChange={this.handleRadio} name="transcode" />
                  <span>H264</span>
                </label>
              </div>
            </div>
            <div className="dropdown-item">
              <div className="select is-rounded">
                <select onChange={this.handleSelect} defaultValue="480p_4" id="videoProfile" className="ag-rounded is-clipped">
                  {options}
                </select>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Index