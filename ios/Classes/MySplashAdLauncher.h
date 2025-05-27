//
//  MySplashAdLauncher.h
//  Pods
//
//  Created by admin on 2025/5/27.
//

#import <Foundation/Foundation.h>
#import <newios_sdk/AdvanceSplash.h>

@interface MySplashAdLauncher : NSObject <AdvanceSplashDelegate>
+ (instancetype)shared;
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId;
@end 