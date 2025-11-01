# Setting Up the Flutter Multi-App Project

Once your Flutter development environment is set up and Android Emulator is running, follow these steps to get all three applications working.

## Prerequisites

Before continuing, ensure:
- Android Emulator is running and fully booted
- Terminal/PowerShell can access `flutter` command
- You have internet connection for downloading packages

Run this to verify everything is ready:

```bash
flutter doctor
```

All items should be checked (green checkmark) except Xcode (for iOS, not needed for this project).

---

## Step 1: Clone the Project Repository

Open Terminal (or PowerShell on Windows) and navigate to your projects folder:

```bash
cd ~
mkdir Flutter-Projects
cd Flutter-Projects
```

Clone the repository containing all three apps:

```bash
git clone https://github.com/ficrammanifur/flutter-project.git
cd flutter-multi-app
```

Replace the URL with your actual repository URL.

---

## Step 2: Understand Project Structure

After cloning, your folder structure should look like:

```
flutter-multi-app/
├── scheduling_assistant/        # Scheduling Assistant app
│   ├── lib/
│   ├── android/
│   ├── pubspec.yaml
│   └── ...
├── pastry_stock/                # PastryStock app
│   ├── lib/
│   ├── android/
│   ├── pubspec.yaml
│   └── ...
├── pilates_member/              # Pilates Member app
│   ├── lib/
│   ├── android/
│   ├── pubspec.yaml
│   └── ...
├── backend/                     # Python Flask APIs
│   ├── scheduling_api/
│   ├── pastry_stock_api/
│   ├── pilates_api/
│   └── requirements.txt
└── docs/                        # Documentation (this file)
```

---

## Step 3: Run First Flutter App (Scheduling Assistant)

Navigate to the first app:

```bash
cd scheduling_assistant
```

Get Flutter dependencies:

```bash
flutter pub get
```

This downloads all required packages (takes 1-2 minutes).

Start the app on your running emulator:

```bash
flutter run
```

You should see:
- "Flutter Doctor" verification running
- App compiling (first time takes 3-5 minutes)
- App launching on the emulator
- "Scheduling Assistant" screen appearing

---

## Step 4: Test the Scheduling Assistant App

Once the app is running:

1. Explore the UI - navigate through different screens
2. Try adding a schedule entry if the feature exists
3. Verify database connections work by checking for data persistence
4. In Terminal, you'll see logs like `I/flutter: ...` showing app activity

To stop the app:
- Press `q` in Terminal, or
- Close the app on emulator and Terminal will show app exited

---

## Step 5: Run Second Flutter App (PastryStock)

Navigate to the second app:

```bash
cd ../pastry_stock
```

Get dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Test the app's inventory and sales features.

---

## Step 6: Run Third Flutter App (Pilates Member)

Navigate to the third app:

```bash
cd ../pilates_member
```

Get dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Test membership management features.

---

## Step 7: Set Up Python Flask Backend

The Flutter apps need Flask APIs running for full functionality.

### Install Python (if not already installed)

**macOS:**
```bash
brew install python@3.11
```

**Windows:** Download from https://www.python.org/downloads/

**Linux:**
```bash
sudo apt install -y python3 python3-pip
```

### Set Up Flask Servers

Navigate to backend folder:

```bash
cd ../backend
```

Install Python dependencies:

```bash
pip install -r requirements.txt
```

This installs Flask, SQLAlchemy, Firebase SDK, and other required packages.

---

## Step 8: Run Flask Backends

Each app has its own backend. Start them in separate terminal windows:

### Terminal 1: Scheduling Assistant API

```bash
cd backend/scheduling_api
python app.py
```

You should see: `Running on http://localhost:5001`

### Terminal 2: PastryStock API

```bash
cd backend/pastry_stock_api
python app.py
```

You should see: `Running on http://localhost:5002`

### Terminal 3: Pilates Member API

```bash
cd backend/pilates_api
python app.py
```

You should see: `Running on http://localhost:5003`

---

## Step 9: Connect Flutter Apps to Backend APIs

The Flutter apps need to be configured to communicate with your Flask servers.

For each Flutter app, find the configuration file (usually in `lib/config/` or `lib/services/`):

1. Find the API base URL configuration
2. Update it to match your Flask server URL:
   - `http://localhost:5001` for Scheduling Assistant
   - `http://localhost:5002` for PastryStock
   - `http://localhost:5003` for Pilates Member

Note: The emulator uses `10.0.2.2` instead of `localhost` to reach your computer:
- `http://10.0.2.2:5001` (from emulator perspective)

After updating config, rebuild the app:

```bash
flutter run
```

---

## Step 10: Verify Full Integration

1. Keep all three Flask servers running in separate terminals
2. Keep Android Emulator running
3. Run one Flutter app using `flutter run`
4. Test features that require API calls:
   - Fetching data from backend
   - Saving data to database
   - Real-time updates if applicable

---

## Common Development Workflow

**Daily Development:**

1. Start Android Emulator
2. In 3 separate terminals, start the 3 Flask servers
3. In 4th terminal, navigate to the app you're working on:
   ```bash
   cd scheduling_assistant  # (or other app)
   flutter run
   ```
4. App hot-reloads as you save changes (press `r` in terminal)
5. Press `q` to stop the app

**Hot Reload:** While developing, press `r` in the terminal running `flutter run` to instantly reload code changes without restarting the app.

---

## Next Steps

- Check `99-troubleshooting.md` if you encounter errors
- Read the specific app documentation in each app's folder
- Set up your favorite code editor (VS Code, Android Studio, or IntelliJ)
