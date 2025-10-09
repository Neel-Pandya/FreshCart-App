import { z } from 'zod';
import ApiError from '../../core/utils/api_error.util.js';

export const addUserValidation = z.object({
  name: z
    .string()
    .min(3, 'Name must be at least 3 characters long')
    .max(100, 'Name must be at most 100 characters long'),
  email: z.email({error: (issue) => issue.input == undefined ? 'Email is required' : 'Invalid email'}),
  password: z
    .string()
    .min(6, 'Password must be at least 6 characters long')
    .max(100, 'Password must be at most 100 characters long'),
  role: z.string().min(0).max(1).transform((value) => Number(value)),
  status: z.string().default('inactive'),
});

export const updateUserValidation = z.object({
  name: z
    .string()
    .min(3, 'Name must be at least 3 characters long')
    .max(100, 'Name must be at most 100 characters long')
    .optional(),
  email: z.email({error: (issue) => issue.input == undefined ? 'Email is required' : 'Invalid email'}),
});

export const removeUserValidation = z.object({
  id: z.string().nonempty({ error: 'User ID is required' }),
});

export const getUserValidation = z.object({
  id: z.string().min(1, 'User ID is required'),
});
