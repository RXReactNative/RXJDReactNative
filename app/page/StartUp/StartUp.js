/**
 * @this  app入口
 *
 * author : srxboys
 * @flow  : 用于 静态语法检查
 */

/*

  完全的ReactNative项目

  2种情况

  一、
      导航
      page ...
      TabBar

  二、
      导航
      page ...

*/

'use strict'
import React, { Component} from 'react';

import {
    StyleSheet,
    ScrollView,
    Text,
    View,
    Image,
    NativeModules,
    Navigator,
    TouchableWithoutFeedback,
    TouchableHighlight,
    TouchableOpacity,
} from 'react-native'


export default class StartUp extends Component<{}> {
  constructor(props){
    super(props);
    this.state = ({
      a:0
    })
  }

  componentDidMount(){

  }

  componentWillUnmount() {

  }

  render() {
    return(
          <View style={{flex:1}}>
            <View style={{height:80, backgroundColor:'yellow'}} />
            <Text>12345678</Text>
            <Text>srxboys</Text>
            <View style={{ height:50, backgroundColor:'yellow'}} />
          </View>
          )
  }
}
