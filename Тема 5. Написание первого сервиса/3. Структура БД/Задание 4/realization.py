# drop TABLE stg.order_events;
# CREATE TABLE IF NOT EXISTS stg.order_events (
#     id SERIAL PRIMARY KEY,
#     object_id INT UNIQUE NOT NULL,
#     payload json NOT NULL,
#     object_type VARCHAR(100) NOT NULL,
#     sent_dttm TIMESTAMP NOT NULL
# );
#
