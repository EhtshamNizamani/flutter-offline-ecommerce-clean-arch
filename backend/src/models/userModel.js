import mongoose from 'mongoose';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  refreshToken: { type: String },
}, { timestamps: true });

// Corrected pre-save hook for ESM and Async/Await
userSchema.pre('save', async function () {
  // Agar password modify nahi hua (jaise login ke waqt refresh token save ho raha ho)
  if (!this.isModified('password')) return;

  // Agar password naya hai ya change hua hai
  try {
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
  } catch (error) {
    throw error;
  }
});

userSchema.methods.isPasswordCorrect = async function (password) {
  return await bcrypt.compare(password, this.password);
};

userSchema.methods.generateAccessToken = function () {
  return jwt.sign(
    { id: this._id }, 
    process.env.ACCESS_TOKEN_SECRET, 
    { expiresIn: '15m' }
  );
};

userSchema.methods.generateRefreshToken = function () {
  return jwt.sign(
    { id: this._id }, 
    process.env.REFRESH_TOKEN_SECRET, 
    { expiresIn: '7d' }
  );
};

export const User = mongoose.model('User', userSchema);