/**
 * @Author: srxboys
 * @Date:   2018-10-14
 * @Project: RXJDReactNative
 *
 * @flow
 */

'use strict'
import React, { Component} from 'react';

import StartUpPage from './app/page/StartUp/StartUp'

//默认应用的容器组件
export default class App extends Component<{}> {

    render() {
        // console.log(this.props.entrance);
        return <StartUpPage />
    }
}
