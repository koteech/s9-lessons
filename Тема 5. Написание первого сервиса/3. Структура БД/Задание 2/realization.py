# drop TABLE cdm.user_product_counters;
# CREATE TABLE IF NOT EXISTS cdm.user_product_counters (
#     id SERIAL PRIMARY KEY,
#     user_id uuid NOT NULL,
#     product_id uuid NOT NULL,
#     product_name VARCHAR(255) NOT NULL,
#     order_cnt INT NOT NULL CHECK (order_cnt >= 0),
#     UNIQUE (user_id, product_id)
# );