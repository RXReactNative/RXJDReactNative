/**
 * @this 
 *
 * author : srxboys
 * @flow  
 */

'use strict'
import React, { Component } from './node_modules/react'
import {
    Text,
    View,
    Image,
    ScrollView,
    NativeModules,
    LayoutAnimation,
    NativeEventEmitter,
    TouchableHighlight
} from 'react-native'

import PropTypes from './node_modules/prop-types';

import {ISIphoneX, ISIphone,ISAndroid, IFIphone, IFIphoneX, DeviceWidth, DeviceHeight} from '../../util/RXPlatformType.js'


export default class Home extends Component {
 constructor(props){
   super(props);
   this.state = ({

               });
 }

 static defaultProps = {
   //这个可以不写，但是为了记录这个是 index.js 里面传过来的
   screenProps:{

   }
 }

 componentDidMount(){

 }

 componentWillUnmount() {

 }

 refresh() {

 }

 render() {
   return(
         <View style={{flex:1}}>

         </View>
   );
 }

}