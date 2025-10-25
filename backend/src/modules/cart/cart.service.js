import ApiError from '../../core/utils/api_error.util.js';
import User from '../user/user.model.js';
import Product from '../products/product.model.js';

class CartService {
  async addToCart(userId, productId, quantity = 1) {
    const [user, product] = await Promise.all([
      User.findById(userId),
      Product.findById(productId),
    ]);

    if (!user) throw new ApiError(404, 'User not found');
    if (!product) throw new ApiError(404, 'Product not found');
    if (quantity > product.stock) {
      throw new ApiError(400, `Insufficient stock. Only ${product.stock} items available`);
    }

    const cartItem = user.cart.find(item => item.productId.toString() === productId.toString());

    if (!cartItem) {
      user.cart.push({ productId, quantity });
    } else {
      const newQuantity = cartItem.quantity + quantity;
      if (newQuantity > product.stock) {
        throw new ApiError(400, `Insufficient stock. Only ${product.stock} items available in total`);
      }
      cartItem.quantity = newQuantity;
    }

    await user.save();
    return { message: 'Product added to cart' };
  }

  async getCart(userId) {
    const user = await User.findById(userId).populate({
      path: 'cart.productId',
      model: Product,
      select: 'name price imageUrl stock category',
      populate: {
        path: 'category',
        select: 'name',
      },
    });

    if (!user) throw new ApiError(404, 'User not found');

    return user.cart;
  }

  async removeFromCart(userId, productId) {
    const user = await User.findById(userId);

    if (!user) throw new ApiError(404, 'User not found');

    const cartItemIndex = user.cart.findIndex(item => item.productId.toString() === productId.toString());

    if (cartItemIndex === -1) throw new ApiError(404, 'Product not found in cart');

    user.cart.splice(cartItemIndex, 1);
    await user.save();

    return { message: 'Product removed from cart' };
  }

  async updateCartQuantity(userId, productId, quantity) {
    if (quantity < 1) {
      throw new ApiError(400, 'Quantity must be at least 1');
    }

    const user = await User.findById(userId);

    if (!user) throw new ApiError(404, 'User not found');

    const cartItem = user.cart.find(item => item.productId.toString() === productId.toString());

    if (!cartItem) throw new ApiError(404, 'Product not found in cart');

    const product = await Product.findById(productId);
    if (!product) throw new ApiError(404, 'Product not found');

    if (quantity > product.stock) {
      throw new ApiError(400, `Insufficient stock. Only ${product.stock} items available`);
    }

    cartItem.quantity = quantity;
    await user.save();

    return { message: 'Cart quantity updated' };
  }

  async clearCart(userId) {
    const user = await User.findById(userId);

    if (!user) throw new ApiError(404, 'User not found');

    user.cart = [];
    await user.save();

    return { message: 'Cart cleared' };
  }

  async getCartCount(userId) {
    const user = await User.findById(userId);

    if (!user) throw new ApiError(404, 'User not found');

    return user.cart.length;
  }
}

export default new CartService();
