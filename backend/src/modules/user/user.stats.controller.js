import asyncHandler from 'express-async-handler';
import ApiResponse from '../../core/utils/api_response.util.js';
import User from './user.model.js';
import Product from '../products/product.model.js';

const getDashboardStats = asyncHandler(async (_req, res) => {
  // Get total users count (excluding admins)
  const totalUsers = await User.countDocuments({ role: 0 });

  // Get total products count
  const totalProducts = await Product.countDocuments();

  // Get total orders count from all users
  const ordersAggregation = await User.aggregate([
    { $unwind: '$orders' },
    { $count: 'totalOrders' },
  ]);
  const totalOrders = ordersAggregation.length > 0 ? ordersAggregation[0].totalOrders : 0;

  // Get total payment amount from all orders
  const paymentAggregation = await User.aggregate([
    { $unwind: '$orders' },
    {
      $group: {
        _id: null,
        totalPayment: { $sum: '$orders.totalAmount' },
      },
    },
  ]);
  const totalPayment = paymentAggregation.length > 0 ? paymentAggregation[0].totalPayment : 0;

  const stats = {
    totalUsers,
    totalProducts,
    totalOrders,
    totalPayment,
  };

  return res.status(200).json(new ApiResponse(200, 'Dashboard stats retrieved successfully', stats));
});

export { getDashboardStats };
