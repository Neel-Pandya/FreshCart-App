import { Router } from 'express';
import { signup, login } from './auth.controller.js';
import validate from '../../core/middleware/zod.middleware.js';
import { signupValidation, loginValidation } from './auth.validation.js';

const router = Router();

router.post('/signup', validate(signupValidation), signup);
router.post('/login', validate(loginValidation), login);

export default router;
