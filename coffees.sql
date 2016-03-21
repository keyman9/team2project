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