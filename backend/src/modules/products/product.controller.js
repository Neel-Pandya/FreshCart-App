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

const toggleFavourite = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { productId } = req.body;

  const { message } = await ProductService.toggleFavourite(userId, productId);
  return res.status(200).json(new ApiResponse(200, message, null));
});

const isProductFavourite = asyncHandler(async (req, res) => {
  const userId = req.user.id;
  const { productId } = req.query;

  const isFavourite = await ProductService.isProductFavourite(userId, productId);
  return res
    .status(200)
    .json(new ApiResponse(200, 'Favourite status retrieved successfully', { isFavourite }));
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

export {
  addProduct,
  getAllProducts,
  toggleFavourite,
  isProductFavourite,
  deleteProduct,
  updateProduct,
};
