import 'package:flutter_test/flutter_test.dart';
import 'package:mypl/mypl.dart';
import 'package:mypl/mypl_platform_interface.dart';
import 'package:mypl/mypl_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyplPlatform
    with MockPlatformInterfaceMixin
    implements MyplPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyplPlatform initialPlatform = MyplPlatform.instance;

  test('$MethodChannelMypl is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMypl>());
  });

  test('getPlatformVersion', () async {
    Mypl myplPlugin = Mypl();
    MockMyplPlatform fakePlatform = MockMyplPlatform();
    MyplPlatform.instance = fakePlatform;

    expect(await myplPlugin.getPlatformVersion(), '42');
  });
}
