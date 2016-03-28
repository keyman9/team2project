DROP DATABASE IF EXISTS coffee;
CREATE DATABASE  coffee;
\c coffee;
--
-- Table structure for table City
--

DROP TABLE IF EXISTS Coffee;
CREATE TABLE Coffee (
  ID serial NOT NULL,
  Name varchar(35)  NOT NULL default '',
  Price numeric(6,2) NOT NULL default '0.0',
  Weight int NOT NULL default '0',
  Roast varchar(30) NOT NULL default '',
  Body text NOT NULL default '',
  Region varchar(35) NOT NULL default '',
  Description text NOT NULL default '',
  PRIMARY KEY  (ID),
  UNIQUE(Name)
);

DROP TABLE IF EXISTS Login;
CREATE TABLE Login (
  ID serial NOT NULL,
  First_Name varchar(35)  NOT NULL default '',
  Last_Name varchar(40)  NOT NULL default '',
  Username varchar(35)  NOT NULL default '',
  Password varchar(35)  NOT NULL default '',
  PRIMARY KEY (ID),
  UNIQUE(Username)
);

DROP TABLE IF EXISTS User_Info; 
CREATE TABLE User_Info (
  Username varchar(35) NOT NULL default '' REFERENCES Login(Username),
  Email varchar(40)  NOT NULL default '',
  Zipcode integer NOT NULL default 0,
  Favorite_Coffee varchar(20)  NOT NULL default '' REFERENCES Coffee(Name),
  PRIMARY KEY (Username)
);

--
-- Grant permissions
--
DROP USER IF EXISTS visiting;
CREATE USER visiting with password '06*65uSl13Cu';
GRANT INSERT, SELECT ON coffee TO visiting;
GRANT SELECT ON coffee_id_seq TO visiting;
GRANT INSERT, SELECT ON Login TO visiting;
GRANT SELECT ON login_id_seq TO visiting;
GRANT INSERT, SELECT ON User_Info TO visiting;



--
-- Insert elements into Coffee table
--
-- INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Aldo''s Blend',14.00,12,'Medium Dark','Central America','Spiced cider, dark chocolate, earthy, mequite');
-- INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Bell''s Blend',14.00,12,'Medium','Central America','Peanut butter, floral earth, hot cocoa with marshmallows, a happy childhood memory');
-- INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Decaf Monk',16.00,12,'Medium Dark','Central American','Red wine, smoked caramel, chocolate undertones');
-- INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Espresso Savio',14.00,12,'Medium Dark','Central America','Nutty, fresh citrus, toffee, milk chocolate');
-- INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Ethiopia Borboya',16.00,12,'Medium','Africa','Blackberry, lemongrass, and peach tea');
-- INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Fazenda Ambiental Fortaleza',16.00,12,'Medium','South America','Plum, fig, cumin, red fruit, tawny port, blood orange');
-- INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Finca Idealista',16.00,12,'Medium','Central America','Dark chocolate and ripe plums. Mellow finish');

INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (1, 'Aldo''s Blend', 14.00, 12, 'Medium Dark', 'Chewy, creamy, like a brownie', 'Central America', 'Spiced cider, dark chocolate, earthy, mequite');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (2, 'Bell''s Blend', 14.00, 12, 'Medium', 'Chocolate Chip Cookie, Medium-light', 'Central America', 'Peanut butter, floral earth, hot cocoa with marshmallows, a happy childhood memory');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (3, 'Decaf Monk', 16.00, 12, 'Medium Dark', 'Medium-light' ,'Central American', 'Red wine, smoked caramel, chocolate undertones');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (4, 'Espresso Savio', 14.00, 12, 'Medium Dark', 'Full, Sultry, and soft like Mink fur', 'Central America', 'Nutty, fresh citrus, toffee, milk chocolate');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (5, 'Ethiopia Borboya', 16.00, 12, 'Medium', 'Full and creamy', 'Africa', 'Blackberry, lemongrass, and peach tea');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (6, 'Fazenda Ambiental Fortaleza', 16.00, 12, 'Medium', 'Full yet nuanced', 'South America', 'Plum, fig, cumin, red fruit, tawny port, blood orange');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (7, 'Finca Idealista', 16.00, 12, 'Medium', 'Full', 'Central America', 'Dark chocolate and ripe plums. Mellow finish');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (8, 'Finca Idealista Microlots', 22.00, 12, 'Medium', 'Full, Creamy', 'Central America', 'Baker''s chocolate, almond, plum, cacao, juicy, citrus.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (9, 'Misty Valley', 16.00, 12, 'Medium', 'Milky', 'Africa', 'Blueberry muffins, floral, baker''s chocolate');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (10, 'Singgalang', 16.00, 12, 'Medium', 'Heavy, Syrupy, Stout', 'Indonesia', 'Roasted pineapple, pear, kola syrup');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (11, 'Suka Quto', 16.00, 12, 'Medium', 'Juicy', 'Africa', 'Stone fruit, ripe Asian pear and apricot, silky.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (12, 'William and Maria - Costa Rica', 16.00, 12, 'Medium', 'Buttery, Pastry-Like', 'Central America', 'Graham cracker and lemon peel.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (13, 'Bali Kintamani (Natural)', 14.95, 12, 'Light', 'Big and full', 'Indonesia', 'Dark chocolate and earthy spice flavors balance with bright pops of strawberry and a subtle cream note');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (14, 'Black Phantom Decaf Espresso', 12.75, 12, 'Medium', 'Full, hearty', 'Central America', 'Sweet, smoky.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (15, 'Black Velvet', 12.25, 12, 'Dark', 'Big', 'Central America', 'Smoky, chocolate, cocoa.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (16, 'Cosmopolitan Espresso Blend', 12.25, 12, 'Medium', 'Rich and full', 'Central America', 'Milk chocolate, earthy, bittersweet tones.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (17, 'Costa Rica La Magnolia', 12.25, 12, 'Medium Light', 'Light, smooth', 'Central America', 'Citrus, sweet.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (18, 'Costa Rican La Minita', 15.95, 12, 'Light', 'Medium', 'Central America', 'Sweet, chocolate.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (19, 'Daterra Farm Reserve Espresso', 13.95, 12, 'Medium', 'Rich', 'South America', 'Sweet almond, chocolate, citrus.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (20, 'Decaf Brazil', 12.75, 12, 'Medium', 'South America', 'Medium', 'Bittersweet Chocolate, Caramel and Nuts.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (21, 'Diesel Dark Roast', 12.25, 12, 'Dark', 'Heavy', 'Indonesia', 'Dried fruit, spicy.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (22, 'Espresso Intensi', 12.25, 12, 'Medium Dark', 'Big', 'Central America', 'Cocoa, spice and light citrus, fruit nuances.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (23, 'Ethiopia Hambela Estate', 15.95, 12, 'Light', 'Light and Delicate', 'Africa', 'Floral and citrus flavors, lavender, bergamot and white nectarine. Toasted marshmallow finish.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (24, 'French Roast', 12.25, 12, 'Dark', 'Medium to heavy', 'Indonesia', 'Smoky, chocolate.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (25, 'House Blend', 12.25, 12, 'Medium', 'Medium', 'Central America', 'Milk chocolate, nutty.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (26, 'Kenya AA Nguguini', 15.95, 12, 'Light', 'Medium, Creamy, Jam like', 'Africa', 'Deep strawberry and blackberry.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (27, 'Rocketeer Blend', 12.25, 12, 'Medium', 'Rich', 'Central America', 'Chocolate, spicy.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (28, 'Rwanda Gashonga', 15.95, 12, 'Light', 'Medium and Savory', 'Africa', 'Red currant, plum, pomegranate and red jam flourish with hints of chocolate.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (29, 'Sumatra Dolok Sangull ', 15.95, 12, 'Medium Light', 'Clean', 'Indonesia', 'Woodsy flavors, cedar, herb, deep berry, jam, grapefruit tartness.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (30, 'Sumatra Mandheling Gayo Mountain', 13.00, 12, 'Medium', 'Medium to heavy', 'Indonesia', 'Fruit, floral.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (31, 'El Socorro Amarillo', 18.95, 12, 'Medium Light', 'Creamy', 'Central America', 'Strawberry, apricot, and dark honey.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (32, 'Espresso Sampler - 3 bags', 52.95, 24, 'Medium', 'Various', 'Various', 'Various.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (33, 'Las Mercedes El Salvador', 17.95, 12, 'Medium Light', 'Smooth', 'Central America', 'Tahitian vanilla, brown sugar, roasted almonds and citrus.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (34, 'Pacaya Espresso', 17.95, 12, 'Medium', 'Velvety', 'Central America', 'Chocolate brownie, dates.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (35, 'Redcab - Brazil', 14.95, 12, 'Medium Dark', 'Heavy and round', 'South America', 'Nougat, nutmeg, dark chocolate.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (36, 'Redcab - Espresso', 14.95, 12, 'Dark', 'Thick and round', 'South America', 'Nougat, cashew butter, dark chocolate.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (37, 'Santander EP - FT Organic', 16.95, 12, 'Medium', 'Creamy', 'South America', 'Caramel, citrus, and toffee.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (38, 'The Beast', 13.75, 12, 'Dark', 'Heavy and Bold', 'Central America', 'Bittersweet chocolate and snickerdoodle.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (39, 'The Boss Espresso', 16.95, 12, 'Medium', 'Thick and heavy', 'South America', 'Dark chocolate and thick, bittersweet undertones, clove-like space.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (40, 'The Heavy', 16.45, 12, 'Dark', 'Heavy', 'Central America', 'Deep, dark, chocolatey.');
INSERT INTO coffee (id, name, price, weight, roast, body, region, description) VALUES (41, 'Traditional Drip Sampler - 3 bags', 39.75, 24, 'Medium', 'Heavier bodied coffees', 'Various', 'Nut and chocolate type notes.');
