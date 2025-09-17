class ApiError extends Error {
  constructor(status, message, errors = [], stack) {
    super(message);
    this.status = status;
    this.errors = errors;
    this.success = status < 400;
    if (stack) {
      this.stack = stack;
    }

    Error.captureStackTrace(this, this.constructor);
  }
}

export default ApiError;
