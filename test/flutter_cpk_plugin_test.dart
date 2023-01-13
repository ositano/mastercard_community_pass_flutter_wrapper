import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin_platform_interface.dart';
import 'package:flutter_cpk_plugin/flutter_cpk_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterCpkPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterCpkPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String> getCpkConnectionStatus(String appGuid) => Future.value('40');
}

void main() {
  final FlutterCpkPluginPlatform initialPlatform =
      FlutterCpkPluginPlatform.instance;

  test('$MethodChannelFlutterCpkPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterCpkPlugin>());
  });

  test('getPlatformVersion', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(await flutterCpkPlugin.getPlatformVersion(), '42');
  });

  test('getCpkConnectionStatus', () async {
    FlutterCpkPlugin flutterCpkPlugin = FlutterCpkPlugin();
    MockFlutterCpkPluginPlatform fakePlatform = MockFlutterCpkPluginPlatform();
    FlutterCpkPluginPlatform.instance = fakePlatform;

    expect(
        await flutterCpkPlugin
            .getCpkConnectionStatus('etpjkVuioVcb9o3LDQVnyb8b1GIJHp9bHeYVa4d8'),
        '40');
  });
}
