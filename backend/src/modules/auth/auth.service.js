import User from '../../core/models/user.model.js';
import ApiError from '../../core/utils/api_error.util.js';

class AuthService {
  async signup(data) {
    const { name, email, password } = data;
    const existingUser = await User.findOne({ email });

    if (existingUser) throw new ApiError(400, 'User already exists');

    const user = await User.create({ name, email, password });

    if (!user) throw new ApiError(400, 'User creation failed');

    return user;
  }

  async login(data) {
    const { email, password } = data;
    const user = await User.findOne({ email });

    if (!user) throw new ApiError(400, 'User not found');

    const isMatch = await user.comparePassword(password);

    if (!isMatch) throw new ApiError(400, 'Invalid credentials');

    const accessToken = user.generateToken();

    return { user, accessToken };
  }
}

export default new AuthService();
