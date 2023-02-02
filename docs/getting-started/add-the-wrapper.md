# Section 5: Install the Community Pass Flutter Wrapper

## 5.1 Objectives

To help you connect to the Community Pass Kernel, our team created the Community Pass Flutter Wrapper which bridges the gap between your application and the Community Pass Kernel. This plugin will enable you to develop an application using the CPK service’s APIs.

- At the end of this step, you will have added the Community Pass Flutter Wrapper to your Flutter reliant application.

## 5.2 Pre-requisites

1. Completed the sections 1, 2, 3 and 4 of this guide
2. The Flutter plugin, which is accessible via the [CP Assets](https://developer.mastercard.com/cp-kernel-integration-api/documentation/cp-assets/cp-assets-request/) Request. We will show you how to add the library to your project.

```
NOTE: Please note that you will need to create a developer account and request access to the library file
through CP Assets request. The approval may take 1-2 business days. Once you have access, proceed to download
the library for your development environment.
```

The following are the steps required to set up your project with the Community Pass Client SDK:

## 5.3 Installation

1. Download and extract the contents of the plugin to a folder.
2. The plugin will have a name similar to the following example: `community-pass-flutter-wrapper-x.y.z.tgz`.
3. Place the exctracted folder at the "same" level as your flutter project directory:

```
 -- plugin-name
 -- your flutter directory -- lib
                           -- android
                           -- ios etc etc
```

3. Open your flutter application project from an IDE and find this file => `pubspec.yaml`
4. Add the community pass flutter plugin dependency as shown below:

```yaml
dependencies:
  flutter:
    sdk: flutter
  my_new_package:
    path: /path/commnity_pass_flutter_wrapper
```

The `/path/commnity_pass_flutter_wrapper` above refers to the root folder of the plugin. it contains a pubspec.yaml for the plugin.

> If you have the package as a directory at the same level as the app, in other words one level higher up in the directory tree, you can use `../commnity_pass_flutter_wrapper` (note the double dot) or a full path to the package directory.

> Do not create a folder in your flutter root named packages and put packages or plugins in there. The packages folder is removed during build.

5. Open a terminal/command prompt and navigate to the root folder of your reliant application project. See example below:

```sh
cd /path/TestApp
```

6. Run the follownig command to make the package ready for use. Some IDEs like Visual Studio Code will automatically execute the command when the `pubspec.yaml` file has changed.

```sh
flutter pub get
```

7. Open `android/app/build.gradle` file of your reliant application and add the following line to your dependencies

```gradle
dependencies {
    ...

    // add this to your list of dependencies
    implementation project(':flutter_cpk_plugin');
    ...
}
```

8. Open `android/settings.gradle` file of your reliant application and replace `include: 'app'` with the following line

```gradle
include ':app', ':flutter_cpk_plugin'
```

9. If you are using Android Studio, a pop up notification will appear as given in the below image informing you that the Gradle files have changed. Click on Sync Now to synchronize the project with the Gradle files.

![](/docs/assets/android-studio-popup.png)

---

<br/>
You should now have completed the process of adding the Community Pass Flutter Wrapper into your Flutter Android Project.

You are now ready to engage with the CPK on your POI device and connect your Reliant Application to the Community Pass Kernel services.

[Return to Getting Started](README.md)
