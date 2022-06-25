--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.23
-- Dumped by pg_dump version 9.6.23

-- Started on 2022-06-25 21:33:13

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

--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2145 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 575 (class 1247 OID 16429)
-- Name: course_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.course_type AS (
	course_name character varying
);


ALTER TYPE public.course_type OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 188 (class 1259 OID 16421)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    id integer NOT NULL,
    name character varying(300),
    department_id integer,
    credits integer
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 16400)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id character varying(300),
    name character varying(300)
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 16394)
-- Name: professor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professor (
    id integer NOT NULL,
    name character varying,
    department_id integer
);


ALTER TABLE public.professor OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16418)
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule (
    professor_id integer,
    course_id integer,
    semester integer,
    year integer
);


ALTER TABLE public.schedule OWNER TO postgres;

--
-- TOC entry 2137 (class 0 OID 16421)
-- Dependencies: 188
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (id, name, department_id, credits) FROM stdin;
9	Clinical Biochemistry	2	3
4	Astronomy	1	6
10	Clinical Neuroscience	2	5
1	Pure Mathematics and Mathematical Statistics	1	3
6	Geography	1	7
8	Chemistry	1	1
5	Physics	1	8
3	Earth Science	1	7
7	Materials Science and Metallurgy	1	5
2	Applied Mathematics and Theoretical Physics	1	5
\.


--
-- TOC entry 2135 (class 0 OID 16400)
-- Dependencies: 186
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id, name) FROM stdin;
3	Biological Sciences
5	Technology
6	Humanities & Social Sciences
2	Clinical Medicine
4	Arts and Humanities
1	Physical Sciences
\.


--
-- TOC entry 2134 (class 0 OID 16394)
-- Dependencies: 185
-- Data for Name: professor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.professor (id, name, department_id) FROM stdin;
1	John Doe	5
8	Camden Lin	1
9	Daniel Hicks	5
2	Frida Mcintosh	2
10	Timothy Hickman	4
3	Grace Avery	1
4	Ada Osborne	3
7	Sarahi Barry	2
5	Rowan Graves	1
6	Selena Owen	5
\.


--
-- TOC entry 2136 (class 0 OID 16418)
-- Dependencies: 187
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule (professor_id, course_id, semester, year) FROM stdin;
5	3	6	2012
7	3	1	2013
5	7	6	2010
2	10	2	2004
5	1	1	2011
2	9	4	2005
7	10	6	2009
5	6	4	2007
7	9	1	2014
9	9	5	2011
\.


-- Completed on 2022-06-25 21:33:14

--
-- PostgreSQL database dump complete
--

