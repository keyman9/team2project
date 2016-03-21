DROP DATABASE IF EXISTS userCoffee;
CREATE DATABASE  userCoffee;
\c userCoffee;

DROP TABLE IF EXISTS Coffee;
CREATE TABLE Coffee (
  ID serial NOT NULL,
  FIRSTNAME varchar(35)  NOT NULL default '',
  LASTNAME varchar(40)  NOT NULL default '',
  USER varchar(35)  NOT NULL default '',
  PASSWORD varchar(35)  NOT NULL default '',
  EMAIL varchar(40)  NOT NULL default '',
  ZIPCODE integer NOT NULL default '',
  FAVORITECOFFEE varchar(20)  NOT NULL default '',
  PRIMARY KEY (ID)
);



