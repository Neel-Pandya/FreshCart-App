import { v2 as cloudinary } from 'cloudinary';
import EnvConfig from '../config/env.config.js';
import ApiError from './api_error.util.js';
import fs from 'node:fs/promises';

cloudinary.config({
  cloud_name: EnvConfig.cloudinaryCloudName,
  api_key: EnvConfig.cloudinaryApiKey,
  api_secret: EnvConfig.cloudinaryApiSecret,
  secure: true,
});

const uploadImage = async (filePath) => {
  try {
    const image = await cloudinary.uploader.upload(filePath, { folder: 'freshcart/products' });
    await fs.unlink(filePath); // Delete the local file after upload
    return image.url;
  } catch (error) {
    console.error('Cloudinary Upload Error:', error);
    await fs.unlink(filePath);
    throw new ApiError(400, 'Image upload failed');
  }
};

const removeImageFromCloudinary = async (publicId) => {
  try {
    await cloudinary.uploader.destroy(publicId);
    return;
  } catch (error) {
    console.error('Cloudinary Deletion Error:', error);
    throw new ApiError(400, 'Image deletion failed');
  }
};

export { removeImageFromCloudinary };
export default uploadImage;
