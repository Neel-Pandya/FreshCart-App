import asyncHandler from 'express-async-handler';
import categoryService from './category.service.js';
import ApiResponse from '../../core/utils/api_response.util.js';

const addCategory = asyncHandler(async (req, res) => {
  const { name } = req.body;
  const category = await categoryService.addCategory(name);
  return res.status(201).json(new ApiResponse(201, 'Category Created Successfully', category));
});

const getAllCategories = asyncHandler(async (req, res) => {
  const categories = await categoryService.getAllCategories();
  return res.status(200).json(new ApiResponse(200, 'Categories Fetched Successfully', categories));
});

const deleteCategory = asyncHandler(async (req, res) => {
  const { id } = req.body;
  const category = await categoryService.deleteCategory(id);
  return res.status(200).json(new ApiResponse(200, 'Category Deleted Successfully', category));
});

const updateCategory = asyncHandler(async (req, res) => {
  const { id, name } = req.body;
  const category = await categoryService.updateCategory(id, name);
  return res.status(200).json(new ApiResponse(200, 'Category Updated Successfully', category));
});

export { addCategory, getAllCategories, deleteCategory, updateCategory };
