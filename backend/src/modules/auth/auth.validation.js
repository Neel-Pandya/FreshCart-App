import { z } from 'zod';

const signupValidation = z.strictObject({
  name: z
    .string({ error: 'Name is required' })
    .nonempty({ error: 'Name is required' })
    .trim()
    .min(3, { error: 'Name must be at least 3 characters long' })
    .max(32, { error: 'Name must be less than 32 characters long' }),
  email: z.email({
    error: (issue) => (issue.input == undefined ? 'Email is required' : 'Invalid email'),
  }),
  password: z
    .string({ error: 'Password is required' })
    .nonempty({ error: 'Password is required' })
    .trim()
    .min(8, { error: 'Password must be at least 8 characters long' })
    .max(16, { error: 'Password must be at most 16 characters long' })
    .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/, {
      error:
        'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character',
    }),
});

const googleSignupValidation = z.strictObject({
  idToken: z.string({ error: 'ID Token is required' }).nonempty({ error: 'ID Token is required' }),
});

const loginValidation = z.strictObject({
  email: z.email({
    error: (issue) => (issue.input == undefined ? 'Email is required' : 'Invalid email'),
  }),
  password: z
    .string({ error: 'Password is required' })
    .nonempty({ error: 'Password is required' })
    .trim()
    .min(8, { error: 'Password must be at least 8 characters long' })
    .max(16, { error: 'Password must be at most 16 characters long' })
    .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/, {
      error:
        'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character',
    }),
});

const resendOtpValidation = z.strictObject({
  email: z.email({
    error: (issue) => (issue.input == undefined ? 'Email is required' : 'Invalid email'),
  }),
});

const verifyOtpValidation = z.strictObject({
  email: z.email({
    error: (issue) => (issue.input == undefined ? 'Email is required' : 'Invalid email'),
  }),

  otp: z.string({ error: 'OTP is required' }).nonempty({ error: 'OTP is required' }),
});

const forgotPasswordValidation = z.strictObject({
  email: z.email({
    error: (issue) => (issue.input == undefined ? 'Email is required' : 'Invalid email'),
  }),
});

const resetPasswordValidation = z.strictObject({
  email: z.email({
    error: (issue) => (issue.input == undefined ? 'Email is required' : 'Invalid email'),
  }),
  password: z
    .string({ error: 'Password is required' })
    .nonempty({ error: 'Password is required' })
    .trim()
    .min(8, { error: 'Password must be at least 8 characters long' })
    .max(16, { error: 'Password must be at most 16 characters long' })
    .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/, {
      error:
        'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character',
    }),
});

const changePasswordValidation = z.strictObject({
  oldPassword: z
    .string({ error: 'Old Password is required' })
    .nonempty({ error: 'Old Password is required' }),
  newPassword: z
    .string({ error: 'New Password is required' })
    .nonempty({ error: 'New Password is required' })
    .trim()
    .min(8, { error: 'New Password must be at least 8 characters long' })
    .max(16, { error: 'New Password must be at most 16 characters long' })
    .regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/, {
      error:
        'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character',
    }),
});

export {
  signupValidation,
  googleSignupValidation,
  loginValidation,
  resendOtpValidation,
  verifyOtpValidation,
  forgotPasswordValidation,
  resetPasswordValidation,
  changePasswordValidation,
};
