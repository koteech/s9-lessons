#
# drop TABLE dds.h_user;
# CREATE TABLE IF NOT EXISTS dds.h_user (
#     h_user_pk UUID PRIMARY KEY,
#     user_id VARCHAR(255),
#     load_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
#     load_src VARCHAR(100) DEFAULT 'orders-system-kafka'
# );