# 📱 FreshCart - Flutter Mobile Application

A feature-rich, cross-platform e-commerce mobile application built with Flutter. FreshCart offers a complete shopping experience with Firebase authentication, Razorpay payment integration, real-time cart management, and intuitive admin controls.

---

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Running the App](#-running-the-app)
- [Project Structure](#-project-structure)
- [State Management](#-state-management)
- [API Integration](#-api-integration)
- [Payment Integration](#-payment-integration)
- [Troubleshooting](#-troubleshooting)

---

## ✨ Features

### 🔐 Authentication
- **Email/Password Sign-in** with OTP verification
- **Google Sign-In** with Firebase integration
- **Password Reset** via email OTP
- **Profile Management** with image upload
- **Secure Token Storage** using Flutter Secure Storage
- **Loading Toast** for Google authentication feedback

### 🛍️ Shopping Experience
- **Product Catalog** with category filtering
- **Search Functionality** for quick product discovery
- **Product Details** with high-quality images
- **Favorites/Wishlist** management
- **Stock Tracking** in real-time
- **Responsive UI** with light/dark theme support

### 🛒 Cart Management
- **Add/Remove Items** with smooth animations
- **Quantity Management** with instant updates
- **Real-time Price Calculation**
- **Persistent Cart** synced with backend
- **Empty Cart** state handling

### 💳 Checkout & Payments
- **Multiple Payment Methods:**
  - Cash on Delivery (COD)
  - Online Payment via Razorpay
- **Delivery Address** input and validation
- **Order Summary** before payment
- **Payment Gateway** integration with Razorpay
- **Order Confirmation** with success feedback

### 📦 Order Management
- **Order History** with detailed view
- **Order Tracking** by payment method
- **Order Details** with product list
- **Pull-to-Refresh** for latest orders

### 👨‍💼 Admin Features
- **Separate Admin Interface**
- **Product Management** (CRUD operations)
- **Category Management**
- **Order Overview** with filters
- **User Management**
- **Stock Management**
- **Image Upload** to Cloudinary

---

## 🚀 Tech Stack

### Framework & Language
- **Flutter** 3.9.0+
- **Dart** SDK

### State Management
- **GetX** - Reactive state management, dependency injection, and routing

### Networking
- **Dio** - HTTP client for API calls
- **Cookie Jar** - Cookie management
- **Dio Cookie Manager** - Cookie persistence

### Authentication & Storage
- **Firebase Auth** - Email/Password and Google Sign-in
- **Google Sign In** - Google authentication
- **Flutter Secure Storage** - Secure token storage

### Payment Integration
- **Razorpay Flutter** - Payment gateway SDK

### UI & Components
- **Cupertino Icons** - iOS-style icons
- **Google Fonts** - Custom typography
- **Flutter Feather Icons** - Beautiful icon set
- **Flutter SVG** - SVG rendering
- **Smooth Page Indicator** - Onboarding indicators
- **Toastification** - Toast notifications
- **Skeletonizer** - Loading placeholders

### Utilities
- **Form Field Validator** - Input validation
- **Pin Code Fields** - OTP input
- **File Picker** - Image selection
- **Flutter Dotenv** - Environment variables

---

## 📋 Prerequisites

Before you begin, ensure you have installed:

- **Flutter SDK** (3.9.0 or higher)
  ```bash
  flutter --version
  ```
- **Dart SDK** (comes with Flutter)
- **Android Studio** or **Xcode** (for iOS development)
- **Git**
- **Node.js** (for backend)
- **MongoDB** (local or cloud)

### Required Accounts
- **Firebase Account** (for authentication)
- **Razorpay Account** (for payment gateway)
- **Cloudinary Account** (for image uploads)

---

## 🔧 Installation

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Neel-Pandya/FreshCart-App.git
cd FreshCart-App/frontend
```

### 2️⃣ Install Flutter Dependencies

```bash
flutter pub get
```

### 3️⃣ Verify Installation

```bash
flutter doctor
```

Fix any issues reported by Flutter doctor before proceeding.

---

## ⚙️ Configuration

### 1️⃣ Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add Project"**
3. Name it **"FreshCart"** and follow the setup wizard
4. Enable **Google Analytics** (optional)

#### Enable Authentication Methods
1. Navigate to **Authentication → Sign-in method**
2. Enable:
   - **Email/Password**
   - **Google Sign-In**

#### Add Android App

1. In Firebase Console → **Project Settings**
2. Click **"Add App"** → Select **Android**
3. **Package Name:** `com.example.frontend` (or check `android/app/build.gradle`)
4. Download `google-services.json`
5. Place it at: `android/app/google-services.json`

**Get SHA-1 Certificate (for Google Sign-In):**
```bash
cd android
./gradlew signingReport
```
Copy SHA-1 and add it to Firebase Console → Project Settings → Android App

#### Add iOS App

1. In Firebase Console → **Project Settings**
2. Click **"Add App"** → Select **iOS**
3. **Bundle ID:** `com.example.frontend.RunnerTests` (check `ios/Runner.xcodeproj`)
4. Download `GoogleService-Info.plist`
5. Place it at: `ios/Runner/GoogleService-Info.plist`
6. Install CocoaPods dependencies:
   ```bash
   cd ios
   pod install
   cd ..
   ```

### 2️⃣ Environment Variables

Create a `.env` file in the `frontend/` directory:

```env
# Backend API URL (use your local IP for testing on physical devices)
BACKEND_URL=http://192.168.1.100:8000/api/

# Razorpay Keys (Test mode)
RAZORPAY_KEY_ID=rzp_test_YOUR_KEY_ID
RAZORPAY_KEY_SECRET=YOUR_KEY_SECRET
```

> **Note:** Replace `192.168.1.100` with your machine's IP address. Don't use `localhost` when testing on physical devices.

**To find your IP:**
- **Windows:** `ipconfig` (look for IPv4 Address)
- **Mac/Linux:** `ifconfig` or `ip addr`

### 3️⃣ Razorpay Configuration

1. Sign up at [Razorpay Dashboard](https://dashboard.razorpay.com/)
2. Go to **Settings → API Keys**
3. Generate **Test Keys**
4. Copy **Key ID** and **Key Secret** to `.env` file

### 4️⃣ Backend Setup

Make sure the backend server is running:

```bash
cd ../backend
npm install
npm run dev
```

The backend should be running on `http://YOUR_IP:8000`

---

## 🚀 Running the App

### Development Mode

```bash
flutter run
```

### Run on Specific Device

```bash
# List available devices
flutter devices

# Run on Android
flutter run -d android

# Run on iOS (Mac only)
flutter run -d ios

# Run on Chrome (Web)
flutter run -d chrome
```

### Build Release

#### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

#### Android App Bundle
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

#### iOS
```bash
flutter build ios --release
```

---

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point
├── firebase_options.dart          # Firebase configuration
│
├── core/                          # Core app functionality
│   ├── controllers/
│   │   ├── theme_controller.dart
│   │   ├── bottom_nav_controller.dart
│   │   └── drawer_nav_controller.dart
│   │
│   ├── models/                    # Data models
│   │   ├── user.dart
│   │   ├── product.dart
│   │   ├── cart.dart
│   │   ├── order.dart
│   │   ├── admin_order.dart
│   │   └── category.dart
│   │
│   ├── routes/                    # Route definitions
│   │   ├── auth_routes.dart
│   │   ├── user_routes.dart
│   │   └── admin_routes.dart
│   │
│   ├── services/                  # Business logic services
│   │   └── razorpay_service.dart
│   │
│   ├── theme/                     # App theming
│   │   ├── app_colors.dart
│   │   └── app_typography.dart
│   │
│   ├── utils/                     # Utilities
│   │   ├── api_client.dart        # Dio HTTP client
│   │   └── toaster.dart           # Toast notifications
│   │
│   ├── validators/                # Form validators
│   │   ├── auth_validator.dart
│   │   └── product_validator.dart
│   │
│   └── widgets/                   # Reusable widgets
│       ├── primary_button.dart
│       ├── custom_textfield.dart
│       ├── product_card.dart
│       └── drawer_navigation.dart
│
├── modules/                       # Feature modules
│   ├── common/
│   │   └── auth/                  # Authentication
│   │       ├── login/
│   │       ├── signup/
│   │       ├── forgot_password/
│   │       ├── otp_verification/
│   │       └── common/
│   │           └── controllers/
│   │               └── auth_controller.dart
│   │
│   ├── user/                      # User-side features
│   │   ├── home/
│   │   │   ├── screens/
│   │   │   ├── widgets/
│   │   │   └── controller/
│   │   │
│   │   ├── products/
│   │   │   ├── screens/
│   │   │   ├── widgets/
│   │   │   └── controller/
│   │   │
│   │   ├── cart/
│   │   │   ├── screens/
│   │   │   ├── widgets/
│   │   │   └── controller/
│   │   │
│   │   ├── checkout/
│   │   │   ├── screens/
│   │   │   ├── widgets/
│   │   │   └── controller/
│   │   │
│   │   ├── orders/
│   │   │   ├── screens/
│   │   │   ├── widgets/
│   │   │   └── controller/
│   │   │
│   │   └── profile/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   └── admin/                     # Admin-side features
│       ├── dashboard/
│       ├── products/
│       ├── categories/
│       ├── orders/
│       └── users/
│
└── layout/                        # Layout wrappers
    ├── user_master_layout.dart
    └── admin_master_layout.dart
```

---

## 🎯 State Management

### GetX Controllers

FreshCart uses **GetX** for state management. Each feature has its own controller:

#### Example: Cart Controller

```dart
class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  Rx<bool> isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }
  
  Future<void> addToCart(String productId, int quantity) async {
    // API call
  }
  
  Future<void> fetchCart() async {
    // API call
  }
}
```

#### Usage in Widgets

```dart
class CartScreen extends StatelessWidget {
  final cartController = Get.find<CartController>();
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => cartController.isLoading.value
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) => CartItemWidget(
              item: cartController.cartItems[index],
            ),
          ));
  }
}
```

---

## 🌐 API Integration

### API Client Configuration

The app uses **Dio** with custom interceptors for authentication:

```dart
// lib/core/utils/api_client.dart
class ApiClient {
  final Dio _dio;
  
