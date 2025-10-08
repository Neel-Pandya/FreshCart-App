import asyncHandler from 'express-async-handler';
import AuthService from './auth.service.js';
import ApiResponse from "../../core/utils/api_response.util.js";
import validateFile from '../../core/middleware/file_validator.middleware.js';
import cookieOptions from '../../core/config/cookie.config.js';

const signup = asyncHandler(async (req, res) => {
  const { message } = await AuthService.signup(req.body);

  return res.status(201).json(new ApiResponse(201, message));
});

const googleSignup = asyncHandler(async (req, res) => {
  const { message, user } = await AuthService.googleSignup(req.body.idToken);

  return res.status(201).json(new ApiResponse(201, message));
});

const login = asyncHandler(async (req, res) => {
  const { user, accessToken } = await AuthService.login(req.body);

  return res.status(200).cookie('accessToken', accessToken, cookieOptions).json(
    new ApiResponse(200, 'User logged in successfully', {
      id: user._id,
      name: user.name,
      email: user.email,
      status: user.status,
      profile: user.profile,
      role: user.role,
      isGoogle: user.isGoogle,
      accessToken,
    })
  );
});

const googleLogin = asyncHandler(async (req, res) => {
  const { accessToken, user } = await AuthService.googleLogin(req.body.idToken);
  return res.status(200).cookie('accessToken', accessToken, cookieOptions).json(
    new ApiResponse(200, 'User logged in successfully', {
      id: user._id,
      name: user.name,
      email: user.email,
      status: user.status,
      profile: user.profile,
      role: user.role,
      isGoogle: user.isGoogle,
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

const updateProfile = asyncHandler(async (req, res) => {
  validateFile(req, false);
  const { user } = req;
  const { name } = req.body;

  const { updatedUser } = await AuthService.updateProfile(
    user.id,
    name,
    user.profile,
    req.file?.path ?? ''
  );

  return res.status(200).json(
    new ApiResponse(200, 'Profile updated successfully', {
      id: updatedUser._id,
      name: updatedUser.name,
      email: updatedUser.email,
      status: updatedUser.status,
      profile: updatedUser.profile,
      role: updatedUser.role,
      isGoogle: updatedUser.isGoogle,
      accessToken: req.cookies.accessToken,
    })
  );
});

export {
  signup,
  googleSignup,
  login,
  googleLogin,
  resendOtp,
  verifyOtp,
  forgotPassword,
  resetPassword,
  changePassword,
  updateProfile,
};
