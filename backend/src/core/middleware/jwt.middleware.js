import jwt from 'jsonwebtoken';
import EnvConfig from '../config/env.config.js';
import ApiError from '../utils/api_error.util.js';

const verifyJWT = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];

  if (!token) throw new ApiError(401, 'Unauthorized');

  jwt.verify(token, EnvConfig.jwtSecret, (err, user) => {
    if (err) throw new ApiError(401, 'Unauthorized');
    req.user = user;
    next();
  });
};

export default verifyJWT;
