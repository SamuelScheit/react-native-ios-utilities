//
//  RNIDummyView.swift
//  ReactNativeIosUtilities
//
//  Created by Dominic Go on 10/4/23.
//

import ExpoModulesCore


public class RNIDummyView: ExpoView {

  // MARK: Properties
  // ----------------
  
  public weak var eventDelegate: RNIDummyViewEventsNotifiable?;
  
  public var detachedViews: [UIView] = [];
  private(set) public var touchHandlers: Dictionary<NSNumber, RCTTouchHandler> = [:];
  
  private(set) public var didTriggerCleanup = false;
  
  public override var reactTag: NSNumber! {
    didSet {
      guard let newValue = self.reactTag,
            newValue != oldValue
      else { return };
      
      self.onReactTagDidSetEvent.callAsFunction([
        "reactTag": newValue
      ]);
    }
  };
  
  // MARK: Properties - Props
  // ------------------------
  
  public var shouldCleanupOnComponentWillUnmount = false;
  
  // MARK: Properties - Prop - Events
  // --------------------------------
  
  let onReactTagDidSetEvent = EventDispatcher("onReactTagDidSet");
  
  // MARK: Init + Lifecycle
  // ----------------------

  public required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext);
  };
  
  public override func layoutSubviews() {
    super.layoutSubviews();
  };
  
  public override func insertReactSubview(_ subview: UIView!, at atIndex: Int) {
    subview.removeFromSuperview();
    self.detachedViews.append(subview);
  };
  
  // MARK: Module Functions
  // ----------------------
  
  func notifyOnComponentWillUnmount(isManuallyTriggered: Bool){
    self.eventDelegate?.onJSComponentWillUnmount(
      sender: self,
      isManuallyTriggered: isManuallyTriggered
    );
    
    if self.shouldCleanupOnComponentWillUnmount {
      self.cleanup();
    };
  };
};

// MARK: - RNICleanable
// --------------------

extension RNIDummyView: RNICleanable {
  
  public func cleanup(){
    guard !self.didTriggerCleanup,
          let bridge = self.appContext?.reactBridge
    else { return };
    
    self.didTriggerCleanup = true;
    let viewsToCleanup = self.detachedViews + [self];
 
    for view in viewsToCleanup  {
      if let touchHandler = self.touchHandlers[view.reactTag] {
        touchHandler.detach(from: view);
      };
      
      RNIHelpers.recursivelyRemoveFromViewRegistry(
        forReactView: view,
        usingReactBridge: bridge
      );
    };
    
    self.touchHandlers.removeAll();
    self.detachedViews.removeAll();
  };
};
