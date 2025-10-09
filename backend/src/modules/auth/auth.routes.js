import { Router } from 'express';
import {
  signup,
  login,
  resendOtp,
  verifyOtp,
  forgotPassword,
  resetPassword,
  changePassword,
  googleSignup,
  googleLogin,
  updateProfile,
} from './auth.controller.js';
import validate from '../../core/middleware/zod.middleware.js';
import {
  signupValidation,
  loginValidation,
  resendOtpValidation,
  verifyOtpValidation,
  forgotPasswordValidation,
  resetPasswordValidation,
  changePasswordValidation,
  googleSignupValidation,
  googleLoginValidation,
  updateProfileValidation,
} from './auth.validation.js';
import verifyJWT from '../../core/middleware/jwt.middleware.js';
import upload from '../../core/middleware/multer.middleware.js';

const router = Router();

router.post('/signup', validate(signupValidation), signup);
router.post('/google-signup', validate(googleSignupValidation), googleSignup);
router.post('/login', validate(loginValidation), login);
router.post('/google-login', validate(googleLoginValidation), googleLogin);
router.post('/verify-otp', validate(verifyOtpValidation), verifyOtp);
router.post('/resend-otp', validate(resendOtpValidation), resendOtp);
router.post('/forgot-password', validate(forgotPasswordValidation), forgotPassword);
router.post('/reset-password', validate(resetPasswordValidation), resetPassword);
router.post('/change-password', verifyJWT, validate(changePasswordValidation), changePassword);
router.put(
  '/update-profile',
  verifyJWT,
  upload.single('profile'),
  validate(updateProfileValidation),
  updateProfile
);

export default router;
