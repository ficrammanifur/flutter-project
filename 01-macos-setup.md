# macOS: Complete Flutter Setup from Zero

## Step 1: Install Homebrew (macOS Package Manager)

Homebrew makes installing development tools easy on macOS.

1. Open **Terminal** (Cmd + Space, type "Terminal")
2. Copy and paste this command, then press Enter:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Enter your password when prompted
4. Wait for installation to complete (this may take 5-10 minutes)
5. Verify installation by running:

```bash
brew --version
```

You should see version information printed.

---

## Step 2: Install Java Development Kit (JDK)

Flutter requires JDK for compiling Android apps.

```bash
brew install openjdk
```

After installation, set the Java path. Add this line to your shell profile:

```bash
export JAVA_HOME=/opt/homebrew/opt/openjdk
```

Add it to your `~/.zshrc` file (or `~/.bash_profile` if using Bash):

```bash
echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk' >> ~/.zshrc
source ~/.zshrc
```

Verify by running:

```bash
java -version
```

---

## Step 3: Install Android SDK

The Android SDK is required to build Android apps.

```bash
brew install --cask android-sdk
```

Set the Android SDK path in your shell profile:

```bash
echo 'export ANDROID_SDK_ROOT=/usr/local/share/android-sdk' >> ~/.zshrc
echo 'export PATH=$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/tools:$PATH' >> ~/.zshrc
source ~/.zshrc
```

Verify the path:

```bash
echo $ANDROID_SDK_ROOT
```

---

## Step 4: Download Android Components Using sdkmanager

The `sdkmanager` is included with Android SDK. Install required components:

```bash
$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager "platform-tools" "build-tools;33.0.0" "platforms;android-33" "system-images;android-33;google_apis;x86_64" "emulator"
```

This downloads:
- Platform Tools (adb, fastboot)
- Build Tools 33.0.0
- Android 33 SDK
- Android 33 emulator system image
- Emulator executable

Accept licenses if prompted by typing `y` and pressing Enter.

---

## Step 5: Install Flutter SDK

Download and install Flutter:

```bash
cd ~/
git clone https://github.com/flutter/flutter.git -b stable
```

Add Flutter to your PATH:

```bash
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

Verify Flutter is installed:

```bash
flutter --version
```

---

## Step 6: Run Flutter Doctor

Flutter has a built-in diagnostic tool to check your setup:

```bash
flutter doctor
```

This will show:
- Dart version status (should be included with Flutter)
- Android SDK status
- Java version status
- Xcode status (for iOS development - not needed for Android emulator)

Common issues and fixes are shown in the output. Most Android development issues can be resolved by accepting Android SDK licenses:

```bash
flutter doctor --android-licenses
```

Press `y` to accept all licenses.

---

## Step 7: Create Android Virtual Device (Emulator)

Now create a virtual Android device to test your Flutter apps.

```bash
$ANDROID_SDK_ROOT/emulator/emulator -list-avds
```

This lists any existing emulators. If empty, create one:

```bash
$ANDROID_SDK_ROOT/tools/bin/avdmanager create avd -n flutter_device -k "system-images;android-33;google_apis;x86_64" -d pixel
```

This creates an emulator named `flutter_device` based on a Pixel phone with Android 33.

---

## Step 8: Launch the Android Emulator

Start the emulator:

```bash
$ANDROID_SDK_ROOT/emulator/emulator -avd flutter_device
```

The emulator window will open. Wait for it to fully boot (you'll see the Android home screen). This takes 1-3 minutes.

---

## Next Steps

Once the emulator is running and booted:
- Go to `04-project-setup.md` to clone and run the Flutter apps
- Your emulator stays open while you develop (minimize it)
- You can open multiple emulators at once for testing
