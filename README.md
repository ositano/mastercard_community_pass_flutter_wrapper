# Mastercard's Community Pass Service - Flutter Plugin

[![](https://developer.mastercard.com/_/_/src/global/assets/svg/mcdev-logo-light.svg#gh-dark-mode-only)](https://developer.mastercard.com/)

[![](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE)
[![](https://sonarcloud.io/api/project_badges/measure?project=Mastercard_community-pass-flutter-wrapper&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Mastercard_community-pass-flutter-wrapper)
[![](https://sonarcloud.io/api/project_badges/measure?project=Mastercard_community-pass-flutter-wrapper&metric=coverage)](https://sonarcloud.io/summary/new_code?id=Mastercard_community-pass-flutter-wrapper)
[![](https://sonarcloud.io/api/project_badges/measure?project=Mastercard_community-pass-flutter-wrapper&metric=vulnerabilities)](https://sonarcloud.io/summary/new_code?id=Mastercard_community-pass-flutter-wrapper)

A performant interactive Community Pass Service flutter plugin with fully configurable options 🚀

## Table of Contents

- [Overview](#overview)
  - [Platform Support](#platform-support)
  - [References](#references)
- [Usage](#usage)
  - [Prerequisites](#prerequisites)
  - [Configuration](#configuration)
  - [Installation](#installation)
  - [Usage Examples](#usage-examples)
  - [API](#api)
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

- [Flutter](https://docs.flutter.dev/get-started/install) installed and working.
- Android Studio IDE or equivalent
- Android 7.0 (Nougat) or later
- minSdkVersion 24 or later
- Android Gradle Plugin v3.4.0 or greater required
- Gradle 5.1.1 or greater required

### Configuration <a name="configuration"></a>

To get started please visit our documentation at [Mastercard Developer Zone](https://developer.mastercard.com/cp-kernel-integration-api/tutorial/getting-started-guide/) and complete the following sections

- [Section 1:](https://developer.mastercard.com/cp-kernel-integration-api/tutorial/getting-started-guide/step1) Pre-requisites required to get you starting
- [Section 2:](https://developer.mastercard.com/cp-kernel-integration-api/tutorial/getting-started-guide/step2) Setting up your Community Pass Approved Device
- [Section 3:](https://developer.mastercard.com/cp-kernel-integration-api/tutorial/getting-started-guide/step3) Setting up your development environment
- [Section 4:](https://developer.mastercard.com/cp-kernel-integration-api/tutorial/getting-started-guide/step4) Submit your Reliant App details to Community Pass
- [Section 6:](https://developer.mastercard.com/cp-kernel-integration-api/tutorial/getting-started-guide/step6) Install and Activate the Community Pass Kernel

To report any issue about the [Mastercard Developer Zone](https://developer.mastercard.com/cp-kernel-integration-api/tutorial/getting-started-guide/), please send an email to `cp.patnerprogram[at]mastercard.com`

For issues related with this plugin, please use github issues to report it.

### Installation <a name="installation"></a>

The following steps will help you to connect your reliant application with Community Pass

1. Depend on this plugin

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

### Usage Examples <a name="usage-examples"></a>

Create a channel

```dart
final _channel = const MethodChannel('flutter_cpk_plugin');
```

Implement the saveBiometricConsent() method method

```dart
//main.dart

Future<void> saveBiometricConsent(String reliantApplicationGuid, String programGuid) async {
    String result;

    try {

      // invoke saveBiometricConsent() method and await for the consentId
      result = await _channel.invokeMethod('saveBiometricConsent', {
        'RELIANT_APP_GUID': reliantApplicationGuid,
        'PROGRAM_GUID': programGuid
      });

      // catch exceptions
    } on PlatformException catch(e) {
      result = '';
    }

    // check whether this [state] object is currently in a tree
    if (!mounted) return;

    // save the consentId in dart state
    setState(() {
      _consentId = result;
    });

  }
```

Invoke the saveBiometricConsent() method

```
saveBiometricConsent(_reliantApplicationGuid, _programGuid);
```

### API <a name="api"></a>

| Method                                                          | Parameters                                                                                                                                    | Return Type         |
| --------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| [saveBiometricConsent](#savebiometricconsent)                   | `reliantAppGuid`: String (required)<br/> `programGuid`: String (required)                                                                     | `consentId`: String |
| [getRegisterUserWithBiometrics](#getregisteruserwithbiometrics) | `reliantAppGuid`: String (required)<br/> `programGuid`: String (required)<br/> `consentId`: String (required)                                 | `rId`: String       |
| [getRegisterBasicUser](#getregisterbasicuser)                   | `reliantAppGuid`: String (required)<br/> `programGuid`: String (required)                                                                     | `rId`: String       |
| [getWriteProfile](#getwriteprofile)                             | `reliantAppGuid`: String (required)<br/> `programGuid`: String (required)<br/> `rId`: String (required)<br/> `overwriteCard`: Bool (optional) | `<Object>`          |
| [getWritePasscode](#getwritepasscode)                           | `reliantAppGuid`: String (required)<br/> `programGuid`: String (required)<br/> `rId`: String (required)<br/> `passcode`: String (required)    | `<Object>`          |

### saveBiometricConsent

This API is used to save the user consent prior to collecting the biometric(s) and generating a unique digital identity.

### getRegisterUserWithBiometrics

This API is used by the Reliant Application to receive a bio-token and an R-ID following the registration of a new user.

### getRegisterBasicUser

This API is used to initiate the user registration with a passcode. The API is initiated by the Reliant Application after verifying that the user is unique and is invoked when the user declines the biometric consent capture.

### getWriteProfile

This API is used for card issuance to write the user’s basic profile data to the card once the user has been successfully registered, either by biometric flow or passcode flow. This operation is initiated by the Reliant Application after a successful user registration, when the Reliant Application receives the R-ID.

### getWritePasscode

This API is used to write the Passcode to the card. It is initiated by the Reliant Application to CPK after a successful user registration. The received Intent must be used for starting the Activity using startActivityForResult(), and the result must be handled via the onActivityResult() method.

## Support <a name="support"></a>

If you would like further information, please send an email to `cp.partnerprogram[at]mastercard.com`

- For updates regarding the community pass actions implementation, refer to the [TODO file](TODO.md)
- For information regarding licensing, refer to the [License file](LICENSE.md).
- For copyright information, refer to the [Copyright file](COPYRIGHT.md).
- For instructions on how to contribute to this project, refer to the [Contributing file](CONTRIBUTING.md).
- For changelog information, refer to the [Changelog file](CHANGELOG.md).
