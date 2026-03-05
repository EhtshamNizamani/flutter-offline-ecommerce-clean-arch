const express = require('express');
const app = express();

// Middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
// app.use('/api/users', require('./routes/userRoutes'));
// app.use('/api/products', require('./routes/productRoutes'));

// Error handling middleware
// app.use(require('./middlewares/errorHandler'));

module.exports = app;
