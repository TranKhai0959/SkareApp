const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const pool = require('./config/db');
const authRoutes = require('./routes/authRoutes');
const productRoutes = require('./routes/productRoutes');

const app = express();
const PORT = process.env.PORT || 1911;

// Middlewares
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Kiểm tra trạng thái server & database
app.get('/', async (req, res) => {
  try {
    const dbCheck = await pool.query('SELECT NOW()');
    res.json({
      status: 'OK',
      message: 'SkareApp Backend API đang hoạt động tốt !!!',
      db_time: dbCheck.rows[0].now,
    });
  } catch (error) {
    res.status(500).json({ status: 'ERROR', message: 'Không kết nối được đến Database, vui lòng kiểm tra lại hệ thống !!!' });
  }
});

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/products', productRoutes);

// Khởi động server
app.listen(PORT, () => {
  console.log(`Server đang được chạy tại: http://localhost:${PORT}`);
});