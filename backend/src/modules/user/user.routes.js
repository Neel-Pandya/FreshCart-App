import { Router } from 'express';
import {
  addUser,
  deleteUser,
  getAllUsers,
  getUserById,
  updateUser,
  getUserFavourites,
} from './user.controller.js';
import verifyJWT from '../../core/middleware/jwt.middleware.js';
import adminMiddleware from '../../core/middleware/admin.middleware.js';
import upload from '../../core/middleware/multer.middleware.js';
import validate from '../../core/middleware/zod.middleware.js';
import {
  addUserValidation,
  removeUserValidation,
  updateUserValidation,
  getUserValidation,
} from './user.validation.js';

const router = Router();

router.post(
  '/add',
  verifyJWT,
  adminMiddleware,
  upload.single('profile'),
  validate(addUserValidation),
  addUser
);

router.get('/all', verifyJWT, adminMiddleware, getAllUsers);

router.get('/:id', verifyJWT, adminMiddleware, validate(getUserValidation), getUserById);

router.put(
  '/update/:id',
  verifyJWT,
  adminMiddleware,
  upload.single('profile'),
  validate(updateUserValidation),
  updateUser
);

router.post('/delete', verifyJWT, adminMiddleware, validate(removeUserValidation), deleteUser);

router.get('/favourites/all', verifyJWT, getUserFavourites);

export default router;
