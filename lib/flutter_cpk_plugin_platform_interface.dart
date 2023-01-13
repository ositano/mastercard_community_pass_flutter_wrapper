import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_cpk_plugin_method_channel.dart';

abstract class FlutterCpkPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterCpkPluginPlatform.
  FlutterCpkPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterCpkPluginPlatform _instance = MethodChannelFlutterCpkPlugin();

  /// The default instance of [FlutterCpkPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterCpkPlugin].
  static FlutterCpkPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterCpkPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterCpkPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String> getCpkConnectionStatus(String appGuid) async {
    throw UnimplementedError(
        'getCpkConnectionStatus() has not been implemented.');
  }
}
