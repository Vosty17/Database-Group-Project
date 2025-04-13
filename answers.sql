-- Create the database if not exists
CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;

-- 1. Country Table
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL,
    country_code_2 CHAR(2) NOT NULL,
    country_code_3 CHAR(3) NOT NULL
);

INSERT INTO country (country_name, country_code_2, country_code_3) VALUES 
('Kenya','KE','KEN'),
('Nigeria','NG','NGA'),
('South Africa','ZA','ZAF'),
('Uganda','UG','UGA'),
('Tanzania','TZ','TZA'),
('Zambia','ZM','ZMB'),
('Ethiopia','ET','ETH'),
('Jamaica','JM','JAM'),
('Iran','IR','IRN'),
('South Korea','KR','KOR');

-- 2. Address Status Table
CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    address_status VARCHAR(30) NOT NULL
);

INSERT INTO address_status (address_status) VALUES
('Active'),
('Inactive'),
('Primary'),
('Secondary'),
('Billing'),
('Shipping'),
('Temporary'),
('Verified'),
('Unverified'),
('Archived');

-- 3. Address Table
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street_number VARCHAR(10) NOT NULL,
    street_name VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

INSERT INTO address (street_number, street_name, city, country_id, postal_code) VALUES 
('123','Moi Avenue','Nairobi',1,'0010'),
('456','Kenyatta Street','Mombasa',1,'80100'),
('78','Koinange Street','Nairobi',1,'0010'),
('22','Marina Road','Lagos',2,'101241'),
('15','Ahmadu Bello Way','Abuja',2,'900001'),
('1004','Victoria Island','Lagos',2,'101241'),
('42','Adderly Street','Cape Town',3,'8001'),
('1','Church Square','Pretoria',3,'0002'),
('50','Rivionia Road','Johannesburg',3,'2196'),
('10','Kambala Road','Kambala',4,'256'),
('5','Acacia Avenue','Entebbe',4,'256'),
('361','Mwaya Road','Dar es Salam',5,'11101'),
('12','Ohio Street','Dodoma',5,'41000'),
('1','Independence Avenue ','Lusaka',6,'10101'),
('22','Churchill Road','Addis Ababa',7,'1000'),
('1','Duke Street','Kingstone',8,'JMAKN05'),
('15','Ferdowsi Street','Tehran',9,'11369'),
('161','Sajik-ro','Seoul',10,'04510'),
('12','Gangnam-daero','Seoul',10,'06141');

-- 4. Customer Table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

INSERT INTO customer (first_name, last_name, email, phone) VALUES
('Stephen', 'Wafula', 'Stephwafula70@gmail.com', '+254743335229'),
('James', 'Mwangi', 'james.mwangi@gmail.com', '+254798959449'),
('Cyrill', 'Mukanda', 'fineboymukanda@gmail.com', '+254704112535'),
('Twariq', 'Jamal', 'Jtwariq7@gmaiil,com', '+234772123456'),
('Austine', 'Otieno', 'Otisosto@gmai.com', '+8271234567'),
('William', 'Adenge', 'Adengouma70@gmail.com', '+18761234567'),
('Asten', 'Kalau', 'Kalou14@gmail.com', '+989121234567'),
('Gerrald', 'Brown', 'Gbrown99@gmail.com', '+98912322345'),
('Margret', 'Olivia', 'Olivian@yahoo.com', '+16135551234'),
('Phill', 'Collins', 'philcoll@gmail.com', '+8613842345678');

-- 5. Customer Address Table (junction table)
CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1,1,3), (1,2,2),
(2,4,3), (2,5,6),
(3,7,3),
(4,10,3),
(5,12,3),
(6,14,3),
(7,15,3),
(8,16,3),
(9,17,3),
(10,18,3);

-- 6. Publisher Table
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(255) NOT NULL,
    publisher_email VARCHAR(255),
    publisher_phone VARCHAR(20)
);

INSERT INTO publisher (publisher_name, publisher_email, publisher_phone) VALUES
('East African Educational Publishers','info@eaep.co.ke','+254203743855'),
('Kraft Books Limited','kraftbooks@lagos.com','+23414616170'),
('New Africa Books','info@newafricabooks.co.za','+27214614410'),
('Fountain Publishers Uganda','fountain@uganda.co.ug','+25614530571'),
('Mkuki na Nyota Publishers','info@mkukinanyota.com','+255222130480'),
('Zambia Educational Publishing House','zeph@zambia.co.zm','+260211250432'),
('Macmillan Education','macmillan@education.com','+442070014000'),
('Penguin Random House','contact@penguinrandomhouse','+12127415200'),
('Oxford University Press','enquiry@oup.com','+44186556767'),
('Kwani Trust','info@kwani,org','+254202502908'),
('Cassava republic press','info@cassavarepublic.lib','+2349087623456'),
('Okada Books','suppor@okadabooks.com','+2349087654321');

