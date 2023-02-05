# Contributing

Contributions are always welcome, no matter how large or small!

We want this community to be friendly and respectful to each other. Please follow it in all your interactions with the project. Before contributing, please read the [code of conduct](./CODE_OF_CONDUCT.md).

To get started please complete the following steps:

## 1 Fork the library

1. Fork the community-pass-flutter-wrapper repository
2. Create your feature branch (git checkout -b my-new-feature)

## 2 Add the Community Pass Kernel Library file to your Android Project

To help you connect to the Community Pass Kernel, our team created the Community Pass Kernel Library (.AAR file) that bridges the gap between your application and the Community Pass Kernel. This library will enable you to use the CPK service’s APIs while working on this plugin.

### 2.1 Pre-Requisites

- You will need to use the Android Studio
- Download the Commmunity Pass Kernel AAR library which can be accessed through [CP Assets Request](https://developer.mastercard.com/cp-kernel-integration-api/documentation/cp-assets/cp-assets-request/). We will show you how to add the AAR to your project.

```
NOTE: Please note that you will need to request access to the AAR through CP Assets Request. The approval may take 1-2 business days. Once you have access, proceed to download the AAR library for your development environment.
```

### 2.2 Adding the Community Pass Kernel Library File

The following are the steps required to set up your project with the Community Pass Client SDK:

**Locate and Move the Community Pass Kernel Library File to your Android Studio Project**

1. Locate the folder where you downloaded the AAR library to. The library will have a name similar to the following example: `community-pass-library-2.4.0.aar`
2. Start your Android Studio and click on the **Plugins** mewnu from the left panel.
3. Install the `Dart` and `Flutter` Android Studio plugin. See below:

![](/docs/assets/android-studio-plugins.png)

**Figure 1** Install androud studio plugins

4. Click on the **Projects** menu from the left panel and followed by the open button at the top right corner.
5. Navigate to the location of the `community-pass-flutter-wrapper` folder, open the example folder and select the android folder. Click open.

```
Please note that there are two android folders in the project.
- In the root level of the plugin files
- Inside the example folder (Open this)
```

![](/docs/assets/open-project-2.png)

**Figure 2** Open your Flutter Android Project from android studio

6. The project will take some time to build. After the build process is completed, click on the Project Tab in the top left corner and then click on the Project dropdown to open `community-pass-flutter-wrapper`.

7. Navigate through `community-pass-flutter-wrapper` from the dropdown > app > libs
8. Copy your AAR file into the libs folder in your Android Studio as shown in the figure below:

![](/docs/assets/add-aar-android-studio.png)

**Figure 3** Move the Community Pass Kernel Library file to your Android Studio project

9. On the Android Studio top toolbar, click on **Build** > **Rebuid Project** to synchronize the project with the Gradle files.

You should now have completed the process of adding the Community Pass AAR Library into your Android Studio Project.

You are now ready to install the CPK onto your POI device and connect your Reliant Application to the Community Pass Kernel services.

## 3 Install Flutter Project Pependencies

1. Open a command line and navigate to the root folder of the [example app](/example/). See example below:

```sh
cd /path/community-pass-flutter-wrapper/example
```

2. Run the command below on your command line to install the [example app dependencies](/example/pubspec.yaml). Some IDEs like Visual Studio Code will automatically execute the command when the pubspec.yaml file has changed.

```sh
flutter pub get
```

3. Make sure your POI device has debug mode enabled. Connect it yo your computer and run the following command to build, install and start your flutter application

```sh
flutter run
```

## 4 Quality Expectations

Please ensure any contributions include unit tests. The project maintains a high level of test coverage for its functionality.
Submissions are expected to maintain a similar level of coverage.

## 5 Commit Message Convention

We follow the [conventional commits specification](https://www.conventionalcommits.org/en) for our commit messages:

- `fix`: bug fixes, e.g. fix crash due to deprecated method.
- `feat`: new features, e.g. add new method to the module.
- `refactor`: code refactor, e.g. migrate from class components to hooks.
- `docs`: changes into documentation, e.g. add usage example for the module..
- `test`: adding or updating tests, e.g. add integration tests using detox.
- `chore`: tooling changes, e.g. change CI config.

Our pre-commit hooks verify that your commit message matches this format when committing.

## 6 Publishing

Note that the production version of the library is hosted at [CP Assets](https://developer.mastercard.com/cp-kernel-integration-api/documentation/cp-assets/cp-assets-request/) for easier versioning. Please do not use `flutter pub publish` and `flutter pub publish --dry-run` commands with the library.

## 7 Sending a pull request

> **Working on your first pull request?** You can learn how from this _free_ series: [How to Contribute to an Open Source Project on GitHub](https://app.egghead.io/playlists/how-to-contribute-to-an-open-source-project-on-github).

When you're sending a pull request:

- Prefer small pull requests focused on one change.
- Verify that linters and tests are passing.
- Review the documentation to make sure it looks good.
- Follow the pull request template when opening a pull request.
- For pull requests that change the API or implementation, discuss with maintainers first by opening an issue.
