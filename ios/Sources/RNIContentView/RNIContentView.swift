//
//  RNIContentView.swift
//  react-native-ios-utilities
//
//  Created by Dominic Go on 5/13/24.
//

import Foundation
import DGSwiftUtilities


public protocol RNIContentView where Self:
  RNIContentViewDelegate & StringKeyPathMapping {
  
  #if !RCT_NEW_ARCH_ENABLED
  var horizontalAlignment: HorizontalAlignmentPosition { get };
  var verticalAlignment: VerticalAlignmentPosition { get }
  #endif
};