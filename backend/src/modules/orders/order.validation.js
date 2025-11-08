import { z } from 'zod';

const createOrderValidation = z.object({
  paymentMethod: z.string().min(1, 'Payment method is required'),
  deliveryAddress: z.string().min(1, 'Delivery address is required'),
});

export { createOrderValidation };
