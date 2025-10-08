import asyncHandler from 'express-async-handler';
import ApiResponse from '../../core/utils/api_response.util.js';
import ProductService from './product.service.js';
import validateFile from '../../core/middleware/file_validator.middleware.js';
const addProduct = asyncHandler(async (req, res) => {
  validateFile(req);

  const product = await ProductService.addProduct(req.body, req.file.path);

  return res.status(201).json(new ApiResponse(201, 'Product added successfully', product));
});

const getAllProducts = asyncHandler(async (_req, res) => {
  const products = await ProductService.getAllProducts();
  return res.status(200).json(new ApiResponse(200, 'Products retrieved successfully', products));
});

const deleteProduct = asyncHandler(async (req, res) => {
  const { id } = req.body;

  await ProductService.deleteProduct(id);

  return res.status(200).json(new ApiResponse(200, 'Product deleted successfully', null));
});

const updateProduct = asyncHandler(async (req, res) => {
  validateFile(req, false);

  const product = await ProductService.updateProduct(
    req.body,
    req.body.imageUrl,
    req.file?.path ?? ''
  );

  return res.status(200).json(new ApiResponse(200, 'Product updated successfully', product));
});

export { addProduct, getAllProducts, deleteProduct, updateProduct };
