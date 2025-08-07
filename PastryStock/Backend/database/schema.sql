-- PastryStock Database Schema
-- Firebase Realtime Database SQL Equivalent

-- Users
-- PastryStock Database Schema
-- Firebase Realtime Database SQL Equivalent

-- Users Table
CREATE TABLE users (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Sales Table
CREATE TABLE sales (
    id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255),
    menu_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_per_item DECIMAL(10,2) NOT NULL CHECK (price_per_item > 0),
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount > 0),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_sales_date (date),
    INDEX idx_sales_menu (menu_name),
    INDEX idx_sales_user (user_id)
);

-- Ingredients Table
CREATE TABLE ingredients (
    id VARCHAR(255) PRIMARY KEY,
    ingredient_name VARCHAR(255) NOT NULL UNIQUE,
    current_stock DECIMAL(10,2) NOT NULL DEFAULT 0,
    unit VARCHAR(50) NOT NULL,
    daily_consumption DECIMAL(10,2) DEFAULT 0,
    min_threshold DECIMAL(10,2) NOT NULL DEFAULT 0,
    status ENUM('sufficient', 'low', 'critical') DEFAULT 'sufficient',
    recommendation TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_ingredients_status (status),
    INDEX idx_ingredients_stock (current_stock)
);

-- Consumption History Table
CREATE TABLE consumption_history (
    id VARCHAR(255) PRIMARY KEY,
    ingredient_id VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    consumption DECIMAL(10,2) NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE,
    UNIQUE KEY unique_ingredient_date (ingredient_id, date),
    INDEX idx_consumption_date (date),
    INDEX idx_consumption_ingredient (ingredient_id)
);

-- Predictions Table
CREATE TABLE predictions (
    id VARCHAR(255) PRIMARY KEY,
    ingredient_id VARCHAR(255) NOT NULL,
    ingredient_name VARCHAR(255) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    current_stock DECIMAL(10,2) NOT NULL,
    predicted_consumption JSON NOT NULL,
    predicted_stock JSON NOT NULL,
    days_until_empty INT DEFAULT 0,
    recommended_order DECIMAL(10,2) DEFAULT 0,
    confidence DECIMAL(3,2) DEFAULT 0.00,
    model_params JSON,
    accuracy_metrics JSON,
    confidence_interval JSON,
    seasonal_component JSON,
    trend_direction ENUM('increasing', 'decreasing', 'stable') DEFAULT 'stable',
    prediction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE,
    INDEX idx_predictions_ingredient (ingredient_id),
    INDEX idx_predictions_date (prediction_date)
);

-- Menu Items Table
CREATE TABLE menu_items (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    category VARCHAR(100) DEFAULT 'pastry',
    description TEXT,
    ingredients JSON,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_menu_category (category),
    INDEX idx_menu_active (is_active)
);

-- User Sessions Table (for JWT token management)
CREATE TABLE user_sessions (
    id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    token_hash VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_sessions_user (user_id),
    INDEX idx_sessions_expires (expires_at)
);

-- Insert Default Data
INSERT INTO users (id, name, email, password_hash, role) VALUES
('admin123', 'Admin User', 'admin@pastrystock.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/RK.PmvlG.', 'admin'),
('user123', 'Demo User', 'demo@pastrystock.com', '$2b$12$z0d6my4FAprjSKWNnibBsOC4.dOxXLkfHrhvzmDSmL61A12QCCBei', 'user');

INSERT INTO menu_items (id, name, price, category, description) VALUES
('menu001', 'Muffin', 20000.00, 'pastry', 'Delicious chocolate muffin'),
('menu002', 'Mini Muffin', 15000.00, 'pastry', 'Small sized muffin'),
('menu003', 'Cheesecake', 35000.00, 'cake', 'Creamy cheesecake slice'),
('menu004', 'Sable Cookies', 25000.00, 'cookies', 'Buttery sable cookies'),
('menu005', 'Croissant', 18000.00, 'pastry', 'Flaky butter croissant');

