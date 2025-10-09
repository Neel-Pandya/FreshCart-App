# 🛒 FreshCart

FreshCart is a Flutter-based e-commerce application that integrates with **Firebase Authentication** and a **Node.js + Express + MongoDB backend**.

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/your-username/freshcart.git
cd freshcart
```

---

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

---

### 3️⃣ Firebase Setup

Since Firebase config files are **ignored** (for security reasons), you must add your own.

#### 🔹 Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/).
2. Create a new project named **FreshCart** (or any name).
3. Enable services:

   * **Authentication** → Google Sign-In, Email/Password.
   * **Firestore/Realtime Database** (if used).
   * **Cloud Storage** (if used).

#### 🔹 Add Android App

1. In **Project Settings → General**, click **Add App → Android**.
2. Enter the package name (check `android/app/build.gradle`).
3. Download `google-services.json`.
4. Place it in:

   ```
   android/app/google-services.json
   ```

#### 🔹 Add iOS App

1. In **Project Settings → General**, click **Add App → iOS**.
2. Enter the bundle identifier (check `ios/Runner.xcodeproj`).
3. Download `GoogleService-Info.plist`.
4. Place it in:

   ```
   ios/Runner/GoogleService-Info.plist
   ```
5. Run CocoaPods install (only for iOS):

   ```bash
   cd ios
   pod install
   cd ..
   ```

---

### 4️⃣ Environment Variables

This project uses environment variables for API configuration.

1. Copy the example file:

```bash
cp .env.example .env
```

2. Open `.env` and fill in values:

```env
BACKEND_URL=YOUR_BACKEND_URL_HERE
```

---

### 5️⃣ Backend Setup (Node + Express + MongoDB)

FreshCart uses a custom backend for APIs and database.

1. Navigate to backend folder:

```bash
cd backend
```

2. Install dependencies:

```bash
npm install
```

3. Create a `.env` file:

```env
PORT=5000
MONGO_URI=your-mongodb-uri
JWT_SECRET=your-secret-key
```

4. Start the server:

```bash
npm start
```

---

### 6️⃣ Run the App

Make sure the backend is running, then start the Flutter app:

```bash
flutter run
```

---

## 🚀 Tech Stack

* **Frontend:** Flutter
* **Backend:** Node.js + Express
* **Database:** MongoDB
* **Auth:** Firebase Authentication (Google Sign-In, Email/Password)

---
