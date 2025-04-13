-- Create the database
CREATE DATABASE IF NOT EXISTS bookstore_db; -- it will not give an error if database exist 
USE bookstore_db;

-- 1. country table (created first as it's referenced by address)
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL, -- NOT NULL simply means it cannot be left blank
    country_code_2 CHAR(2) NOT NULL,
    country_code_3 CHAR(3) NOT NULL
);
INSERT INTO country
(country_name, country_code_2, country_code_3)
VALUES ('Kenya','KE','KEN'),
       ('Nigeria','NG','NGA'),
       ('South Africa','ZA','ZAF'),
       ('Uganda','UG','UGA'),
       ('Tanzania','TZ','TZA'),
       ('Zambia','ZM','ZMB'),
       ('Ethiopia','ET','ETH'),
       ('Jamaica','JM','JAM'),
       ('Iran','IR','IRN'),
       ('South Korea','KR','KOR');

-- 2. address_status table
CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    address_status VARCHAR(30) NOT NULL
);
INSERT INTO address_status(address_status)
VALUES('Active'),
      ('Inactive'),
      ('Primary'),
      ('Secondary'),
      ('Billing'),
      ('Shipping'),
      ('Temporary'),
      ('Verified'),
      ('Unverified'),
      ('Archived');

-- 3. address table
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street_number VARCHAR(10) NOT NULL,
    street_name VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);
INSERT INTO address
(street_number,street_name, city, country_id, postal_code)
VALUES 
-- Addresses in Kenya
       ('123','Moi Avenue','Nairobi',1,'0010'),
	   ('456','Kenyatta Street','Mombasa',1,'80100'),
       ('78','Koinange Street','Nairobi',1,'0010'),
-- Addresses in Nigeria
	   ('22','Marina Road','Lagos',2,'101241'),
       ('15','Ahmadu Bello Way','Abuja',2,'900001'),
       ('1004','Victoria Island','Lagos',2,'101241'),
-- Addressess in south africa
	   ('42','Adderly Street','Cape Town',3,'8001'),
       ('1','Church Square','Pretoria',3,'0002'),
       ('50','Rivionia Road','Johannesburg',3,'2196'),
-- Addresses in Uganda
	   ('10','Kambala Road','Kambala',4,'256'),
       ('5','Acacia Avenue','Entebbe',4,'256'),
-- Addresses in Tanzania 
       ('361','Mwaya Road','Dar es Salam',5,'11101'),
       ('12','Ohio Street','Dodoma',5,'41000'),
-- Addresses in Zambia 
       ('1','Independence Avenue ','Lusaka',6,'10101'),
-- Address in Ethiopia 
	   ('22','Churchill Road','Addis Ababa',7,'1000'),
-- Addresses in Jamaica
	   ('1','Duke Street','Kingstone',8,'JMAKN05'),
-- Addresses in Iran
       ('15','Ferdowsi Street','Tehran',9,'11369'),
-- Addressess in South Korea 
       ('161','Sajik-ro','Seoul',10,'04510'),
       ('12','Gangnam-daero','Seoul',10,'06141');
-- 4. customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20)
);
-- Inserting sample custormers into custormers table
INSERT INTO customer
 (first_name,last_name,email,phone)
 VALUES
 -- Customers from Africa 
       ('Stephen','Wafula','Stephwafula70@gmail.com','+254743335229'),
       ('James','Mwangi','james.mwangi@gmail.com','+254798959449'),
       ('Cyrill','Mukanda','fineboymukanda@gmail.com','+254704112535'),
       ('Twariq','Jamal','Jtwariq7@gmaiil,com','+234772123456'),
-- customers from Asia
       ('Austine','Otieno','Otisosto@gmai.com','+8271234567'),
-- Customers from the caribbean
       ('William','Adenge','Adengouma70@gmail.com','+18761234567'),
-- customers from middle east
       ('Asten','Kalau','Kalou14@gmail.com','+989121234567'),
       ('Gerrald','Brown','Gbrown99@gmail.com','+98912322345'),
-- International custorms
       ('Margret','Olivia','Olivian@yahoo.com','+16135551234'),
	   ('Phill','Collins','philcoll@gmail.com','+8613842345678');
    
-- 5. customer_address table (junction table)
CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);
-- Inserting custormer-address table
INSERT INTO customer_address (customer_id,address_id, status_id)
  VALUES
-- Stephen Wafula(Kenya) -2 addresses
     (1,1,3),  -- Primary Address 
     (1,2,2),  -- Secondary address 
     -- (inactive)