INSERT INTO ingredients (id, ingredient_name, current_stock, unit, daily_consumption, min_threshold, status) VALUES
('ing001', 'Keju', 500.00, 'gram', 45.00, 100.00, 'sufficient'),
('ing002', 'Susu UHT Greenfields', 2000.00, 'ml', 150.00, 500.00, 'sufficient'),
('ing003', 'Creamer', 800.00, 'gram', 60.00, 200.00, 'sufficient'),
('ing004', 'Gula', 1500.00, 'gram', 120.00, 300.00, 'sufficient'),
('ing005', 'Dark Cokelat', 300.00, 'gram', 25.00, 100.00, 'sufficient'),
('ing006', 'Yogurt', 1000.00, 'gram', 80.00, 250.00, 'sufficient'),
('ing007', 'Matcha Bubuk', 200.00, 'gram', 15.00, 50.00, 'sufficient'),
('ing008', 'Earl Grey', 150.00, 'gram', 10.00, 30.00, 'sufficient');

-- Insert Sample Consumption History (last 30 days)
INSERT INTO consumption_history (id, ingredient_id, date, consumption) VALUES
-- Keju consumption
('hist001', 'ing001', '2025-01-01', 45.0),
('hist002', 'ing001', '2025-01-02', 47.0),
('hist003', 'ing001', '2025-01-03', 43.0),
('hist004', 'ing001', '2025-01-04', 46.0),
('hist005', 'ing001', '2025-01-05', 48.0),
('hist006', 'ing001', '2025-01-06', 44.0),
('hist007', 'ing001', '2025-01-07', 45.0),
-- Susu UHT consumption
('hist008', 'ing002', '2025-01-01', 150.0),
('hist009', 'ing002', '2025-01-02', 155.0),
('hist010', 'ing002', '2025-01-03', 148.0),
('hist011', 'ing002', '2025-01-04', 152.0),
('hist012', 'ing002', '2025-01-05', 160.0),
('hist013', 'ing002', '2025-01-06', 145.0),
('hist014', 'ing002', '2025-01-07', 150.0);

-- Insert Sample Sales Data
INSERT INTO sales (id, user_id, menu_name, quantity, price_per_item, total_amount, date) VALUES
('sale001', 'user123', 'Muffin', 10, 20000.00, 200000.00, '2025-01-07 10:30:00'),
('sale002', 'user123', 'Croissant', 5, 18000.00, 90000.00, '2025-01-07 11:15:00'),
('sale003', 'user123', 'Cheesecake', 3, 35000.00, 105000.00, '2025-01-07 14:20:00'),
('sale004', 'user123', 'Sable Cookies', 8, 25000.00, 200000.00, '2025-01-07 16:45:00'),
('sale005', 'user123', 'Mini Muffin', 15, 15000.00, 225000.00, '2025-01-06 09:30:00'),
('sale006', 'user123', 'Muffin', 12, 20000.00, 240000.00, '2025-01-06 13:20:00'),
('sale007', 'user123', 'Croissant', 7, 18000.00, 126000.00, '2025-01-06 15:10:00');

-- Create Views for Common Queries
CREATE VIEW daily_sales_summary AS
SELECT 
    DATE(date) as sale_date,
    COUNT(*) as total_transactions,
    SUM(quantity) as total_items_sold,
    SUM(total_amount) as total_revenue,
    AVG(total_amount) as avg_transaction_value
FROM sales 
GROUP BY DATE(date)
ORDER BY sale_date DESC;

CREATE VIEW low_stock_ingredients AS
SELECT 
    id,
    ingredient_name,
    current_stock,
    unit,
    min_threshold,
    ROUND((current_stock / daily_consumption), 1) as days_remaining,
    status
FROM ingredients 
WHERE current_stock <= min_threshold OR status IN ('low', 'critical')
ORDER BY current_stock ASC;

CREATE VIEW top_selling_items AS
SELECT 
    menu_name,
    COUNT(*) as order_count,
    SUM(quantity) as total_quantity_sold,
    SUM(total_amount) as total_revenue,
    AVG(price_per_item) as avg_price
FROM sales 
WHERE date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY menu_name
ORDER BY total_revenue DESC;

-- Stored Procedures
DELIMITER //

