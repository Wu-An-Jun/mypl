
import 'mypl_platform_interface.dart';

class Mypl {
  Future<String?> getPlatformVersion() {
    return MyplPlatform.instance.getPlatformVersion();
  }
  Future<String?> test1() {
    return MyplPlatform.instance.test1();
  }
  Future<String?> test2() {
    return MyplPlatform.instance.test2();
  }
  Future<String?> showRewardVideoAd() {
    return MyplPlatform.instance.showRewardVideoAd();
  }
  Future<String?> showRewardVideoAd2(String adspotId) {
    return MyplPlatform.instance.showRewardVideoAd2(adspotId);
  }

  // Future<String?> FullScreenVideo(String adspotId) {
  //   return MyplPlatform.instance.FullScreenVideo(adspotId);
  // }

  Future<String?> showInterstitialAd(String adspotId) {
    return MyplPlatform.instance.showInterstitialAd(adspotId);
  }

  Future<String?> showBannerAd(String adspotId) {
    return MyplPlatform.instance.showBannerAd(adspotId);
  }

  Future<String?> showFullScreenVideoAd(String adspotId) {
    return MyplPlatform.instance.showFullScreenVideoAd(adspotId);
  }

  Future<String?> showSplashAd(String adspotId) {
    return MyplPlatform.instance.showSplashAd(adspotId);
  }
}
