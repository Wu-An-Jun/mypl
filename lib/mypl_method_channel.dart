import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'mypl_platform_interface.dart';

/// An implementation of [MyplPlatform] that uses method channels.
class MethodChannelMypl extends MyplPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mypl');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> test1() async {
    final version = await methodChannel.invokeMethod<String>('test1');
    return version;
  }

  @override
  Future<String?> test2() async {
    final version = await methodChannel.invokeMethod<String>('test2');
    return version;
  }

  @override
  Future<String?> showRewardVideoAd() async {
    final version = await methodChannel.invokeMethod<String>('showRewardVideoAd');
    return version;
  }
  @override
  Future<String?> showRewardVideoAd2(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showRewardVideoAd2',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> FullScreenVideo(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'FullScreenVideo',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> showInterstitialAd(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showInterstitialAd',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> showBannerAd(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showBannerAd',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> showFullScreenVideoAd(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showFullScreenVideoAd',
      {'adspotId': adspotId},
    );
    return result;
  }

  @override
  Future<String?> showSplashAd(String adspotId) async {
    final result = await methodChannel.invokeMethod<String>(
      'showSplashAd',
      {'adspotId': adspotId},
    );
    return result;
  }
}