CREATE PROCEDURE UpdateIngredientStock(
    IN p_ingredient_id VARCHAR(255),
    IN p_stock_change DECIMAL(10,2),
    IN p_operation ENUM('add', 'subtract')
)
BEGIN
    DECLARE current_stock_val DECIMAL(10,2);
    DECLARE new_stock DECIMAL(10,2);
    DECLARE min_threshold_val DECIMAL(10,2);
    DECLARE new_status VARCHAR(20);
    
    -- Get current stock and threshold
    SELECT current_stock, min_threshold 
    INTO current_stock_val, min_threshold_val
    FROM ingredients 
    WHERE id = p_ingredient_id;
    
    -- Calculate new stock
    IF p_operation = 'add' THEN
        SET new_stock = current_stock_val + p_stock_change;
    ELSE
        SET new_stock = current_stock_val - p_stock_change;
    END IF;
    
    -- Determine new status
    IF new_stock <= 0 THEN
        SET new_status = 'critical';
    ELSEIF new_stock <= min_threshold_val THEN
        SET new_status = 'low';
    ELSE
        SET new_status = 'sufficient';
    END IF;
    
    -- Update ingredient
    UPDATE ingredients 
    SET 
        current_stock = new_stock,
        status = new_status,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = p_ingredient_id;
    
END //

CREATE PROCEDURE AddDailyConsumption(
    IN p_ingredient_id VARCHAR(255),
    IN p_date DATE,
    IN p_consumption DECIMAL(10,2)
)
BEGIN
    -- Insert or update consumption history
    INSERT INTO consumption_history (id, ingredient_id, date, consumption)
    VALUES (UUID(), p_ingredient_id, p_date, p_consumption)
    ON DUPLICATE KEY UPDATE 
        consumption = p_consumption,
        created_at = CURRENT_TIMESTAMP;
    
    -- Update daily consumption average (last 7 days)
    UPDATE ingredients 
    SET daily_consumption = (
        SELECT AVG(consumption) 
        FROM consumption_history 
        WHERE ingredient_id = p_ingredient_id 
        AND date >= DATE_SUB(p_date, INTERVAL 7 DAY)
    )
    WHERE id = p_ingredient_id;
    
END //

DELIMITER ;

-- Triggers
DELIMITER //

CREATE TRIGGER update_ingredient_status 
AFTER UPDATE ON ingredients
FOR EACH ROW
BEGIN
    DECLARE recommendation_text TEXT;
    DECLARE days_remaining DECIMAL(5,1);
    
    -- Calculate days remaining
    IF NEW.daily_consumption > 0 THEN
        SET days_remaining = NEW.current_stock / NEW.daily_consumption;
    ELSE
        SET days_remaining = 999;
    END IF;
    
    -- Generate recommendation
    IF NEW.status = 'critical' THEN
        SET recommendation_text = CONCAT('URGENT: Stock critically low! Order immediately. Estimated ', ROUND(days_remaining, 1), ' days remaining.');
    ELSEIF NEW.status = 'low' THEN
        SET recommendation_text = CONCAT('Stock running low. Consider ordering soon. Estimated ', ROUND(days_remaining, 1), ' days remaining.');
    ELSE
        SET recommendation_text = CONCAT('Stock sufficient for approximately ', ROUND(days_remaining, 1), ' days.');
    END IF;
    
    -- Update recommendation
    UPDATE ingredients 
    SET recommendation = recommendation_text 
    WHERE id = NEW.id;
    
END //

CREATE TRIGGER log_sales_consumption
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    -- This would typically update ingredient consumption based on recipe
    -- For demo purposes, we'll just log the sale date
    INSERT INTO consumption_history (id, ingredient_id, date, consumption)
    SELECT 
        CONCAT('auto_', UUID()),
        'ing001', -- Keju (example)
        DATE(NEW.date),
        CASE NEW.menu_name
            WHEN 'Muffin' THEN NEW.quantity * 5.0
            WHEN 'Cheesecake' THEN NEW.quantity * 15.0
            WHEN 'Croissant' THEN NEW.quantity * 3.0
            ELSE NEW.quantity * 2.0
        END
    ON DUPLICATE KEY UPDATE 
        consumption = consumption + VALUES(consumption);
        
END //

DELIMITER ;

-- Indexes for Performance
CREATE INDEX idx_sales_date_menu ON sales(date, menu_name);
CREATE INDEX idx_consumption_ingredient_date ON consumption_history(ingredient_id, date);
CREATE INDEX idx_predictions_ingredient_date ON predictions(ingredient_id, prediction_date);
CREATE INDEX idx_ingredients_name_status ON ingredients(ingredient_name, status);

-- Full Text Search Indexes
ALTER TABLE ingredients ADD FULLTEXT(ingredient_name, recommendation);
ALTER TABLE menu_items ADD FULLTEXT(name, description);
