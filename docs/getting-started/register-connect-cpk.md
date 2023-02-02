# Section 7: Register and connect your Flutter application with the Community Pass Service

## 7.1 Objectives

Now that you have successfully set up your device and installed the Community Pass Flutter Wrapper on your project, you should be ready to start using the Community Pass Kernel Services. At the end of this segment, you will have completed the following:

- Connect your Reliant App and test your connection to the Community Pass Kernel

## 7.2 Prerequisites

Before you get started on this section, ensure you have completed the following:

- You will need to have completed sections 1, 2, 3, 4, 5 and 6 in the [Getting Started](README.md) guide.
- You have received a Reliant App and Program GUID: This is your reliant application identifier shared with you on email as part of our onboarding process.

## 7.3 Use the Community Pass APIs in your Flutter Application

1. Open a terminal/command prompt and navigate to the root folder of your reliant application project

terminal/comand prompt 1

```sh
cd /path/TestApp
```

2. Ensure that your POI device has debug mode enabled and connect it to your computer.
3. Start your reliant application by running the following command:

```sh
flutter run
```

4. To use a plugin in your code, you need to import it. An example of an import command looks like this:

```dart
import 'package:community_pass_flutter_plugin/community_pass_flutter_plugin.dart';
```

## 7.4 Usage Examples

> By default, your reliant application is connected to the community pass kernel if you can get a response from one of these APIs, as shown below.

Add the saveBiometricConsent() Commnity Pass API to your application

```dart
try {
    var result = await _channel.invokeMethod('saveBiometricConsent', {
        'RELIANT_APP_GUID': 'e32b7762-531c-4ca0-a55e-a74e00c144ac',
        'PROGRAM_GUID': '3ac23543-f4ce-4526-98d3-c071ba422449'
    });
    String consentId = result['consentId']; // cdd5883e-357b-418b-baf1-be5bef0bfaef
} on PlatformException catch (ex) {
    String errorMessage = ex.message;
    String errorCode = ex.code;
}

```

Add the getRegisterUserWithBiometrics() compass API to your application

```dart
try {
    var result = await _channel.invokeMethod('getRegisterUserWithBiometrics', {
        'RELIANT_APP_GUID': 'e32b7762-531c-4ca0-a55e-a74e00c144ac',
        'PROGRAM_GUID': '3ac23543-f4ce-4526-98d3-c071ba422449',
        'CONSENT_ID': 'cdd5883e-357b-418b-baf1-be5bef0bfaef'
    });

    String rId = result['rId']; // 4ae8c3fa-7dc1-40c1-bbaf-b664c41e150a
    String responseStatus = result['responseStatus']; // EXISTING or NEW
    String bioToken = result['bioToken']; // jWt
    String programGUID = result['programGUID']; // 3ac23543-f4ce-4526-98d3-c071ba422449
} on PlatformException catch (ex) {
    String errorMessage = ex.message;
    String errorCode = ex.code;
}
```

Add the getRegisterBasicUser() Commnity Pass API to your application

```dart
try {
    var result = await _channel.invokeMethod('getRegisterBasicUser', {
        'RELIANT_APP_GUID': 'e32b7762-531c-4ca0-a55e-a74e00c144ac',
        'PROGRAM_GUID': '3ac23543-f4ce-4526-98d3-c071ba422449',
    });

    String rId = result['rId']; //4ae8c3fa-7dc1-40c1-bbaf-b664c41e150a
} on PlatformException catch (ex) {
    String errorMessage = ex.message;
    String errorCode = ex.code;
}
```

Add the getWritePasscode() Commnity Pass API to your application

```dart
try {
    var result = await _channel.invokeMethod('getWritePasscode', {
        'RELIANT_APP_GUID': 'e32b7762-531c-4ca0-a55e-a74e00c144ac',
        'PROGRAM_GUID': '3ac23543-f4ce-4526-98d3-c071ba422449',
        'PASSCODE': '123456', // A 6 digit numeric PIN
    });

    String responseStatus = result['responseStatus']; // SUCCESS
} on PlatformException catch (ex) {
    String errorMessage = ex.message;
    String errorCode = ex.code;
}
```

Add the getWriteProfile() Commnity Pass API to your application

```dart
try {
    var result = await _channel.invokeMethod('getWriteProfile', {
        'RELIANT_APP_GUID': 'e32b7762-531c-4ca0-a55e-a74e00c144ac',
        'PROGRAM_GUID': '3ac23543-f4ce-4526-98d3-c071ba422449',
        'OVERWRITE_CARD': false, // true or false
        'RID': 'd81e5987-f36b-4b12-9b78-db71bdc0fbc6'
    });

    String consumerDeviceNumber = result['responseStatus']; //1234564665
} on PlatformException catch (ex) {
    String errorMessage = ex.message;
    String errorCode = ex.code;
}
```

For updates regarding the Community Pass APIs that have been added to the plugin, refer to the [TODO file](/TODO.md)

You are now ready to start building your Flutter Reliant Application using the Community Pass Kernel assets.

[Return to Getting Started](README.md)
