#import "MyplPlugin.h"
#import <newios_sdk/AdvanceRewardVideo.h> // 导入激励视频广告头文件
#import "AdvanceBanner.h" // 导入Banner广告头文件
#import "DemoRewardVideoViewController.h"

#import "MyRewardVideoAdLauncher.h"
#import "XMyRewardVideoAdLauncher.h"
#import "MyFullScreenVideoLauncher.h"

#import "MySplashAdLauncher.h"
#import "MyInterstitialAdLauncher.h"
#import "MyBannerAdLauncher.h"
#import "MyFullScreenVideoLauncher.h"

@implementation MyplPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"mypl"
            binaryMessenger:[registrar messenger]];
  MyplPlugin* instance = [[MyplPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

// 处理 Flutter 的方法调用
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    // 判断方法名
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        // 返回 iOS 版本号
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"test1" isEqualToString:call.method]) {
        // 返回“安卓很好”
        result(@"安卓很好123");
    } else if ([@"test2" isEqualToString:call.method]) {
        // 返回“鸿蒙很好”
        result(@"鸿蒙很好");
    } else if ([@"showRewardVideoAd" isEqualToString:call.method]) {
        // 页面展示
//        UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
//        DemoRewardVideoViewController *adVC = [[DemoRewardVideoViewController alloc] init];
//        [rootVC presentViewController:adVC animated:YES completion:nil];
//        result(@"展示激励视频广告");
        // 单广告展示
        [[MyRewardVideoAdLauncher shared] showFromRootVC];
           result(@"已直接展示激励视频广告");
    } else if ([@"showRewardVideoAd2" isEqualToString:call.method]) {
        NSString *adspotId = call.arguments[@"adspotId"];
//        if (adspotId == nil || adspotId.length == 0) {
//            adspotId = @"10008526"; // 可设默认ID
//        }
        [[XMyRewardVideoAdLauncher shared] showFromRootVCWithAdspotId:adspotId];
        result(@"已直接展示激励视频广告");
    }else if ([@"FullScreenVideo" isEqualToString:call.method]) {
        NSString *adspotId = call.arguments[@"adspotId"];
//        if (adspotId == nil || adspotId.length == 0) {
//            adspotId = @"10008526"; // 可设默认ID
//        }
        [[MyFullScreenVideoLauncher shared] showFromRootVCWithAdspotId:adspotId];
        result(@"已直接展示广告视频广告");
    }else if ([@"showInterstitialAd" isEqualToString:call.method]) {
        NSString *adspotId = call.arguments[@"adspotId"];
        [[MyInterstitialAdLauncher shared] showFromRootVCWithAdspotId:adspotId];
        result(@"已直接展示插屏广告");
    } else if ([@"showBannerAd" isEqualToString:call.method]) {
        NSString *adspotId = call.arguments[@"adspotId"];
        [[MyBannerAdLauncher shared] showFromRootVCWithAdspotId:adspotId];
        result(@"已直接展示Banner广告");
    } else if ([@"showFullScreenVideoAd" isEqualToString:call.method]) {
        NSString *adspotId = call.arguments[@"adspotId"];
        [[MyFullScreenVideoLauncher shared] showFromRootVCWithAdspotId:adspotId];
        result(@"已直接展示全屏视频广告");
    } else if ([@"showSplashAd" isEqualToString:call.method]) {
        NSString *adspotId = call.arguments[@"adspotId"];
        [[MySplashAdLauncher shared] showFromRootVCWithAdspotId:adspotId];
        result(@"已直接展示开屏广告");
    }else {
        // 未实现的方法
        result(FlutterMethodNotImplemented);
    }
}

@end
