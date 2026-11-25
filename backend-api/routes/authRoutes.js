const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const pool = require('../config/db');
const { verifyToken } = require('../middleware/authMiddleware');

const router = express.Router();

// Đăng ký tài khoản: POST /api/auth/register
router.post('/register', async (req, res) => {
  const { full_name, email, password, phone, role } = req.body;

  if (!full_name || !email || !password) {
    return res.status(400).json({ message: 'Vui lòng nhập đầy đủ họ tên, email và mật khẩu !!!' });
  }

  try {
    // Kiểm tra email đã tồn tại trên hệ thống chưa
    const userExists = await pool.query(
      'SELECT user_id FROM users_management.users WHERE email = $1',
      [email]
    );
    if (userExists.rows.length > 0) {
      return res.status(409).json({ message: 'Email này đã được sử dụng !!!' });
    }

    // Mã hóa mật khẩu
    const salt = await bcrypt.genSalt(10);
    const password_hash = await bcrypt.hash(password, salt);

    // Mặc định role sẽ là 'CUSTOMER' nếu không quy định hoặc quy định sai
    const validRole = role === 'ADMIN' ? 'ADMIN' : 'CUSTOMER';

    const newUser = await pool.query(
      `INSERT INTO users_management.users (full_name, email, password_hash, phone, role)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING user_id, full_name, email, phone, role, created_at`,
      [full_name, email, password_hash, phone || null, validRole]
    );

    const user = newUser.rows[0];
    const token = jwt.sign(
      { user_id: user.user_id, email: user.email, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: '7d' }
    );

    res.status(201).json({
      message: 'Đăng ký tài khoản thành công !!!',
      token,
      user,
    });
  } catch (error) {
    console.error('Lỗi đăng ký:', error);
    res.status(500).json({ message: 'Server gặp lỗi khi tiến hành đăng ký tài khoản !!!' });
  }
});

// 2. Đăng nhập: POST /api/auth/login
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: 'Vui lòng nhập email và mật khẩu !!!' });
  }

  try {
    const result = await pool.query(
      'SELECT * FROM users_management.users WHERE email = $1',
      [email]
    );

    if (result.rows.length === 0) {
      return res.status(401).json({ message: 'Email hoặc mật khẩu không chính xác !!!' });
    }

    const user = result.rows[0];
    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) {
      return res.status(401).json({ message: 'Email hoặc mật khẩu không chính xác !!!' });
    }

    const token = jwt.sign(
      { user_id: user.user_id, email: user.email, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: '7d' }
    );

    // Ẩn password_hash trước khi trả về client
    delete user.password_hash;

    res.json({
      message: 'Đăng nhập thành công !!!',
      token,
      user,
    });
  } catch (error) {
    console.error('Lỗi đăng nhập:', error);
    res.status(500).json({ message: 'Server gặp lỗi khi tiến hành đăng nhập tài khoản !!!' });
  }
});

// Lấy thông tin người dùng hiện tại: GET /api/auth/me
router.get('/me', verifyToken, async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT user_id, full_name, email, phone, role, created_at FROM users_management.users WHERE user_id = $1',
      [req.user.user_id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Không tìm thấy người dùng này trên hệ thống !!!' });
    }
    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: 'Lỗi server.' });
  }
});

module.exports = router;