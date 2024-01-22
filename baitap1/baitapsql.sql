CREATE DATABASE Baitap1;

USE Baitap1;

CREATE TABLE users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(30) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  pasword VARCHAR(20) NOT NULL
);

ALTER TABLE users
CHANGE COLUMN pasword passwords VARCHAR(255) NOT NULL;




CREATE TABLE food_type (
	type_id INT PRIMARY KEY AUTO_INCREMENT,
	type_name VARCHAR(20)
);

CREATE TABLE restaurant (
	res_id INT PRIMARY KEY AUTO_INCREMENT,
	res_name VARCHAR(30),
	image VARCHAR(50),
	description VARCHAR(50)
);

CREATE TABLE like_res (
	user_id INT,
	FOREIGN KEY (user_id) REFERENCES users (user_id),
	res_id INT,
	FOREIGN KEY (res_id) REFERENCES restaurant (res_id),
	date_like DATETIME
);


CREATE TABLE rate_res (
	user_id INT,
	FOREIGN KEY (user_id) REFERENCES users (user_id),
	res_id INT,
	FOREIGN KEY (res_id) REFERENCES restaurant (res_id),
	amount INT,
	date_rate DATETIME
);





CREATE TABLE food (
	food_id INT PRIMARY KEY AUTO_INCREMENT,
	food_name VARCHAR(20),
	image VARCHAR(50),
	price FLOAT,
	description VARCHAR(50),
	type_id INT,
	FOREIGN KEY (type_id) REFERENCES food_type (type_id)
);

ALTER TABLE food
MODIFY COLUMN food_name VARCHAR(255);
ALTER TABLE food
MODIFY COLUMN description VARCHAR(255);

CREATE TABLE orders (
	user_id INT,
	FOREIGN KEY (user_id) REFERENCES users (user_id),
	food_id INT,
	FOREIGN KEY (food_id) REFERENCES food (food_id),
	amount INT,
	codes VARCHAR(20),
	arr_sub_id VARCHAR(20)
);


CREATE TABLE sub_food (
	sub_id INT PRIMARY KEY AUTO_INCREMENT,
	sub_name VARCHAR(20),
	sub_price FLOAT,
	food_id INT,
	FOREIGN KEY (food_id) REFERENCES food (food_id)
);





# Thêm dữ liệu vào bảng users
INSERT INTO users (full_name, email, passwords) VALUES
('John Doe', 'john.doe@email.com', 'password1'),
('Jane Smith', 'jane.smith@email.com', 'password2'),
('Alice Johnson', 'alice.johnson@email.com', 'password3'),
('Bob Williams', 'bob.williams@email.com', 'password4'),
('Eva Davis', 'eva.davis@email.com', 'password5'),
('Michael Brown', 'michael.brown@email.com', 'password6'),
('Sophie Miller', 'sophie.miller@email.com', 'password7'),
('Chris Wilson', 'chris.wilson@email.com', 'password8'),
('Olivia Taylor', 'olivia.taylor@email.com', 'password9'),
('Daniel Lee', 'daniel.lee@email.com', 'password10');
SELECT * FROM users;

# Thêm dữ liệu vào bảng restaurant
INSERT INTO restaurant (res_name, image, description) VALUES
('Restaurant A', 'image1.jpg', 'Description for Restaurant A'),
('Restaurant B', 'image2.jpg', 'Description for Restaurant B'),
('Restaurant C', 'image3.jpg', 'Description for Restaurant C'),
('Restaurant D', 'image4.jpg', 'Description for Restaurant D'),
('Restaurant E', 'image5.jpg', 'Description for Restaurant E'),
('Restaurant F', 'image6.jpg', 'Description for Restaurant F'),
('Restaurant G', 'image7.jpg', 'Description for Restaurant G'),
('Restaurant H', 'image8.jpg', 'Description for Restaurant H'),
('Restaurant I', 'image9.jpg', 'Description for Restaurant I'),
('Restaurant J', 'image10.jpg', 'Description for Restaurant J');
SELECT * FROM restaurant;

