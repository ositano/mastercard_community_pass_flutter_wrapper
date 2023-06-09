# Section 7: Register and connect your Flutter application with the Community Pass Service

## 7.1 Objectives

Now that you have successfully set up your device and installed the Community Pass Flutter Wrapper on your project, you should be ready to start using the Community Pass Kernel Services. At the end of this segment, you will have completed the following:

- Connect your Reliant App and test your connection to the Community Pass Kernel

## 7.2 Prerequisites

Before you get started on this section, ensure you have completed the following:

- You will need to have completed sections 1, 2, 3, 4, 5 and 6 in the [Getting Started](README.md) guide.
- You have received a Reliant App and Program GUID: This is your reliant application identifier shared with you on email as part of our onboarding process.

## 7.3 Use the Community Pass APIs in your Flutter Application

1. Open a command line and navigate to the root folder of your reliant application project

terminal/comand prompt 1

```sh
cd /path/FlutterTestApp
```

2. Ensure that your POI device has debug mode enabled and connect it to your computer.
3. Start your reliant application by running the following command:

```sh
flutter run
```

4. To use the plugin in your code, import it to a file in your lib folder. See example below:

```dart
// main.dart

import 'package:compass_library_wrapper_plugin/compassapi.dart';
```

5. From the dame file initialize the API to a variable, see example below:

```dart
  final _communityPassFlutterplugin = CommunityPassApi();
```

## 7.4 Usage Examples

> By default, your reliant application is connected to the community pass kernel if you can get a response from one of these APIs, as shown below.

Add the saveBiometricConsent() Commnity Pass API to your application

```dart
static final String reliantGUID = 'e32b7762-531c-4ca0-a55e-a74e00c144ac';
static final String programGUID = '3ac23543-f4ce-4526-98d3-c071ba422449';
bool consumerConsentValue = true; // please use true for grant consent and false for deny consent

try{
    SaveBiometricConsentResult result = await _communityPassFlutterplugin.saveBiometricConsent(
          reliantGUID, programGUID , consumerConsentValue);

    print(result.consentID); // cdd5883e-357b-418b-baf1-be5bef0bfaef
    print(result.responseStatus); // SUCCESS
} on Platformexception catch (exception) {
    print(exception.code); // 600
}
```

Add the getRegisterUserWithBiometrics() compass API to your application

```dart
static final String reliantGUID = 'e32b7762-531c-4ca0-a55e-a74e00c144ac';
static final String programGUID = '3ac23543-f4ce-4526-98d3-c071ba422449';

try{
    RegisterUserWithBiometricsResult result = await _communityPassFlutterplugin.getRegisterUserWithBiometrics(
          reliantGUID, programGUID, consentID);

    print(result.rID); // 4ae8c3fa-7dc1-40c1-bbaf-b664c41e150a
    print(result.enrolmentStatus); // EXISTING | NEW
    print(result.bioToken) // jWt if user is new. Empty string if user Exists
    print(result.programGUID) // 3ac23543-f4ce-4526-98d3-c071ba422449
} on Platformexception catch (exception) {
    print(exception.code); // 501
}
```

Add the getRegisterBasicUser() Commnity Pass API to your application

```dart
static final String reliantGUID = 'e32b7762-531c-4ca0-a55e-a74e00c144ac';
static final String programGUID = '3ac23543-f4ce-4526-98d3-c071ba422449';

try{
    RegisterBasicUserResult result = await _communityPassFlutterplugin.getRegisterBasicUser(
          reliantGUID, programGUID);

    print(result.rID); // 4ae8c3fa-7dc1-40c1-bbaf-b664c41e150a
} on Platformexception catch (exception) {
    print(exception.code); // 600
}
```

Add the getWritePasscode() Commnity Pass API to your application

```dart
static final String reliantGUID = 'e32b7762-531c-4ca0-a55e-a74e00c144ac';
static final String programGUID = '3ac23543-f4ce-4526-98d3-c071ba422449';

try{
    WritePasscodeResult result = await _communityPassFlutterplugin.getWritePasscode(
          reliantGUID, programGUID);

    print(result.responseStatus); // SUCCESS
} on Platformexception catch (exception) {
    print(exception.code); // 702
}
```

Add the getWriteProfile() Commnity Pass API to your application

```dart
static final String reliantGUID = 'e32b7762-531c-4ca0-a55e-a74e00c144ac';
static final String programGUID = '3ac23543-f4ce-4526-98d3-c071ba422449';

try{
    WriteProfileResult result = await _communityPassFlutterplugin.getWriteProfile(
          reliantGUID, programGUID, rID, overwriteCard);

    print(result.consumerDeviceNumber); // 1234564665
} on Platformexception catch (exception) {
    print(exception.code); // 721
}
```

For updates regarding the Community Pass APIs that have been added to the plugin, refer to the [TODO file](/TODO.md)

You are now ready to start building your Flutter Reliant Application using the Community Pass Kernel assets.

[Return to Getting Started](README.md)
