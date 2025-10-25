import asyncHandler from 'express-async-handler';
import ApiResponse from '../../core/utils/api_response.util.js';
import CartService from './cart.service.js';

const addToCart = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { productId } = req.body;
  const quantity = req.body.quantity || 1;

  const result = await CartService.addToCart(userId, productId, quantity);

  return res.status(200).json(new ApiResponse(200, result.message, null));
});

const getCart = asyncHandler(async (req, res) => {
  const userId = req.user.id;

  const cartItems = await CartService.getCart(userId);

  return res.status(200).json(new ApiResponse(200, 'Cart retrieved successfully', cartItems));
});

const removeFromCart = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { productId } = req.body;

  const result = await CartService.removeFromCart(userId, productId);

  return res.status(200).json(new ApiResponse(200, result.message, null));
});

const updateCartQuantity = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { productId, quantity } = req.body;

  const result = await CartService.updateCartQuantity(userId, productId, quantity);

  return res.status(200).json(new ApiResponse(200, result.message, null));
});

const clearCart = asyncHandler(async (req, res) => {
  const userId = req.user.id;

  const result = await CartService.clearCart(userId);

  return res.status(200).json(new ApiResponse(200, result.message, null));
});

const getCartCount = asyncHandler(async (req, res) => {
  const userId = req.user.id;

  const count = await CartService.getCartCount(userId);

  return res.status(200).json(new ApiResponse(200, 'Cart count retrieved successfully', { count }));
});

export { addToCart, getCart, removeFromCart, updateCartQuantity, clearCart, getCartCount };
