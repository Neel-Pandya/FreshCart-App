import mongoose from 'mongoose';
const productSchema = new mongoose.Schema(
  {
    name: { type: String, required: [true, 'Name is required'] },
    price: { type: Number, required: [true, 'Price is required'] },
    category: {
      type: mongoose.Schema.Types.ObjectId,
      required: [true, 'Category is required'],
      ref: 'Category',
    },
    stock: { type: Number, required: [true, 'Stock is required'] },
    description: { type: String, required: [true, 'Description is required'] },
    imageUrl: { type: String, required: [true, 'Image URL is required'] },
  },
  { timestamps: true }
);

const Product = mongoose.model('Product', productSchema);
export default Product;
