# Type Aliases

## User Registration Request

### SaveBiometricConsentParams<a name="save-biometric-consent-params"></a>

```dart
typedef SaveBiometricConsentParams = Map<String, dynamic>;
final SaveBiometricConsentParams requestParam = {
  "reliantAppGUID": "";
  "programGUID": "";
  "consumerConsentValue": false;
}
```

### GetWritePasscodeParams<a name="get-write-passcode-params"></a>

```dart
typedef GetWritePasscodeParams = Map<String, String>;
final GetWritePasscodeParams requestParam = {
  "reliantAppGUID": "";
  "programGUID": "";
  "rID": "";
  "passcode": "";
}
```

### GetWriteProfileParams<a name="get-write-profile-params"></a>

```dart
typedef GetWriteProfileParams = Map<String, dynamic>;
final GetWriteProfileParams requestParam = {
  "reliantAppGUID": "";
  "programGUID": "";
  "rID": "";
  "overwriteCard": false;
}
```

### GetRegisterBasicUserParams<a name="get-register-basic-user-params"></a>

```dart
typedef GetRegisterBasicUserParams = Map<String, String>;
final GetRegisterBasicUserParams requestParam = {
  "reliantAppGUID": "";
  "programGUID": "";
}
```

### GetRegisterUserWithBiometricsParams<a name="get-register-user-with-biometrics-params"></a>

```dart
typedef GetRegisterUserWithBiometricsParams = Map<String, String>;
final GetRegisterUserWithBiometricsParams requestParam = {
  "reliantAppGUID": "";
  "programGUID": "";
  "consentId": "";
}
```

## User Registration Response

### SaveBiometricConsentResult<a name="save-biometric-consent-result"></a>

```dart
typedef SaveBiometricConsentResult = Map<String, String>;
final SaveBiometricConsentResult responseParam = {
  "consentId": "";
  "responseStatus": "";
}
```

### GetWritePasscodeResult<a name="get-write-passcode-result"></a>

```dart
typedef GetWritePasscodeResult = Map<String, String>;
final GetWritePasscodeResult responseParam =  {
  "responseStatus": "";
}
```

### GetWriteProfileResult<a name="get-write-profile-result"></a>

```dart
typedef GetWriteProfileResult = Map<String, String>;
final GetWriteProfileResult responseParam = {
  "consumerDeviceNumber": "";
}
```

### GetRegisterBasicUserResult<a name="get-register-basic-user-result"></a>

```dart
typedef GetRegisterBasicUserResult = Map<String, String>;
final GetRegisterBasicUserResult responseParam = {
  "rId": "";
}
```

### GetRegisterUserWithBiometricsResult<a name="get-register-user-with-biometrics-result"></a>

```dart
typedef GetRegisterUserWithBiometricsResult = Map<String, String>;
final GetRegisterUserWithBiometricsResult responseParam = {
  "rId": "";
  "enrolmentStatus": "";
  "bioToken": "";
  "programGUID": "";
}
```
