import ApiError from '../../core/utils/api_error.util.js';
import uploadImage, { removeImageFromCloudinary } from '../../core/utils/cloudinary.util.js';
import Product from './product.model.js';
import Category from '../category/category.model.js';
import User from "../user/user.model.js";

class ProductService {
  async addProduct(data, filePath) {
    const category = await Category.findOne({ name: data.category });
    if (!category) throw new ApiError(400, 'Invalid category');

    let product = await Product.findOne({ name: data.name });
    if (product) throw new ApiError(400, 'Product already exists');

    const imageUrl = await uploadImage(filePath);

    product = await Product.create({ ...data, imageUrl, category: category._id });

    if (!product) throw new ApiError(400, 'Failed to add product');

    // Populate category before returning
    await product.populate('category', 'name');

    return product;
  }

  async getAllProducts() {
    const products = await Product.find().populate('category', 'name');
    return products;
  }

  async toggleFavourite(userId, productId) {

    const [user, product] = await Promise.all([
      User.findById(userId),
      Product.findById(productId),
    ]);

    if (!user) throw new ApiError(404, 'User not found');
    if (!product) throw new ApiError(404, 'Product not found');
    
    const isFavourite = user.favourites.includes(productId);

    if (isFavourite) {
      // If already favourite, remove it
      user.favourites = user.favourites.filter(id => id.toString() !== productId.toString());
      await user.save();
      return { message: 'Product removed from favourites' };
    } else {
      // If not favourite, add it
      user.favourites.push(productId);
      await user.save();
      return { message: 'Product added to favourites' };
    }
  }

  async isProductFavourite(userId, productId) {
    const user = await User.findById(userId);
    if (!user) throw new ApiError(404, 'User not found');
    return user.favourites.includes(productId);
  }

  async updateProduct(product, prevImageUrl, filePath) {
    let imageUrl = prevImageUrl;
    if (filePath) {
      await removeImageFromCloudinary(prevImageUrl);
      imageUrl = await uploadImage(filePath);
    }

    const category = await Category.findOne({ name: product.category });
    if (!category) throw new ApiError(400, 'Invalid category');

    const updated = await Product.findByIdAndUpdate(
      product.id,
      { ...product, imageUrl, category: category._id },
      { new: true }
    ).populate('category', 'name');

    if (!updated) throw new ApiError(404, 'Product not found');

    return updated;
  }

  async deleteProduct(productId) {
    const product = await Product.findById(productId);
    if (!product) throw new ApiError(404, 'Product not found');
    await removeImageFromCloudinary(product.imageUrl);
    await Product.findByIdAndDelete(productId);

    return;
  }
}

export default new ProductService();
