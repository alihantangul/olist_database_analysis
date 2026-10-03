/* Run on an empty PostgreSQL database before import_data.sql. */

CREATE TABLE geo_location (
    geo_id BIGSERIAL PRIMARY KEY,
    zipcode INTEGER NOT NULL,
    latitude NUMERIC,
    longitude NUMERIC,
    city VARCHAR(100),
    geostate CHAR(2)
);

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zipcode INTEGER,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zipcode INTEGER,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category VARCHAR(100),
    product_name_length INTEGER,
    product_desc_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_grams INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL REFERENCES customers(customer_id),
    order_status VARCHAR(50),
    order_purchase TIMESTAMP,
    order_approved TIMESTAMP,
    order_delivered_carrier TIMESTAMP,
    order_delivered_customer TIMESTAMP,
    order_estimated_delivery TIMESTAMP
);

CREATE TABLE order_payments (
    order_id VARCHAR(50) NOT NULL REFERENCES orders(order_id),
    payment_sequential INTEGER NOT NULL,
    payment_type VARCHAR(20),
    payment_installments INTEGER,
    payment_value NUMERIC(12, 2),
    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE order_reviews (
    review_id VARCHAR(50) NOT NULL,
    order_id VARCHAR(50) NOT NULL REFERENCES orders(order_id),
    review_score INTEGER,
    review_title TEXT,
    review_comment TEXT,
    review_create TIMESTAMP,
    review_answer TIMESTAMP,
    PRIMARY KEY (review_id, order_id)
);

CREATE TABLE order_items (
    order_id VARCHAR(50) NOT NULL REFERENCES orders(order_id),
    order_item_id INTEGER NOT NULL,
    product_id VARCHAR(50) REFERENCES products(product_id),
    seller_id VARCHAR(50) REFERENCES sellers(seller_id),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(12, 2),
    freight_value NUMERIC(12, 2),
    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE product_translation (
    category VARCHAR(100) PRIMARY KEY,
    category_translation VARCHAR(100)
);
