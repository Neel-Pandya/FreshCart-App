import asyncHandler from 'express-async-handler';
import AuthService from './auth.service.js';
import ApiResponse from '../../core/utils/api_response.util.js';

const signup = asyncHandler(async (req, res) => {
  await AuthService.signup(req.body);

  return res.status(201).json(new ApiResponse(201, 'Account registered please verify the otp sent to your email to activate your account'));
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
        status: user.status, 
        profile: user.profile,
        role: user.role,
          
        accessToken,
      })
    );
});

const resendOtp = asyncHandler(async (req, res) => {
  const { email } = req.body;
  await AuthService.resendOtp(email);

  return res.status(200).json(new ApiResponse(200, 'OTP sent to your email. Please verify.'));
});

const verifyOtp = asyncHandler(async (req, res) => {
  const { email, otp } = req.body;
  await AuthService.verifyOtp(email, otp);

  return res.status(200).json(new ApiResponse(200, 'OTP verified successfully.'));
});

export { signup, login, resendOtp, verifyOtp };
