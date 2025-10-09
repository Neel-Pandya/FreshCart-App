import asyncHandler from 'express-async-handler';
import ApiResponse from '../../core/utils/api_response.util.js';
import UserService from './user.service.js';
import validateFile from '../../core/middleware/file_validator.middleware.js';

const addUser = asyncHandler(async (req, res) => {
  validateFile(req, false);

  const user = await UserService.addUser(req.body, req.file?.path ?? '');

  return res.status(201).json(new ApiResponse(201, 'User added successfully', user));
});

const getAllUsers = asyncHandler(async (_req, res) => {
  const users = await UserService.getAllUsers();
  return res.status(200).json(new ApiResponse(200, 'Users retrieved successfully', users));
});

const getUserById = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const user = await UserService.getUserById(id);
  return res.status(200).json(new ApiResponse(200, 'User retrieved successfully', user));
});

const updateUser = asyncHandler(async (req, res) => {
  validateFile(req, false);

  const { id } = req.params;
  const user = await UserService.updateUser(id, req.body, req.file?.path ?? '');

  return res.status(200).json(new ApiResponse(200, 'User updated successfully', user));
});

const deleteUser = asyncHandler(async (req, res) => {
  const { id } = req.body;

  await UserService.deleteUser(id);

  return res.status(200).json(new ApiResponse(200, 'User deleted successfully', null));
});

export { addUser, getAllUsers, getUserById, updateUser, deleteUser };
