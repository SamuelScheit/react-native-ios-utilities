//
//  RNIBaseViewShadowNode.h
//  react-native-ios-utilities
//
//  Created by Dominic Go on 5/7/24.
//

#pragma once

#include <react-native-ios-utilities/RNIBaseViewState.h>

#include <react/renderer/components/RNIosUtilitiesViewSpec/EventEmitters.h>
#include <react/renderer/components/RNIosUtilitiesViewSpec/Props.h>

#include <react/renderer/components/view/ConcreteViewShadowNode.h>
#include <jsi/jsi.h>


namespace facebook::react {

template <
  const char* concreteComponentName,
  typename ViewPropsT = ViewProps,
  typename ViewEventEmitterT = ViewEventEmitter
>
class JSI_EXPORT RNIBaseViewShadowNode : public ConcreteViewShadowNode<
  concreteComponentName,
  ViewPropsT,
  ViewEventEmitterT,
  RNIBaseViewState
> {

public:
  using ConcreteViewShadowNode<
    concreteComponentName,
    ViewPropsT,
    ViewEventEmitterT,
    RNIBaseViewState
  >::ConcreteViewShadowNode;
  
  virtual Point getContentOriginOffset() const override {
    auto stateData = this->getStateData();
    return stateData.contentOffset;
  }
};

} // facebook::react


