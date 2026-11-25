const express = require('express');
const pool = require('../config/db');
const { verifyToken, isAdmin } = require('../middleware/authMiddleware');

const router = express.Router();

// PHẦN DANH MỤC - CATEGORIES

// Lấy tất cả danh mục: GET /api/products/categories/all
router.get('/categories/all', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM product_catalog.categories ORDER BY category_id ASC'
    );
    res.json(result.rows);
  } catch (error) {
    console.error('Lỗi lấy danh mục:', error);
    res.status(500).json({ message: 'Server gặp lỗi khi đang lấy danh mục !!!' });
  }
});

// Thêm danh mục mới (Chỉ ADMIN): POST /api/products/categories
router.post('/categories', verifyToken, isAdmin, async (req, res) => {
  const { name } = req.body;
  if (!name) return res.status(400).json({ message: 'Tên danh mục không được để trống !!!' });

  try {
    const result = await pool.query(
      'INSERT INTO product_catalog.categories (name) VALUES ($1) RETURNING *',
      [name]
    );
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Lỗi thêm danh mục:', error);
    res.status(500).json({ message: 'Server gặp lỗi khi đang thêm danh mục !!!' });
  }
});

// PHẦN SẢN PHẨM - PRODUCTS

// Lấy danh sách sản phẩm (hỗ trợ lọc theo loại da, mức mụn, danh mục, từ khóa)
// VD: GET /api/products?skin_type=Oily&acne_level=Level_1
router.get('/', async (req, res) => {
  const { skin_type, acne_level, category_id, search } = req.query;

  try {
    let query = `
      SELECT p.*, c.name AS category_name
      FROM product_catalog.products p
      LEFT JOIN product_catalog.categories c ON p.category_id = c.category_id
      WHERE 1=1
    `;
    const values = [];
    let paramIndex = 1;

    if (skin_type) {
      query += ` AND (p.target_skin_type ILIKE $${paramIndex} OR p.target_skin_type ILIKE 'All')`;
      values.push(skin_type);
      paramIndex++;
    }

    if (acne_level) {
      query += ` AND p.target_acne_level ILIKE $${paramIndex}`;
      values.push(acne_level);
      paramIndex++;
    }

    if (category_id) {
      query += ` AND p.category_id = $${paramIndex}`;
      values.push(category_id);
      paramIndex++;
    }

    if (search) {
      query += ` AND p.name ILIKE $${paramIndex}`;
      values.push(`%${search}%`);
      paramIndex++;
    }

    query += ' ORDER BY p.product_id DESC';

    const result = await pool.query(query, values);
    res.json(result.rows);
  } catch (error) {
    console.error('Lỗi lấy danh sách sản phẩm:', error);
    res.status(500).json({ message: 'Server gặp lỗi khi đang lấy danh sách sản phẩm !!!' });
  }
});

// Lấy chi tiết 1 sản phẩm: GET /api/products/:id
router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT p.*, c.name AS category_name
       FROM product_catalog.products p
       LEFT JOIN product_catalog.categories c ON p.category_id = c.category_id
       WHERE p.product_id = $1`,
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Không tìm thấy sản phẩm nào !!!' });
    }
    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ message: 'Server gặp lỗi khi đang lấy chi tiết sản phẩm !!!' });
  }
});

// Thêm sản phẩm mới (Quyền Của Admin): POST /api/products
router.post('/', verifyToken, isAdmin, async (req, res) => {
  const { category_id, name, price, stock, image_url, target_skin_type, target_acne_level } = req.body;

  if (!name || price === undefined) {
    return res.status(400).json({ message: 'Tên sản phẩm và giá bán là yêu cầu bắt buộc !!!' });
  }

  try {
    const result = await pool.query(
      `INSERT INTO product_catalog.products
       (category_id, name, price, stock, image_url, target_skin_type, target_acne_level)
       VALUES ($1, $2, $3, $4, $5, $6, $7)
       RETURNING *`,
      [
        category_id || null,
        name,
        price,
        stock || 0,
        image_url || null,
        target_skin_type || 'All',
        target_acne_level || 'Level_0',
      ]
    );
    res.status(201).json({
      message: 'Thêm sản phẩm thành công !!!',
      product: result.rows[0],
    });
  } catch (error) {
    console.error('Lỗi thêm sản phẩm:', error);
    res.status(500).json({ message: 'Server gặp lỗi khi đang thêm sản phẩm !!!' });
  }
});

// 4. Cập nhật sản phẩm (Chỉ ADMIN): PUT /api/products/:id
router.put('/:id', verifyToken, isAdmin, async (req, res) => {
  const { category_id, name, price, stock, image_url, target_skin_type, target_acne_level } = req.body;

  try {
    const result = await pool.query(
      `UPDATE product_catalog.products
       SET category_id = COALESCE($1, category_id),
           name = COALESCE($2, name),
           price = COALESCE($3, price),
           stock = COALESCE($4, stock),
           image_url = COALESCE($5, image_url),
           target_skin_type = COALESCE($6, target_skin_type),
           target_acne_level = COALESCE($7, target_acne_level)
       WHERE product_id = $8
       RETURNING *`,
      [category_id, name, price, stock, image_url, target_skin_type, target_acne_level, req.params.id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Không tìm thấy sản phẩm nào để cập nhật !!!' });
    }

    res.json({
      message: 'Cập nhật sản phẩm thành công !!!',
      product: result.rows[0],
    });
  } catch (error) {
    console.error('Lỗi cập nhật sản phẩm:', error);
    res.status(500).json({ message: 'Server gặp lỗi khi đang cập nhật sản phẩm !!!' });
  }
});

// 5. Xóa sản phẩm (Chỉ ADMIN): DELETE /api/products/:id
router.delete('/:id', verifyToken, isAdmin, async (req, res) => {
  try {
    const result = await pool.query(
      'DELETE FROM product_catalog.products WHERE product_id = $1 RETURNING product_id',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Không tìm thấy sản phẩm để xóa !!!' });
    }
    res.json({ message: 'Xóa sản phẩm thành công !!!' });
  } catch (error) {
    console.error('Lỗi xóa sản phẩm:', error);
    res.status(500).json({ message: 'Server gặp lỗi khi đang xóa sản phẩm !!!' });
  }
});

module.exports = router;