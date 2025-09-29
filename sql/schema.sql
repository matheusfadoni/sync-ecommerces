-- =========================
-- category_map
-- =========================
CREATE TABLE category_map (
    id INT AUTO_INCREMENT PRIMARY KEY,
    br_cat_id INT NULL UNIQUE,
    py_cat_id INT NULL UNIQUE,
    br_name VARCHAR(255),
    py_name VARCHAR(255),
    br_slug VARCHAR(255),
    py_slug VARCHAR(255),
    match_type ENUM('exact','manual','pending') DEFAULT 'pending',
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_synced_at TIMESTAMP NULL,
    INDEX idx_match_type (match_type),
    INDEX idx_is_active (is_active)
);

-- =========================
-- brand_map
-- =========================
CREATE TABLE brand_map (
    id INT AUTO_INCREMENT PRIMARY KEY,
    br_brand_id INT NULL UNIQUE,
    py_brand_id INT NULL UNIQUE,
    br_name VARCHAR(255),
    py_name VARCHAR(255),
    br_slug VARCHAR(255),
    py_slug VARCHAR(255),
    match_type ENUM('exact','manual','pending') DEFAULT 'pending',
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_synced_at TIMESTAMP NULL,
    INDEX idx_match_type (match_type),
    INDEX idx_is_active (is_active)
);

-- =========================
-- product_map
-- =========================
CREATE TABLE product_map (
    id INT AUTO_INCREMENT PRIMARY KEY,
    br_product_id INT NULL UNIQUE,
    py_product_id INT NULL UNIQUE,
    sku VARCHAR(255) NULL UNIQUE,
    brand_map_id INT NULL,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_synced_at TIMESTAMP NULL,
    INDEX idx_sku (sku),
    CONSTRAINT fk_product_brand FOREIGN KEY (brand_map_id) REFERENCES brand_map(id)
);

-- =========================
-- product_category_map
-- =========================
CREATE TABLE product_category_map (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_map_id INT NOT NULL,
    category_map_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_synced_at TIMESTAMP NULL,
    CONSTRAINT fk_pc_product FOREIGN KEY (product_map_id) REFERENCES product_map(id),
    CONSTRAINT fk_pc_category FOREIGN KEY (category_map_id) REFERENCES category_map(id)
);

-- =========================
-- sync_log
-- =========================
CREATE TABLE sync_log (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    entity ENUM('category','brand','product','photo') NOT NULL,
    entity_id INT NOT NULL,
    action ENUM('insert','update','skip','error') NOT NULL,
    site_origin ENUM('PY','BR','SYSTEM') NOT NULL,
    photo_type ENUM('brand','product') NULL,
    old_value JSON NULL,
    new_value JSON NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_entity (entity, entity_id, timestamp)
);
