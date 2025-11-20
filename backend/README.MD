# 🚀 FreshCart Backend API

A robust RESTful API built with Node.js, Express, and MongoDB for the FreshCart e-commerce application. Features JWT authentication, Razorpay payment integration, image upload with Cloudinary, and comprehensive user & admin management.

---

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Running the Server](#-running-the-server)
- [API Documentation](#-api-documentation)
- [Project Structure](#-project-structure)
- [Database Schema](#-database-schema)
- [Middleware](#-middleware)
- [Error Handling](#-error-handling)
- [Security](#-security)
- [Testing](#-testing)
- [Deployment](#-deployment)

---

## ✨ Features

### 🔐 Authentication & Authorization
- **JWT-based Authentication** with secure token management
- **Email/Password Registration** with OTP verification
- **Google Sign-In** integration via Firebase Admin SDK
- **Password Reset** with email OTP
- **Role-based Access Control** (User/Admin)
- **Cookie-based Session Management**

### 📦 Product Management
- **CRUD Operations** for products
- **Category Management**
- **Image Upload** to Cloudinary
- **Stock Tracking**
- **Search & Filter** capabilities
- **Pagination Support**

### 🛒 Cart & Orders
- **Persistent Cart** per user
- **Real-time Stock Validation**
- **Multiple Payment Methods:**
  - Cash on Delivery (COD)
  - Razorpay Online Payments
- **Order History** tracking
- **Payment Verification** with signature validation

### 💳 Payment Integration
- **Razorpay Gateway** integration
- **Order Creation** with Razorpay
- **Payment Verification** using HMAC SHA256
- **Transaction Security** with signature validation
- **Test Mode Support**

### 👨‍💼 Admin Features
- **User Management** (view, update, delete)
- **Product Management** with image uploads
- **Order Overview** across all users
- **Category Management**
- **Analytics-ready** data structure

### 📧 Email Services
- **OTP Email** for registration
- **Password Reset** emails
- **Nodemailer Integration**
- **Custom Email Templates**

---

## 🚀 Tech Stack

### Core Technologies
- **Node.js** - JavaScript runtime
- **Express.js** - Web framework
- **MongoDB** - NoSQL database
- **Mongoose** - ODM for MongoDB

### Authentication & Security
- **JSON Web Tokens (JWT)** - Token-based authentication
- **bcrypt.js** - Password hashing
- **Firebase Admin SDK** - Google Sign-In verification
- **Cookie Parser** - Cookie management

### Payment & Cloud Services
- **Razorpay** - Payment gateway integration
- **Cloudinary** - Image storage and CDN
- **Nodemailer** - Email service

### Development Tools
- **Nodemon** - Auto-reload during development
- **Morgan** - HTTP request logger
- **Winston** - Advanced logging
- **Prettier** - Code formatting
- **Zod** - Schema validation

### Utilities
- **Multer** - File upload handling
- **UUID** - Unique identifier generation
- **CORS** - Cross-origin resource sharing
- **dotenv** - Environment variable management

---

## 📋 Prerequisites

Before you begin, ensure you have:

- **Node.js** (v16.0.0 or higher)
  ```bash
  node --version
  ```
- **npm** (comes with Node.js)
  ```bash
  npm --version
  ```
- **MongoDB** (local installation or MongoDB Atlas account)
  ```bash
  mongod --version
  ```
- **Git**

### Required Accounts
- **MongoDB Atlas** (or local MongoDB)
- **Razorpay Account** (for payment gateway)
- **Cloudinary Account** (for image uploads)
- **Firebase Project** (for Google Sign-In)
- **Gmail Account** (for sending emails)

---

## 🔧 Installation

### 1️⃣ Navigate to Backend Directory

```bash
cd FreshCart-App/backend
```

### 2️⃣ Install Dependencies

```bash
npm install
```

This will install all required packages listed in `package.json`.

### 3️⃣ Verify Installation

```bash
npm list --depth=0
```

---

## ⚙️ Configuration

### Environment Variables

Create a `.env` file in the backend root directory:

```env
# =========================
# App Configuration
# =========================
APP_HOST=192.168.1.100        # Your local IP address
APP_PORT=8000                  # Server port
NODE_ENV=development           # Environment (development/production)

# =========================
# Database Configuration
# =========================
MONGO_URI=mongodb://localhost:27017/freshcart
# Or for MongoDB Atlas:
# MONGO_URI=mongodb+srv://username:password@cluster.mongodb.net/freshcart

# =========================
# JWT Configuration
# =========================
JWT_SECRET=your_super_secret_jwt_key_here_min_32_characters
COOKIE_SECRET=your_cookie_secret_key_here

# =========================
# Email Configuration (Gmail)
# =========================
EMAIL_USERNAME=your_email@gmail.com
EMAIL_PASSWORD=your_16_digit_app_password

# =========================
# Cloudinary Configuration
# =========================
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

# =========================
# Firebase Admin Configuration
# =========================
FIREBASE_ACCOUNT_TYPE=service_account
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY_ID=your_private_key_id
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYOUR_PRIVATE_KEY_HERE\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxxx@your-project.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=your_client_id
FIREBASE_AUTH_URI=https://accounts.google.com/o/oauth2/auth
FIREBASE_TOKEN_URI=https://oauth2.googleapis.com/token
FIREBASE_AUTH_PROVIDER_X509_CERT_URL=https://www.googleapis.com/oauth2/v1/certs
FIREBASE_CLIENT_X509_CERT_URL=https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-xxxxx%40your-project.iam.gserviceaccount.com
FIREBASE_UNIVERSE_DOMAIN=googleapis.com

# =========================
# Razorpay Configuration
# =========================
RAZORPAY_KEY_ID=rzp_test_YOUR_KEY_ID
RAZORPAY_KEY_SECRET=YOUR_KEY_SECRET
```

### Configuration Steps

#### 1. MongoDB Setup

**Option A: Local MongoDB**
```bash
# Install MongoDB locally
# Start MongoDB service
mongod --dbpath /path/to/data
```

**Option B: MongoDB Atlas (Recommended)**
1. Create account at [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a new cluster
3. Get connection string
4. Add to `.env` as `MONGO_URI`

#### 2. Gmail App Password

1. Enable 2-factor authentication on your Gmail account
2. Go to **Google Account → Security → 2-Step Verification**
3. Scroll to **App passwords**
4. Generate password for "Mail"
5. Copy 16-digit password to `.env` as `EMAIL_PASSWORD`

#### 3. Cloudinary Setup

1. Sign up at [Cloudinary](https://cloudinary.com/)
2. Go to **Dashboard**
3. Copy **Cloud Name**, **API Key**, and **API Secret**
4. Add to `.env` file

#### 4. Firebase Admin SDK

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. **Project Settings → Service Accounts**
4. Click **Generate New Private Key**
5. Download JSON file
6. Copy values to `.env`:
   - `project_id` → `FIREBASE_PROJECT_ID`
   - `private_key_id` → `FIREBASE_PRIVATE_KEY_ID`
   - `private_key` → `FIREBASE_PRIVATE_KEY`
   - `client_email` → `FIREBASE_CLIENT_EMAIL`
   - etc.

#### 5. Razorpay Setup

1. Sign up at [Razorpay](https://dashboard.razorpay.com/)
2. Go to **Settings → API Keys**
3. Generate **Test Keys**
4. Copy **Key ID** and **Key Secret** to `.env`

#### 6. Generate Secrets

For `JWT_SECRET` and `COOKIE_SECRET`:
```bash
# Generate random secret
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

---

## 🚀 Running the Server

### Development Mode (with auto-reload)

```bash
npm run dev
```

Server will start at: `http://YOUR_IP:8000`

### Production Mode

```bash
npm start
```

### Format Code

```bash
# Format all files
npm run format

# Check formatting
npm run format:check
```

### Seed Database

```bash
npm run seed
```

This will populate the database with sample products (if seed script exists).

---

## 📡 API Documentation

### Base URL

```
http://YOUR_IP:8000/api
```

### Authentication Endpoints

#### 1. User Signup
**POST** `/auth/signup`

Register a new user and send OTP.

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "Password123"
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

#### 2. Verify OTP
**POST** `/auth/verify-otp`

Verify OTP to complete registration.

**Request Body:**
```json
{
  "email": "john@example.com",
  "otp": "123456"
}
```

**Response:**
```json
{
  "status": 200,
  "message": "Account verified successfully",
  "success": true
}
```

#### 3. Login
**POST** `/auth/login`

Login with email and password.

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "Password123"
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
    "profile": "image_url",
    "accessToken": "jwt_token_here"
  },
  "success": true
}
```

#### 4. Google Login
**POST** `/auth/google-login`

Login using Google ID token.

**Request Body:**
```json
{
  "idToken": "firebase_id_token"
}
```

#### 5. Google Signup
**POST** `/auth/google-signup`

Signup using Google ID token.

**Request Body:**
```json
{
  "idToken": "firebase_id_token"
}
```

#### 6. Forgot Password
**POST** `/auth/forgot-password`

Request password reset OTP.

**Request Body:**
```json
{
  "email": "john@example.com"
}
```

#### 7. Reset Password
**POST** `/auth/reset-password`

Reset password using OTP.

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "NewPassword123"
}
```

**Note:** User must verify OTP before calling this endpoint.

#### 8. Change Password
**POST** `/auth/change-password`

Change password (requires authentication).

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Request Body:**
```json
{
  "oldPassword": "OldPassword123",
  "newPassword": "NewPassword123"
}
```

#### 9. Update Profile
**PUT** `/auth/update-profile`

Update user profile with optional image upload.

**Headers:**
```
Authorization: Bearer <jwt_token>
Content-Type: multipart/form-data
```

**Form Data:**
- `name` (optional)
- `email` (optional)
- `image` (file, optional)

---

### Product Endpoints

#### 1. Get All Products
**GET** `/products/all`

Retrieve all products with optional filters.

**Query Parameters:**
- `category` - Filter by category ID
- `search` - Search by product name

**Example:**
```
GET /products/all?category=64f5a1b2c3d4e5f6a7b8c9d0&search=apple
```

**Response:**
```json
{
  "status": 200,
  "message": "Products retrieved successfully",
  "data": [
    {
      "_id": "product_id",
      "name": "Fresh Apple",
      "description": "Organic red apples",
      "price": 150,
      "stock": 100,
      "imageUrl": "cloudinary_url",
      "categoryId": {
        "_id": "category_id",
        "name": "Fruits"
      }
    }
  ],
  "success": true
}
```

#### 2. Get Product by ID
**GET** `/products/:id`

Get single product details.

**Response:**
```json
{
  "status": 200,
  "message": "Product retrieved successfully",
  "data": {
    "_id": "product_id",
    "name": "Fresh Apple",
    "description": "Organic red apples",
    "price": 150,
    "stock": 100,
    "imageUrl": "cloudinary_url",
    "categoryId": {
      "_id": "category_id",
      "name": "Fruits"
    }
  },
  "success": true
}
```

#### 3. Add Product (Admin Only)
**POST** `/products/add`

Add a new product with image upload.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
Content-Type: multipart/form-data
```

**Form Data:**
- `name` (required)
- `description` (required)
- `price` (required, number)
- `stock` (required, number)
- `categoryId` (required)
- `image` (file, required)

**Response:**
```json
{
  "status": 201,
  "message": "Product added successfully",
  "data": {
    "_id": "new_product_id",
    "name": "Fresh Apple",
    ...
  },
  "success": true
}
```

#### 4. Update Product (Admin Only)
**PUT** `/products/update/:id`

Update product details.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
Content-Type: multipart/form-data
```

**Form Data:**
- `name` (optional)
- `description` (optional)
- `price` (optional)
- `stock` (optional)
- `categoryId` (optional)
- `image` (file, optional)

#### 5. Delete Product (Admin Only)
**DELETE** `/products/delete/:id`

Delete a product.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
```

---

### Cart Endpoints

All cart endpoints require authentication.

#### 1. Get Cart
**GET** `/cart/get`

Get user's cart items.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response:**
```json
{
  "status": 200,
  "message": "Cart retrieved successfully",
  "data": [
    {
      "productId": {
        "_id": "product_id",
        "name": "Fresh Apple",
        "price": 150,
        "imageUrl": "url"
      },
      "quantity": 2
    }
  ],
  "success": true
}
```

#### 2. Add to Cart
**POST** `/cart/add`

Add item to cart or update quantity if exists.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Request Body:**
```json
{
  "productId": "product_id",
  "quantity": 2
}
```

#### 3. Update Cart Item
**PUT** `/cart/update`

Update cart item quantity.

**Request Body:**
```json
{
  "productId": "product_id",
  "quantity": 5
}
```

#### 4. Remove from Cart
**DELETE** `/cart/remove/:productId`

Remove item from cart.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

#### 5. Clear Cart
**DELETE** `/cart/clear`

Clear entire cart.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

---

### Order Endpoints

#### 1. Create Order (COD)
**POST** `/orders/create`

Create order with Cash on Delivery.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Request Body:**
```json
{
  "paymentMethod": "Cash on Delivery",
  "deliveryAddress": "123 Main St, City, State, 12345"
}
```

**Response:**
```json
{
  "status": 201,
  "message": "Order created successfully",
  "data": {
    "items": [...],
    "totalAmount": 500,
    "paymentMethod": "Cash on Delivery",
    "deliveryAddress": "123 Main St...",
    "createdAt": "2025-11-20T10:30:00.000Z"
  },
  "success": true
}
```

#### 2. Create Razorpay Order
**POST** `/orders/razorpay/create`

Create Razorpay order for online payment.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Request Body:**
```json
{
  "deliveryAddress": "123 Main St, City, State, 12345"
}
```

**Response:**
```json
{
  "status": 201,
  "message": "Razorpay order created successfully",
  "data": {
    "orderId": "order_NXj4k5L6M7N8O9",
    "amount": 50000,
    "currency": "INR",
    "keyId": "rzp_test_..."
  },
  "success": true
}
```

#### 3. Verify Razorpay Payment
**POST** `/orders/razorpay/verify`

Verify payment and create order in database.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Request Body:**
```json
{
  "razorpayOrderId": "order_NXj4k5L6M7N8O9",
  "razorpayPaymentId": "pay_OPq5r6S7T8U9V0",
  "razorpaySignature": "signature_hash",
  "deliveryAddress": "123 Main St, City, State, 12345"
}
```

**Response:**
```json
{
  "status": 201,
  "message": "Payment verified and order created successfully",
  "data": {
    "items": [...],
    "totalAmount": 500,
    "paymentMethod": "RazorPay",
    "deliveryAddress": "...",
    "paymentDetails": {
      "razorpayOrderId": "order_...",
      "razorpayPaymentId": "pay_...",
      "paymentStatus": "completed"
    }
  },
  "success": true
}
```

#### 4. Get User Orders
**GET** `/orders/all`

Get all orders for authenticated user.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

#### 5. Get Order by ID
**GET** `/orders/:orderId`

Get specific order details.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

#### 6. Get All Orders (Admin Only)
**GET** `/orders/admin/all`

Get all orders from all users.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
```

---

### Category Endpoints

#### 1. Get All Categories
**GET** `/category/all`

Retrieve all categories.

**Response:**
```json
{
  "status": 200,
  "message": "Categories retrieved successfully",
  "data": [
    {
      "_id": "category_id",
      "name": "Fruits",
      "imageUrl": "cloudinary_url"
    }
  ],
  "success": true
}
```

#### 2. Add Category (Admin Only)
**POST** `/category/add`

Add new category with image.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
Content-Type: multipart/form-data
```

**Form Data:**
- `name` (required)
- `image` (file, required)

#### 3. Update Category (Admin Only)
**PUT** `/category/update/:id`

Update category details.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
Content-Type: multipart/form-data
```

**Form Data:**
- `name` (optional)
- `image` (file, optional)

#### 4. Delete Category (Admin Only)
**DELETE** `/category/delete/:id`

Delete a category.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
```

---

### User Management Endpoints (Admin Only)

#### 1. Get All Users
**GET** `/user/all`

Get all registered users.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
```

#### 2. Update User
**PUT** `/user/update/:id`

Update user details.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
```

**Request Body:**
```json
{
  "name": "Updated Name",
  "role": 1
}
```

#### 3. Delete User
**DELETE** `/user/delete/:id`

Delete a user.

**Headers:**
```
Authorization: Bearer <admin_jwt_token>
```

---

## 📁 Project Structure

```
backend/
├── src/
│   ├── server.js                      # Entry point
│   ├── app.js                         # Express app configuration
│   ├── index.routes.js                # Route aggregation
│   │
│   ├── core/                          # Core functionality
│   │   ├── config/
│   │   │   ├── env.config.js          # Environment variables
│   │   │   ├── db.config.js           # MongoDB connection
│   │   │   ├── cloudinary.config.js   # Cloudinary setup
│   │   │   └── firebase.config.js     # Firebase Admin SDK
│   │   │
│   │   ├── middleware/
│   │   │   ├── jwt.middleware.js      # JWT authentication
│   │   │   ├── admin.middleware.js    # Admin authorization
│   │   │   ├── zod.middleware.js      # Input validation
│   │   │   ├── multer.middleware.js   # File upload
│   │   │   └── error_handler.middleware.js
│   │   │
│   │   ├── models/
│   │   │   └── (shared models)
│   │   │
│   │   └── utils/
│   │       ├── api_response.util.js   # Standardized responses
│   │       ├── api_error.util.js      # Custom error class
│   │       ├── email.util.js          # Email sending
│   │       └── otp.util.js            # OTP generation
│   │
│   └── modules/                       # Feature modules
│       ├── auth/
│       │   ├── auth.controller.js     # Auth handlers
│       │   ├── auth.service.js        # Business logic
│       │   ├── auth.routes.js         # Route definitions
│       │   └── auth.validation.js     # Zod schemas
│       │
│       ├── products/
│       │   ├── product.controller.js
│       │   ├── product.service.js
│       │   ├── product.model.js       # Mongoose schema
│       │   ├── product.routes.js
│       │   └── product.validation.js
│       │
│       ├── cart/
│       │   ├── cart.controller.js
│       │   ├── cart.service.js
│       │   ├── cart.routes.js
│       │   └── cart.validation.js
│       │
│       ├── orders/
│       │   ├── order.controller.js
│       │   ├── order.service.js
│       │   ├── order.razorpay.js      # Razorpay integration
│       │   ├── order.routes.js
│       │   └── order.validation.js
│       │
│       ├── category/
│       │   ├── category.controller.js
│       │   ├── category.service.js
│       │   ├── category.model.js
│       │   ├── category.routes.js
│       │   └── category.validation.js
│       │
│       └── user/
│           ├── user.controller.js
│           ├── user.service.js
│           ├── user.model.js          # User schema with cart & orders
│           ├── user.routes.js
│           └── user.validation.js
│
├── uploads/                           # Temporary file uploads
├── .env                               # Environment variables
├── .env.sample                        # Environment template
├── .gitignore
├── .prettierrc.json                   # Prettier config
├── .prettierignore
├── package.json
├── package-lock.json
└── README.md
```

---

## 🗄️ Database Schema

### User Model

```javascript
{
  name: String,
  email: String (unique),
  password: String (hashed),
  profile: String (image URL),
  status: String (active/inactive),
  role: Number (0 = user, 1 = admin),
  isGoogle: Boolean,
  favourites: [ObjectId] (Product references),
  cart: [{
    productId: ObjectId (Product reference),
    quantity: Number
  }],
  orders: [{
    items: [{
      productId: ObjectId,
      productName: String,
      price: Number,
      quantity: Number,
      total: Number,
      imageUrl: String
    }],
    totalAmount: Number,
    paymentMethod: String (Cash on Delivery/RazorPay),
    deliveryAddress: String,
    paymentDetails: {
      razorpayOrderId: String,
      razorpayPaymentId: String,
      razorpaySignature: String,
      paymentStatus: String
    },
    createdAt: Date
  }],
  timestamps: true
}
```

### Product Model

```javascript
{
  name: String,
  description: String,
  price: Number,
  stock: Number,
  imageUrl: String (Cloudinary URL),
  categoryId: ObjectId (Category reference),
  timestamps: true
}
```

### Category Model

```javascript
{
  name: String,
  imageUrl: String (Cloudinary URL),
  timestamps: true
}
```

---

## 🛡️ Middleware

### 1. JWT Authentication (`jwt.middleware.js`)

Verifies JWT token and attaches user to request.

```javascript
// Usage
router.get('/protected', verifyJWT, handler);
```

### 2. Admin Authorization (`admin.middleware.js`)

Ensures user has admin role.

```javascript
// Usage
router.post('/admin-only', verifyJWT, adminMiddleware, handler);
```

### 3. Input Validation (`zod.middleware.js`)

Validates request body using Zod schemas.

```javascript
// Usage
router.post('/signup', validate(signupSchema), handler);
```

### 4. File Upload (`multer.middleware.js`)

Handles multipart form data for file uploads.

```javascript
// Usage
router.post('/upload', uploadSingle, handler);
```

### 5. Error Handler (`error_handler.middleware.js`)

Global error handling middleware.

---

## ⚠️ Error Handling

### Custom Error Class

```javascript
class ApiError extends Error {
  constructor(statusCode, message) {
    super(message);
    this.statusCode = statusCode;
  }
}
```

### Usage

```javascript
throw new ApiError(404, 'User not found');
throw new ApiError(400, 'Invalid credentials');
throw new ApiError(401, 'Unauthorized access');
```

### Error Response Format

```json
{
  "status": 400,
  "message": "Error message here",
  "success": false
}
```

---

## 🔒 Security

### Implemented Security Measures

1. **Password Hashing**
   - bcrypt with salt rounds of 10
   - Passwords never stored in plain text

2. **JWT Tokens**
   - Signed with secret key
   - Includes user ID, role, email
   - Stored securely in HTTP-only cookies

3. **Input Validation**
   - Zod schema validation
   - Prevents injection attacks
   - Type checking

4. **CORS**
   - Configured for specific origins
   - Credentials support

5. **Environment Variables**
   - Sensitive data in `.env`
   - Not committed to version control

6. **Rate Limiting** (Recommended)
   - Implement using `express-rate-limit`

7. **Helmet** (Recommended)
   - Add helmet for security headers

### Best Practices

- Never expose sensitive data in responses
- Validate all user inputs
- Use HTTPS in production
- Regular security audits
- Keep dependencies updated

---

## 🧪 Testing

### Manual Testing with Postman

1. Import API collection
2. Set environment variables
3. Test endpoints sequentially

### Recommended Test Flow

```
1. POST /auth/signup
2. POST /auth/verify-otp
3. POST /auth/login (get JWT token)
4. GET /products/all
5. POST /cart/add
6. GET /cart/get
7. POST /orders/create
```

### Unit Testing (To be implemented)

```bash
npm install --save-dev jest supertest
```

---

## 🚢 Deployment

### Environment Setup

1. Set `NODE_ENV=production` in `.env`
2. Use production MongoDB URI
3. Use production Razorpay keys
4. Configure CORS for production domain

### Deployment Platforms

#### Heroku

```bash
heroku create freshcart-api
heroku config:set NODE_ENV=production
heroku config:set MONGO_URI=your_production_uri
git push heroku main
```

#### Render

1. Connect GitHub repository
2. Set environment variables in dashboard
3. Deploy

#### Railway

1. Connect GitHub repository
2. Add environment variables
3. Deploy automatically

#### AWS EC2

```bash
# SSH into EC2 instance
ssh -i key.pem ubuntu@ec2-ip

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PM2
sudo npm install -g pm2

# Clone repository
git clone your-repo
cd backend

# Install dependencies
npm install

# Start with PM2
pm2 start src/server.js --name freshcart-api
pm2 save
pm2 startup
```

### Production Checklist

- [ ] Environment variables configured
- [ ] MongoDB connection secured
- [ ] CORS properly configured
- [ ] Cloudinary limits set
- [ ] Razorpay in production mode
- [ ] Error logging enabled
- [ ] HTTPS enabled
- [ ] Rate limiting implemented
- [ ] Helmet configured
- [ ] Regular backups scheduled

---

## 📊 Monitoring & Logging

### Winston Logger

Configured for different log levels:

```javascript
logger.info('Server started');
logger.error('Error occurred', error);
logger.warn('Warning message');
```

### Morgan HTTP Logger

Logs all HTTP requests in development mode.

---

## 🐛 Common Issues & Solutions

### Issue: "MongooseServerSelectionError"

**Problem:** Cannot connect to MongoDB

**Solutions:**
- Check MongoDB service is running
- Verify `MONGO_URI` in `.env`
- Check network/firewall settings
- Whitelist IP in MongoDB Atlas

### Issue: "JWT malformed"

**Problem:** Invalid token format

**Solutions:**
- Ensure token is properly formatted
- Check token is sent in Authorization header
- Verify token hasn't expired

### Issue: "Cloudinary upload failed"

**Problem:** Image upload not working

**Solutions:**
- Verify Cloudinary credentials
- Check image file size (max 10MB)
- Ensure proper file format (jpg, png)

### Issue: "Razorpay signature verification failed"

**Problem:** Payment verification failing

**Solutions:**
- Check `RAZORPAY_KEY_SECRET` is correct
- Verify signature calculation logic
- Ensure order ID matches

### Issue: "Port already in use"

**Problem:** Server won't start

**Solutions:**
```bash
# Find process using port 8000
netstat -ano | findstr :8000  # Windows
lsof -i :8000                 # Mac/Linux

# Kill process
taskkill /PID <PID> /F        # Windows
kill -9 <PID>                 # Mac/Linux
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run `npm run format`
5. Commit with clear messages
6. Open a pull request

---

## 📄 License

This project is licensed under the MIT License.

---

## 👨‍💻 Developer

**Neel Pandya**
- GitHub: [@Neel-Pandya](https://github.com/Neel-Pandya)

---

## 📞 Support

For issues and questions:
- Review this documentation
- Check [Frontend README](../frontend/README.md)
- Open an issue on GitHub

---

**Built with ❤️ using Node.js & Express**