# Thêm dữ liệu vào bảng rate_res
INSERT INTO rate_res (user_id, res_id, amount, date_rate)
VALUES
(1, 1, 4, '2024-01-15 08:30:00'),
(2, 2, 3, '2024-01-15 12:45:00'),
(3, 1, 5, '2024-01-16 10:15:00'),
(4, 3, 4, '2024-01-16 15:30:00'),
(5, 2, 3, '2024-01-17 09:45:00'),
(1, 3, 4, '2024-01-18 14:00:00'),
(2, 1, 4, '2024-01-19 11:00:00'),
(3, 2, 3, '2024-01-20 13:30:00'),
(4, 3, 5, '2024-01-21 16:45:00'),
(5, 1, 4, '2024-01-22 10:00:00');
SELECT * FROM rate_res;

# Thêm dữ liệu vào bảng food_type
INSERT INTO food_type (type_id, type_name) VALUES
(1, 'Pizza'),
(2, 'Pasta'),
(3, 'Sushi'),
(4, 'Burger'),
(5, 'Dessert');
SELECT * FROM food_type;

# Thêm dữ liệu vào bảng food
INSERT INTO food (food_name, image, description, type_id, price,food_id) VALUES
('Spaghetti Bolognese', 'spaghetti_bolognese.jpg', 'Classic spaghetti with Bolognese sauce.', 2, 9.99,1),
('Caesar Salad', 'caesar_salad.jpg', 'Fresh Caesar salad with grilled chicken.', 3, 7.99,2),
('Steak with Mashed Potatoes', 'steak_mashed_potatoes.jpg', 'Juicy steak served with creamy mashed potatoes.', 4, 15.99,3),
('Seafood Paella', 'seafood_paella.jpg', 'Spanish seafood paella with a variety of fresh seafood.', 1, 18.99,4),
('Mango Sticky Rice', 'mango_sticky_rice.jpg', 'Sweet mango sticky rice with coconut milk.', 5, 5.99,5);
SELECT * FROM food;

# Thêm dữ liệu vào bảng orders
INSERT INTO orders (user_id, food_id, amount, codes, arr_sub_id) VALUES
(1, 3, 2, 'ABC123', 'Sub123'),
(2, 4, 1, 'XYZ456', 'Sub456'),
(3, 2, 3, 'DEF789', 'Sub789'),
(1, 1, 2, 'GHI012', 'Sub012'),
(2, 5, 1, 'JKL345', 'Sub345');
SELECT * FROM orders;

# 5 người like nhà hàng nhiều nhất
SELECT users.user_id , users.full_name, COUNT(rate_res.res_id) AS total_likes
FROM users
JOIN rate_res ON users.user_id = rate_res.user_id
GROUP BY users.user_id, users.full_name
ORDER BY total_likes DESC
LIMIT 5;

# 2 nhà hàng có lượt like nhiều nhất
SELECT restaurant.res_id, restaurant.res_name, COUNT(rate_res.user_id) AS total_likes
FROM restaurant
JOIN rate_res ON restaurant.res_id = rate_res.res_id
GROUP BY restaurant.res_id, restaurant.res_name
ORDER BY total_likes DESC
LIMIT 2;

# Tìm người đặt hàng nhiều nhất
SELECT users.full_name, COUNT(orders.user_id) AS total_orders
FROM users
JOIN orders ON users.user_id = orders.user_id
GROUP BY users.user_id, users.full_name
ORDER BY total_orders DESC
LIMIT 1;


# Tìm người dùng không hoạt động trong hệ thống (không like, không đặt hàng, không đánh giá)
SELECT users.full_name
FROM users
LEFT JOIN like_res ON users.user_id = like_res.user_id
LEFT JOIN orders ON users.user_id = orders.user_id
LEFT JOIN rate_res ON users.user_id = rate_res.user_id
WHERE like_res.user_id IS NULL AND orders.user_id IS NULL AND rate_res.user_id IS NULL;



