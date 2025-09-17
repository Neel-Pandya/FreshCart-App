process.loadEnvFile('./.env');

class EnvConfig {
  static appHost = process.env.APP_HOST;
  static appPort = process.env.APP_PORT;
  static mongoUri = process.env.MONGO_URI;
  static jwtSecret = process.env.JWT_SECRET;
}

export default EnvConfig;
