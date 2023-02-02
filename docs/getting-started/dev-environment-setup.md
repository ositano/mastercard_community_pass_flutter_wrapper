# Section 3: Setting Up Your Flutter Development Environment

## 3.1 Objectives

Once your device has been set-up, you will now need to prepare your development environment. This will allow you to create your Flutter project and connect your device to your Reliant Application that will be used in later sections.

At the end of this section you will have done the following:

- Install development dependencies
- Setup Android Studio
- Setup Flutter CLI
- Create a new project
- Connect the Flutter CLI to your device
- Run a simple “Hello world” application to test your setup

> To configure an existing project for Community Pass integration, please see the [Install the Community Pass Flutter Wrapper](add-the-wrapper.md) instructions.

## 3.2 Installing dependencies on macOS

You will need to meet the following minimum requirements:

- **Operating Systems**: macOS
- **Disk Space**: 2.8 GB (does not include disk space for IDE/tools).
- **Tools**: Flutter uses `git` for installation and upgrade.

> Important: If you’re installing on an [Apple Silicon Mac](https://support.apple.com/en-us/HT211814), you must have the Rosetta translation environment available for some [ancillary tools](https://github.com/flutter/website/pull/7119#issuecomment-1124537969). You can install this manually by running:

```sh
 sudo softwareupdate --install-rosetta --agree-to-license
```

### 3.2.1 Get the Flutter SDK

1. Download an installation bundle from [here](https://docs.flutter.dev/development/tools/sdk/releases?tab=macos) to get the latest stable release of the Flutter SDK.

> Tip: To determine whether your Mac uses an Apple silicon processor, refer to [Mac computers with Apple silicon](https://support.apple.com/en-us/HT211814) on apple.com

2. Extract the file in the desired location, for example:

```sh
cd ~/development
unzip ~/Downloads/flutter_macos_3.7.1-stable.zip
```

3. Add the flutter tool to your path:

```sh
export PATH="$PATH:`pwd`/flutter/bin"
```

This command sets your `PATH` variable for the current terminal window only. To permanently add Flutter to your path, see [Update your path](#323-update-your-path).

You are now ready to run Flutter commands!

### 3.2.2 Run flutter doctor

Run the following command to see if there are any dependencies you need to install to complete the setup (for verbose output, add the `-v` flag):

```sh
flutter doctor
```

This command checks your environment and displays a report to the terminal window. The Dart SDK is bundled with Flutter; it is not necessary to install Dart separately. Check the output carefully for other software you might need to install or further tasks to perform (shown in **bold** text)

For example:

```
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/obiwan/Library/Android/sdk
    ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</pre>
    • Try re-installing or updating your Android SDK,
      visit https://docs.flutter.dev/setup/#android-setup for detailed instructions.

```

The following sections describe how to perform these tasks and finish the setup process.

Once you have installed any missing dependencies, run the flutter doctor command again to verify that you’ve set everything up correctly.

### 3.2.3 Update your path (macOS)<a href="update-yout-path-macos"></a>

You can update your PATH variable for the current session at the command line, as shown in Get the Flutter SDK. You’ll probably want to update this variable permanently, so you can run flutter commands in any terminal session.

The steps for modifying this variable permanently for all terminal sessions are machine-specific. Typically you add a line to a file that is executed whenever you open a new window. For example:

1.  Determine the path of your clone of the Flutter SDK. You need this in Step 3.
2.  Open (or create) the rc file for your shell. Typing `echo $SHELL` in your Terminal tells you which shell you’re using. If you’re using Bash, edit `$HOME/.bash_profile`or`$HOME/.bashrc`. If you’re using Z shell, edit `$HOME/.zshrc`. If you’re using a different shell, the file path and filename will be different on your machine.
3.  Add the following line and change `[PATH_OF_FLUTTER_GIT_DIRECTORY]` to be the path of your clone of the Flutter git repo:

```sh
export PATH="$PATH:[PATH_OF_FLUTTER_GIT_DIRECTORY]/bin"
```

4. Run `source $HOME/.<rc file>` to refresh the current window, or open a new terminal window to automatically source the file.
5. Verify that the `flutter/bin` directory is now in your PATH by running:

```sh
echo $PATH
```

Verify that the `flutter` command is available by running:

```sh
which flutter
```

## 3.3 Installing dependencies on Windows

You will need to meet the following minimum requirements:

- **Operating Systems**: Windows 10 or later (64-bit), x86-64 based.
- **Disk Space**: 1.64 GB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these tools being available in your environment.

  - [Windows PowerShell 5.0](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-windows-powershell) or newer (this is pre-installed with Windows 10)
  - [Git for Windows](https://git-scm.com/download/win) 2.x, with the **Use Git from the Windows Command Prompt** option.

    If Git for Windows is already installed, make sure you can run git commands from the command prompt or PowerShell.

### 3.3.1 Get the Flutter SDK

1. Download an installation bundle from [here](https://docs.flutter.dev/development/tools/sdk/releases?tab=macos) to get the latest stable release of the Flutter SDK.
2. Extract the zip file and place the contained flutter in the desired installation location for the Flutter SDK (for example, `C:\src\flutter`).

> Warning: Do not install Flutter to a path that contains special characters or spaces.

> Warning: Do not install Flutter in a directory like C:\Program Files\ that requires elevated privileges.

If you don’t want to install a fixed version of the installation bundle, you can skip steps 1 and 2. Instead, get the source code from the [Flutter repo](https://github.com/flutter/flutter) on GitHub, and change branches or tags as needed. For example:

```sh
git clone https://github.com/flutter/flutter.git -b stable
```

You are now ready to run Flutter commands in the Flutter Console.

### 3.3.2 Update your path (Windows)

If you wish to run Flutter commands in the regular Windows console, take these steps to add Flutter to the PATH environment variable:

- From the Start search bar, enter ‘env’ and select Edit environment variables for your account.
- Under User variables check if there is an entry called Path:
  - If the entry exists, append the full path to flutter\bin using ; as a separator from existing values.
  - If the entry doesn’t exist, create a new user variable named Path with the full path to flutter\bin as its value.

You have to close and reopen any existing console windows for these changes to take effect.

### 3.3.3 Run flutter doctor

From a console window that has the Flutter directory in the path, run the following command to see if there are any platform dependencies you need to complete the setup:

```sh
C:\src\flutter>flutter doctor
```

This command checks your environment and displays a report of the status of your Flutter installation. Check the output carefully for other software you might need to install or further tasks to perform (shown in **bold** text).

For example:

```sh
[-] Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
    • Try re-installing or updating your Android SDK,
      visit https://docs.flutter.dev/setup/#android-setup for detailed instructions.
```

The following sections describe how to perform these tasks and finish the setup process. Once you have installed any missing dependencies, you can run the `flutter doctor` command again to verify that you’ve set everything up correctly.

Note: If `flutter doctor` returns that either the Flutter plugin or Dart plugin of Android Studio are not installed, move on to platform setup to resolve this issue.

## 3.4 Platform setup (Windos and macOS)

Please complete the steps below, to be able to build and run your first Flutter app.

### 3.4.1 Android setup

> Note: Flutter relies on a full installation of Android Studio to supply its Android platform dependencies. However, you can write your Flutter apps in a number of editors; a later step discusses that.

### 3.4.2 Install Android Studio

1. Download and install [Android Studio](https://developer.android.com/studio).
2. Start Android Studio, and go through the ‘Android Studio Setup Wizard’. This installs the latest Android SDK, Android SDK Command-line Tools, and Android SDK Build-Tools, which are required by Flutter when developing for Android.
3. Run `flutter doctor` to confirm that Flutter has located your installation of Android Studio. If Flutter cannot locate it, run `flutter config --android-studio-dir <directory>` to set the directory that Android Studio is installed to.

### 3.4.3 Set up your Android device

To prepare to run and test your Flutter app on an Android device, you need an Android device running Android 4.1 (API level 16) or higher.

1. Enable `Developer options` and `USB debugging` on your device. Detailed instructions are available in section 2 ofd this guide.
2. Windows-only: Install the [Google USB Driver](https://developer.android.com/studio/run/win-usb).
3. Using a USB cable, plug your phone into your computer. If prompted on your device, authorize your computer to access your device.
4. In the terminal, run the `flutter devices` command to verify that Flutter recognizes your connected Android device. By default, Flutter uses the version of the Android SDK where your `adb` tool is based. If you want Flutter to use a different installation of the Android SDK, you must set the `ANDROID_SDK_ROOT` environment variable to that installation directory.

### 3.4.4 Agree to Android Licenses

Before you can use Flutter, you must agree to the licenses of the Android SDK platform. This step should be done after you have installed the tools listed above.

1. Make sure that you have a version of Java 8 installed and that your `JAVA_HOME` environment variable is set to the JDK’s folder.

   Android Studio versions 2.2 and higher come with a JDK, so this should already be done.

2. Open an elevated console window and run the following command to begin signing licenses.

```sh
flutter doctor --android-licenses
```

3. Review the terms of each license carefully before agreeing to them.
4. Once you are done agreeing with licenses, run `flutter doctor` again to confirm that you are ready to use Flutter.

[Return to Getting Started](README.md)
