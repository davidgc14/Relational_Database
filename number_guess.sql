--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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
    gamer_id integer NOT NULL,
    random_number integer NOT NULL,
    tries integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    gamer_id integer NOT NULL,
    name character varying(22)
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

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.gamer_id;


--
-- Name: users gamer_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN gamer_id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 455, 100);
INSERT INTO public.games VALUES (1, 355, 9);
INSERT INTO public.games VALUES (15, 562, 562);
INSERT INTO public.games VALUES (15, 849, 849);
INSERT INTO public.games VALUES (16, 351, 351);
INSERT INTO public.games VALUES (16, 475, 475);
INSERT INTO public.games VALUES (15, 671, 672);
INSERT INTO public.games VALUES (15, 759, 759);
INSERT INTO public.games VALUES (15, 690, 690);
INSERT INTO public.games VALUES (17, 224, 224);
INSERT INTO public.games VALUES (17, 87, 87);
INSERT INTO public.games VALUES (18, 589, 589);
INSERT INTO public.games VALUES (18, 242, 242);
INSERT INTO public.games VALUES (17, 67, 68);
INSERT INTO public.games VALUES (17, 122, 122);
INSERT INTO public.games VALUES (17, 447, 447);
INSERT INTO public.games VALUES (19, 391, 10);
INSERT INTO public.games VALUES (20, 191, 191);
INSERT INTO public.games VALUES (20, 187, 187);
INSERT INTO public.games VALUES (21, 933, 933);
INSERT INTO public.games VALUES (21, 73, 73);
INSERT INTO public.games VALUES (20, 485, 486);
INSERT INTO public.games VALUES (20, 367, 367);
INSERT INTO public.games VALUES (20, 298, 298);
INSERT INTO public.games VALUES (22, 956, 957);
INSERT INTO public.games VALUES (22, 18, 19);
INSERT INTO public.games VALUES (23, 166, 167);
INSERT INTO public.games VALUES (23, 350, 351);
INSERT INTO public.games VALUES (22, 577, 580);
INSERT INTO public.games VALUES (22, 234, 236);
INSERT INTO public.games VALUES (22, 96, 97);
INSERT INTO public.games VALUES (24, 374, 375);
INSERT INTO public.games VALUES (24, 99, 100);
INSERT INTO public.games VALUES (25, 593, 594);
INSERT INTO public.games VALUES (25, 302, 303);
INSERT INTO public.games VALUES (24, 64, 67);
INSERT INTO public.games VALUES (24, 825, 827);
INSERT INTO public.games VALUES (24, 233, 234);
INSERT INTO public.games VALUES (26, 4, 5);
INSERT INTO public.games VALUES (26, 177, 178);
INSERT INTO public.games VALUES (27, 375, 376);
INSERT INTO public.games VALUES (27, 297, 298);
INSERT INTO public.games VALUES (26, 464, 467);
INSERT INTO public.games VALUES (26, 600, 602);
INSERT INTO public.games VALUES (26, 338, 339);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'David');
INSERT INTO public.users VALUES (15, 'user_1666171971281');
INSERT INTO public.users VALUES (16, 'user_1666171971280');
INSERT INTO public.users VALUES (17, 'user_1666172059317');
INSERT INTO public.users VALUES (18, 'user_1666172059316');
INSERT INTO public.users VALUES (19, 'Mari');
INSERT INTO public.users VALUES (20, 'user_1666172166419');
INSERT INTO public.users VALUES (21, 'user_1666172166418');
INSERT INTO public.users VALUES (22, 'user_1666172265847');
INSERT INTO public.users VALUES (23, 'user_1666172265846');
INSERT INTO public.users VALUES (24, 'user_1666172291029');
INSERT INTO public.users VALUES (25, 'user_1666172291028');
INSERT INTO public.users VALUES (26, 'user_1666172299646');
INSERT INTO public.users VALUES (27, 'user_1666172299645');


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_id_seq', 27, true);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (gamer_id);


--
-- Name: games games_gamer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_gamer_id_fkey FOREIGN KEY (gamer_id) REFERENCES public.users(gamer_id);


--
-- PostgreSQL database dump complete
--

