DROP TABLE IF EXISTS cdm.user_product_counters;
DROP TABLE IF EXISTS cdm.user_category_counters;

create table if not exists cdm.user_product_counters
(
    id           serial
        primary key,
    user_id      uuid         not null,
    product_id   uuid         not null,
    product_name varchar(255) not null,
    order_cnt    integer      not null
        constraint user_product_counters_order_cnt_check
            check (order_cnt >= 0),
    constraint unique_user_product
        unique (user_id, product_id)
);

create table if not exists cdm.user_category_counters
(
    id            serial
        primary key,
    user_id       uuid         not null,
    category_id   uuid         not null,
    category_name varchar(255) not null,
    order_cnt     integer      not null
        constraint user_category_counters_order_cnt_check
            check (order_cnt >= 0),
    constraint unique_user_category
        unique (user_id, category_id)
);



DROP TABLE IF EXISTS dds.s_order_status;
DROP TABLE IF EXISTS dds.s_order_cost;
DROP TABLE IF EXISTS dds.s_restaurant_names;
DROP TABLE IF EXISTS dds.s_product_names;
DROP TABLE IF EXISTS dds.s_user_names;
DROP TABLE IF EXISTS dds.l_order_user;
DROP TABLE IF EXISTS dds.l_product_category;
DROP TABLE IF EXISTS dds.l_product_restaurant;
DROP TABLE IF EXISTS dds.l_order_product;
DROP TABLE IF EXISTS dds.h_order;
DROP TABLE IF EXISTS dds.h_restaurant;
DROP TABLE IF EXISTS dds.h_category;
DROP TABLE IF EXISTS dds.h_product;
DROP TABLE IF EXISTS dds.h_user;

CREATE TABLE IF NOT EXISTS dds.h_user (
    h_user_pk uuid NOT NULL PRIMARY KEY,
    user_id   varchar(255) NOT NULL,
    load_dt   timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    load_src  varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS dds.h_product (
    h_product_pk uuid NOT NULL PRIMARY KEY,
    product_id   varchar(255) NOT NULL,
    load_dt      timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    load_src     varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS dds.h_category (
    h_category_pk uuid NOT NULL PRIMARY KEY,
    category_name varchar NOT NULL,
    load_dt       timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    load_src      varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS dds.h_restaurant (
    h_restaurant_pk uuid NOT NULL PRIMARY KEY,
    restaurant_id   varchar NOT NULL,
    load_dt         timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    load_src        varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS dds.h_order (
    h_order_pk uuid NOT NULL PRIMARY KEY,
    order_id   integer NOT NULL,
    order_dt   timestamp NOT NULL,
    load_dt    timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
    load_src   varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS dds.l_order_product (
    hk_order_product_pk uuid NOT NULL PRIMARY KEY,
    h_order_pk          uuid NOT NULL REFERENCES dds.h_order(h_order_pk),
    h_product_pk        uuid NOT NULL REFERENCES dds.h_product(h_product_pk),
    load_dt             timestamp NOT NULL,
    load_src            varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS dds.l_product_restaurant (
    hk_product_restaurant_pk uuid NOT NULL PRIMARY KEY,
    h_product_pk             uuid NOT NULL REFERENCES dds.h_product(h_product_pk),
    h_restaurant_pk          uuid NOT NULL REFERENCES dds.h_restaurant(h_restaurant_pk),
    load_dt                  timestamp NOT NULL,
    load_src                 varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS dds.l_product_category (
    hk_product_category_pk uuid NOT NULL PRIMARY KEY,
    h_product_pk           uuid NOT NULL REFERENCES dds.h_product(h_product_pk),
    h_category_pk          uuid NOT NULL REFERENCES dds.h_category(h_category_pk),
    load_dt                timestamp NOT NULL,
    load_src               varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS dds.l_order_user (
    hk_order_user_pk uuid NOT NULL PRIMARY KEY,
    h_order_pk       uuid NOT NULL REFERENCES dds.h_order(h_order_pk),
    h_user_pk        uuid NOT NULL REFERENCES dds.h_user(h_user_pk),
    load_dt          timestamp NOT NULL,
    load_src         varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS dds.s_user_names (
    h_user_pk              uuid NOT NULL REFERENCES dds.h_user(h_user_pk),
    username               varchar NOT NULL,
    userlogin              varchar NOT NULL,
    load_dt                timestamp NOT NULL,
    load_src               varchar NOT NULL,
    hk_user_names_hashdiff uuid NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS dds.s_product_names (
    h_product_pk              uuid NOT NULL REFERENCES dds.h_product(h_product_pk),
    name                      varchar NOT NULL,
    load_dt                   timestamp NOT NULL,
    load_src                  varchar NOT NULL,
    hk_product_names_hashdiff uuid NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS dds.s_restaurant_names (
    h_restaurant_pk              uuid NOT NULL REFERENCES dds.h_restaurant(h_restaurant_pk),
    name                         varchar NOT NULL,
    load_dt                      timestamp NOT NULL,
    load_src                     varchar NOT NULL,
    hk_restaurant_names_hashdiff uuid NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS dds.s_order_cost (
    h_order_pk             uuid NOT NULL REFERENCES dds.h_order(h_order_pk),
    cost                   numeric(19, 5) NOT NULL CONSTRAINT s_order_cost_cost_check CHECK (cost >= (0)::numeric),
    payment                numeric(19, 5) NOT NULL CONSTRAINT s_order_cost_payment_check CHECK (payment >= (0)::numeric),
    load_dt                timestamp NOT NULL,
    load_src               varchar NOT NULL,
    hk_order_cost_hashdiff uuid NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS dds.s_order_status (
    h_order_pk               uuid NOT NULL REFERENCES dds.h_order(h_order_pk),
    status                   varchar NOT NULL,
    load_dt                  timestamp NOT NULL,
    load_src                 varchar NOT NULL,
    hk_order_status_hashdiff uuid NOT NULL PRIMARY KEY
);
drop table if exists stg.order_events;
create table if not exists stg.order_events
(
    id          serial
        primary key,
    object_id   integer      not null
        constraint unique_object_id
            unique,
    payload     json         not null,
    object_type varchar(255) not null,
    sent_dttm   timestamp    not null
);