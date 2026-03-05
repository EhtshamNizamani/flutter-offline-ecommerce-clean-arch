const User = require('../models/userModel');
const ApiError = require('../utils/apiError');

exports.register = async (req, res, next) => {
  try {
    const { name, email, password } = req.body;
    
    const existingUser = await User.findOne({ email });
    if (existingUser) throw new ApiError(400, "User already exists");

    const user = await User.create({ name, email, password });
    
    res.status(201).json({ success: true, message: "User registered successfully" });
  } catch (error) {
    next(error); // Global error handler ko bhej do
  }
};

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user || !(await bcrypt.compare(password, user.password))) {
      throw new ApiError(401, "Invalid credentials");
    }

    const accessToken = user.generateAccessToken();
    const refreshToken = user.generateRefreshToken();

    // Save refresh token in DB
    user.refreshToken = refreshToken;
    await user.save();

    res.status(200).json({
      success: true,
      accessToken,
      refreshToken,
      user: { id: user._id, name: user.name, email: user.email }
    });
  } catch (error) {
    next(error);
  }
};