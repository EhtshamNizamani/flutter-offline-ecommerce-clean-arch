import { Product } from '../models/productModel.js';
import ApiError from '../utils/apiError.js';

// --- Get All Products ---
export const getProducts = async (req, res, next) => {
  try {
    const { category, search } = req.query;
    let query = {};

    // Filter by Category
    if (category) query.category = category;
    
    // Search logic
    if (search) query.name = { $regex: search, $options: 'i' };

    const products = await Product.find(query);
    
    res.status(200).json({
      success: true,
      count: products.length,
      products
    });
  } catch (error) {
    next(error);
  }
};

// --- Get Single Product ---
export const getProductById = async (req, res, next) => {
  try {
    const product = await Product.findById(req.params.id);
    if (!product) throw new ApiError(404, "Product not found");

    res.status(200).json({ success: true, product });
  } catch (error) {
    next(error);
  }
};

// --- Add Product (Testing ke liye data daalne ke liye) ---
export const createProduct = async (req, res, next) => {
    try {
      const product = await Product.create(req.body);
      res.status(201).json({ success: true, product });
    } catch (error) {
      next(error);
    }
  };