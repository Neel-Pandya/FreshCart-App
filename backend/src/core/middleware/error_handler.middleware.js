import ApiResponse from '../utils/api_response.util.js';
const errorHandler = (error, _req, res, _next) => {
  return res
    .status(error.status || 500)
    .json(
      new ApiResponse(
        error.status || 500,
        error.message || 'Something went wrong',
        error.errors || null
      )
    );
};

export default errorHandler;