  ApiClient() : _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BACKEND_URL']!,
    connectTimeout: Duration(seconds: 15),
    receiveTimeout: Duration(seconds: 15),
  ));
  
  // Automatically adds JWT token to headers
  // Handles errors globally
}
```

### Making API Calls

```dart
// GET request
final response = await apiClient.get('products/all');

// POST request
final response = await apiClient.post('auth/login', data: {
  'email': email,
  'password': password,
});

// PUT request
final response = await apiClient.put('cart/update', data: {
  'productId': productId,
  'quantity': quantity,
});

// DELETE request
final response = await apiClient.delete('cart/remove/$productId');
```

### Error Handling

The API client automatically handles common errors:
- **Network timeout**
- **No internet connection**
- **Server errors (4xx, 5xx)**
- **Invalid responses**

---

## 💳 Payment Integration

### Razorpay Setup

#### Initialize Service

```dart
class _CheckoutScreenState extends State<CheckoutScreen> {
  late final RazorpayService razorpayService;
  
  @override
  void initState() {
    super.initState();
    razorpayService = RazorpayService();
  }
  
  @override
  void dispose() {
    razorpayService.dispose();
    super.dispose();
  }
}
```

#### Payment Flow

```dart
Future<void> _handleRazorpayPayment() async {
  // 1. Create order on backend
  final orderData = await orderController.createRazorpayOrder(address);
  
  // 2. Open Razorpay modal
  razorpayService.openPaymentGateway(
    orderId: orderData['orderId'],
    amount: orderData['amount'],
    keyId: orderData['keyId'],
    name: user.name,
    email: user.email,
    contact: '9999999999',
    onSuccess: (paymentId, orderId, signature) async {
      // 3. Verify payment on backend
      await orderController.verifyRazorpayPayment(
        razorpayOrderId: orderId,
        razorpayPaymentId: paymentId,
        razorpaySignature: signature,
        deliveryAddress: address,
      );
    },
    onError: (errorMessage) {
      Toaster.showErrorMessage(message: errorMessage);
    },
  );
}
```

### Test Payment

Use these test card details in development:
- **Card:** 4111 1111 1111 1111
- **CVV:** Any 3 digits
- **Expiry:** Any future date

---

## 🐛 Troubleshooting

### Common Issues

#### 1. "Network Error" or "Connection Refused"

**Problem:** App can't connect to backend

**Solutions:**
- Ensure backend is running on the correct port
- Check `BACKEND_URL` in `.env` file
- Use your machine's IP address (not `localhost`) for physical devices
- Disable firewall or allow port 8000
- Restart both frontend and backend

```bash
# Find your IP
ipconfig  # Windows
ifconfig  # Mac/Linux
```

#### 2. Google Sign-In Not Working

**Problem:** Google authentication fails

**Solutions:**
- Add SHA-1 certificate to Firebase Console
- Download updated `google-services.json`
- Enable Google Sign-In in Firebase Authentication
- Check package name matches Firebase configuration
- Rebuild the app after configuration changes

```bash
# Get SHA-1
cd android
./gradlew signingReport
```

#### 3. Razorpay Modal Not Opening

**Problem:** Payment gateway doesn't appear

**Solutions:**
- Verify `RAZORPAY_KEY_ID` in `.env` is correct
- Hot restart app after adding environment variables
- Check backend Razorpay configuration
- Ensure razorpay_flutter package is installed
- Check console logs for errors

```bash
flutter clean
flutter pub get
flutter run
```

#### 4. "Firebase not initialized"

**Problem:** Firebase configuration missing

**Solutions:**
- Add `google-services.json` (Android)
- Add `GoogleService-Info.plist` (iOS)
- Run `flutterfire configure` (if using FlutterFire CLI)
- Check `firebase_options.dart` exists
- Rebuild the app

#### 5. Build Errors After Dependencies Update

**Problem:** Compilation errors after `flutter pub get`

**Solutions:**
```bash
flutter clean
flutter pub get
cd android && ./gradlew clean && cd ..
cd ios && pod deintegrate && pod install && cd ..
flutter run
```

#### 6. Images Not Loading

**Problem:** Product/profile images don't display

**Solutions:**
- Check network connection
- Verify image URLs are correct
- Check Cloudinary configuration in backend
- Add internet permission in AndroidManifest.xml:
  ```xml
  <uses-permission android:name="android.permission.INTERNET"/>
  ```

### Debug Commands

```bash
# Check Flutter installation
flutter doctor -v

