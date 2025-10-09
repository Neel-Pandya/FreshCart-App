import { Router } from 'express';
import verifyJWT from '../../core/middleware/jwt.middleware.js';
import adminMiddleware from '../../core/middleware/admin.middleware.js';
import { addCategory } from './category.controller.js';
import { getAllCategories } from './category.controller.js';
import { deleteCategory, updateCategory } from './category.controller.js';
import {
  addCategoryValidation,
  deleteCategoryValidation,
  updateCategoryValidation,
} from './category.validation.js';
import validate from '../../core/middleware/zod.middleware.js';

const router = Router();

router.post('/add', verifyJWT, adminMiddleware, validate(addCategoryValidation), addCategory);
router.get('/all', getAllCategories);
router.delete(
  '/delete',
  verifyJWT,
  adminMiddleware,
  validate(deleteCategoryValidation),
  deleteCategory
);
router.put(
  '/update',
  verifyJWT,
  adminMiddleware,
  validate(updateCategoryValidation),
  updateCategory
);

export default router;
