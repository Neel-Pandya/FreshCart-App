import asyncHandler from 'express-async-handler';
import AuthService from './auth.service.js';
import ApiResponse from '../../core/utils/api_response.util.js';

const signup = asyncHandler(async (req, res) => {
  await AuthService.signup(req.body);

  return res.status(201).json(new ApiResponse(201, 'User created successfully'));
});

const login = asyncHandler(async (req, res) => {
  const { user, accessToken } = await AuthService.login(req.body);

  return res
    .status(200)
    .json(
      new ApiResponse(200, 'User logged in successfully', {
        _id: user._id,
        name: user.name,
        email: user.email,
        role: user.role,
          
        accessToken,
      })
    );
});

export { signup, login };
