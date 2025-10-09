import ApiError from '../utils/api_error.util.js';

const validateFile = (req, isRequired = true) => {
  // If not required and no file provided, skip validation
  if (!isRequired && !req.file) return;

  // If required but no file provided, throw error
  if (isRequired && !req.file) {
    throw new ApiError(400, 'Image file is required');
  }

  // If file is provided (whether required or not), validate it
  if (req.file) {
    const allowedMimeTypes = ['image/jpeg', 'image/png', 'image/gif'];
    if (!allowedMimeTypes.includes(req.file.mimetype)) {
      throw new ApiError(400, 'Invalid file type. Only JPEG, PNG, and GIF are allowed.');
    }
    if (req.file.size > 1024 * 1024) {
      throw new ApiError(400, 'File size exceeds the 1MB limit.');
    }
  }
};

export default validateFile;
