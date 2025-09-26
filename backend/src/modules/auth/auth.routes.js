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
} from './auth.validation.js';
import verifyJWT from '../../core/middleware/jwt.middleware.js';

const router = Router();

router.post('/signup', validate(signupValidation), signup);
router.post('/google-signup', validate(googleSignupValidation), googleSignup);
router.post('/login', validate(loginValidation), login);
router.post('/verify-otp', validate(verifyOtpValidation), verifyOtp);
router.post('/resend-otp', validate(resendOtpValidation), resendOtp);
router.post('/forgot-password', validate(forgotPasswordValidation), forgotPassword);
router.post('/reset-password', validate(resetPasswordValidation), resetPassword);
router.post('/change-password', verifyJWT, validate(changePasswordValidation), changePassword);

export default router;