# View detailed logs
flutter run --verbose

# Clear build cache
flutter clean

# Rebuild dependencies
flutter pub get

# Run on specific device
flutter devices
flutter run -d <device-id>
```

---

## 📱 Supported Platforms

- ✅ **Android** (5.0 and above)
- ✅ **iOS** (11.0 and above)
- ✅ **Web** (Chrome, Firefox, Safari)
- ⚠️ **Windows** (Experimental)
- ⚠️ **macOS** (Experimental)
- ⚠️ **Linux** (Experimental)

---

## 🎨 Customization

### Change Theme Colors

Edit `lib/core/theme/app_colors.dart`:

```dart
class AppColors {
  static const Color primary = Color(0xFF2AB930);
  static const Color secondary = Color(0xFF1E88E5);
  // Add your custom colors
}
```

### Update Typography

Edit `lib/core/theme/app_typography.dart`:

```dart
class AppTypography {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  // Add your custom text styles
}
```

---

## 📄 Dependencies

Full list in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  google_fonts: ^6.3.1
  smooth_page_indicator: ^1.2.1
  flutter_feather_icons: ^2.0.0+1
  flutter_svg: ^2.2.1
  form_field_validator: ^1.1.0
  toastification: ^3.0.3
  pin_code_fields: ^8.0.1
  dio: ^5.9.0
  flutter_secure_storage: ^9.2.4
  get: ^4.7.2
  flutter_dotenv: ^6.0.0
  file_picker: ^10.3.3
  firebase_core: ^4.1.1
  firebase_auth: ^6.1.0
  google_sign_in: ^7.2.0
  cookie_jar: ^4.0.8
  dio_cookie_manager: ^3.3.0
  skeletonizer: ^2.1.0+1
  razorpay_flutter: ^1.4.0
```

---

## 🤝 Contributing

This is a learning project. Contributions for improvements are welcome!

---

## 👨‍💻 Developer

**Neel Pandya**
- GitHub: [@Neel-Pandya](https://github.com/Neel-Pandya)

---

## 📞 Support

For issues and questions:
- Check the [Troubleshooting](#-troubleshooting) section
- Review [Backend README](../backend/README.md) for API issues
- Open an issue on GitHub

---

**Built with ❤️ using Flutter**