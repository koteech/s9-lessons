# drop TABLE cdm.user_category_counters;
# CREATE TABLE IF NOT EXISTS cdm.user_category_counters (
#     id SERIAL PRIMARY KEY,
#     user_id uuid NOT NULL,
#     category_id uuid NOT NULL,
#     category_name VARCHAR(255) NOT NULL,
#     order_cnt INT NOT NULL CHECK (order_cnt >= 0),
#     UNIQUE (user_id, category_id)
# );
