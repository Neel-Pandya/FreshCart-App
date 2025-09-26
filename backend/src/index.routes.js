import { Router } from 'express';
import authRoutes from './modules/auth/auth.routes.js';
import categoryRoutes from './modules/category/category.routes.js';
import productRoutes from './modules/products/products.routes.js';

const router = Router();

router.use('/auth', authRoutes);
router.use('/category', categoryRoutes);
router.use('/products', productRoutes);

export default router;