-- 7. Book Language Table
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(100) NOT NULL,
    language_code CHAR(2) NOT NULL
);

INSERT INTO book_language (language_name, language_code) VALUES
('English','en'), ('French','fr'), ('Spanish','es'),
('Arabic','ar'), ('Chines','zh'), ('Rassian','ru'),
('Portuguese','pt'), ('German','de'), ('Japaneese','ia'),
('Hindi','hi'), ('Swahili','sw'), ('Afrikaans','af'),
('Hausa','ha'), ('Zulu','zu'), ('luganda','lg'),
('Luyia','Ly'), ('Somali','so');

-- 8. Author Table
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL,
    author_email VARCHAR(255),
    author_phone VARCHAR(20)
);

INSERT INTO author (author_name, author_email, author_phone) VALUES
('Chinua Achebe','info@chinuaachebe.com','+2348030001234'),
('Ngugi wa Thiong"o','contact@ngugi.com','+2547220004567'),
('J.K. Rowling','jkrowling@pottermor.com','+5521999999999'),
('Chimamada Ngozi Adichie','Infi@chimamada.com','+234805000789'),
('Pablo Coelho','contact@pablocoelho.com','+441234567890'),
('Trevor Noah','tnoah@dailyshow.com','+278312345678'),
('wole soyinka','office@wolesoyinga.com','+2348060003456'),
('Nadine Gordimer','info@gordimerfountation.org','+27821234567'),
('Nnedi Okorafor','nnedi@binti.com','+441314567890'),
('Alexander McCsll Smith','ams@nolladies.com','+12025551234');

-- 9. Book Table
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publisher_id INT,
    language_id INT,
    num_pages INT,
    publication_date DATE,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

INSERT INTO book (title, isbn, publisher_id, language_id, num_pages, publication_date, price, stock_quantity) VALUES
('Things Fall Apart','9780385474542',2,1,209,'1958-06-17',12.99,25),
('Petals of blood','9780435905482',1,1,384,'1977-06-01',14.50,15),
('Americanah','9780307271082',8,1,477,'2013-05-14',16.00,20),
('Born a crime','9780599588174',8,1,304,'2016-11-15',18.99,18),
('The Alchemist ','978006231500',9,1,208,'1988-01-01',15.50,12);

-- 10. Book Author Table (junction table)
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

INSERT INTO book_author (book_id, author_id) VALUES
(1,2),
(2,1),
(3,8),
(4,5),
(5,4);

-- 11. Shipping Method Table
CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    delivery_time_days INT NOT NULL
);

INSERT INTO shipping_method (method_name, cost, delivery_time_days) VALUES
('Standard Shipping',10.00,5),
('Express Shipping',25.00,2),
('Next Day Delivery',40.00,1),
('International Shipping',60.00,7);

-- 12. Order Status Table
CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_value VARCHAR(50) NOT NULL
);

INSERT INTO order_status (status_value) VALUES
('Pending'),
('Shipped'),
('Delivered'),
('Canceled'),
('Returned'),
('Processing');

-- 13. Customer Order Table
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    shipping_method_id INT,
    delivery_address_id INT,
    status_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (delivery_address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

INSERT INTO cust_order (customer_id, order_date, shipping_method_id, delivery_address_id, status_id, total_amount) VALUES
(1, '2025-04-12', 2, 3, 1, 80.00),
(2, '2025-04-13', 1, 4, 1, 65.50),
(3, '2025-04-13', 1, 7, 3, 120.75);

-- 14. Order Line Table
CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 2, 12.99),
(1, 3, 1, 16.00),
(2, 4, 1, 18.99),
(2, 5, 2, 15.50);

-- 15. Order History Table
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    status_id INT,
    status_date DATE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

INSERT INTO order_history (order_id, status_id, status_date) VALUES
(1, 1, '2025-04-12'),
(2, 1, '2025-04-13'),
(3, 3, '2025-04-14');
