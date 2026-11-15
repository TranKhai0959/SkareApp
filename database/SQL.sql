CREATE schema users_management;
CREATE schema ai_analysis;
CREATE schema product_catalog;
CREATE schema sales_management;

CREATE TABLE users_management.users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) DEFAULT 'CUSTOMER', -- 'CUSTOMER' hoặc 'ADMIN'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_catalog.categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE product_catalog.products (
    product_id SERIAL PRIMARY KEY,
    category_id INT REFERENCES product_catalog.categories(category_id) ON DELETE SET NULL,
    name VARCHAR(150) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    stock INT DEFAULT 0,
    image_url VARCHAR(255),
    target_skin_type VARCHAR(50), -- VD: 'Oily', 'Dry', 'Normal', 'All'
    target_acne_level VARCHAR(20), -- VD: 'Level_0', 'Level_1', 'Level_2'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ai_analysis.skin_analysis_history (
    analysis_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users_management.users(user_id) ON DELETE CASCADE,
    image_url VARCHAR(255) NOT NULL,
    skin_type VARCHAR(50) NOT NULL,
    acne_level VARCHAR(20) NOT NULL,
    advice_text TEXT,
    analyzed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales_management.cart_items (
    cart_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users_management.users(user_id) ON DELETE CASCADE,
    product_id INT REFERENCES product_catalog.products(product_id) ON DELETE CASCADE,
    quantity INT DEFAULT 1 CHECK (quantity > 0)
);

CREATE TABLE sales_management.orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users_management.users(user_id) ON DELETE CASCADE,
    total_amount DECIMAL(12, 2) NOT NULL,
    address TEXT NOT NULL,
    status VARCHAR(30) DEFAULT 'PENDING', -- PENDING, SHIPPING, DELIVERED, CANCELLED
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales_management.order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES sales_management.orders(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES product_catalog.products(product_id) ON DELETE SET NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(12, 2) NOT NULL
);