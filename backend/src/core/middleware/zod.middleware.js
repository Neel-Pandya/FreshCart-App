import z, { ZodError } from 'zod';
import ApiError from '../utils/api_error.util.js';

const validate = (schema) => async (req, _res, next) => {
  try {
    await schema.parseAsync(req.body);
    next();
  } catch (error) {
    const errors = JSON.parse(error.message);
    throw new ApiError(400, errors[0].message);
  }
};

export default validate;
