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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    id integer NOT NULL,
    user_id integer NOT NULL,
    random_number integer NOT NULL,
    number_of_guesses integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO freecodecamp;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(22) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO freecodecamp;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (103, 35, 264, 264);
INSERT INTO public.games VALUES (104, 35, 891, 891);
INSERT INTO public.games VALUES (105, 36, 454, 454);
INSERT INTO public.games VALUES (106, 36, 301, 301);
INSERT INTO public.games VALUES (107, 35, 578, 580);
INSERT INTO public.games VALUES (108, 35, 805, 805);
INSERT INTO public.games VALUES (109, 35, 409, 409);
INSERT INTO public.games VALUES (110, 37, 528, 529);
INSERT INTO public.games VALUES (111, 37, 72, 73);
INSERT INTO public.games VALUES (112, 38, 19, 20);
INSERT INTO public.games VALUES (113, 38, 579, 580);
INSERT INTO public.games VALUES (114, 37, 371, 374);
INSERT INTO public.games VALUES (115, 37, 121, 122);
INSERT INTO public.games VALUES (116, 37, 77, 78);
INSERT INTO public.games VALUES (117, 39, 599, 600);
INSERT INTO public.games VALUES (118, 39, 650, 651);
INSERT INTO public.games VALUES (119, 40, 997, 998);
INSERT INTO public.games VALUES (120, 40, 769, 770);
INSERT INTO public.games VALUES (121, 39, 364, 367);
INSERT INTO public.games VALUES (122, 39, 129, 130);
INSERT INTO public.games VALUES (123, 39, 696, 697);
INSERT INTO public.games VALUES (124, 41, 989, 1980);
INSERT INTO public.games VALUES (125, 41, 172, 346);
INSERT INTO public.games VALUES (126, 42, 547, 1096);
INSERT INTO public.games VALUES (127, 42, 968, 1938);
INSERT INTO public.games VALUES (128, 41, 808, 1622);
INSERT INTO public.games VALUES (129, 41, 498, 998);
INSERT INTO public.games VALUES (130, 41, 735, 1472);
INSERT INTO public.games VALUES (131, 43, 215, 432);
INSERT INTO public.games VALUES (132, 43, 507, 1016);
INSERT INTO public.games VALUES (133, 44, 229, 460);
INSERT INTO public.games VALUES (134, 44, 608, 1218);
INSERT INTO public.games VALUES (135, 43, 649, 1304);
INSERT INTO public.games VALUES (136, 43, 427, 856);
INSERT INTO public.games VALUES (137, 43, 190, 382);
INSERT INTO public.games VALUES (138, 45, 39, 80);
INSERT INTO public.games VALUES (139, 45, 11, 24);
INSERT INTO public.games VALUES (140, 46, 916, 1834);
INSERT INTO public.games VALUES (141, 46, 302, 606);
INSERT INTO public.games VALUES (142, 45, 724, 1454);
INSERT INTO public.games VALUES (143, 45, 977, 1956);
INSERT INTO public.games VALUES (144, 45, 574, 1150);
INSERT INTO public.games VALUES (145, 47, 855, 1712);
INSERT INTO public.games VALUES (146, 47, 999, 2000);
INSERT INTO public.games VALUES (147, 48, 67, 136);
INSERT INTO public.games VALUES (148, 48, 943, 1888);
INSERT INTO public.games VALUES (149, 47, 269, 544);
INSERT INTO public.games VALUES (150, 47, 203, 408);
INSERT INTO public.games VALUES (151, 47, 995, 1992);
INSERT INTO public.games VALUES (152, 49, 10, 2);
INSERT INTO public.games VALUES (153, 49, 10, 1);
INSERT INTO public.games VALUES (154, 51, 693, 694);
INSERT INTO public.games VALUES (155, 51, 692, 693);
INSERT INTO public.games VALUES (156, 52, 795, 796);
INSERT INTO public.games VALUES (157, 52, 497, 498);
INSERT INTO public.games VALUES (158, 51, 187, 190);
INSERT INTO public.games VALUES (159, 51, 735, 736);
INSERT INTO public.games VALUES (160, 51, 95, 96);
INSERT INTO public.games VALUES (161, 53, 713, 714);
INSERT INTO public.games VALUES (162, 53, 334, 335);
INSERT INTO public.games VALUES (163, 54, 289, 290);
INSERT INTO public.games VALUES (164, 54, 84, 85);
INSERT INTO public.games VALUES (165, 53, 494, 497);
INSERT INTO public.games VALUES (166, 53, 85, 86);
INSERT INTO public.games VALUES (167, 53, 850, 851);
INSERT INTO public.games VALUES (168, 55, 391, 392);
INSERT INTO public.games VALUES (169, 55, 26, 27);
INSERT INTO public.games VALUES (170, 56, 335, 336);
INSERT INTO public.games VALUES (171, 56, 947, 948);
INSERT INTO public.games VALUES (172, 55, 715, 718);
INSERT INTO public.games VALUES (173, 55, 745, 746);
INSERT INTO public.games VALUES (174, 55, 987, 988);
INSERT INTO public.games VALUES (175, 57, 429, 430);
INSERT INTO public.games VALUES (176, 57, 339, 340);
INSERT INTO public.games VALUES (177, 58, 440, 441);
INSERT INTO public.games VALUES (178, 58, 438, 439);
INSERT INTO public.games VALUES (179, 57, 93, 96);
INSERT INTO public.games VALUES (180, 57, 525, 526);
INSERT INTO public.games VALUES (181, 57, 738, 739);
INSERT INTO public.games VALUES (182, 59, 210, 211);
INSERT INTO public.games VALUES (183, 59, 830, 831);
INSERT INTO public.games VALUES (184, 60, 314, 315);
INSERT INTO public.games VALUES (185, 60, 184, 185);
INSERT INTO public.games VALUES (186, 59, 833, 836);
INSERT INTO public.games VALUES (187, 59, 43, 44);
INSERT INTO public.games VALUES (188, 59, 778, 779);
INSERT INTO public.games VALUES (189, 61, 202, 203);
INSERT INTO public.games VALUES (190, 61, 12, 13);
INSERT INTO public.games VALUES (191, 62, 929, 930);
INSERT INTO public.games VALUES (192, 62, 44, 45);
INSERT INTO public.games VALUES (193, 61, 468, 471);
INSERT INTO public.games VALUES (194, 61, 212, 213);
INSERT INTO public.games VALUES (195, 61, 30, 31);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (35, 'user_1749784501777');
INSERT INTO public.users VALUES (36, 'user_1749784501776');
INSERT INTO public.users VALUES (37, 'user_1749784514478');
INSERT INTO public.users VALUES (38, 'user_1749784514477');
INSERT INTO public.users VALUES (39, 'user_1749784531108');
INSERT INTO public.users VALUES (40, 'user_1749784531107');
INSERT INTO public.users VALUES (41, 'user_1749784604263');
INSERT INTO public.users VALUES (42, 'user_1749784604262');
INSERT INTO public.users VALUES (43, 'user_1749784659998');
INSERT INTO public.users VALUES (44, 'user_1749784659997');
INSERT INTO public.users VALUES (45, 'user_1749784680607');
INSERT INTO public.users VALUES (46, 'user_1749784680606');
INSERT INTO public.users VALUES (47, 'user_1749784726221');
INSERT INTO public.users VALUES (48, 'user_1749784726220');
INSERT INTO public.users VALUES (49, 'Gustavo');
INSERT INTO public.users VALUES (50, '10');
INSERT INTO public.users VALUES (51, 'user_1749784822473');
INSERT INTO public.users VALUES (52, 'user_1749784822472');
INSERT INTO public.users VALUES (53, 'user_1749784877595');
INSERT INTO public.users VALUES (54, 'user_1749784877594');
INSERT INTO public.users VALUES (55, 'user_1749784910903');
INSERT INTO public.users VALUES (56, 'user_1749784910902');
INSERT INTO public.users VALUES (57, 'user_1749785008116');
INSERT INTO public.users VALUES (58, 'user_1749785008115');
INSERT INTO public.users VALUES (59, 'user_1749785064002');
INSERT INTO public.users VALUES (60, 'user_1749785064001');
INSERT INTO public.users VALUES (61, 'user_1749785096849');
INSERT INTO public.users VALUES (62, 'user_1749785096848');


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_id_seq', 195, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_id_seq', 62, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

