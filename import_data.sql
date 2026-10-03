/*
Run with psql from the repository root:
psql -U postgres -d olist -f import_data.sql
*/

\copy geo_location(zipcode, latitude, longitude, city, geostate) FROM 'olist_data/olist_geolocation_dataset.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy customers(customer_id, customer_unique_id, customer_zipcode, customer_city, customer_state) FROM 'olist_data/olist_customers_dataset.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy sellers(seller_id, seller_zipcode, seller_city, seller_state) FROM 'olist_data/olist_sellers_dataset.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy products(product_id, product_category, product_name_length, product_desc_length, product_photos_qty, product_weight_grams, product_length_cm, product_height_cm, product_width_cm) FROM 'olist_data/olist_products_dataset.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy orders(order_id, customer_id, order_status, order_purchase, order_approved, order_delivered_carrier, order_delivered_customer, order_estimated_delivery) FROM 'olist_data/olist_orders_dataset.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy order_payments(order_id, payment_sequential, payment_type, payment_installments, payment_value) FROM 'olist_data/olist_order_payments_dataset.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy order_reviews(review_id, order_id, review_score, review_title, review_comment, review_create, review_answer) FROM 'olist_data/olist_order_reviews_dataset.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy order_items(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value) FROM 'olist_data/olist_order_items_dataset.csv' WITH (FORMAT CSV, HEADER TRUE);

\copy product_translation(category, category_translation) FROM 'olist_data/product_category_name_translation.csv' WITH (FORMAT CSV, HEADER TRUE);
