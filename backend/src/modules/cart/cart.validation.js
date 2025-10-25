import { z } from 'zod';
import ApiError from '../../core/utils/api_error.util.js';

const addToCartValidation = z.strictObject(
  {
    productId: z
      .string({ error: 'Product ID is required' })
      .nonempty({ error: 'Product ID cannot be empty' }),

    quantity: z
      .number()
      .int()
      .min(1, { error: 'Quantity must be at least 1' })
      .max(10, { error: 'Quantity cannot exceed 10' })
      .optional()
      .default(1),
  },
  { error: 'Invalid cart data' }
);

const removeFromCartValidation = z.strictObject(
  {
    productId: z
      .string({ error: 'Product ID is required' })
      .nonempty({ error: 'Product ID cannot be empty' }),
  },
  { error: 'Invalid product ID' }
);

const updateCartQuantityValidation = z.strictObject(
  {
    productId: z
      .string({ error: 'Product ID is required' })
      .nonempty({ error: 'Product ID cannot be empty' }),

    quantity: z
      .number()
      .int()
      .min(1, { error: 'Quantity must be at least 1' })
      .max(10, { error: 'Quantity cannot exceed 10' }),
  },
  { error: 'Invalid cart data' }
);

export { addToCartValidation, removeFromCartValidation, updateCartQuantityValidation };
