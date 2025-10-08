process.loadEnvFile('./.env');

class EnvConfig {
  // App
  static appHost = process.env.APP_HOST;
  static appPort = process.env.APP_PORT;
  static nodeEnv = process.env.NODE_ENV;

  // Database
  static mongoUri = process.env.MONGO_URI;

  // JWT
  static jwtSecret = process.env.JWT_SECRET;
  static cookieSecret = process.env.COOKIE_SECRET;

  // Email
  static emailUsername = process.env.EMAIL_USERNAME;
  static emailPassword = process.env.EMAIL_PASSWORD;

  // Cloudinary
  static cloudinaryCloudName = process.env.CLOUDINARY_CLOUD_NAME;
  static cloudinaryApiKey = process.env.CLOUDINARY_API_KEY;
  static cloudinaryApiSecret = process.env.CLOUDINARY_API_SECRET;

  // Firebase Admin
  static firebaseAccountType = process.env.FIREBASE_ACCOUNT_TYPE;
  static firebaseProjectId = process.env.FIREBASE_PROJECT_ID;
  static firebasePrivateKeyId = process.env.FIREBASE_PRIVATE_KEY_ID;
  static firebasePrivateKey = process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n');
  static firebaseClientEmail = process.env.FIREBASE_CLIENT_EMAIL;
  static firebaseClientId = process.env.FIREBASE_CLIENT_ID;
  static firebaseAuthUri = process.env.FIREBASE_AUTH_URI;
  static firebaseTokenUri = process.env.FIREBASE_TOKEN_URI;
  static firebaseAuthProviderCertUrl = process.env.FIREBASE_AUTH_PROVIDER_X509_CERT_URL;
  static firebaseClientCertUrl = process.env.FIREBASE_CLIENT_X509_CERT_URL;
  static firebaseUniverseDomain = process.env.FIREBASE_UNIVERSE_DOMAIN;
}

export default EnvConfig;
