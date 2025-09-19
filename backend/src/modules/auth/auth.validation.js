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
    .max(16, { error: 'Password must be at most 16 characters long' }),
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
    .max(16, { error: 'Password must be at most 16 characters long' }),
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
    .max(16, { error: 'Password must be at most 16 characters long' }),
})

export { signupValidation, loginValidation, resendOtpValidation, verifyOtpValidation, forgotPasswordValidation, resetPasswordValidation };
