//
//  MyFullScreenVideoLauncher.h
//  Pods
//
//  Created by admin on 2025/5/27.
//

#import <Foundation/Foundation.h>
#import <newios_sdk/AdvanceFullScreenVideo.h>

@interface MyFullScreenVideoLauncher : NSObject <AdvanceFullScreenVideoDelegate>
+ (instancetype)shared;
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId;
@end
