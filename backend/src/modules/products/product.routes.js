import { Router } from 'express';
import {
  addProduct,
  deleteProduct,
  getAllProducts,
  isProductFavourite,
  toggleFavourite,
  updateProduct,
} from './product.controller.js';
import verifyJWT from '../../core/middleware/jwt.middleware.js';
import adminMiddleware from '../../core/middleware/admin.middleware.js';
import upload from '../../core/middleware/multer.middleware.js';
import validate from '../../core/middleware/zod.middleware.js';
import {
  addProductValidation,
  removeProductValidation,
  updateProductValidation,
  addToFavouritesValidation,
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
router.post('/favourite', verifyJWT, validate(addToFavouritesValidation), toggleFavourite);
router.get('/favourite-status', verifyJWT, isProductFavourite);
router.post(
  '/delete',
  verifyJWT,
  adminMiddleware,
  validate(removeProductValidation),
  deleteProduct
);
router.put(
  '/update',
  verifyJWT,
  adminMiddleware,
  upload.single('image'),
  validate(updateProductValidation),
  updateProduct
);

export default router;
