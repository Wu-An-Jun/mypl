import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mypl_method_channel.dart';

abstract class MyplPlatform extends PlatformInterface {
  /// Constructs a MyplPlatform.
  MyplPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyplPlatform _instance = MethodChannelMypl();

  /// The default instance of [MyplPlatform] to use.
  ///
  /// Defaults to [MethodChannelMypl].
  static MyplPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyplPlatform] when
  /// they register themselves.
  static set instance(MyplPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> test1() {
    throw UnimplementedError('test1() has not been implemented.');
  }
  Future<String?> test2() {
    throw UnimplementedError('test2() has not been implemented.');
  }
  Future<String?> showRewardVideoAd() {
    throw UnimplementedError('showRewardVideoAd() has not been implemented.');
  }
  Future<String?> showRewardVideoAd2(String adspotId) {
    throw UnimplementedError('showRewardVideoAd2(String adspotId) has not been implemented.');
  }

  // Future<String?> FullScreenVideo(String adspotId) {
  //   throw UnimplementedError('FullScreenVideo(String adspotId) has not been implemented.');
  // }

  @override
  Future<String?> showInterstitialAd(String adspotId) {
    throw UnimplementedError('showInterstitialAd(String adspotId) has not been implemented.');
  }

  @override
  Future<String?> showBannerAd(String adspotId) {
    throw UnimplementedError('showBannerAd(String adspotId) has not been implemented.');
  }

  @override
  Future<String?> showFullScreenVideoAd(String adspotId) {
    throw UnimplementedError('showFullScreenVideoAd(String adspotId) has not been implemented.');
  }

  @override
  Future<String?> showSplashAd(String adspotId) {
    throw UnimplementedError('showSplashAd(String adspotId) has not been implemented.');
  }
}
