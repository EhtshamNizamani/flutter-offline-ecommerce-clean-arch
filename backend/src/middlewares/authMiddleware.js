import jwt from 'jsonwebtoken';
import ApiError from '../utils/apiError.js';
import { User } from '../models/userModel.js';

export const protect = async (req, res, next) => {
  try {
    let token;
    if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
      token = req.headers.authorization.split(' ')[1];
    }

    if (!token) throw new ApiError(401, "Not authorized, no token");

    const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
    req.user = await User.findById(decoded.id).select('-password');
    next();
  } catch (error) {
    next(new ApiError(401, "Token failed"));
  }
};