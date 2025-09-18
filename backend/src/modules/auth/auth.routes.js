import { Router } from 'express';
import { signup, login, resendOtp, verifyOtp } from './auth.controller.js';
import validate from '../../core/middleware/zod.middleware.js';
import { signupValidation, loginValidation, resendOtpValidation, verifyOtpValidation } from './auth.validation.js';

const router = Router();

router.post('/signup', validate(signupValidation), signup);
router.post('/login', validate(loginValidation), login);
router.post('/verify-otp', validate(verifyOtpValidation), verifyOtp);
router.post('/resend-otp', validate(resendOtpValidation), resendOtp);

export default router;
