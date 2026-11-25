const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false,
    // Tắt để khi kết nối đến Neon tránh bị chèn chứng chỉ trung gian dẫn đến việc báo lỗi "self-signed certificate in certificate chain"
  },
});

pool.on('connect', () => {
  console.log('Kết nối đến Neon PostgreSQL thành công !!!');
});

pool.on('error', (err) => {
  console.error('Lỗi kết nối đến PostgreSQL:', err);
});

module.exports = pool;