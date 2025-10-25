import mongoose from 'mongoose';
import bcrypt from 'bcryptjs';
import EnvConfig from '../../core/config/env.config.js';
import jwt from 'jsonwebtoken';

const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Name is required'],
    },
    email: {
      type: String,
      required: [true, 'Email is required'],
      unique: true,
    },
    password: {
      type: String,
      required: false,
      default: '',
    },
    profile: {
      type: String,
      default: '',
    },
    status: {
      type: String,
      default: 'inactive',
    },
    role: {
      type: Number,
      required: [true, 'Role is required'],
      default: 0,
    },

    isGoogle: {
      type: Boolean,
      default: false,
    },
    favourites: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product',
      },
    ],

    cart: [
      {
        productId: {
          type: mongoose.Schema.Types.ObjectId,
          ref: 'Product',
        },
        quantity: {
          type: Number,
          default: 1,
        },
      },
    ]
  },
  { timestamps: true }
);

userSchema.pre('save', async function (next) {
  if (!this.isModified('password')) return next();
  this.password = await bcrypt.hash(this.password, 10);
  next();
});

userSchema.methods.generateToken = function () {
  return jwt.sign(
    { id: this._id, role: this.role, email: this.email, name: this.name },
    EnvConfig.jwtSecret
  );
};

userSchema.methods.hashPassword = async function (password) {
  return await bcrypt.hash(password, 10);
};

userSchema.methods.comparePassword = async function (password) {
  return await bcrypt.compare(password, this.password);
};

const User = mongoose.model('User', userSchema);

export default User;
