//
//  MyInterstitialAdLauncher.h
//  Pods
//
//  Created by admin on 2025/5/27.
//

#import <Foundation/Foundation.h>
#import <newios_sdk/AdvanceInterstitial.h>

@interface MyInterstitialAdLauncher : NSObject <AdvanceInterstitialDelegate>
+ (instancetype)shared;
- (void)showFromRootVCWithAdspotId:(NSString *)adspotId;
@end 