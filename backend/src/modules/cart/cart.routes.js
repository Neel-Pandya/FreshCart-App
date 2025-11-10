import { Router } from 'express';
import {
  addToCart,
  getCart,
  removeFromCart,
  updateCartQuantity,
  clearCart,
  getCartCount,
} from './cart.controller.js';
import verifyJWT from '../../core/middleware/jwt.middleware.js';
import validate from '../../core/middleware/zod.middleware.js';
import {
  addToCartValidation,
  removeFromCartValidation,
  updateCartQuantityValidation,
} from './cart.validation.js';

const router = Router();

// Add product to cart
router.post('/add', verifyJWT, validate(addToCartValidation), addToCart);

// Get all cart items
router.get('/all', verifyJWT, getCart);

// Remove product from cart
router.post('/remove', verifyJWT, validate(removeFromCartValidation), removeFromCart);

// Update cart item quantity
router.put(
  '/update-quantity',
  verifyJWT,
  validate(updateCartQuantityValidation),
  updateCartQuantity
);

// Clear entire cart
router.post('/clear', verifyJWT, clearCart);

// Get cart count
router.get('/count', verifyJWT, getCartCount);

export default router;
