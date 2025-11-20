# 🛒 FreshCart - Complete E-Commerce Solution

FreshCart is a full-stack e-commerce mobile application built with **Flutter** for the frontend and **Node.js + Express + MongoDB** for the backend. It features Firebase Authentication, Razorpay payment integration, real-time cart management, and comprehensive admin controls.

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Setup Instructions](#️-setup-instructions)
- [API Documentation](#-api-documentation)
- [Payment Integration](#-payment-integration)
- [Project Structure](#-project-structure)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)

---

## ✨ Features

### 🛍️ User Features
- **Authentication**
  - Email/Password authentication
  - Google Sign-In with Firebase
  - OTP verification for signup
  - Password reset functionality
  - Profile management with image upload

- **Product Browsing**
  - Browse products by categories
  - Search functionality
  - Product details with images
  - Add to favorites/wishlist
  - Stock availability tracking

- **Shopping Cart**
  - Add/remove items
  - Update quantities
  - Real-time price calculation
  - Persistent cart (saved to backend)

- **Checkout & Orders**
  - Multiple payment methods:
    - Cash on Delivery (COD)
    - Online payment via Razorpay
  - Delivery address management
  - Order history tracking
  - Order details view

### 👨‍💼 Admin Features
- **Dashboard**
  - Sales overview
  - Order statistics
  - User analytics

- **Product Management**
  - Add/Edit/Delete products
  - Category management
  - Stock management
  - Image upload (Cloudinary)

- **Order Management**
  - View all orders
  - Filter by payment method
  - Order status tracking
  - User details for each order

- **User Management**
  - View all users
  - Update user roles
  - Delete users

---

## 🚀 Tech Stack

### Frontend
- **Framework:** Flutter 3.9.0+
- **State Management:** GetX
- **HTTP Client:** Dio
- **UI Components:** Custom widgets with Material Design
- **Authentication:** Firebase Auth
- **Payment:** Razorpay Flutter SDK
- **Storage:** Flutter Secure Storage
- **Image Handling:** File Picker, Cloudinary

### Backend
- **Runtime:** Node.js
- **Framework:** Express.js
- **Database:** MongoDB with Mongoose
- **Authentication:** JWT (JSON Web Tokens)
- **Payment Gateway:** Razorpay
- **Cloud Storage:** Cloudinary
- **Email Service:** Nodemailer
- **Validation:** Zod

### DevOps & Tools
- **Version Control:** Git
- **Development:** Nodemon (auto-reload)
- **Code Quality:** Prettier, ESLint
- **Environment:** dotenv

---

## 🏗️ Architecture

### Frontend Architecture
```
lib/
├── core/
│   ├── controllers/      # Global controllers (theme, navigation)
│   ├── models/          # Data models (User, Product, Order)
│   ├── routes/          # Route definitions
│   ├── services/        # Business logic (Razorpay service)
│   ├── theme/           # App theming (colors, typography)
│   ├── utils/           # Utilities (API client, toaster)
│   ├── validators/      # Form validators
│   └── widgets/         # Reusable widgets
├── modules/
│   ├── common/
│   │   └── auth/        # Authentication screens & controllers
│   ├── user/            # User-side modules
│   │   ├── cart/
│   │   ├── checkout/
│   │   ├── home/
│   │   ├── orders/
│   │   ├── products/
│   │   └── profile/
│   └── admin/           # Admin-side modules
│       ├── dashboard/
│       ├── orders/
│       ├── products/
│       └── users/
└── main.dart
```

### Backend Architecture
```
backend/
├── src/
│   ├── core/
│   │   ├── config/      # Configuration (env, database)
│   │   ├── middleware/  # Custom middleware (auth, error handling)
│   │   ├── models/      # Shared models
│   │   └── utils/       # Utilities (API responses, errors)
│   ├── modules/
│   │   ├── auth/        # Authentication routes & controllers
│   │   ├── cart/        # Cart management
│   │   ├── category/    # Category CRUD
│   │   ├── orders/      # Order processing & Razorpay
│   │   ├── products/    # Product CRUD
│   │   └── user/        # User management
│   ├── app.js           # Express app configuration
│   ├── server.js        # Server entry point
│   └── index.routes.js  # Route aggregation
└── uploads/             # Temporary file uploads
```

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Neel-Pandya/FreshCart-App.git
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

### 4️⃣ Frontend Environment Variables

This project uses environment variables for API configuration.

1. Create a `.env` file in the `frontend/` directory:

```bash
cd frontend
```

2. Add the following variables:

```env
BACKEND_URL=http://YOUR_IP_ADDRESS:8000/api/
RAZORPAY_KEY_ID=rzp_test_YOUR_KEY_ID
RAZORPAY_KEY_SECRET=YOUR_KEY_SECRET
```

> **Note:** Replace `YOUR_IP_ADDRESS` with your local machine's IP address (not `localhost`) for testing on physical devices.

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

3. Create a `.env` file using `.env.sample` as reference:

```env
# App Configuration
APP_HOST=192.168.1.100  # Your local IP
APP_PORT=8000
NODE_ENV=development

# Database Configuration
MONGO_URI=mongodb://localhost:27017/freshcart

# JWT Configuration
JWT_SECRET=your_jwt_secret_key_here
COOKIE_SECRET=your_cookie_secret_key_here

# Email Configuration (for OTP)
EMAIL_USERNAME=your_email@gmail.com
EMAIL_PASSWORD=your_app_password

# Cloudinary Configuration (for image uploads)
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

# Firebase Admin SDK Configuration
FIREBASE_ACCOUNT_TYPE=service_account
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_PRIVATE_KEY_ID=your_private_key_id
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYOUR_KEY\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=firebase-adminsdk@your-project.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=your_client_id
FIREBASE_AUTH_URI=https://accounts.google.com/o/oauth2/auth
FIREBASE_TOKEN_URI=https://oauth2.googleapis.com/token
FIREBASE_AUTH_PROVIDER_X509_CERT_URL=https://www.googleapis.com/oauth2/v1/certs
FIREBASE_CLIENT_X509_CERT_URL=your_cert_url
FIREBASE_UNIVERSE_DOMAIN=googleapis.com

# Razorpay Configuration (for payments)
RAZORPAY_KEY_ID=rzp_test_YOUR_KEY_ID
RAZORPAY_KEY_SECRET=YOUR_KEY_SECRET
```

> **Important:** Get Firebase service account credentials from Firebase Console → Project Settings → Service Accounts → Generate New Private Key

4. Start the development server:

```bash
npm run dev
```

---

### 6️⃣ Run the App

Make sure the backend is running, then start the Flutter app:

```bash
flutter run
```

Or for specific platforms:

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome
```

---

## 📡 API Documentation

### Authentication Endpoints

#### POST `/api/auth/signup`
Register a new user with email verification.

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "status": 201,
  "message": "OTP sent to your email",
  "success": true
}
```

#### POST `/api/auth/verify-otp`
Verify OTP to complete registration.

**Request Body:**
```json
{
  "email": "john@example.com",
  "otp": "123456"
}
```

#### POST `/api/auth/login`
Login with email and password.

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "status": 200,
  "message": "Login successful",
  "data": {
    "id": "user_id",
    "name": "John Doe",
    "email": "john@example.com",
    "role": 0,
    "accessToken": "jwt_token_here"
  }
}
```

#### POST `/api/auth/google-login`
Login with Google ID token.

#### POST `/api/auth/google-signup`
Signup with Google ID token.

#### POST `/api/auth/forgot-password`
Request password reset OTP.

#### POST `/api/auth/reset-password`
Reset password using OTP.

### Product Endpoints

#### GET `/api/products/all`
Get all products (with optional filters).

**Query Parameters:**
- `category`: Filter by category ID
- `search`: Search by product name

#### GET `/api/products/:id`
Get single product by ID.

#### POST `/api/products/add` (Admin only)
Add a new product.

**Request Body (multipart/form-data):**
```json
{
  "name": "Product Name",
  "description": "Product Description",
  "price": 99.99,
  "stock": 100,
  "categoryId": "category_id",
  "image": "file"
}
```

#### PUT `/api/products/update/:id` (Admin only)
Update product details.

#### DELETE `/api/products/delete/:id` (Admin only)
Delete a product.

### Cart Endpoints

#### GET `/api/cart/get`
Get user's cart items.

#### POST `/api/cart/add`
Add item to cart.

**Request Body:**
```json
{
  "productId": "product_id",
  "quantity": 2
}
```

#### PUT `/api/cart/update`
Update cart item quantity.

#### DELETE `/api/cart/remove/:productId`
Remove item from cart.

#### DELETE `/api/cart/clear`
Clear entire cart.

### Order Endpoints

#### POST `/api/orders/create`
Create order (for COD).

**Request Body:**
```json
{
  "paymentMethod": "Cash on Delivery",
  "deliveryAddress": "123 Main St, City, Country"
}
```

#### POST `/api/orders/razorpay/create`
Create Razorpay order.

**Response:**
```json
{
  "status": 201,
  "data": {
    "orderId": "order_xyz123",
    "amount": 20000,
    "currency": "INR",
    "keyId": "rzp_test_key"
  }
}
```

#### POST `/api/orders/razorpay/verify`
Verify Razorpay payment and create order.

**Request Body:**
```json
{
  "razorpayOrderId": "order_xyz123",
  "razorpayPaymentId": "pay_abc456",
  "razorpaySignature": "signature_hash",
  "deliveryAddress": "123 Main St, City, Country"
}
```

#### GET `/api/orders/all`
Get user's order history.

#### GET `/api/orders/admin/all` (Admin only)
Get all orders from all users.

### Category Endpoints

#### GET `/api/category/all`
Get all categories.

#### POST `/api/category/add` (Admin only)
Add new category.

#### PUT `/api/category/update/:id` (Admin only)
Update category.

#### DELETE `/api/category/delete/:id` (Admin only)
Delete category.

### User Endpoints (Admin only)

#### GET `/api/user/all`
Get all users.

#### PUT `/api/user/update/:id`
Update user details.

#### DELETE `/api/user/delete/:id`
Delete user.

---

## 💳 Payment Integration

### Razorpay Setup

1. **Create Razorpay Account**
   - Go to [Razorpay Dashboard](https://dashboard.razorpay.com/)
   - Sign up and verify your account

2. **Get API Keys**
   - Navigate to Settings → API Keys
   - Generate Test Keys for development
   - Copy `Key ID` and `Key Secret`

3. **Add to Environment**
   - Add keys to both frontend and backend `.env` files
   - Frontend uses `RAZORPAY_KEY_ID` for SDK initialization
   - Backend uses both keys for order creation and verification

### Payment Flow

1. **User selects Razorpay** at checkout
2. **Frontend calls** `/api/orders/razorpay/create`
3. **Backend creates** Razorpay order and returns `orderId`
4. **Frontend opens** Razorpay payment modal
5. **User completes** payment with test/real card
6. **Razorpay returns** payment details (paymentId, signature)
7. **Frontend calls** `/api/orders/razorpay/verify`
8. **Backend verifies** signature and creates order in database
9. **Stock is updated** and cart is cleared

### Test Card Details

For testing in development:
- **Card Number:** 4111 1111 1111 1111
- **CVV:** Any 3 digits (e.g., 123)
- **Expiry:** Any future date (e.g., 12/25)
- **Name:** Any name

---

## 📁 Project Structure

### Key Files & Directories

#### Frontend
```
frontend/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── firebase_options.dart     # Firebase configuration
│   ├── core/
│   │   ├── routes/
│   │   │   ├── auth_routes.dart
│   │   │   ├── user_routes.dart
│   │   │   └── admin_routes.dart
│   │   ├── services/
│   │   │   └── razorpay_service.dart
│   │   ├── utils/
│   │   │   ├── api_client.dart   # Dio HTTP client
│   │   │   └── toaster.dart      # Toast notifications
│   │   └── widgets/
│   │       ├── primary_button.dart
│   │       └── custom_textfield.dart
│   └── modules/
│       ├── common/auth/
│       ├── user/
│       │   ├── home/
│       │   ├── products/
│       │   ├── cart/
│       │   ├── checkout/
│       │   └── orders/
│       └── admin/
├── assets/
│   ├── images/
│   └── icons/
├── .env                          # Environment variables
└── pubspec.yaml                  # Dependencies
```

#### Backend
```
backend/
├── src/
│   ├── server.js                 # Entry point
│   ├── app.js                    # Express configuration
│   ├── index.routes.js           # Route aggregator
│   ├── core/
│   │   ├── config/
│   │   │   ├── env.config.js     # Environment variables
│   │   │   └── db.config.js      # MongoDB connection
│   │   ├── middleware/
│   │   │   ├── jwt.middleware.js
│   │   │   ├── admin.middleware.js
│   │   │   └── error_handler.middleware.js
│   │   └── utils/
│   │       ├── api_response.util.js
│   │       └── api_error.util.js
│   └── modules/
│       ├── auth/
│       │   ├── auth.controller.js
│       │   ├── auth.service.js
│       │   ├── auth.routes.js
│       │   └── auth.validation.js
│       ├── products/
│       ├── orders/
│       │   ├── order.controller.js
│       │   ├── order.service.js
│       │   ├── order.razorpay.js  # Razorpay integration
│       │   └── order.routes.js
│       └── user/
│           └── user.model.js      # User schema with orders
├── .env                           # Environment variables
├── package.json
└── .gitignore
```

---

## 🎨 Screenshots

### User App
- **Home Screen:** Browse products and categories
- **Product Details:** View product information, add to cart
- **Cart:** Manage cart items, update quantities
- **Checkout:** Select payment method, enter address
- **Orders:** View order history and details

### Admin App
- **Dashboard:** Analytics and statistics
- **Product Management:** Add, edit, delete products
- **Order Management:** View and track all orders
- **User Management:** Manage user accounts

---

## 🔐 Security Features

- **JWT Authentication:** Secure token-based authentication
- **Password Hashing:** bcrypt for secure password storage
- **Environment Variables:** Sensitive data in .env files
- **Input Validation:** Zod schema validation on backend
- **CORS Configuration:** Controlled cross-origin access
- **Secure Storage:** Flutter Secure Storage for tokens
- **Payment Verification:** Signature verification for Razorpay

---

## 🐛 Common Issues & Solutions

### Issue: "Network Error" on app launch
**Solution:** Ensure backend server is running and `BACKEND_URL` in `.env` matches your server IP and port.

### Issue: Google Sign-In not working
**Solution:** 
1. Add SHA-1 and SHA-256 certificates to Firebase Console
2. Download updated `google-services.json`
3. Ensure Firebase Auth is enabled

### Issue: Razorpay modal not opening
**Solution:**
1. Check `RAZORPAY_KEY_ID` is correct in `.env`
2. Hot restart the app after adding `.env`
3. Ensure Razorpay package is properly installed

### Issue: Images not uploading
**Solution:**
1. Verify Cloudinary credentials in backend `.env`
2. Check internet connection
3. Ensure proper file permissions

### Issue: Orders not showing
**Solution:**
1. Check MongoDB connection
2. Verify JWT token is valid
3. Check backend logs for errors

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License.

---

## 👨‍💻 Developer

**Neel Pandya**
- GitHub: [@Neel-Pandya](https://github.com/Neel-Pandya)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for authentication services
- Razorpay for payment gateway integration
- MongoDB for database solution
- All open-source contributors

---

## 📞 Support

For issues and questions:
- Open an issue on GitHub
- Check existing documentation
- Review API documentation above

---

**Happy Coding! 🚀**
