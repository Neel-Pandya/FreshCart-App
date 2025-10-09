import { Router } from 'express';
import { addProduct, deleteProduct, getAllProducts, updateProduct } from './product.controller.js';
import verifyJWT from '../../core/middleware/jwt.middleware.js';
import adminMiddleware from '../../core/middleware/admin.middleware.js';
import upload from '../../core/middleware/multer.middleware.js';
import validate from '../../core/middleware/zod.middleware.js';
import {
  addProductValidation,
  removeProductValidation,
  updateProductValidation,
} from './product.validation.js';

const router = Router();

router.post(
  '/add',
  verifyJWT,
  adminMiddleware,
  upload.single('image'),
  validate(addProductValidation),
  addProduct
);
router.get('/all', getAllProducts);
router.post('/delete', validate(removeProductValidation), deleteProduct);
router.put(
  '/update',
  verifyJWT,
  adminMiddleware,
  upload.single('image'),
  validate(updateProductValidation),
  updateProduct
);

export default router;
