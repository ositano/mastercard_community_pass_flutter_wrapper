# Mastercard's Community Pass Service - Flutter Plugin

[![](https://developer.mastercard.com/_/_/src/global/assets/svg/mcdev-logo-light.svg#gh-dark-mode-only)](https://developer.mastercard.com/)

[![](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE)
[![](https://sonarcloud.io/api/project_badges/measure?project=Mastercard_community-pass-flutter-wrapper&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Mastercard_community-pass-flutter-wrapper)
[![](https://sonarcloud.io/api/project_badges/measure?project=Mastercard_community-pass-flutter-wrapper&metric=coverage)](https://sonarcloud.io/summary/new_code?id=Mastercard_community-pass-flutter-wrapper)
[![](https://sonarcloud.io/api/project_badges/measure?project=Mastercard_community-pass-flutter-wrapper&metric=vulnerabilities)](https://sonarcloud.io/summary/new_code?id=Mastercard_community-pass-flutter-wrapper)

## Table of Contents

- [Overview](#overview)
  - [Platform Support](#platform-support)
  - [References](#references)
- [Usage](#usage)
  - [Prerequisites](#prerequisites)
  - [Configuration](#configuration)
  - [Installation](#installation)
  - [Examples](#examples)
  - [Recommendation](#recommendation)
- [Support](#support)

## Overview <a name="overview"></a>

The Community Pass Platform provides technology that allows customers servicing digitally excluded and remote communities to do so in a more efficient and effective manner. The lives of consumers and the variety of services needed across any community are not limited to commerce and payments – rather they include a broad range of “life transactions” such as verifying who you are, health visits, crop exchanges, and agricultural deliveries, to name a few. In Community Pass, the functionality and capabilities are organized around these “life transactions” and include activities necessary to administer and maintain any technology-based program that supports them. Enabling these transactions requires different actions and attention before, during and after an event or service is provided – as well as various administrative or back-office functions. Please see here for more details on the API: [Mastercard Developers](https://developer.mastercard.com/product/community-pass-platform/documentation/).

### Platform Support <a name="platform-support"></a>

| Android | iOS | MacOS Web | Linux | Windows |
| :-----: | :-: | :-------: | :---: | :-----: |
|   ✔️    | ❌  |    ❌     |  ❌   |   ❌    |

### References <a name="references"></a>

- [Mastercard’s Community Pass Library](https://developer.mastercard.com/cp-kernel-integration-api/documentation/cp-assets/cp-assets-request/)
- [Using Community Pass Library to Access Mastercard APIs](https://developer.mastercard.com/cp-kernel-integration-api/tutorial/getting-started-guide/)

## Usage <a name="usage"></a>

### Prerequisites <a name="prerequisites"></a>

- [Mastercard Developers Account](https://developer.mastercard.com/dashboard) with access to [Community Pass Assets](https://developer.mastercard.com/cp-kernel-integration-api/documentation/cp-assets/cp-assets-request/)
- Android 7.0 (Nougat) or later
- minSdkVersion 24 or later
- Android Gradle Plugin v3.4.0 or greater required
- Gradle 5.1.1 or greater required

### Configuration <a name="configuration"></a>

- Once you have the Program Name, Application Name, Application ID, and Certificate fingerprint, send them to the Community Pass Platform Admin via the `cp.patnerprogram[at]mastercard.com` to initiate the onboarding process.

- Create an account at [Mastercard Developers](https://developer.mastercard.com/account/sign-up).
- Request for access to the [Community Pass Assets](https://developer.mastercard.com/cp-kernel-integration-api/documentation/cp-assets/cp-assets-request/)
- Download the assets and place the community-pass-library-v2.4.0.aar file inside your project
- Install and activate the Community Pass Kernel

### Installation <a name="installation"></a>

1. Depend on it

Run this command Flutter:

```
flutter pub add flutter_cpk_plugin
```

This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

```yaml
dependencies:
  flutter_cpk_plugin: ^0.0.1
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

2. Import it

Now in your Dart code, you can use:

```dart
import 'package:flutter_cpk_plugin/flutter_cpk_plugin.dart';
```

### Examples <a name="examples"></a>

Create a channel

```dart
final _channel = const MethodChannel('flutter_cpk_plugin');
```

Invoke the connection method

```dart
Future<void> initCpkConnectionState(String appGuid) async {
    String result;
    try {
      result = await _channel
          .invokeMethod('getCpkConnectionStatus', {'appGuid': appGuid});
    } on PlatformException {
      result = 'Failed to get the connection status';
    }

    if (!mounted) return;

    setState(() {
      _connectionStatus = result;
    });
  }
```

## Support <a name="support"></a>

If you would like further information, please send an email to `cp.partnerprogram[at]mastercard.com`

- For updates regarding the community pass actions implementation, refer to the [TODO file](TODO.md)
- For information regarding licensing, refer to the [License file](LICENSE.md).
- For copyright information, refer to the [Copyright file](COPYRIGHT.md).
- For instructions on how to contribute to this project, refer to the [Contributing file](CONTRIBUTING.md).
- For changelog information, refer to the [Changelog file](CHANGELOG.md).
