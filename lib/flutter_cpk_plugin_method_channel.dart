import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_cpk_plugin_platform_interface.dart';

/// An implementation of [FlutterCpkPluginPlatform] that uses method channels.
class MethodChannelFlutterCpkPlugin extends FlutterCpkPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_cpk_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String> getCpkConnectionStatus(String appGuid) async {
    try {
      final String? result =
          await methodChannel.invokeMethod('getCpkConnectionStatus', {
        'id': appGuid,
      });
      return result ?? 'Could not set timer.';
    } on PlatformException catch (ex) {
      return ex.message ?? 'Unexpected error';
    }
  }
}
