import ApiError from '../../core/utils/api_error.util.js';
import uploadImage, { removeImageFromCloudinary } from '../../core/utils/cloudinary.util.js';
import User from '../../core/models/user.model.js';

class UserService {
  async addUser(data, filePath) {
    // Check if user already exists
    const existingUser = await User.findOne({ email: data.email });
    if (existingUser) throw new ApiError(400, 'User with this email already exists');

    let imageUrl = '';
    if (filePath) {
      imageUrl = await uploadImage(filePath);
    }

    const user = await User.create({
      ...data,
      profile: imageUrl,
    });

    if (!user) throw new ApiError(400, 'Failed to add user');

    return user;
  }

  async getAllUsers() {
    const users = await User.find().select('-password');
    return users;
  }

  async updateUser(userId, data, filePath) {
    const user = await User.findById(userId);
    if (!user) throw new ApiError(404, 'User not found');

    let imageUrl = user.profile;
    if (filePath) {
      if (user.profile) {
        await removeImageFromCloudinary(user.profile);
      }
      imageUrl = await uploadImage(filePath);
    }

    const updated = await User.findByIdAndUpdate(
      userId,
      { ...data, profile: imageUrl },
      { new: true }
    ).select('-password');

    if (!updated) throw new ApiError(404, 'User not found');

    return updated;
  }

  async deleteUser(userId) {
    const user = await User.findById(userId);
    if (!user) throw new ApiError(404, 'User not found');

    // Remove profile image from cloudinary if exists
    if (user.profile) {
      await removeImageFromCloudinary(user.profile);
    }

    await User.findByIdAndDelete(userId);
    return;
  }

  async getUserById(userId) {
    const user = await User.findById(userId).select('-password');
    if (!user) throw new ApiError(404, 'User not found');
    return user;
  }
}

export default new UserService();
