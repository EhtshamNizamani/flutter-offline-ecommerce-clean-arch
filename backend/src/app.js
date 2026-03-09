import express from 'express';

const app = express();

// Middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
// import userRoutes from './routes/userRoutes.js';
// import productRoutes from './routes/productRoutes.js';
// app.use('/api/users', userRoutes);
// app.use('/api/products', productRoutes);

// Error handling middleware
// import errorMiddleware from './middlewares/errorMiddleware.js';
// app.use(errorMiddleware);

export default app;
