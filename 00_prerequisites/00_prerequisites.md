# Prerequisites: Setting Up Your Flutter Development Environment

Before starting this course, you need to set up Flutter and the required development tools. This guide covers installation for both Windows and macOS.

## What You'll Install

1. **Flutter SDK** - The framework itself
2. **An IDE** - We recommend VS Code, but alternatives work fine
3. **Platform tools** - Android Studio (required for Android) and Xcode (macOS only, for iOS)

---

## 1. Installing Flutter SDK

### Windows

> 📹 **Video Walkthrough:** [Windows Flutter Installation](placeholder)

**System Requirements:**
- Windows 10 or later (64-bit)
- 2.5 GB disk space (not including IDE)
- PowerShell 5.0 or newer
- Git for Windows

**Steps:**

1. Download the Flutter SDK from [flutter.dev/docs/get-started/install/windows](https://docs.flutter.dev/get-started/install/windows)

2. Extract the zip file to a location without spaces in the path. Recommended:
   ```
   C:\src\flutter
   ```
   Avoid paths like `C:\Program Files\` — spaces cause issues with some tools.

3. Add Flutter to your PATH:
   - Search for "Environment Variables" in Windows
   - Under "User variables", find `Path` and click Edit
   - Add the full path to `flutter\bin` (e.g., `C:\src\flutter\bin`)
   - Click OK to save

4. Open a new Command Prompt or PowerShell window and run:
   ```
   flutter doctor
   ```

You'll likely see some warnings — that's expected. We'll address them in the following sections.

### macOS

> 📹 **Video Walkthrough:** [macOS Flutter Installation](placeholder)

**System Requirements:**
- macOS 10.15 (Catalina) or later
- 2.8 GB disk space (not including IDE)
- Git (comes with Xcode Command Line Tools)

**Option A: Direct Download**

1. Download the Flutter SDK from [flutter.dev/docs/get-started/install/macos](https://docs.flutter.dev/get-started/install/macos)
   - Choose the correct version for your Mac (Apple Silicon or Intel)

2. Extract to your home directory:
   ```bash
   cd ~/development
   unzip ~/Downloads/flutter_macos_*.zip
   ```

3. Add Flutter to your PATH. For zsh (default on modern macOS):
   ```bash
   echo 'export PATH="$HOME/development/flutter/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

**Option B: Using Homebrew**

If you have Homebrew installed:
```bash
brew install --cask flutter
```

This handles PATH configuration automatically.

**Verify installation:**
```bash
flutter doctor
```

---

## 2. IDE Setup

### VS Code (Recommended)

VS Code is lightweight, fast, and has excellent Flutter support. It's what most Flutter developers use.

> 📹 **Video Walkthrough:** [VS Code Flutter Setup](placeholder)

1. Download VS Code from [code.visualstudio.com](https://code.visualstudio.com/)

2. Install the Flutter extension:
   - Open VS Code
   - Press `Ctrl+Shift+X` (Windows) or `Cmd+Shift+X` (macOS) to open Extensions
   - Search for "Flutter"
   - Install the extension by Dart Code (it will also install the Dart extension)

3. Verify the setup:
   - Press `Ctrl+Shift+P` / `Cmd+Shift+P`
   - Type "Flutter: Run Flutter Doctor"
   - The output should appear in the terminal

**Useful VS Code Shortcuts:**
- `Ctrl+.` / `Cmd+.` — Quick fixes and refactoring
- `F5` — Run with debugging
- `Ctrl+F5` / `Cmd+F5` — Run without debugging
- `r` in terminal — Hot reload (while app is running)
- `R` in terminal — Hot restart

### Alternative IDEs

**Android Studio / IntelliJ IDEA**
- Full-featured IDE with built-in Android tools
- Heavier on system resources
- Install Flutter and Dart plugins from Settings → Plugins

**Zed**
- Fast, modern editor
- Flutter support through extensions
- Good choice if you prefer minimal interfaces

---

## 3. Android Setup

You need Android Studio even if you use VS Code — it provides the Android SDK and emulator.

> 📹 **Video Walkthrough:** [Android Development Setup](placeholder)

### Installing Android Studio

1. Download from [developer.android.com/studio](https://developer.android.com/studio)

2. Run the installer and follow the setup wizard

3. During setup, ensure these components are selected:
   - Android SDK
   - Android SDK Command-line Tools
   - Android SDK Build-Tools
   - Android Emulator

4. Accept the Android licenses:
   ```bash
   flutter doctor --android-licenses
   ```
   Type `y` to accept each license.

### Creating an Android Emulator

1. Open Android Studio
2. Go to Tools → Device Manager (or click the phone icon in the toolbar)
3. Click "Create Device"
4. Select a phone model (Pixel 6 or similar is a good choice)
5. Download a system image (select a recent API level, e.g., API 34)
6. Finish the wizard and launch the emulator

### Using a Physical Android Device

1. Enable Developer Options on your phone:
   - Go to Settings → About Phone
   - Tap "Build Number" seven times

2. Enable USB Debugging:
   - Settings → Developer Options → USB Debugging

3. Connect your phone via USB and accept the debugging prompt

4. Verify the device is detected:
   ```bash
   flutter devices
   ```

---

## 4. iOS Setup (macOS Only)

> 📹 **Video Walkthrough:** [iOS Development Setup](placeholder)

iOS development requires a Mac with Xcode installed.

### Installing Xcode

1. Open the App Store and search for "Xcode"
2. Click Install (this takes a while — Xcode is large)

3. After installation, open Terminal and run:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```

4. Accept the Xcode license:
   ```bash
   sudo xcodebuild -license accept
   ```

5. Install CocoaPods (dependency manager for iOS):
   ```bash
   sudo gem install cocoapods
   ```

### Using the iOS Simulator

1. Open Xcode
2. Go to Xcode → Open Developer Tool → Simulator
3. Or from Terminal:
   ```bash
   open -a Simulator
   ```

The simulator will appear in `flutter devices` output.

### Using a Physical iOS Device

Physical device development requires an Apple Developer account (free tier works for personal testing):

1. Connect your iPhone via USB
2. Open Xcode and go to Settings → Accounts
3. Add your Apple ID
4. When you run a Flutter app, Xcode will prompt for code signing

---

## 5. Verifying Your Setup

Run Flutter Doctor to check everything is configured:

```bash
flutter doctor
```

**Ideal output:**

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain - develop for Android devices
[✓] Xcode - develop for iOS and macOS (macOS only)
[✓] Chrome - develop for the web
[✓] Android Studio
[✓] VS Code
[✓] Connected device (2 available)
[✓] Network resources
```

Don't worry if you see warnings for platforms you don't plan to use. For this course, you need at least:
- Flutter SDK
- Android toolchain OR Xcode
- Your IDE of choice
- At least one connected device or emulator

### Creating Your First Flutter App

Test your setup by creating and running a Flutter app:

```bash
flutter create my_first_app
cd my_first_app
flutter run
```

If everything is configured correctly, you'll see the Flutter demo app running on your emulator or device.

> 📹 **Video Walkthrough:** [Running Your First Flutter App](placeholder)

---

## Troubleshooting

### "flutter: command not found"

The Flutter SDK isn't in your PATH. Double-check:
- Windows: The PATH entry points to `flutter\bin`, not just `flutter`
- macOS: Run `source ~/.zshrc` after editing, or open a new terminal

### Android licenses not accepted

Run:
```bash
flutter doctor --android-licenses
```

### Xcode command line tools not installed

Run:
```bash
xcode-select --install
```

### CocoaPods not installed

Run:
```bash
sudo gem install cocoapods
```

If you get permission errors on macOS:
```bash
brew install cocoapods
```

### Emulator won't start / HAXM error (Windows)

Intel HAXM (hardware acceleration) may need to be installed separately:
1. Open Android Studio → SDK Manager
2. Go to SDK Tools tab
3. Check "Intel x86 Emulator Accelerator (HAXM installer)"
4. Apply changes

For AMD processors, use Android Emulator Hypervisor Driver instead.

### "Unable to locate Android SDK"

Set the Android SDK path:
```bash
flutter config --android-sdk /path/to/android/sdk
```

Typical locations:
- Windows: `C:\Users\<username>\AppData\Local\Android\Sdk`
- macOS: `~/Library/Android/sdk`

---

## Next Steps

Once `flutter doctor` shows no critical issues, you're ready to start Lesson 1.
