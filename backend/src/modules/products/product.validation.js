import { int, z } from 'zod';
import ApiError from '../../core/utils/api_error.util.js';

const addProductValidation = z.object(
  {
    name: z
      .string({ error: 'Name is required' })
      .nonempty({ error: 'Name cannot be empty' })
      .trim()
      .min(3, { error: 'Product Name must be at least 3 characters long' })
      .max(100, { error: 'Product Name cannot exceed 100 characters' })
      .regex(/^[a-zA-Z0-9\s\-_,\.;:()]+$/, { error: 'Product Name contains invalid characters' }),

    price: z
      .string({ error: 'Price is required' })
      .min(2, { error: 'Price must be at least 2' })
      .max(10, { error: 'Price cannot exceed 1,000,000' })
      .transform((price) => {
        const priceInt = Number.parseInt(price);
        if (priceInt == NaN) throw new ApiError(400, 'Invalid Price');
        return priceInt;
      }),

    category: z
      .string({ error: 'Category is required' })
      .nonempty({ error: 'Category cannot be empty' })
      .trim()
      .min(3, { error: 'Category must be at least 3 characters long' })
      .max(50, { error: 'Category cannot exceed 50 characters' })
      .regex(/^[a-zA-Z\s]+$/, { error: 'Category contains invalid characters' }),

    stock: z
      .string({ error: 'Stock is required' })
      .min(1, { error: 'Stock cannot be negative' })
      .max(10000, { error: 'Stock cannot exceed 10,000' })
      .transform((stock) => {
        const stockInt = Number.parseInt(stock);
        if (stockInt == NaN) throw new ApiError(400, 'Invalid Stock');
        return stockInt;
      }),

    description: z
      .string({ error: 'Description is required' })
      .nonempty({ error: 'Description cannot be empty' })
      .trim()
      .min(10, { error: 'Description must be at least 10 characters long' })
      .max(1000, { error: 'Description cannot exceed 1,000 characters' })
      .regex(/^[a-zA-Z0-9\s\-_,\.;:()]+$/, { error: 'Description contains invalid characters' }),
  },
  { error: 'Invalid product data' }
);

const removeProductValidation = z.strictObject(
  {
    id: z
      .string({ error: 'Product ID is required' })
      .nonempty({ error: 'Product ID cannot be empty' }),
  },
  { error: 'Invalid product ID' }
);

const updateProductValidation = z.object({
  id: z
    .string({ error: 'Product ID is required' })
    .nonempty({ error: 'Product ID cannot be empty' }),
  name: z
    .string({ error: 'Name is required' })
    .nonempty({ error: 'Name cannot be empty' })
    .trim()
    .min(3, { error: 'Product Name must be at least 3 characters long' })
    .max(100, { error: 'Product Name cannot exceed 100 characters' })
    .regex(/^[a-zA-Z0-9\s\-_,\.;:()]+$/, { error: 'Product Name contains invalid characters' }),
  price: z
    .string({ error: 'Price is required' })
    .min(2, { error: 'Price must be at least 2' })
    .max(10, { error: 'Price cannot exceed 1,000,000' })
    .transform((price) => {
      const priceInt = Number.parseInt(price);
      if (priceInt == NaN) throw new ApiError(400, 'Invalid Price');
      return priceInt;
    }),
  category: z
    .string({ error: 'Category is required' })
    .nonempty({ error: 'Category cannot be empty' })
    .trim()
    .min(3, { error: 'Category must be at least 3 characters long' })
    .max(50, { error: 'Category cannot exceed 50 characters' })
    .regex(/^[a-zA-Z\s]+$/, { error: 'Category contains invalid characters' }),
  stock: z
    .string({ error: 'Stock is required' })
    .min(1, { error: 'Stock cannot be negative' })
    .max(10000, { error: 'Stock cannot exceed 10,000' })
    .transform((stock) => {
      const stockInt = Number.parseInt(stock);
      if (stockInt == NaN) throw new ApiError(400, 'Invalid Stock');
      return stockInt;
    }),
  description: z
    .string({ error: 'Description is required' })
    .nonempty({ error: 'Description cannot be empty' })
    .trim()
    .min(10, { error: 'Description must be at least 10 characters long' })
    .max(1000, { error: 'Description cannot exceed 1,000 characters' })
    .regex(/^[a-zA-Z0-9\s\-_,\.;:()]+$/, { error: 'Description contains invalid characters' }),
    
    imageUrl: z.url({ message: 'Invalid image URL' }).nonempty({ message: 'Image URL is required' }),
});

export { addProductValidation, removeProductValidation, updateProductValidation };
