//
//  MyBannerAdLauncher.h
//  Pods
//
//  Created by admin on 2025/5/27.
//

#import <Foundation/Foundation.h>
#import <newios_sdk/AdvanceBanner.h>

@interface MyBannerAdLauncher : NSObject <AdvanceBannerDelegate>
+ (instancetype)shared;
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId;
@end 