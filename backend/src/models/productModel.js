import mongoose from 'mongoose';

const productSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true },
  description: { type: String, required: true },
  price: { type: Number, required: true },
  oldPrice: { type: Number }, // Discount dikhane ke liye
  category: { type: String, required: true },
  image: { type: String, required: true }, // URL save karenge
  stock: { type: Number, required: true, default: 0 },
  rating: { type: Number, default: 0 },
  numReviews: { type: Number, default: 0 }
}, { timestamps: true });

export const Product = mongoose.model('Product', productSchema);