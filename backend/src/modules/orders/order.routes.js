import { Router } from 'express';
import { createOrder, getOrders, getOrderById, getAllOrders } from './order.controller.js';
import verifyJWT from '../../core/middleware/jwt.middleware.js';
import adminMiddleware from '../../core/middleware/admin.middleware.js';
import validate from '../../core/middleware/zod.middleware.js';
import { createOrderValidation } from './order.validation.js';

const router = Router();

// Create order (Cash on Delivery)
router.post('/create', verifyJWT, validate(createOrderValidation), createOrder);

// Get all orders for user
router.get('/all', verifyJWT, getOrders);

// Get all orders (Admin only)
router.get('/admin/all', verifyJWT, adminMiddleware, getAllOrders);

// Get order by ID
router.get('/:orderId', verifyJWT, getOrderById);

export default router;
