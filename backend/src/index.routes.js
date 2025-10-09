import { Router } from 'express';
import authRoutes from './modules/auth/auth.routes.js';
import categoryRoutes from './modules/category/category.routes.js';
import productRoutes from './modules/products/product.routes.js';
import userRoutes from './modules/user/user.routes.js';

const router = Router();

router.use('/auth', authRoutes);
router.use('/category', categoryRoutes);
router.use('/products', productRoutes);
router.use('/users', userRoutes);

export default router;
