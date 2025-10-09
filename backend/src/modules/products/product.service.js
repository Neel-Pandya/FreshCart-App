import ApiError from '../../core/utils/api_error.util.js';
import uploadImage, { removeImageFromCloudinary } from '../../core/utils/cloudinary.util.js';
import Product from './product.model.js';
import Category from '../category/category.model.js';
class ProductService {
  async addProduct(data, filePath) {
    const category = await Category.findOne({ name: data.category });
    if (!category) throw new ApiError(400, 'Invalid category');

    let product = await Product.findOne({ name: data.name });
    if (product) throw new ApiError(400, 'Product already exists');

    const imageUrl = await uploadImage(filePath);

    product = await Product.create({ ...data, imageUrl, category: category._id });

    if (!product) throw new ApiError(400, 'Failed to add product');

    return product;
  }

  async getAllProducts() {
    const products = await Product.find().populate('category', 'name');
    return products;
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
