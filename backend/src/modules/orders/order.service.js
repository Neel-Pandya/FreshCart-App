import ApiError from '../../core/utils/api_error.util.js';
import User from '../user/user.model.js';
import Product from '../products/product.model.js';

class OrderService {
  async createOrder(userId, paymentMethod, deliveryAddress) {
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

    // Only allow Cash on Delivery
    if (paymentMethod !== 'Cash on Delivery') {
      throw new ApiError(400, 'Only Cash on Delivery is currently supported');
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

    // Create order object
    const newOrder = {
      items: orderItems,
      totalAmount,
      paymentMethod,
      deliveryAddress,
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

    return newOrder;
  }

  async getOrders(userId) {
    const user = await User.findById(userId).populate({
      path: 'orders.items.productId',
      select: 'name imageUrl',
    });

    if (!user) throw new ApiError(404, 'User not found');

    return user.orders;
  }


  async getOrderById(userId, orderId) {
    const user = await User.findById(userId);

    if (!user) throw new ApiError(404, 'User not found');

    const order = user.orders.id(orderId);

    if (!order) throw new ApiError(404, 'Order not found');

    return order;
  }

  async getAllOrders() {
    // Get all users with their orders populated
    const users = await User.find()
      .select('name email profile orders')
      .populate({
        path: 'orders.items.productId',
        select: 'name imageUrl',
      });

    // Flatten all orders and add user information
    const allOrders = [];
    for (const user of users) {
      for (const order of user.orders) {
        allOrders.push({
          ...order.toObject(),
          userId: user._id,
          userName: user.name,
          userEmail: user.email,
          userProfile: user.profile,
        });
      }
    }

    // Sort by creation date (newest first)
    allOrders.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));

    return allOrders;
  }
}

export default new OrderService();
