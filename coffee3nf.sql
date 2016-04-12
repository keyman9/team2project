--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: coffee; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE coffee (
    id integer NOT NULL,
    name character varying(35) DEFAULT ''::character varying NOT NULL,
    price numeric(6,2) DEFAULT 0.0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    roast character varying(30) DEFAULT ''::character varying NOT NULL,
    body text DEFAULT ''::text NOT NULL,
    region character varying(35) DEFAULT ''::character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.coffee OWNER TO postgres;

--
-- Name: coffee_cost; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE coffee_cost (
    name character varying(35) NOT NULL,
    price numeric(6,2),
    weight integer
);


ALTER TABLE public.coffee_cost OWNER TO postgres;

--
-- Name: coffee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE coffee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coffee_id_seq OWNER TO postgres;

--
-- Name: coffee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE coffee_id_seq OWNED BY coffee.id;


--
-- Name: coffee_names; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE coffee_names (
    name character varying(35) NOT NULL,
    body text,
    description text
);


ALTER TABLE public.coffee_names OWNER TO postgres;

--
-- Name: coffee_region; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE coffee_region (
    name character varying(35),
    region_id integer
);


ALTER TABLE public.coffee_region OWNER TO postgres;

--
-- Name: coffee_roast; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE coffee_roast (
    name character varying(35) NOT NULL,
    roast_id integer NOT NULL
);


ALTER TABLE public.coffee_roast OWNER TO postgres;

--
-- Name: login; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE login (
    id integer NOT NULL,
    first_name character varying(35) DEFAULT ''::character varying NOT NULL,
    last_name character varying(40) DEFAULT ''::character varying NOT NULL,
    username character varying(35) DEFAULT ''::character varying NOT NULL,
    password character varying(60) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.login OWNER TO postgres;

--
-- Name: login_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE login_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_id_seq OWNER TO postgres;

--
-- Name: login_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE login_id_seq OWNED BY login.id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE region (
    region_id integer NOT NULL,
    name text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.region OWNER TO postgres;

--
-- Name: region_region_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE region_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.region_region_id_seq OWNER TO postgres;

--
-- Name: region_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE region_region_id_seq OWNED BY region.region_id;


--
-- Name: roast; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roast (
    roast_id integer NOT NULL,
    roast text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.roast OWNER TO postgres;

--
-- Name: roast_roast_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE roast_roast_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roast_roast_id_seq OWNER TO postgres;

--
-- Name: roast_roast_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE roast_roast_id_seq OWNED BY roast.roast_id;


--
-- Name: user_info; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_info (
    username character varying(35) DEFAULT ''::character varying NOT NULL,
    email character varying(40) DEFAULT ''::character varying NOT NULL,
    zipcode integer DEFAULT 0 NOT NULL,
    favorite_coffee character varying(20) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.user_info OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY coffee ALTER COLUMN id SET DEFAULT nextval('coffee_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY login ALTER COLUMN id SET DEFAULT nextval('login_id_seq'::regclass);


--
-- Name: region_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY region ALTER COLUMN region_id SET DEFAULT nextval('region_region_id_seq'::regclass);


--
-- Name: roast_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roast ALTER COLUMN roast_id SET DEFAULT nextval('roast_roast_id_seq'::regclass);


--
-- Data for Name: coffee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY coffee (id, name, price, weight, roast, body, region, description) FROM stdin;
1	Aldo's Blend	14.00	12	Medium Dark	Chewy, creamy, like a brownie	Central America	Spiced cider, dark chocolate, earthy, mequite
2	Bell's Blend	14.00	12	Medium	Chocolate Chip Cookie, Medium-light	Central America	Peanut butter, floral earth, hot cocoa with marshmallows, a happy childhood memory
4	Espresso Savio	14.00	12	Medium Dark	Full, Sultry, and soft like Mink fur	Central America	Nutty, fresh citrus, toffee, milk chocolate
5	Ethiopia Borboya	16.00	12	Medium	Full and creamy	Africa	Blackberry, lemongrass, and peach tea
6	Fazenda Ambiental Fortaleza	16.00	12	Medium	Full yet nuanced	South America	Plum, fig, cumin, red fruit, tawny port, blood orange
7	Finca Idealista	16.00	12	Medium	Full	Central America	Dark chocolate and ripe plums. Mellow finish
8	Finca Idealista Microlots	22.00	12	Medium	Full, Creamy	Central America	Baker's chocolate, almond, plum, cacao, juicy, citrus.
9	Misty Valley	16.00	12	Medium	Milky	Africa	Blueberry muffins, floral, baker's chocolate
10	Singgalang	16.00	12	Medium	Heavy, Syrupy, Stout	Indonesia	Roasted pineapple, pear, kola syrup
11	Suka Quto	16.00	12	Medium	Juicy	Africa	Stone fruit, ripe Asian pear and apricot, silky.
12	William and Maria - Costa Rica	16.00	12	Medium	Buttery, Pastry-Like	Central America	Graham cracker and lemon peel.
13	Bali Kintamani (Natural)	14.95	12	Light	Big and full	Indonesia	Dark chocolate and earthy spice flavors balance with bright pops of strawberry and a subtle cream note
15	Black Velvet	12.25	12	Dark	Big	Central America	Smoky, chocolate, cocoa.
16	Cosmopolitan Espresso Blend	12.25	12	Medium	Rich and full	Central America	Milk chocolate, earthy, bittersweet tones.
17	Costa Rica La Magnolia	12.25	12	Medium Light	Light, smooth	Central America	Citrus, sweet.
18	Costa Rican La Minita	15.95	12	Light	Medium	Central America	Sweet, chocolate.
19	Daterra Farm Reserve Espresso	13.95	12	Medium	Rich	South America	Sweet almond, chocolate, citrus.
20	Decaf Brazil	12.75	12	Medium	South America	Medium	Bittersweet Chocolate, Caramel and Nuts.
21	Diesel Dark Roast	12.25	12	Dark	Heavy	Indonesia	Dried fruit, spicy.
22	Espresso Intensi	12.25	12	Medium Dark	Big	Central America	Cocoa, spice and light citrus, fruit nuances.
23	Ethiopia Hambela Estate	15.95	12	Light	Light and Delicate	Africa	Floral and citrus flavors, lavender, bergamot and white nectarine. Toasted marshmallow finish.
24	French Roast	12.25	12	Dark	Medium to heavy	Indonesia	Smoky, chocolate.
25	House Blend	12.25	12	Medium	Medium	Central America	Milk chocolate, nutty.
26	Kenya AA Nguguini	15.95	12	Light	Medium, Creamy, Jam like	Africa	Deep strawberry and blackberry.
27	Rocketeer Blend	12.25	12	Medium	Rich	Central America	Chocolate, spicy.
28	Rwanda Gashonga	15.95	12	Light	Medium and Savory	Africa	Red currant, plum, pomegranate and red jam flourish with hints of chocolate.
29	Sumatra Dolok Sangull 	15.95	12	Medium Light	Clean	Indonesia	Woodsy flavors, cedar, herb, deep berry, jam, grapefruit tartness.
30	Sumatra Mandheling Gayo Mountain	13.00	12	Medium	Medium to heavy	Indonesia	Fruit, floral.
31	El Socorro Amarillo	18.95	12	Medium Light	Creamy	Central America	Strawberry, apricot, and dark honey.
33	Las Mercedes El Salvador	17.95	12	Medium Light	Smooth	Central America	Tahitian vanilla, brown sugar, roasted almonds and citrus.
34	Pacaya Espresso	17.95	12	Medium	Velvety	Central America	Chocolate brownie, dates.
35	Redcab - Brazil	14.95	12	Medium Dark	Heavy and round	South America	Nougat, nutmeg, dark chocolate.
36	Redcab - Espresso	14.95	12	Dark	Thick and round	South America	Nougat, cashew butter, dark chocolate.
37	Santander EP - FT Organic	16.95	12	Medium	Creamy	South America	Caramel, citrus, and toffee.
38	The Beast	13.75	12	Dark	Heavy and Bold	Central America	Bittersweet chocolate and snickerdoodle.
39	The Boss Espresso	16.95	12	Medium	Thick and heavy	South America	Dark chocolate and thick, bittersweet undertones, clove-like space.
40	The Heavy	16.45	12	Dark	Heavy	Central America	Deep, dark, chocolatey.
\.


--
-- Data for Name: coffee_cost; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY coffee_cost (name, price, weight) FROM stdin;
Aldo's Blend	14.00	12
Bell's Blend	14.00	12
Espresso Savio	14.00	12
Ethiopia Borboya	16.00	12
Fazenda Ambiental Fortaleza	16.00	12
Finca Idealista	16.00	12
Finca Idealista Microlots	22.00	12
Misty Valley	16.00	12
Singgalang	16.00	12
Suka Quto	16.00	12
William and Maria - Costa Rica	16.00	12
Bali Kintamani (Natural)	14.95	12
Black Velvet	12.25	12
Cosmopolitan Espresso Blend	12.25	12
Costa Rica La Magnolia	12.25	12
Costa Rican La Minita	15.95	12
Daterra Farm Reserve Espresso	13.95	12
Diesel Dark Roast	12.25	12
Espresso Intensi	12.25	12
Ethiopia Hambela Estate	15.95	12
French Roast	12.25	12
House Blend	12.25	12
Kenya AA Nguguini	15.95	12
Rocketeer Blend	12.25	12
Rwanda Gashonga	15.95	12
Sumatra Dolok Sangull 	15.95	12
Sumatra Mandheling Gayo Mountain	13.00	12
El Socorro Amarillo	18.95	12
Las Mercedes El Salvador	17.95	12
Pacaya Espresso	17.95	12
Redcab - Brazil	14.95	12
Redcab - Espresso	14.95	12
Santander EP - FT Organic	16.95	12
The Beast	13.75	12
The Boss Espresso	16.95	12
The Heavy	16.45	12
\.


--
-- Name: coffee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('coffee_id_seq', 1, false);


--
-- Data for Name: coffee_names; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY coffee_names (name, body, description) FROM stdin;
Aldo's Blend	Chewy, creamy, like a brownie	Spiced cider, dark chocolate, earthy, mequite
Bell's Blend	Chocolate Chip Cookie, Medium-light	Peanut butter, floral earth, hot cocoa with marshmallows, a happy childhood memory
Espresso Savio	Full, Sultry, and soft like Mink fur	Nutty, fresh citrus, toffee, milk chocolate
Ethiopia Borboya	Full and creamy	Blackberry, lemongrass, and peach tea
Fazenda Ambiental Fortaleza	Full yet nuanced	Plum, fig, cumin, red fruit, tawny port, blood orange
Finca Idealista	Full	Dark chocolate and ripe plums. Mellow finish
Finca Idealista Microlots	Full, Creamy	Baker's chocolate, almond, plum, cacao, juicy, citrus.
Misty Valley	Milky	Blueberry muffins, floral, baker's chocolate
Singgalang	Heavy, Syrupy, Stout	Roasted pineapple, pear, kola syrup
Suka Quto	Juicy	Stone fruit, ripe Asian pear and apricot, silky.
William and Maria - Costa Rica	Buttery, Pastry-Like	Graham cracker and lemon peel.
Bali Kintamani (Natural)	Big and full	Dark chocolate and earthy spice flavors balance with bright pops of strawberry and a subtle cream note
Black Velvet	Big	Smoky, chocolate, cocoa.
Cosmopolitan Espresso Blend	Rich and full	Milk chocolate, earthy, bittersweet tones.
Costa Rica La Magnolia	Light, smooth	Citrus, sweet.
Costa Rican La Minita	Medium	Sweet, chocolate.
Daterra Farm Reserve Espresso	Rich	Sweet almond, chocolate, citrus.
Diesel Dark Roast	Heavy	Dried fruit, spicy.
Espresso Intensi	Big	Cocoa, spice and light citrus, fruit nuances.
Ethiopia Hambela Estate	Light and Delicate	Floral and citrus flavors, lavender, bergamot and white nectarine. Toasted marshmallow finish.
French Roast	Medium to heavy	Smoky, chocolate.
House Blend	Medium	Milk chocolate, nutty.
Kenya AA Nguguini	Medium, Creamy, Jam like	Deep strawberry and blackberry.
Rocketeer Blend	Rich	Chocolate, spicy.
Rwanda Gashonga	Medium and Savory	Red currant, plum, pomegranate and red jam flourish with hints of chocolate.
Sumatra Dolok Sangull 	Clean	Woodsy flavors, cedar, herb, deep berry, jam, grapefruit tartness.
Sumatra Mandheling Gayo Mountain	Medium to heavy	Fruit, floral.
El Socorro Amarillo	Creamy	Strawberry, apricot, and dark honey.
Las Mercedes El Salvador	Smooth	Tahitian vanilla, brown sugar, roasted almonds and citrus.
Pacaya Espresso	Velvety	Chocolate brownie, dates.
Redcab - Brazil	Heavy and round	Nougat, nutmeg, dark chocolate.
Redcab - Espresso	Thick and round	Nougat, cashew butter, dark chocolate.
Santander EP - FT Organic	Creamy	Caramel, citrus, and toffee.
The Beast	Heavy and Bold	Bittersweet chocolate and snickerdoodle.
The Boss Espresso	Thick and heavy	Dark chocolate and thick, bittersweet undertones, clove-like space.
The Heavy	Heavy	Deep, dark, chocolatey.
\.


--
-- Data for Name: coffee_region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY coffee_region (name, region_id) FROM stdin;
Fazenda Ambiental Fortaleza	1
Daterra Farm Reserve Espresso	1
Redcab - Brazil	1
Redcab - Espresso	1
Santander EP - FT Organic	1
The Boss Espresso	1
Aldo's Blend	2
Bell's Blend	2
Espresso Savio	2
Finca Idealista	2
Finca Idealista Microlots	2
William and Maria - Costa Rica	2
Black Velvet	2
Cosmopolitan Espresso Blend	2
Costa Rica La Magnolia	2
Costa Rican La Minita	2
Espresso Intensi	2
House Blend	2
Rocketeer Blend	2
El Socorro Amarillo	2
Las Mercedes El Salvador	2
Pacaya Espresso	2
The Beast	2
The Heavy	2
Singgalang	3
Bali Kintamani (Natural)	3
Diesel Dark Roast	3
French Roast	3
Sumatra Dolok Sangull 	3
Sumatra Mandheling Gayo Mountain	3
Ethiopia Borboya	4
Misty Valley	4
Suka Quto	4
Ethiopia Hambela Estate	4
Kenya AA Nguguini	4
Rwanda Gashonga	4
\.


--
-- Data for Name: coffee_roast; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY coffee_roast (name, roast_id) FROM stdin;
The Boss Espresso	1
Santander EP - FT Organic	1
Pacaya Espresso	1
Sumatra Mandheling Gayo Mountain	1
Rocketeer Blend	1
House Blend	1
Daterra Farm Reserve Espresso	1
Cosmopolitan Espresso Blend	1
William and Maria - Costa Rica	1
Suka Quto	1
Singgalang	1
Misty Valley	1
Finca Idealista Microlots	1
Finca Idealista	1
Fazenda Ambiental Fortaleza	1
Ethiopia Borboya	1
Bell's Blend	1
Redcab - Brazil	2
Espresso Intensi	2
Espresso Savio	2
Aldo's Blend	2
The Heavy	3
The Beast	3
Redcab - Espresso	3
French Roast	3
Diesel Dark Roast	3
Black Velvet	3
Las Mercedes El Salvador	4
El Socorro Amarillo	4
Sumatra Dolok Sangull 	4
Costa Rica La Magnolia	4
Rwanda Gashonga	5
Kenya AA Nguguini	5
Ethiopia Hambela Estate	5
Costa Rican La Minita	5
Bali Kintamani (Natural)	5
\.


--
-- Data for Name: login; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY login (id, first_name, last_name, username, password) FROM stdin;
\.


--
-- Name: login_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('login_id_seq', 1, false);


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY region (region_id, name) FROM stdin;
1	South America
2	Central America
3	Indonesia
4	Africa
\.


--
-- Name: region_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('region_region_id_seq', 4, true);


--
-- Data for Name: roast; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roast (roast_id, roast) FROM stdin;
1	Medium
2	Medium Dark
3	Dark
4	Medium Light
5	Light
\.


--
-- Name: roast_roast_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('roast_roast_id_seq', 5, true);


--
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_info (username, email, zipcode, favorite_coffee) FROM stdin;
\.


--
-- Name: coffee_cost_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coffee_cost
    ADD CONSTRAINT coffee_cost_pkey PRIMARY KEY (name);


--
-- Name: coffee_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coffee
    ADD CONSTRAINT coffee_name_key UNIQUE (name);


--
-- Name: coffee_names_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coffee_names
    ADD CONSTRAINT coffee_names_name_key UNIQUE (name);


--
-- Name: coffee_names_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coffee_names
    ADD CONSTRAINT coffee_names_pkey PRIMARY KEY (name);


--
-- Name: coffee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coffee
    ADD CONSTRAINT coffee_pkey PRIMARY KEY (id);


--
-- Name: coffee_roast_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coffee_roast
    ADD CONSTRAINT coffee_roast_pkey PRIMARY KEY (name, roast_id);


--
-- Name: login_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY login
    ADD CONSTRAINT login_pkey PRIMARY KEY (id);


--
-- Name: login_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY login
    ADD CONSTRAINT login_username_key UNIQUE (username);


--
-- Name: region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pkey PRIMARY KEY (region_id);


--
-- Name: roast_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roast
    ADD CONSTRAINT roast_pkey PRIMARY KEY (roast_id);


--
-- Name: user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_info
    ADD CONSTRAINT user_info_pkey PRIMARY KEY (username);


--
-- Name: name; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY coffee_roast
    ADD CONSTRAINT name FOREIGN KEY (name) REFERENCES coffee_names(name);


--
-- Name: name; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY coffee_region
    ADD CONSTRAINT name FOREIGN KEY (name) REFERENCES coffee_names(name);


--
-- Name: name; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY coffee_cost
    ADD CONSTRAINT name FOREIGN KEY (name) REFERENCES coffee_names(name);


--
-- Name: roast_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY coffee_roast
    ADD CONSTRAINT roast_id FOREIGN KEY (roast_id) REFERENCES roast(roast_id);


--
-- Name: user_info_favorite_coffee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_info
    ADD CONSTRAINT user_info_favorite_coffee_fkey FOREIGN KEY (favorite_coffee) REFERENCES coffee(name);


--
-- Name: user_info_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_info
    ADD CONSTRAINT user_info_username_fkey FOREIGN KEY (username) REFERENCES login(username);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: coffee; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE coffee FROM PUBLIC;
REVOKE ALL ON TABLE coffee FROM postgres;
GRANT ALL ON TABLE coffee TO postgres;
GRANT SELECT,INSERT ON TABLE coffee TO visiting;


--
-- Name: coffee_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE coffee_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE coffee_id_seq FROM postgres;
GRANT ALL ON SEQUENCE coffee_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE coffee_id_seq TO visiting;


--
-- Name: login; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE login FROM PUBLIC;
REVOKE ALL ON TABLE login FROM postgres;
GRANT ALL ON TABLE login TO postgres;
GRANT SELECT,INSERT ON TABLE login TO visiting;


--
-- Name: login_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE login_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE login_id_seq FROM postgres;
GRANT ALL ON SEQUENCE login_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE login_id_seq TO visiting;


--
-- Name: user_info; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE user_info FROM PUBLIC;
REVOKE ALL ON TABLE user_info FROM postgres;
GRANT ALL ON TABLE user_info TO postgres;
GRANT SELECT,INSERT ON TABLE user_info TO visiting;


--
-- PostgreSQL database dump complete
--

