import { Router } from 'express';
import { signup, login, resendOtp, verifyOtp, forgotPassword, resetPassword } from './auth.controller.js';
import validate from '../../core/middleware/zod.middleware.js';
import {
  signupValidation,
  loginValidation,
  resendOtpValidation,
  verifyOtpValidation,
  forgotPasswordValidation,
  resetPasswordValidation,
} from './auth.validation.js';

const router = Router();

router.post('/signup', validate(signupValidation), signup);
router.post('/login', validate(loginValidation), login);
router.post('/verify-otp', validate(verifyOtpValidation), verifyOtp);
router.post('/resend-otp', validate(resendOtpValidation), resendOtp);
router.post('/forgot-password', validate(forgotPasswordValidation), forgotPassword);
router.post('/reset-password', validate(resetPasswordValidation), resetPassword);

export default router;
