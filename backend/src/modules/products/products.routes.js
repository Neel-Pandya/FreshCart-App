import { Router } from 'express';
import { addProduct } from './products.controller.js';
import verifyJWT from '../../core/middleware/jwt.middleware.js';
import adminMiddleware from '../../core/middleware/admin.middleware.js';

const router = Router();

router.post('/add', verifyJWT, adminMiddleware, addProduct);

export default router;
