import User from '../user/user.model.js';
import Otp from '../../core/models/otp.model.js';
import ApiError from '../../core/utils/api_error.util.js';
import nodemailer from 'nodemailer';
import EnvConfig from '../../core/config/env.config.js';
import bcrypt from 'bcryptjs';
import admin from '../../core/config/firebase.config.js';
import uploadImage from '../../core/utils/cloudinary.util.js';

class AuthService {
  async signup(data) {
    const { name, email, password } = data;
    const existingUser = await User.findOne({ email });

    if (existingUser) throw new ApiError(400, 'User already exists');

    const user = await User.create({ name, email, password });

    if (!user) throw new ApiError(400, 'User creation failed');

    await this.sendOtp(user);

    return {
      message:
        'Account registered please verify the otp sent to your email to activate your account',
    };
  }

  async googleSignup(idToken) {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    const { uid, email } = decodedToken;

    if (!email) throw new ApiError(400, 'Google account has no email associated');

    // Fetch user details from Firebase
    const firebaseUser = await admin.auth().getUser(uid);

    if (!firebaseUser) throw new ApiError(401, 'Invalid or expired ID Token');

    const { displayName, photoURL } = firebaseUser;
    const name = displayName || email.split('@')[0];

    // Check if user already exists
    let user = await User.findOne({ email });

    if (user) throw new ApiError(400, 'User already exists. Please login instead.');

    user = await User.create({
      email,
      name,
      profile: photoURL,
      isGoogle: true,
      status: 'active',
    });

    if (!user) throw new ApiError(500, 'User creation failed');

    return {
      message: 'Google signup successful',
      user,
    };
  }

  async login(data) {
    const { email, password } = data;
    const user = await User.findOne({ email });

    if (!user) throw new ApiError(400, 'User not found');

    if (user.isGoogle)
      throw new ApiError(400, 'This account is associated with Google. Please use Google Sign-In.');

    const isMatch = await user.comparePassword(password);

    if (!isMatch) throw new ApiError(400, 'Invalid credentials');

    return { user, accessToken: user.generateToken() };
  }

  async googleLogin(idToken) {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    const { uid, email } = decodedToken;

    if (!email) throw new ApiError(400, 'Google account has no email associated');

    // Fetch user details from Firebase
    const firebaseUser = await admin.auth().getUser(uid);

    if (!firebaseUser) throw new ApiError(401, 'Invalid or expired ID Token');

    // Check if user exists
    const user = await User.findOne({ email });

    if (!user) throw new ApiError(400, 'User not found. Please sign up first.');

    if (!user.isGoogle)
      throw new ApiError(
        400,
        'This account is not associated with Google. Please use regular login.'
      );

    return { user, accessToken: user.generateToken() };
  }

  async sendOtp(user) {
    const otpCode = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 10 * 60 * 1000); // expires in 10 minutes

    await Otp.create({
      userId: user._id,
      otp: otpCode,
      expiresAt,
    });

    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: EnvConfig.emailUsername,
        pass: EnvConfig.emailPassword,
      },
    });
    const mailOptions = {
      from: EnvConfig.emailUsername,
      to: user.email,
      subject: `🔐 Your Freshcart OTP Code`,
      html: `<body style="margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f4f4f4; text-align: center;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td align="center" style="padding: 20px;">
                <table role="presentation" width="400px" style="background-color: #ffffff; border-radius: 12px; box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); overflow: hidden; text-align: center;padding: 2px;">
                    <tr>
                        <td style="background-color: #007BFF; padding: 20px; border-radius: 12px 12px 0 0;">
                            <h2 style="color: #ffffff; margin: 0; font-size: 22px;">Your Freshcart OTP Code</h2>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 25px; text-align: center; color: #333;">
                            <p style="font-size: 16px; margin-bottom: 10px;">Hello ${user.name},</p>
                            <p style="font-size: 14px; color: #555;">Your OTP code is <b>${otpCode}</b>.</p>
                            <p style="font-size: 14px; color: #007BFF; margin-top: 10px;">Note: The OTP will expire in 10 minutes.</p>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: #f4f4f4; padding: 10px; font-size: 12px; color: #777; border-radius: 0 0 12px 12px;">
                            &copy; 2025 FreshCart. All rights reserved.
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>`,
    };
    await transporter.sendMail(mailOptions);
  }

  async verifyOtp(email, otpCode) {
    const existingUser = await User.findOne({ email });

    if (!existingUser) throw new ApiError(400, 'User not found');

    const record = await Otp.findOne({ userId: existingUser._id, otp: otpCode });

    if (!record) {
      throw new ApiError(400, 'Invalid OTP');
    }

    if (record.expiresAt < new Date()) {
      throw new ApiError(400, 'OTP expired');
    }

    await Otp.deleteOne({ _id: record._id });

    const user = await User.findByIdAndUpdate(existingUser._id, { status: 'active' });
    return { user };
  }

  async resendOtp(email) {
    const existingUser = await User.findOne({ email });

    if (!existingUser) throw new ApiError(400, 'User not found');

    const existingOtp = await Otp.findOne({ userId: existingUser._id });

    if (existingOtp && existingOtp.expiresAt > new Date())
      throw new ApiError(400, 'OTP already sent');

    await Otp.deleteOne({ _id: existingOtp?._id });
    await this.sendOtp(existingUser);

    return { message: 'OTP sent to your email. Please verify.' };
  }

  async forgotPassword(email) {
    const existingUser = await User.findOne({ email });

    if (!existingUser) throw new ApiError(400, 'User not found');

    await this.sendOtp(existingUser);

    return { message: 'OTP sent to your email. Please verify.' };
  }

  async resetPassword(email, password) {
    const existingUser = await User.findOne({ email });

    if (!existingUser) throw new ApiError(400, 'User not found');

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await User.findByIdAndUpdate(
      existingUser._id,
      { password: hashedPassword },
      { new: true }
    );
    return { user };
  }

  async changePassword(email, oldPassword, newPassword) {
    const existingUser = await User.findOne({ email });

    if (!existingUser) throw new ApiError(400, 'User not found');

    const isMatch = await existingUser.comparePassword(oldPassword);

    if (!isMatch) throw new ApiError(400, 'Old password is incorrect');

    const hashedPassword = await bcrypt.hash(newPassword, 10);

    await User.findByIdAndUpdate(existingUser._id, { password: hashedPassword }, { new: true });
  }

  async updateProfile(userId, name, oldProfile, profile) {
    const user = await User.findById(userId);
    if (!user) throw new ApiError(404, 'User not found');

    let newProfile = oldProfile;
    if (profile) {
      newProfile = await uploadImage(profile);
    }

    const updatedUser = await User.findByIdAndUpdate(
      userId,
      { name, profile: newProfile },
      { new: true }
    );

    if (!updatedUser) throw new ApiError(400, 'Profile update failed');

    return { updatedUser };
  }
}

export default new AuthService();
