//
//  RNIBaseViewPaperEventHandler.h
//  react-native-ios-utilities
//
//  Created by Dominic Go on 5/19/24.
//

#if !RCT_NEW_ARCH_ENABLED
#import <Foundation/Foundation.h>

@class RNIBaseView;

@interface RNIBaseViewPaperEventHandler : NSObject

@property (nonatomic, weak, nullable) RNIBaseView *parentView;

+ (nonnull NSMutableDictionary *)sharedClassRegistry;

- (nonnull instancetype)initWithParentRef:(nonnull id)ref;

- (void)createSettersForEvents:(nonnull NSArray *)events;

- (void)invokeEventBlockForEventName:(nonnull NSString *)eventName
                         withPayload:(nonnull NSDictionary *)eventPayload;

@end
#endif
