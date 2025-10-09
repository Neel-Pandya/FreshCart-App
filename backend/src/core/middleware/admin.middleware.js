import ApiError from '../utils/api_error.util.js';

const adminMiddleware = (req, res, next) => {
  if (req.user.role !== 1) throw new ApiError(401, 'Unauthorized');

  next();
};

export default adminMiddleware;
