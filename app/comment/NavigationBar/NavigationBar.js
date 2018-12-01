/**
 * @this NavigationBar : 通用-导航栏
 *
 * author : srxboys
 * @flow  : 用于 静态语法检查
 */

'use strict'

import React, { Component } from 'react';

import {
 StyleSheet,
 Text,
 View,
 Image,
 TouchableOpacity
} from 'react-native'

import PropTypes from 'prop-types';

import {ISIphoneX, ISIphone,ISAndroid, IFIphone, IFIphoneX, DeviceWidth, DeviceHeight} from '../../util/RXPlatformType.js'


/**
 *  导航栏
 *
 *  @param  title       :  标题
 *  @param  left        :  返回
 *  @param  left_1      :  返回_1
 *  @param  right       :

 *  @func onLeftPress|onClosePress
 *  @func onRightPress
 */
type navProps = {
  title?:string,
  left?:string,
  right?:string
}

const AllHeight = IFIphoneX(89, 65, 65);
const LineHeight = 0.5;
const ContentHeight =  AllHeight - LineHeight;
const statusHeight = IFIphoneX(44, 20, 0);
const naviHeight = 44;

export default class NavigationBar extends Component <navProps> {

  static defaultProps = {
    title:'',
    left : '返回',
    right: ''
  }
  _left() {
    if(this.props.onLeftPress){
      return(
          <TouchableOpacity onPress={this.props.onLeftPress}>
            <View style={[style.DefaultItem, style.Item_left1]}>
              <Image style={style.Image}
                source={require('../images/navi_bar_back.png')} />
              <Text style={style.TextLeft_1}>{this.props.left}</Text>
            </View>
          </TouchableOpacity>
      )
    }
    else {
      return( <View style={[style.DefaultItem, style.Item_left1]} /> )
    }
  }

  _middle() {
    return(
      <View style={style.DefaultTitle}>
        <Text style={style.TextTitle} >{this.props.title}</Text>
      </View>
    )
  }

  _right() {
    if(this.props.onRightPress) {
      return(
          <TouchableOpacity onPress={this.props.onRightPress}>
            <View style={[style.DefaultItem, style.Item_Right1]}>
              <Text style={style.TextRight_1}>
                {this.props.right}
              </Text>
            </View>
          </TouchableOpacity>
      )
    }
    else {
      return(
          <View style={[style.DefaultItem, style.Item_Right1]}>
            <Text style={style.TextRight_1}>
              {this.props.right}
            </Text>
          </View>
    )
    }
  }


  _lineView() {
    return(
      <View style={style.Line} />
    )
  }

  _getView() {

    return(
      <View style={style.Container}>
          <View style={style.Content}>
            {this._left()}
            {this._middle()}
            {this._right()}
          </View>
          {this._lineView()}
      </View>
    )
  }

  render(){
    return(
      <View>
        {this._getView()}
      </View>
    )
  }
}


const style = StyleSheet.create({

    Container: {
      width: DeviceWidth,
      height: AllHeight,
      backgroundColor: 'white',
    },

    Content: {
      width: DeviceWidth,
      height: ContentHeight,
      paddingTop: statusHeight,
      flexDirection: 'row',
      alignItems: 'center',
          // test code
          // backgroundColor: 'yellow',
    },

    DefaultItem: {
      width:70,
      height:20,
      flexDirection:'row',
      alignItems:'center',
      justifyContent: 'center',
          // test code
          // backgroundColor:'coral',
    },

    DefaultTitle: {
      flex:1,
      height:20,
      alignItems:'center',
      justifyContent: 'center',
          // test code
          // backgroundColor:'cyan',
    },

    Item_left1: {
      paddingLeft:20,
      marginRight:10,
    },

    Item_Right1: {
      paddingRight:20,
      marginLeft:10,
    },

    TextLeft_1 : {
        flex:1,
        paddingLeft:5,
        fontSize:16,
        color:'#4e82d7',
        height:18,
    },

    TextTitle : {
        flex:1,
        fontSize:18,
        fontWeight:'bold',
        color:'#2e353b',
        height:20,
    },

    TextRight_1 : {
        flex:1,
        fontSize:16,
        color:'#4e82d7',
        height:18,
        justifyContent: 'center',
        textAlign : 'right',
    },

    Image : {
      width:12,
      height:20,
    },

    Line : {
      height:LineHeight,
      backgroundColor:'lightgray',
    }
});
