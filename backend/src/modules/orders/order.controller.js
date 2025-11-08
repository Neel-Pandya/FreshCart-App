import asyncHandler from 'express-async-handler';
import ApiResponse from '../../core/utils/api_response.util.js';
import OrderService from './order.service.js';

const createOrder = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { paymentMethod, deliveryAddress } = req.body;

  const order = await OrderService.createOrder(userId, paymentMethod, deliveryAddress);

  return res.status(201).json(new ApiResponse(201, 'Order created successfully', order));
});

const getOrders = asyncHandler(async (req, res) => {
  const userId = req.user.id;

  const orders = await OrderService.getOrders(userId);

  return res.status(200).json(new ApiResponse(200, 'Orders retrieved successfully', orders));
});

const getOrderById = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { orderId } = req.params;

  const order = await OrderService.getOrderById(userId, orderId);

  return res.status(200).json(new ApiResponse(200, 'Order retrieved successfully', order));
});

const getAllOrders = asyncHandler(async (_req, res) => {
  const orders = await OrderService.getAllOrders();

  return res.status(200).json(new ApiResponse(200, 'All orders retrieved successfully', orders));
});

export { createOrder, getOrders, getOrderById, getAllOrders };
