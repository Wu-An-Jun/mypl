import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mypl/mypl.dart';

void main() {
  // 应用程序入口，运行 MyApp 组件
  runApp(const MyApp());
}

// MyApp 是一个有状态组件，用于展示插件调用的结果
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 保存从平台获取的版本信息
  String _platformVersion = 'Unknown';
  // 保存 test1 方法的返回结果
  String _test1 = 'Unknown';
  // 保存 test2 方法的返回结果
  String _test2 = 'Unknown';
  // 创建插件实例，用于调用平台方法
  final _myplPlugin = Mypl();
// 新增：用于输入广告位ID
  final TextEditingController _adspotIdController = TextEditingController();
  final TextEditingController _bannerAdspotIdController = TextEditingController();
  final TextEditingController _interstitialAdspotIdController = TextEditingController();
  final TextEditingController _splashAdspotIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 初始化平台状态，获取平台信息
    initPlatformState();
  }

  // 平台消息是异步的，因此我们在异步方法中初始化
  Future<void> initPlatformState() async {
    String platformVersion;
    String test1;
    String test2;
    // 尝试获取平台版本信息，如果失败则捕获异常
    try {
      // 调用插件方法获取平台版本号，若返回 null 则设为默认值
      platformVersion =
          await _myplPlugin.getPlatformVersion() ?? '未知的平台版本';
    } on PlatformException {
      // 捕获异常，说明获取平台版本失败
      platformVersion = '获取平台版本失败。';
    }
    // 尝试调用 test1 方法
    try {
      test1 = await _myplPlugin.test1() ?? '未知的平台版本';
    } on PlatformException {
      test1 = '获取 test1 失败。';
    }
    // 尝试调用 test2 方法
    try {
      test2 = await _myplPlugin.test2() ?? '未知的平台版本';
    } on PlatformException {
      test2 = '获取 test2 失败。';
    }
    // 如果当前组件已经被移除（如页面关闭），则不再更新界面，避免内存泄漏
    if (!mounted) return;

    // 更新状态，刷新界面显示最新数据
    setState(() {
      _platformVersion = platformVersion;
      _test1 = test1;
      _test2 = test2;
    });
  }

  // 显示结果对话框
  void _showResultDialog(String result) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  // 检查广告位ID是否为空
  bool _checkAdspotId(String adspotId, String type) {
    if (adspotId.isEmpty) {
      _showResultDialog('请输入${type}广告位ID');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // 构建应用界面，显示获取到的平台信息和测试结果
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('广告插件示例'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('运行平台: $_platformVersion',
                          style: const TextStyle(fontSize: 16)),
                      Text('test1 结果: $_test1',
                          style: const TextStyle(fontSize: 16)),
                      Text('test2 结果: $_test2',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _adspotIdController,
                decoration: const InputDecoration(
                  labelText: '广告位ID',
                  border: OutlineInputBorder(),
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final result = await _myplPlugin.showRewardVideoAd();
                          _showResultDialog(result ?? '无返回');
                        } catch (e) {
                          _showResultDialog('调用失败: $e');
                        }
                      },
                      child: const Text('默认激励视频广告'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final adspotId = _adspotIdController.text.trim();
                        if (!_checkAdspotId(adspotId, '激励视频')) return;
                        try {
                          final result = await _myplPlugin.showRewardVideoAd2(adspotId);
                          _showResultDialog(result ?? '无返回');
                        } catch (e) {
                          _showResultDialog('调用失败: $e');
                        }
                      },
                      child: const Text('自定义激励视频广告'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  final adspotId = _adspotIdController.text.trim();
                  if (!_checkAdspotId(adspotId, '全屏视频')) return;
                  try {
                    final result = await _myplPlugin.showFullScreenVideoAd(adspotId);
                    _showResultDialog(result ?? '无返回');
                  } catch (e) {
                    _showResultDialog('调用失败: $e');
                  }
                },
                child: const Text('全屏视频广告'),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('开屏广告', 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _splashAdspotIdController,
                        decoration: const InputDecoration(
                          labelText: '开屏广告位ID',
                          border: OutlineInputBorder(),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final adspotId = _splashAdspotIdController.text.trim();
                          if (!_checkAdspotId(adspotId, '开屏')) return;
                          try {
                            final result = await _myplPlugin.showSplashAd(adspotId);
                            _showResultDialog(result ?? '无返回');
                          } catch (e) {
                            _showResultDialog('调用失败: $e');
                          }
                        },
                        child: const Text('显示开屏广告'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Banner广告', 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _bannerAdspotIdController,
                        decoration: const InputDecoration(
                          labelText: 'Banner广告位ID',
                          border: OutlineInputBorder(),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final adspotId = _bannerAdspotIdController.text.trim();
                          if (!_checkAdspotId(adspotId, 'Banner')) return;
                          try {
                            final result = await _myplPlugin.showBannerAd(adspotId);
                            _showResultDialog(result ?? '无返回');
                          } catch (e) {
                            _showResultDialog('调用失败: $e');
                          }
                        },
                        child: const Text('显示Banner广告'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('插屏广告', 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _interstitialAdspotIdController,
                        decoration: const InputDecoration(
                          labelText: '插屏广告位ID',
                          border: OutlineInputBorder(),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final adspotId = _interstitialAdspotIdController.text.trim();
                          if (!_checkAdspotId(adspotId, '插屏')) return;
                          try {
                            final result = await _myplPlugin.showInterstitialAd(adspotId);
                            _showResultDialog(result ?? '无返回');
                          } catch (e) {
                            _showResultDialog('调用失败: $e');
                          }
                        },
                        child: const Text('显示插屏广告'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