-- James mwangi (Nigeria) -2 ddresses
	 (2,4,3), -- Primary address
     (2,5,6), -- Shipping address 
-- Cyrill Mukanda (South Africa )
      (3,7,3), -- Primarily address 
-- Twariq Jamal (Uganda)
      (4,10,3), -- Primary address 
-- Austine otieno(Tanzania)
       (5,12,3), -- Primary address 
-- William Adenge(Zambia)
       (6,14,3), -- Primary address 
-- Asten Kalou(Ethiopia)
       (7,15,3), -- Prmary address
-- Gerrald Brown(Jamaica)
       (8,16,3), -- Primary address 
-- Margaret Olivia (Iran)
       (9,17,3), -- primary address
-- Phill Collins (South Korea )
        (10,18,3);  -- Primary address
-- 6. publisher table
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(255) NOT NULL,
    publisher_email VARCHAR(255),
    publisher_phone VARCHAR(20)
);
-- Insert publishers into the table
INSERT INTO publisher
 (publisher_name, publisher_email, publisher_phone)
 VALUES
 -- African publishers 
       ('East African Educational Publishers','info@eaep.co.ke','+254203743855'),
       ('Kraft Books Limited','kraftbooks@lagos.com','+23414616170'),
       ('New Africa Books','info@newafricabooks.co.za','+27214614410'),
       ('Fountain Publishers Uganda','fountain@uganda.co.ug','+25614530571'),
       ('Mkuki na Nyota Publishers','info@mkukinanyota.com','+255222130480'),
       ('Zambia Educational Publishing House','zeph@zambia.co.zm','+260211250432'),
-- International publishers 
        ('Macmillan Education','macmillan@education.com','+442070014000'),
        ('Penguin Random House','contact@penguinrandomhouse','+12127415200'),
        ('Oxford University Press','enquiry@oup.com','+44186556767'),
-- Specialized publishers
		('Kwani Trust','info@kwani,org','+254202502908'),
        ('Cassava republic press','info@cassavarepublic.lib','+2349087623456'),
-- Digital-first publishes 
		('Okada Books','suppor@okadabooks.com','+2349087654321');
-- 7. book_language table
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(100) NOT NULL,
    language_code CHAR(2) NOT NULL
);
-- inserting books languages into book-language table
INSERT INTO book_language(language_name,language_code)
VALUES
-- Major languages
      ('English','en'),
      ('French','fr'),
      ('Spanish','es'),
      ('Arabic','ar'),
      ('Chines','zh'),
      ('Rassian','ru'),
      ('Portuguese','pt'),
      ('German','de'),
      ('Japaneese','ia'),
      ('Hindi','hi'),
-- African languages 
	  ('Swahili',''),
      ('Afrikaans','af'),
      ('Hausa','ha'),
      ('Zulu','zu'),
-- Regional languages 
       ('luganda','lg'),
       ('Luyia','Ly'),
       ('Somali','so');
