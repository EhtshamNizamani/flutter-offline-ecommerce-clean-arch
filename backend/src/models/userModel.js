const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  refreshToken: { type: String }, // Refresh token store karne ke liye
}, { timestamps: true });

// Password hash karne ka logic before saving
userSchema.pre('save', async function(next) {
  if (!this.isModified('password')) return next();
  this.password = await bcrypt.hash(this.password, 10);
});

// Methods to generate tokens
userSchema.methods.generateAccessToken = function() {
  return jwt.sign({ id: this._id }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15m' });
};

userSchema.methods.generateRefreshToken = function() {
  return jwt.sign({ id: this._id }, process.env.REFRESH_TOKEN_SECRET, { expiresIn: '7d' });
};

module.exports = mongoose.model('User', userSchema);