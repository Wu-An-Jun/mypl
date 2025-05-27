//
//  MyRewardVideoAdLauncher.h
//  Pods
//
//  Created by admin on 2025/5/26.
//

#import <Foundation/Foundation.h>
#import <newios_sdk/AdvanceRewardVideo.h>

@interface MyRewardVideoAdLauncher : NSObject <AdvanceRewardedVideoDelegate>
+ (instancetype)shared;
- (void)showFromRootVC;
@end
