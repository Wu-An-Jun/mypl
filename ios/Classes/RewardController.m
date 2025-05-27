//
//  RewardController.m
//  Pods
//
//  Created by admin on 2025/5/26.
//

#import "RewardController.h"
//#import <AdvanceSDK/AdvanceRewardVideo.h>
#import <newios_sdk/AdvanceRewardVideo.h>
@interface RewardController () <AdvanceRewardedVideoDelegate>
@property (nonatomic, strong) AdvanceRewardVideo *advanceRewardVideo;
@end

@implementation RewardController




// MARK: ======================= AdvanceRewardVideoDelegate =======================

/// 广告策略加载成功
- (void)didFinishLoadingADPolicyWithSpotId:(NSString *)spotId {
    NSLog(@"%s 广告位id为: %@",__func__ , spotId);
}

/// 广告策略或者渠道广告加载失败
- (void)didFailLoadingADSourceWithSpotId:(NSString *)spotId error:(NSError *)error description:(NSDictionary *)description {
    NSLog(@"广告展示失败 %s  error: %@ 详情:%@", __func__, error,description);
    [JDStatusBarNotification showWithStatus:@"广告加载失败" dismissAfter:1.5];
    self.advanceRewardVideo.delegate = nil;
    self.advanceRewardVideo = nil;
}

/// 广告位中某一个广告源开始加载广告
- (void)didStartLoadingADSourceWithSpotId:(NSString *)spotId sourceId:(NSString *)sourceId {
    NSLog(@"广告位中某一个广告源开始加载广告 %s  sourceId: %@", __func__, sourceId);
}

/// 激励视频广告数据拉取成功
- (void)didFinishLoadingRewardedVideoADWithSpotId:(NSString *)spotId {
    NSLog(@"激励视频广告加载成功");
    [JDStatusBarNotification showWithStatus:@"激励视频广告加载成功" dismissAfter:1.5];
    [self.advanceRewardVideo showAd];
}

/// 激励视频缓存成功
- (void)rewardedVideoDidDownLoadForSpotId:(NSString *)spotId extra:(NSDictionary *)extra{
    NSLog(@"视频缓存成功 %s", __func__);
}

/// 激励视频开始播放
- (void)rewardedVideoDidStartPlayingForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告曝光回调 %s", __func__);
}

/// 激励视频到达激励时间
- (void)rewardedVideoDidRewardSuccessForSpotId:(NSString *)spotId extra:(NSDictionary *)extra rewarded:(BOOL)rewarded {
    NSLog(@"到达激励时间 %s %d", __func__, rewarded);
}

/// 激励视频播放完成
- (void)rewardedVideoDidEndPlayingForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"播放完成 %s", __func__);
}

/// 激励视频广告点击
- (void)rewardedVideoDidClickForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告点击 %s", __func__);
}

/// 激励视频广告关闭
- (void)rewardedVideoDidCloseForSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"广告关闭了 %s", __func__);
    self.advanceRewardVideo.delegate = nil;
    self.advanceRewardVideo = nil;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
