import asyncHandler from 'express-async-handler';
import Razorpay from 'razorpay';
import crypto from 'crypto';
import ApiResponse from '../../core/utils/api_response.util.js';
import ApiError from '../../core/utils/api_error.util.js';
import EnvConfig from '../../core/config/env.config.js';
import User from '../user/user.model.js';
import Product from '../products/product.model.js';

// Initialize Razorpay instance
const razorpay = new Razorpay({
  key_id: EnvConfig.razorpayKeyId || process.env.RAZORPAY_KEY_ID,
  key_secret: EnvConfig.razorpayKeySecret || process.env.RAZORPAY_KEY_SECRET,
});

/**
 * Create Razorpay order
 * This endpoint creates a Razorpay order and returns the order ID
 * which will be used to initiate payment on the frontend
 */
const createRazorpayOrder = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { deliveryAddress } = req.body;

  console.log('Creating Razorpay order for user:', userId);
  console.log('Delivery address:', deliveryAddress);

  // Validate Razorpay credentials
  if (!EnvConfig.razorpayKeyId && !process.env.RAZORPAY_KEY_ID) {
    console.error('Razorpay Key ID not configured');
    throw new ApiError(500, 'Payment gateway not configured properly');
  }

  if (!EnvConfig.razorpayKeySecret && !process.env.RAZORPAY_KEY_SECRET) {
    console.error('Razorpay Key Secret not configured');
    throw new ApiError(500, 'Payment gateway not configured properly');
  }

  // Fetch user with cart items populated
  const user = await User.findById(userId).populate({
    path: 'cart.productId',
    model: Product,
    select: 'price stock name imageUrl',
  });

  if (!user) throw new ApiError(404, 'User not found');

  if (user.cart.length === 0) {
    throw new ApiError(400, 'Cart is empty');
  }

  // Validate stock and calculate total amount
  let totalAmount = 0;

  for (const cartItem of user.cart) {
    const product = cartItem.productId;

    if (!product) {
      throw new ApiError(404, 'Product not found in cart');
    }

    if (product.stock < cartItem.quantity) {
      throw new ApiError(
        400,
        `Insufficient stock for ${product.name}. Available: ${product.stock}, Requested: ${cartItem.quantity}`
      );
    }

    const itemTotal = product.price * cartItem.quantity;
    totalAmount += itemTotal;
  }

  console.log('Total amount for order:', totalAmount);

  // Create Razorpay order
  // Note: receipt must be <= 40 characters
  const timestamp = Date.now().toString().slice(-8); // Last 8 digits of timestamp
  const userIdShort = userId.toString().slice(-8); // Last 8 characters of userId

  const options = {
    amount: totalAmount * 100, // Amount in paise (₹1 = 100 paise)
    currency: 'INR',
    receipt: `ord_${userIdShort}_${timestamp}`, // Format: ord_12345678_87654321 (max 29 chars)
    notes: {
      userId: userId.toString(),
      deliveryAddress,
    },
  };

  try {
    const razorpayOrder = await razorpay.orders.create(options);
    console.log('Razorpay order created:', razorpayOrder.id);

    return res.status(201).json(
      new ApiResponse(201, 'Razorpay order created successfully', {
        orderId: razorpayOrder.id,
        amount: razorpayOrder.amount,
        currency: razorpayOrder.currency,
        keyId: EnvConfig.razorpayKeyId || process.env.RAZORPAY_KEY_ID,
      })
    );
  } catch (error) {
    console.error('Razorpay order creation failed:', error);
    throw new ApiError(500, `Failed to create payment order: ${error.message}`);
  }
});

/**
 * Verify Razorpay payment and create order
 * This endpoint verifies the payment signature and creates the order in database
 */
const verifyRazorpayPayment = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { razorpayOrderId, razorpayPaymentId, razorpaySignature, deliveryAddress } = req.body;

  // Verify signature
  const body = razorpayOrderId + '|' + razorpayPaymentId;
  const expectedSignature = crypto
    .createHmac('sha256', EnvConfig.razorpayKeySecret || process.env.RAZORPAY_KEY_SECRET)
    .update(body.toString())
    .digest('hex');

  if (expectedSignature !== razorpaySignature) {
    throw new ApiError(400, 'Payment verification failed');
  }

  // Fetch user with cart items populated
  const user = await User.findById(userId).populate({
    path: 'cart.productId',
    model: Product,
    select: 'price stock name imageUrl',
  });

  if (!user) throw new ApiError(404, 'User not found');

  if (user.cart.length === 0) {
    throw new ApiError(400, 'Cart is empty');
  }

  // Validate stock and prepare order items
  const orderItems = [];
  let totalAmount = 0;

  for (const cartItem of user.cart) {
    const product = cartItem.productId;

    if (!product) {
      throw new ApiError(404, 'Product not found in cart');
    }

    if (product.stock < cartItem.quantity) {
      throw new ApiError(
        400,
        `Insufficient stock for ${product.name}. Available: ${product.stock}, Requested: ${cartItem.quantity}`
      );
    }

    const itemTotal = product.price * cartItem.quantity;
    orderItems.push({
      productId: product._id,
      productName: product.name,
      price: product.price,
      quantity: cartItem.quantity,
      total: itemTotal,
      imageUrl: product.imageUrl,
    });

    totalAmount += itemTotal;
  }

  // Create order object with payment details
  const newOrder = {
    items: orderItems,
    totalAmount,
    paymentMethod: 'RazorPay',
    deliveryAddress,
    paymentDetails: {
      razorpayOrderId,
      razorpayPaymentId,
      razorpaySignature,
      paymentStatus: 'completed',
    },
    createdAt: new Date(),
  };

  // Reduce stock for each product
  for (const cartItem of user.cart) {
    const product = cartItem.productId;
    product.stock -= cartItem.quantity;
    await product.save();
  }

  // Add order to user's orders array
  user.orders.push(newOrder);

  // Clear user's cart
  user.cart = [];
  await user.save();

  return res
    .status(201)
    .json(new ApiResponse(201, 'Payment verified and order created successfully', newOrder));
});

export { createRazorpayOrder, verifyRazorpayPayment };
