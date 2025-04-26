--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: black_role; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.black_role (
    black_role_id integer NOT NULL,
    name character varying(40),
    notes character varying(255),
    has_photo boolean NOT NULL
);


ALTER TABLE public.black_role OWNER TO freecodecamp;

--
-- Name: black_role_black_role_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.black_role_black_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.black_role_black_role_id_seq OWNER TO freecodecamp;

--
-- Name: black_role_black_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.black_role_black_role_id_seq OWNED BY public.black_role.black_role_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30),
    discovery_year numeric NOT NULL,
    notes character varying(255),
    has_photo boolean DEFAULT false NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30),
    rotation_days integer,
    planet_id integer,
    notes character varying(255),
    has_photo boolean DEFAULT false NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30),
    has_rings boolean,
    star_id integer,
    notes character varying(255) DEFAULT 'Planet'::character varying NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30),
    age integer,
    description text,
    is_binary boolean,
    galaxy_id integer,
    has_photo boolean DEFAULT false NOT NULL,
    notes character varying(255)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: black_role black_role_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_role ALTER COLUMN black_role_id SET DEFAULT nextval('public.black_role_black_role_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: black_role; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.black_role VALUES (2, 'Sagittarius A*', NULL, false);
INSERT INTO public.black_role VALUES (3, 'M87*', NULL, false);
INSERT INTO public.black_role VALUES (4, 'Cygnus X-1', NULL, false);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Via Láctea', 1609, NULL, false);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 1900, NULL, false);
INSERT INTO public.galaxy VALUES (3, 'Cometa Galaxy', 1977, NULL, false);
INSERT INTO public.galaxy VALUES (4, 'Milky Way', 44, NULL, false);
INSERT INTO public.galaxy VALUES (5, 'Andromeda', 964, NULL, false);
INSERT INTO public.galaxy VALUES (6, 'Messier 87', 1781, NULL, false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 4, 1, NULL, false);
INSERT INTO public.moon VALUES (21, 'Moon', 27, 1, NULL, false);
INSERT INTO public.moon VALUES (2, 'Phobos', 0, 1, NULL, false);
INSERT INTO public.moon VALUES (3, 'Deimos', 1, 1, NULL, false);
INSERT INTO public.moon VALUES (4, 'Io', 2, 1, NULL, false);
INSERT INTO public.moon VALUES (5, 'Europa', 4, 1, NULL, false);
INSERT INTO public.moon VALUES (6, 'Ganymede', 7, 1, NULL, false);
INSERT INTO public.moon VALUES (7, 'Callisto', 17, 1, NULL, false);
INSERT INTO public.moon VALUES (8, 'Titan', 16, 1, NULL, false);
INSERT INTO public.moon VALUES (9, 'Enceladus', 1, 1, NULL, false);
INSERT INTO public.moon VALUES (10, 'Triton', 6, 1, NULL, false);
INSERT INTO public.moon VALUES (11, 'Miranda', 1, 1, NULL, false);
INSERT INTO public.moon VALUES (12, 'Ariel', 3, 1, NULL, false);
INSERT INTO public.moon VALUES (13, 'Umbriel', 4, 1, NULL, false);
INSERT INTO public.moon VALUES (14, 'Oberon', 14, 1, NULL, false);
INSERT INTO public.moon VALUES (15, 'Charon', 6, 1, NULL, false);
INSERT INTO public.moon VALUES (16, 'Dione', 3, 1, NULL, false);
INSERT INTO public.moon VALUES (17, 'Rhea', 5, 1, NULL, false);
INSERT INTO public.moon VALUES (18, 'Iapetus', 79, 1, NULL, false);
INSERT INTO public.moon VALUES (19, 'Mimas', 1, 1, NULL, false);
INSERT INTO public.moon VALUES (20, 'Hyperion', 5, 1, NULL, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (4, 'Mercury', false, 1, 'Closest planet to the Sun, no atmosphere.');
INSERT INTO public.planet VALUES (5, 'Venus', false, 1, 'Hottest planet due to thick atmosphere.');
INSERT INTO public.planet VALUES (6, 'Earth', false, 1, 'Home to known life forms.');
INSERT INTO public.planet VALUES (7, 'Mars', false, 1, 'Known as the Red Planet.');
INSERT INTO public.planet VALUES (8, 'Jupiter', true, 1, 'Largest planet, has a Great Red Spot.');
INSERT INTO public.planet VALUES (9, 'Saturn', true, 1, 'Famous for its prominent ring system.');
INSERT INTO public.planet VALUES (10, 'Uranus', true, 1, 'Rotates on its side, faint rings.');
INSERT INTO public.planet VALUES (11, 'Neptune', true, 1, 'Blue color due to methane in atmosphere.');
INSERT INTO public.planet VALUES (12, 'Pluto', false, 1, 'Dwarf planet in the Kuiper Belt.');
INSERT INTO public.planet VALUES (13, 'Ceres', false, 1, 'Dwarf planet located in the asteroid belt.');
INSERT INTO public.planet VALUES (14, 'Eris', false, 1, 'Large dwarf planet beyond Pluto.');
INSERT INTO public.planet VALUES (15, 'Haumea', false, 1, 'Elliptical dwarf planet with fast rotation.');
INSERT INTO public.planet VALUES (1, 'Earth', false, 1, '1');
INSERT INTO public.planet VALUES (2, 'Plutao', false, 1, '2');
INSERT INTO public.planet VALUES (3, 'Venus', true, 1, '3');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'UY Scuti', 9, 'A big star', true, 1, false, NULL);
INSERT INTO public.star VALUES (2, 'Big Star', 4, 'A cool star', false, 1, false, NULL);
INSERT INTO public.star VALUES (3, 'Julian Star', 8, 'Star top', true, 1, false, NULL);
INSERT INTO public.star VALUES (4, 'Sun', 4600, 'Main sequence G-type star, center of Solar System.', false, 1, false, NULL);
INSERT INTO public.star VALUES (5, 'Sirius', 242, 'Brightest star in the night sky, part of a binary system.', true, 1, false, NULL);
INSERT INTO public.star VALUES (6, 'Betelgeuse', 10, 'Red supergiant in the constellation Orion, nearing supernova.', false, 1, false, NULL);


--
-- Name: black_role_black_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.black_role_black_role_id_seq', 4, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 1, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 15, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: black_role black_role_notes_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_role
    ADD CONSTRAINT black_role_notes_key UNIQUE (notes);


--
-- Name: black_role black_role_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_role
    ADD CONSTRAINT black_role_pkey PRIMARY KEY (black_role_id);


--
-- Name: galaxy galaxy_notes_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_notes_key UNIQUE (notes);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_notes_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_notes_key UNIQUE (notes);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_notes_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_notes_key UNIQUE (notes);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_notes_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_notes_key UNIQUE (notes);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

