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
  Region varchar(35) NOT NULL default '',
  Description text NOT NULL default '',
  PRIMARY KEY  (ID)
) ;

--
-- Grant permissions
--
create user visiting with password '06*65uSl13Cu';
grant all on coffee to visiting;
grant all on coffee_id_seq to visiting;

--
-- Insert elements into Coffee table
--
INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Aldo''s Blend',14.00,12,'Medium Dark','Central America','Spiced cider, dark chocolate, earthy, mequite');
INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Bell''s Blend',14.00,12,'Medium','Central America','Peanut butter, floral earth, hot cocoa with marshmallows, a happy childhood memory');
INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Decaf Monk',16.00,12,'Medium Dark','Central American','Red wine, smoked caramel, chocolate undertones');
INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Espresso Savio',14.00,12,'Medium Dark','Central America','Nutty, fresh citrus, toffee, milk chocolate');
INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Ethiopia Borboya',16.00,12,'Medium','Africa','Blackberry, lemongrass, and peach tea');
INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Fazenda Ambiental Fortaleza',16.00,12,'Medium','South America','Plum, fig, cumin, red fruit, tawny port, blood orange');
INSERT INTO Coffee(Name,Price,Weight,Roast,Region,Description) VALUES ('Finca Idealista',16.00,12,'Medium','Central America','Dark chocolate and ripe plums. Mellow finish');