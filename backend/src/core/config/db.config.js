import { connect } from 'mongoose';
import EnvConfig from './env.config.js';

const connectDB = async () => {
  return await connect(EnvConfig.mongoUri, {
    dbName: 'Freshcart',
  });
};

export default connectDB;
