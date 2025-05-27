//
//  MyRewardVideoAdLauncher.m
//  Pods
//
//  Created by admin on 2025/5/26.
//

#import "MyRewardVideoAdLauncher.h"
#import <UIKit/UIKit.h>

// 匿名扩展，声明私有属性和方法，防止外部访问
@interface MyRewardVideoAdLauncher ()
// 当前激励视频广告实例，生命周期由本类统一管理
@property (nonatomic, strong) AdvanceRewardVideo *advanceRewardVideo;
@end

@implementation MyRewardVideoAdLauncher

#pragma mark - 单例实现

/// 获取全局唯一实例，保证广告管理全局唯一
+ (instancetype)shared {
    static MyRewardVideoAdLauncher *ins;
    static dispatch_once_t onceToken;
    // dispatch_once保证多线程环境下只初始化一次
    dispatch_once(&onceToken, ^{
        ins = [[MyRewardVideoAdLauncher alloc] init];
    });
    return ins;
}

#pragma mark - 广告加载与展示

/// 从根视图控制器展示激励视频广告
- (void)showFromRootVC {
    // 获取应用主窗口的根视图控制器，确保广告能正确弹出
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    // 初始化广告对象
    // adspotId: 广告位ID，需在广告平台后台申请
    // customExt: 可选扩展参数，通常为nil
    // viewController: 广告承载的控制器
    self.advanceRewardVideo = [[AdvanceRewardVideo alloc] initWithAdspotId:@"10008526" customExt:nil viewController:rootVC];
    
    // 设置代理为当前对象，接收广告加载、展示、关闭等回调
    self.advanceRewardVideo.delegate = self;
    
    // 开始异步加载广告资源，加载成功后会回调rewardedVideoDidDownLoadForSpotId
    [self.advanceRewardVideo loadAd];
}

#pragma mark - 广告回调（需实现AdvanceRewardVideoDelegate协议）

/// 广告缓存成功后自动展示
/// @param spotId 当前广告位ID
/// @param extra  额外信息（如广告平台返回的扩展数据）
- (void)rewardedVideoDidDownLoadForSpotId:(NSString *)spotId extra:(NSDictionary *)extra{
    // 判断广告对象有效性，防止因提前释放或加载失败导致崩溃
    if (self.advanceRewardVideo.isAdValid) {
        // 展示广告，通常为全屏弹窗
        [self.advanceRewardVideo showAd];
    } else {
        // 广告无效，可能因超时、被回收等原因
        NSLog(@"广告无效，无法展示");
    }
}

/// 广告关闭后释放对象，防止内存泄漏
/// @param spotId 当前广告位ID
/// @param extra  额外信息
- (void)rewardedVideoDidCloseForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    // 断开代理，防止回调野指针
    self.advanceRewardVideo.delegate = nil;
    // 释放广告对象，保证下次可重新加载
    self.advanceRewardVideo = nil;
}

@end