-- 8. author table
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL,
    author_email VARCHAR(255),
    author_phone VARCHAR(20)
);
-- insert authors into author table
INSERT INTO author(author_name,author_email,author_phone)
VALUES
-- African Library Giants 
      ('Chinua Achebe','info@chinuaachebe.com','+2348030001234'),
	-- Nigerian author of things fall apart 
      ('Ngugi wa Thiong"o','contact@ngugi.com','+2547220004567'), 
      --  kenyan author , "petas of blood "
      -- Global Bestsellers 
        ('J.K. Rowling ','jkrowling@pottermor.com','+5521999999999
        '), -- Brazilian "The Alchemist "
	-- contemporary african voices 
        ('Chimamada Ngozi Adichie','Infi@chimamada.com','+234805000789'),
             -- (Americanah)
		('Pablo Coelho','contact@pablocoelho.com','+441234567890'),
        -- Harry potter series 
        ('Trevor Noah','tnoah@dailyshow.com','+278312345678'), -- South african
        -- born a crime 
        ('wole soyinka','office@wolesoyinga.com','+2348060003456'), /* Nigerian 
        Nobel winner */
        ('Nadine Gordimer','info@gordimerfountation.org','+27821234567'), /*
        South African  Nobel winner */
        ('Nnedi Okorafor','nnedi@binti.com','+441314567890'), /*Nigerian-American 
        sci-fi */
        ('Alexander McCsll Smith','ams@nolladies.com','+12025551234');
        -- Botswana-set mysteries 
-- 9. book table
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
-- insert books into the book table with key detail
 INSERT INTO book 
 (title,isbn,publisher_id,language_id,num_pages,publication_date,price,stock_quantity)
 VALUES
       ('Things Fall Apart','9780385474542',2,1,209,'1958-06-17',12.99,25),
       -- chinua Achebes classics 
       ('Petals of blood','9780435905482',1,1,384,'1977-06-01',14.50,15),
       -- Ngugi wathiong'o
       ('Americanah','9780307271082',8,1,477,'2013-05-14',16.00,20),
       -- Chimamada Adichie
       ('Born a crime','9780599588174',8,1,304,'2016-11-15',18.99,18),
       -- Trevor  Noah
       ('The Alchemist ','978006231500',9,1,208,'1988-01-01',15.050,12);
       -- paulo coelho
-- 10. book_author table (junction table)
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
-- link books to their authours in the book_author table
INSERT INTO book_author(book_id,author_id)
VALUES
-- Chinua Achebe wrote things fall apart 
     (1,2),
-- Ngugi wa thiong'o wrote petals of blood 
      (2,1),
-- Chimamada Ngizi Adichie wrote Americanah
	  (3,8),
--  Trevor Noah wrote Born a crime 
	  (4,5),
-- Paulo Coelho wrote the Alchemist 
       (5,4);
       
-- 11. shipping_method table
CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    delivery_time_days INT NOT NULL
);
-- inserting shipping methods into shipping_method table
INSERT INTO shipping_method(method_name,cost,delivery_time_days)
VALUES 
     ('Standard Shipping',5.99,5),
     ('Express Shipping',12.99,2),
     ('Next-Day Delivery',19.99,1),
     ('International Standard',15.99,10),
     ('International Express',29.99,5),
     ('Free Shipping',0.00,7),
     ('In-store pickup',0.00,0),
     ('Courier Service',8.50,3),
     ('Economy Shipping',3.99,8),
     ('Same-Day Delivery',24.99,0);
-- 12. order_status table
CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_value VARCHAR(30) NOT NULL
);
-- Insert order_status into the order_status table
INSERT INTO order_status(status_value)
VALUES
      ('Pending'),
      ('Processing'),
      ('Shipped'),
      ('Delivere'),
      ('Cancelled'),
      ('Refunded'),
      ('On Hold'),
      ('Backordered'),
      ('Returned'),
      ('Partially Shipped '),
      ('Payment Failed'),
      ('Completed');
-- 13. cust_order table
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT NOT NULL,
    dest_address_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (dest_address_id) REFERENCES address(address_id)
);
-- Insert customers order into cust order table
INSERT INTO cust_order
(customer_id,order_date,shipping_method_id,dest_address_id)
Values
     (1,'2023-01-15 09:30:45',3,1),
     (1,'2023-01-16 14:15:22',1,2),
     (2,'2023-03-05 11:05:33',2,4),
     (3,'2023-03-18 16:45:10',6,7),
     (4,'2023-04-01 10:00:00',4,10),
     (5,'2023-04-12 13:22:18',5,12),
     (10,'2023-05-05 08:08:15',3,8),
     (10,'2023-05-20 19:30:00',7,19);
-- 14. order_line table
CREATE TABLE order_line (
    line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
-- insert order line items  into orderline table
INSERT INTO order_line
(order_id,book_id,price,quantity)
VALUES
     (1,1,12.99,1),
     (1,2,16.00,2),
     (2,2,15.50,1),
     (3,2,14.50,1),
     (3,4,18.99,3),
     (4,1,12.99,3),
     (5,3,16.00,1),
     (5,5,15.50,1),
     (6,4,18.99,2),
     (7,1,12.99,1),
     (7,2,14.50,1),
     (8,5,15.50,1);


-- 15. order_history table
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
-- insert into order_history table
INSERT INTO order_history(order_id,status_id,status_date)
VALUES
     (1,1,'2023-01-15 09:30:45'),
     (1,2,'2023-01-15 11:45:00'),
     (1,3,'2023-01-16 08:30:00'),
     (1,4,'2023-01-17 10:15:00'),
     (4,1,'2023-03-18 16:45:10'),
     (4,5,'2023-03-19 10:00:00'),
     (7,1,'2023-05-05 08:15:45'),
     (7,2,'2023-05-05 09:00:00'),
     (7,3,'2023-05-05 17:00:00'),
     (7,4,'2023-05-06 11:30:00');