import express from 'express';
// Controller se functions import karein (Extension .js lazmi hai)
import { registerUser, loginUser, refreshAccessToken } from '../controllers/authController.js';

const router = express.Router();

// Routes definition
router.post('/register', registerUser);
router.post('/login', loginUser);

// Refresh token route (Jo humne pehle discuss kiya tha)
router.post('/refresh-token', refreshAccessToken);

export default router;