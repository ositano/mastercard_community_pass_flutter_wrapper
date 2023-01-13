import 'flutter_cpk_plugin_platform_interface.dart';

class FlutterCpkPlugin {
  Future<String?> getPlatformVersion() {
    return FlutterCpkPluginPlatform.instance.getPlatformVersion();
  }

  Future<String> getCpkConnectionStatus(String appGuid) {
    return FlutterCpkPluginPlatform.instance.getCpkConnectionStatus(appGuid);
  }
}
