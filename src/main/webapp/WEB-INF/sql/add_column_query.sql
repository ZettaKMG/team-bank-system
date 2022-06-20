USE bank;

DESC Product;
SELECT * FROM Product;

-- ALTER TABLE Product
-- ADD summary VARCHAR(200) NOT NULL AFTER item_name;

-- ALTER TABLE Product
-- ADD detail VARCHAR(1000) NOT NULL;

-- ALTER TABLE Product
-- MODIFY COLUMN detail VARCHAR(1000) AFTER rate;

-- ALTER TABLE Product
-- MODIFY COLUMN detail VARCHAR(1000) NOT NULL;

-- ALTER TABLE Product
-- MODIFY COLUMN sav_method VARCHAR(20) NOT NULL;

-- ALTER TABLE Product
-- MODIFY COLUMN sav_method VARCHAR(20) AFTER summary;

-- ALTER TABLE Product
-- MODIFY COLUMN exp_period int(11) AFTER sav_method;

-- INSERT INTO Product (item_name, summary, sav_method, rate, detail)
-- VALUES ('기본예금', '기본적인 예금', '예금', 0.5, '가장 기본적인 예금입니다.');

-- INSERT INTO Product (item_name, summary, sav_method, exp_period, rate, detail)
-- VALUES ('기본적금', '기본적인 적금', '적금', 12, 2.0, '가장 기본적인 적금입니다.');

-- INSERT INTO Product (item_name, summary, sav_method, exp_period, rate, detail)
-- VALUES ('기본적금1', '기본적인 적금1', '적금', 24, 3.5, '가장 기본적인 적금을 리뉴얼');

DESC Product;
SELECT * FROM Product ORDER BY 1 DESC;

DESC User;
SELECT * FROM User ORDER BY 1 DESC;

DESC Auth;
SELECT * FROM Auth ORDER BY 1 DESC;

DESC Account;
