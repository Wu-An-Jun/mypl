//
//  MyBannerAdLauncher.m
//  Pods
//
//  Created by admin on 2025/5/27.
//

#import "MyBannerAdLauncher.h"
#import <UIKit/UIKit.h>
#import <newios_sdk/AdvanceBanner.h>

@interface MyBannerAdLauncher () <AdvanceBannerDelegate>
@property (nonatomic, strong) AdvanceBanner *advanceBanner;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation MyBannerAdLauncher

+ (instancetype)shared {
    static MyBannerAdLauncher *ins;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[MyBannerAdLauncher alloc] init];
    });
    return ins;
}

- (void)showFromRootVCWithAdspotId:(NSString *)adspotId {
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    [self.contentView removeFromSuperview];
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, rootVC.view.bounds.size.width, rootVC.view.bounds.size.width*5/32.0)];
    
    self.advanceBanner = [[AdvanceBanner alloc] initWithAdspotId:adspotId 
                                                    adContainer:self.contentView
                                                    customExt:nil 
                                                viewController:rootVC];
    self.advanceBanner.delegate = self;
    self.advanceBanner.refreshInterval = 30;
    [self.advanceBanner loadAd];
}

#pragma mark - AdvanceBannerDelegate

- (void)didFinishLoadingADPolicyWithSpotId:(NSString *)spotId {
    NSLog(@"Banner广告策略加载成功 spotId: %@", spotId);
}

- (void)didFailLoadingADSourceWithSpotId:(NSString *)spotId error:(NSError *)error description:(NSDictionary *)description {
    NSLog(@"Banner广告加载失败 spotId: %@, error: %@, description: %@", spotId, error, description);
}

- (void)didStartLoadingADSourceWithSpotId:(NSString *)spotId sourceId:(NSString *)sourceId {
    NSLog(@"Banner广告源开始加载 spotId: %@, sourceId: %@", spotId, sourceId);
}

- (void)didFinishLoadingBannerADWithSpotId:(NSString *)spotId {
    NSLog(@"Banner广告加载成功 spotId: %@", spotId);
    [self.advanceBanner showAd];
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootVC.view addSubview:self.contentView];
}

- (void)bannerView:(UIView *)bannerView didShowAdWithSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"Banner广告展示成功 spotId: %@", spotId);
}

- (void)bannerView:(UIView *)bannerView didClickAdWithSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"Banner广告被点击 spotId: %@", spotId);
}

- (void)bannerView:(UIView *)bannerView didCloseAdWithSpotId:(NSString *)spotId extra:(NSDictionary *)extra {
    NSLog(@"Banner广告关闭 spotId: %@", spotId);
    [bannerView removeFromSuperview];
    self.advanceBanner.delegate = nil;
    self.advanceBanner = nil;
}

@end 
