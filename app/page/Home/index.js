/**
 * @this NavigationBar : 无忧宝投资页入口
 *
 * author : srxboys
 * @flow  : 用于 静态语法检查
 */
'use strict'
import React, { Component } from 'react';

import Home from './Home'

import { createStackNavigator,NavigationActions } from 'react-navigation';
// import CardStackStyleInterpolator from 'react-navigation/src/views/StackView/StackViewStyleInterpolator';

const RootStack =  createStackNavigator(
  {
    index: {
      screen :  Home,
      navigationOptions: {} // 此处设置了, 会覆盖组件内的`static navigationOptions`设置
    },

  },
  {
    initialRouteName:'index', //设置堆栈的默认屏幕
    mode : 'card', //屏幕渲染和转换的样式
    headerMode: 'none'   //页眉的呈现方式

    // ,transitionConfig: () => ({
    //     screenInterpolator: CardStackStyleInterpolator.forHorizontal,
    // })
  }
);

export default class WYBIndex extends Component<{}> {
  render() {
      return (
          <RootStack screenProps={this.props.parameter}/>
      )
  }
}
