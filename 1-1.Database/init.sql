CREATE TABLE `product` (
    `product_id` int  NOT NULL ,
    -- http://mdr.tta.or.kr/item/1036/property/sku
    `sku` varchar(200)  NOT NULL ,
    -- Field documentation comment 3
    `name` varchar(200)  NOT NULL ,
    `price` int  NOT NULL ,
    `stock` int  NOT NULL ,
    `factory_id` int  NOT NULL ,
    `pending` boolean NOT NULL,
    PRIMARY KEY (
        `product_id`
    ),
    CONSTRAINT `uc_product_sku` UNIQUE (
        `sku`
    ),
    CONSTRAINT `uc_product_name` UNIQUE (
        `name`
    )
);

INSERT INTO product(product_id, sku, name, price, stock, factory_id, pending)
VALUES(1,'CP-502101', 'KBDS도넛', 19900, 13, 1, false);
