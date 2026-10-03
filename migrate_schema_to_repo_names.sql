BEGIN;

ALTER TABLE geolocation RENAME TO geo_location;
ALTER TABLE geo_location RENAME COLUMN geolocation_zip_code_prefix TO zipcode;
ALTER TABLE geo_location RENAME COLUMN geolocation_lat TO latitude;
ALTER TABLE geo_location RENAME COLUMN geolocation_lng TO longitude;
ALTER TABLE geo_location RENAME COLUMN geolocation_city TO city;
ALTER TABLE geo_location RENAME COLUMN geolocation_state TO geostate;
ALTER TABLE geo_location ADD COLUMN geo_id BIGSERIAL;
ALTER TABLE geo_location ADD CONSTRAINT geo_location_pkey PRIMARY KEY (geo_id);

ALTER TABLE customers RENAME COLUMN customer_zip_code_prefix TO customer_zipcode;
ALTER TABLE sellers RENAME COLUMN seller_zip_code_prefix TO seller_zipcode;

ALTER TABLE products RENAME COLUMN product_category_name TO product_category;
ALTER TABLE products RENAME COLUMN product_name_lenght TO product_name_length;
ALTER TABLE products RENAME COLUMN product_description_lenght TO product_desc_length;
ALTER TABLE products RENAME COLUMN product_weight_g TO product_weight_grams;

ALTER TABLE orders RENAME COLUMN order_purchase_timestamp TO order_purchase;
ALTER TABLE orders RENAME COLUMN order_approved_at TO order_approved;
ALTER TABLE orders RENAME COLUMN order_delivered_carrier_date TO order_delivered_carrier;
ALTER TABLE orders RENAME COLUMN order_delivered_customer_date TO order_delivered_customer;
ALTER TABLE orders RENAME COLUMN order_estimated_delivery_date TO order_estimated_delivery;

ALTER TABLE order_reviews RENAME COLUMN review_comment_title TO review_title;
ALTER TABLE order_reviews RENAME COLUMN review_comment_message TO review_comment;
ALTER TABLE order_reviews RENAME COLUMN review_creation_date TO review_create;
ALTER TABLE order_reviews RENAME COLUMN review_answer_timestamp TO review_answer;
ALTER TABLE order_reviews
    ADD CONSTRAINT order_reviews_pkey PRIMARY KEY (review_id, order_id);

ALTER TABLE order_payments
    ADD CONSTRAINT order_payments_pkey PRIMARY KEY (order_id, payment_sequential);

ALTER TABLE product_category_name_translation RENAME TO product_translation;
ALTER TABLE product_translation RENAME COLUMN product_category_name TO category;
ALTER TABLE product_translation RENAME COLUMN product_category_name_english TO category_translation;
ALTER TABLE product_translation
    ADD CONSTRAINT product_translation_pkey PRIMARY KEY (category);

COMMIT;
