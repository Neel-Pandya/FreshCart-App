import asyncHandler from 'express-async-handler';
import AuthService from './auth.service.js';
import ApiResponse from '../../core/utils/api_response.util.js';

const signup = asyncHandler(async (req, res) => {
  const { message } = await AuthService.signup(req.body);

  return res.status(201).json(new ApiResponse(201, message));
});

const login = asyncHandler(async (req, res) => {
  const { user, accessToken } = await AuthService.login(req.body);

  return res.status(200).json(
    new ApiResponse(200, 'User logged in successfully', {
      id: user._id,
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
  const { message } = await AuthService.resendOtp(email);

  return res.status(200).json(new ApiResponse(200, message));
});

const verifyOtp = asyncHandler(async (req, res) => {
  const { email, otp } = req.body;
  await AuthService.verifyOtp(email, otp);

  return res.status(200).json(new ApiResponse(200, 'OTP verified successfully.'));
});

const forgotPassword = asyncHandler(async (req, res) => {
  const { email } = req.body;
  const { message } = await AuthService.forgotPassword(email);

  return res.status(200).json(new ApiResponse(200, message));
});

const resetPassword = asyncHandler(async (req, res) => {
  const { email, password } = req.body;
  await AuthService.resetPassword(email, password);

  return res.status(200).json(new ApiResponse(200, 'Password reset successfully.'));
});

const changePassword = asyncHandler(async (req, res) => {
  const { user } = req;
  const { oldPassword, newPassword } = req.body;

  await AuthService.changePassword(user.email, oldPassword, newPassword);

  return res.status(200).json(new ApiResponse(200, 'Password changed successfully.'));
});

export { signup, login, resendOtp, verifyOtp, forgotPassword, resetPassword, changePassword };
