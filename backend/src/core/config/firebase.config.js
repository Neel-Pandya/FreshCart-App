import EnvConfig from './env.config.js';
import admin from 'firebase-admin';

const serviceAccount = {
  type: EnvConfig.firebaseAccountType,
  project_id: EnvConfig.firebaseProjectId,
  private_key_id: EnvConfig.firebasePrivateKeyId,
  private_key: EnvConfig.firebasePrivateKey,
  client_email: EnvConfig.firebaseClientEmail,
  client_id: EnvConfig.firebaseClientId,
  auth_uri: EnvConfig.firebaseAuthUri,
  token_uri: EnvConfig.firebaseTokenUri,
  auth_provider_x509_cert_url: EnvConfig.firebaseAuthProviderCertUrl,
  client_x509_cert_url: EnvConfig.firebaseClientCertUrl,
};

if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });
}

export default admin;
