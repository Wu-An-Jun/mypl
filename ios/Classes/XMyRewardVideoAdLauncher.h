//
//  XMyRewardVideoAdLauncher.h
//  Pods
//
//  Created by admin on 2025/5/26.
//

#import <Foundation/Foundation.h>
#import <newios_sdk/AdvanceRewardVideo.h>

@interface XMyRewardVideoAdLauncher : NSObject <AdvanceRewardedVideoDelegate>
+ (instancetype)shared;
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId;
@end
