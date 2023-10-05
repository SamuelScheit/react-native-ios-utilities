import * as React from 'react';
import { StyleSheet } from 'react-native';

import { RNIDummyViewModule } from './RNIDummyViewModule';
import { RNIDummyNativeView } from './RNIDummyNativeView';

import { RNIDummyViewProps } from './RNIDummyViewTypes';
import { OnReactTagDidSetEvent } from './RNIDummyViewEvents';


export class RNIDummyView extends React.PureComponent<RNIDummyViewProps> {
  
  reactTag?: number;

  constructor(props: RNIDummyViewProps){
    super(props);
  };

  componentWillUnmount(){
    this.notifyComponentWillUnmount(false);
  };

  notifyComponentWillUnmount = (isManuallyTriggered: boolean = true) => {
    const reactTag = this.reactTag;
    if(typeof reactTag !== 'number') return;

    RNIDummyViewModule.notifyComponentWillUnmount(
      reactTag, 
      isManuallyTriggered
    );
  };

  private _handleOnReactTagDidSet: OnReactTagDidSetEvent = ({nativeEvent}) => {
    this.reactTag = nativeEvent.reactTag;
  };

  render(){
    const props = this.props;

    return React.createElement(RNIDummyNativeView, {
      ...props,
      style: styles.nativeDummyView,
      onReactTagDidSet: this._handleOnReactTagDidSet,
    });
  };
};

const styles = StyleSheet.create({
  nativeDummyView: {
    position: 'absolute',
    opacity: 0.01,
  },
});