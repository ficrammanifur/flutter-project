# Troubleshooting Guide

## Common Issues and Solutions

### Issue: `flutter: command not found`

**Problem:** Flutter is not in your PATH.

**Solutions:**

**macOS/Linux:**
```bash
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
# or ~/.bash_profile for Bash
source ~/.zshrc
```

**Windows:**
- Go to Environment Variables
- Add `C:\Users\YourUsername\flutter\bin` to the Path variable
- Restart PowerShell

---

### Issue: `ANDROID_SDK_ROOT not found` or `Android SDK tools not found`

**Problem:** Android SDK environment variables not set.

**Solutions:**

Find your Android SDK path:
- macOS/Linux: Usually `/Users/username/Library/Android/Sdk` or similar
- Windows: Usually `C:\Users\Username\AppData\Local\Android\Sdk`

Set the environment variable:

**macOS/Linux:**
```bash
echo 'export ANDROID_SDK_ROOT=/path/to/your/android/sdk' >> ~/.zshrc
source ~/.zshrc
```

**Windows:** Add to Environment Variables as described in setup guides.

---

### Issue: `Java: command not found`

**Problem:** JDK not installed or not in PATH.

**Solutions:**

Verify Java is installed:

```bash
java -version
javac -version
```

If not found, install JDK:

**macOS:**
```bash
brew install openjdk
```

**Windows:** Download from https://www.oracle.com/java/technologies/downloads/

**Linux:**
```bash
sudo apt install openjdk-11-jdk
```

Set JAVA_HOME environment variable and restart terminal.

---

### Issue: Emulator won't start / `emulator: ERROR: ...`

**Problem:** Emulator can't launch or crashes.

**Solutions:**

1. Check if emulator already exists:
   ```bash
   $ANDROID_SDK_ROOT/emulator/emulator -list-avds
   ```

2. If no emulator listed, create one:
   ```bash
   $ANDROID_SDK_ROOT/tools/bin/avdmanager create avd -n flutter_device -k "system-images;android-33;google_apis;x86_64" -d pixel
   ```

3. Try starting with verbose output:
   ```bash
   $ANDROID_SDK_ROOT/emulator/emulator -avd flutter_device -verbose
   ```

4. Check if port 5037 is in use (Android Debug Bridge):
   ```bash
   # macOS/Linux
   lsof -i :5037
   
   # Windows
   netstat -ano | findstr :5037
   ```

5. If port in use, kill the process and try again.

---

### Issue: `flutter pub get` fails

**Problem:** Package download fails due to network or permission issues.

**Solutions:**

1. Check internet connection
2. Clear pub cache:
   ```bash
   flutter pub cache clean
   ```

3. Try again:
   ```bash
   flutter pub get
   ```

4. If specific package fails, try removing `pubspec.lock`:
   ```bash
   rm pubspec.lock
   flutter pub get
   ```

---

### Issue: App compilation fails with Gradle errors

**Problem:** Android build system (Gradle) encounters errors.

**Solutions:**

1. Check `android/gradle.properties` exists with correct settings:
   ```properties
   org.gradle.jvmargs=-Xmx1024m -XX:MaxMetaspaceSize=512m -XX:ReservedCodeCacheSize=256m -XX:+HeapDumpOnOutOfMemoryError
   android.useAndroidX=true
   android.enableJetifier=true
   ```

2. Clear Gradle cache:
   ```bash
   rm -rf android/.gradle
   flutter pub get
   flutter run
   ```

3. Update Gradle wrapper:
   ```bash
   cd android
   ./gradlew --version
   cd ..
   flutter run
   ```

---

### Issue: "No devices found" or emulator not detected by Flutter

**Problem:** Emulator is running but Flutter can't see it.

**Solutions:**

1. Check if emulator is visible:
   ```bash
   flutter devices
   ```

2. Start adb server:
   ```bash
   adb start-server
   ```

3. List connected devices:
   ```bash
   adb devices
   ```

4. If emulator listed but Flutter can't see it, restart:
   ```bash
   flutter clean
   flutter pub get
   ```

---

### Issue: Flask backend connection error in Flutter app

**Problem:** Flutter app can't connect to Python Flask server.

**Solutions:**

1. Verify Flask server is running:
   ```bash
   # Should see "Running on http://localhost:PORT"
   ```

2. Check if port is accessible:
   ```bash
   # macOS/Linux
   lsof -i :5001
   
   # Windows
   netstat -ano | findstr :5001
   ```

3. In Flutter app config, use correct IP:
   - On emulator: `http://10.0.2.2:5001` (10.0.2.2 = host machine)
   - On real device: `http://YOUR_COMPUTER_IP:5001` (get IP with `ipconfig` on Windows or `ifconfig` on Mac/Linux)

4. Check firewall isn't blocking connections:
   - macOS: System Preferences → Security & Privacy → Firewall
   - Windows: Settings → Privacy & Security → Windows Defender Firewall

5. In Flask app, ensure CORS is enabled for Flutter requests

---

### Issue: "Insufficient disk space" during build

**Problem:** Not enough storage for emulator or build artifacts.

**Solutions:**

1. Check available disk space:
   ```bash
   # macOS/Linux
   df -h
   
   # Windows
   wmic logicaldisk get name,size,freespace
   ```

2. Clean Flutter cache:
   ```bash
   flutter clean
   rm -rf build/
   ```

3. Delete old emulator snapshots (if not using):
   ```bash
   # Find emulator data location and remove old snapshots
   ```

4. Free up space by moving files or deleting unnecessary files

---

### Issue: App crashes immediately after launch

**Problem:** App runs but crashes before displaying UI.

**Solutions:**

1. Check Flutter logs:
   ```bash
   flutter run -v  # verbose output
   ```

2. Look for error messages starting with "E/"
3. Common causes:
   - Database connection failed
   - Required API not responding
   - Missing permissions in AndroidManifest.xml
   - Version mismatch between package versions

4. Check if Flask backend is running (if app needs API)

5. Try running on a different emulator version

---

### Issue: Hot reload not working

**Problem:** Changes don't appear when pressing `r` in terminal.

**Solutions:**

1. Some changes require full rebuild:
   - Changes to `pubspec.yaml`
   - Changes to Android manifest
   - Plugin changes
   
   For these, press `R` (capital) to hot restart, or stop and run again.

2. If hot reload still fails:
   ```bash
   # Stop the app (press 'q')
   flutter clean
   flutter run
   ```

---

### Issue: "Unhandled Exception" with database or Firebase errors

**Problem:** App encounters runtime error related to data storage.

**Solutions:**

1. Check database credentials in config
2. Verify Firebase setup if using Firebase
3. Check if local SQLite database has proper permissions
4. For SQLite, ensure `android/app/build.gradle` includes:
   ```gradle
   dependencies {
       implementation 'androidx.sqlite:sqlite:...'
   }
   ```

---

### Getting More Help

If you're still stuck:

1. Check the specific app's README in its folder
2. Run `flutter doctor` to diagnose system issues
3. Check Flutter logs with `-v` flag: `flutter run -v`
4. Search Flutter GitHub issues: https://github.com/flutter/flutter/issues
5. Check app-specific documentation in `backend/` folder
