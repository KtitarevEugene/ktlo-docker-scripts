--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4 (Debian 11.4-1.pgdg90+1)
-- Dumped by pg_dump version 11.3

-- Started on 2019-07-11 17:17:55

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

CREATE USER ktlo111 WITH
    LOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOINHERIT
    NOREPLICATION
    CONNECTION LIMIT -1
    PASSWORD '111';

--
-- TOC entry 2929 (class 1262 OID 16385)
-- Name: ktloui; Type: DATABASE; Schema: -; Owner: ktlo111
--

CREATE DATABASE ktloui WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE ktloui OWNER TO ktlo111;

\connect ktloui

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
-- TOC entry 7 (class 2615 OID 16386)
-- Name: ktlo; Type: SCHEMA; Schema: -; Owner: ktlo111
--

CREATE SCHEMA ktlo;


ALTER SCHEMA ktlo OWNER TO ktlo111;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 16390)
-- Name: authorities; Type: TABLE; Schema: ktlo; Owner: ktlo111
--

CREATE TABLE ktlo.authorities (
    id integer NOT NULL,
    authority character varying(255) NOT NULL
);


ALTER TABLE ktlo.authorities OWNER TO ktlo111;

--
-- TOC entry 197 (class 1259 OID 16388)
-- Name: authorities_id_seq; Type: SEQUENCE; Schema: ktlo; Owner: ktlo111
--

CREATE SEQUENCE ktlo.authorities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ktlo.authorities_id_seq OWNER TO ktlo111;

--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 197
-- Name: authorities_id_seq; Type: SEQUENCE OWNED BY; Schema: ktlo; Owner: ktlo111
--

ALTER SEQUENCE ktlo.authorities_id_seq OWNED BY ktlo.authorities.id;


--
-- TOC entry 200 (class 1259 OID 16398)
-- Name: tokens; Type: TABLE; Schema: ktlo; Owner: ktlo111
--

CREATE TABLE ktlo.tokens (
    id integer NOT NULL,
    access_token character varying(1000) NOT NULL,
    acquisition_time timestamp without time zone NOT NULL,
    expires_in integer NOT NULL,
    jti character varying(100) NOT NULL,
    account_non_expired boolean NOT NULL,
    account_non_locked boolean,
    credentials_non_expired boolean NOT NULL,
    email character varying(100) NOT NULL,
    enabled boolean NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    password character varying(100),
    username character varying(100) NOT NULL,
    refresh_token character varying(1000) NOT NULL,
    scope character varying(100) NOT NULL,
    token_type character varying(100) NOT NULL
);


ALTER TABLE ktlo.tokens OWNER TO ktlo111;

--
-- TOC entry 201 (class 1259 OID 16407)
-- Name: tokens_authorities; Type: TABLE; Schema: ktlo; Owner: ktlo111
--

CREATE TABLE ktlo.tokens_authorities (
    token_id integer NOT NULL,
    authority_id integer NOT NULL
);


ALTER TABLE ktlo.tokens_authorities OWNER TO ktlo111;

--
-- TOC entry 199 (class 1259 OID 16396)
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: ktlo; Owner: ktlo111
--

CREATE SEQUENCE ktlo.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ktlo.tokens_id_seq OWNER TO ktlo111;

--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 199
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: ktlo; Owner: ktlo111
--

ALTER SEQUENCE ktlo.tokens_id_seq OWNED BY ktlo.tokens.id;


--
-- TOC entry 203 (class 1259 OID 16414)
-- Name: user_state_types; Type: TABLE; Schema: ktlo; Owner: ktlo111
--

CREATE TABLE ktlo.user_state_types (
    id integer NOT NULL,
    state_type character varying(255) NOT NULL
);


ALTER TABLE ktlo.user_state_types OWNER TO ktlo111;

--
-- TOC entry 202 (class 1259 OID 16412)
-- Name: user_state_types_id_seq; Type: SEQUENCE; Schema: ktlo; Owner: ktlo111
--

CREATE SEQUENCE ktlo.user_state_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ktlo.user_state_types_id_seq OWNER TO ktlo111;

--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 202
-- Name: user_state_types_id_seq; Type: SEQUENCE OWNED BY; Schema: ktlo; Owner: ktlo111
--

ALTER SEQUENCE ktlo.user_state_types_id_seq OWNED BY ktlo.user_state_types.id;


--
-- TOC entry 205 (class 1259 OID 16422)
-- Name: users_states; Type: TABLE; Schema: ktlo; Owner: ktlo111
--

CREATE TABLE ktlo.users_states (
    id integer NOT NULL,
    state text NOT NULL,
    token_id integer NOT NULL,
    user_state_type_id integer NOT NULL
);


ALTER TABLE ktlo.users_states OWNER TO ktlo111;

--
-- TOC entry 204 (class 1259 OID 16420)
-- Name: users_states_id_seq; Type: SEQUENCE; Schema: ktlo; Owner: ktlo111
--

CREATE SEQUENCE ktlo.users_states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ktlo.users_states_id_seq OWNER TO ktlo111;

--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 204
-- Name: users_states_id_seq; Type: SEQUENCE OWNED BY; Schema: ktlo; Owner: ktlo111
--

ALTER SEQUENCE ktlo.users_states_id_seq OWNED BY ktlo.users_states.id;


--
-- TOC entry 2766 (class 2604 OID 16393)
-- Name: authorities id; Type: DEFAULT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.authorities ALTER COLUMN id SET DEFAULT nextval('ktlo.authorities_id_seq'::regclass);


--
-- TOC entry 2767 (class 2604 OID 16401)
-- Name: tokens id; Type: DEFAULT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.tokens ALTER COLUMN id SET DEFAULT nextval('ktlo.tokens_id_seq'::regclass);


--
-- TOC entry 2768 (class 2604 OID 16417)
-- Name: user_state_types id; Type: DEFAULT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.user_state_types ALTER COLUMN id SET DEFAULT nextval('ktlo.user_state_types_id_seq'::regclass);


--
-- TOC entry 2769 (class 2604 OID 16425)
-- Name: users_states id; Type: DEFAULT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.users_states ALTER COLUMN id SET DEFAULT nextval('ktlo.users_states_id_seq'::regclass);


--
-- TOC entry 2771 (class 2606 OID 16395)
-- Name: authorities authorities_pkey; Type: CONSTRAINT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.authorities
    ADD CONSTRAINT authorities_pkey PRIMARY KEY (id);


--
-- TOC entry 2780 (class 2606 OID 16411)
-- Name: tokens_authorities tokens_authorities_pkey; Type: CONSTRAINT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.tokens_authorities
    ADD CONSTRAINT tokens_authorities_pkey PRIMARY KEY (token_id, authority_id);


--
-- TOC entry 2777 (class 2606 OID 16406)
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 2784 (class 2606 OID 16419)
-- Name: user_state_types user_state_types_pkey; Type: CONSTRAINT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.user_state_types
    ADD CONSTRAINT user_state_types_pkey PRIMARY KEY (id);


--
-- TOC entry 2789 (class 2606 OID 16430)
-- Name: users_states users_states_pkey; Type: CONSTRAINT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.users_states
    ADD CONSTRAINT users_states_pkey PRIMARY KEY (id);


--
-- TOC entry 2772 (class 1259 OID 16431)
-- Name: index_authorities_id; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_authorities_id ON ktlo.authorities USING btree (id);


--
-- TOC entry 2773 (class 1259 OID 16433)
-- Name: index_tokens_access_token; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_tokens_access_token ON ktlo.tokens USING btree (access_token);


--
-- TOC entry 2778 (class 1259 OID 16435)
-- Name: index_tokens_authorities_token_id_authority_id; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_tokens_authorities_token_id_authority_id ON ktlo.tokens_authorities USING btree (token_id, authority_id);


--
-- TOC entry 2774 (class 1259 OID 16432)
-- Name: index_tokens_id; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_tokens_id ON ktlo.tokens USING btree (id);


--
-- TOC entry 2775 (class 1259 OID 16434)
-- Name: index_tokens_username; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_tokens_username ON ktlo.tokens USING btree (username);


--
-- TOC entry 2781 (class 1259 OID 16436)
-- Name: index_user_state_types_id; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_user_state_types_id ON ktlo.user_state_types USING btree (id);


--
-- TOC entry 2782 (class 1259 OID 16437)
-- Name: index_user_state_types_state_type; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_user_state_types_state_type ON ktlo.user_state_types USING btree (state_type);


--
-- TOC entry 2785 (class 1259 OID 16438)
-- Name: index_users_states_id; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_users_states_id ON ktlo.users_states USING btree (id);


--
-- TOC entry 2786 (class 1259 OID 16439)
-- Name: index_users_states_token_id; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_users_states_token_id ON ktlo.users_states USING btree (token_id);


--
-- TOC entry 2787 (class 1259 OID 16440)
-- Name: index_users_states_user_state_type_id; Type: INDEX; Schema: ktlo; Owner: ktlo111
--

CREATE INDEX index_users_states_user_state_type_id ON ktlo.users_states USING btree (user_state_type_id);


--
-- TOC entry 2791 (class 2606 OID 16446)
-- Name: tokens_authorities fk1a9wkm6wu4pivnp5m6nofny32; Type: FK CONSTRAINT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.tokens_authorities
    ADD CONSTRAINT fk1a9wkm6wu4pivnp5m6nofny32 FOREIGN KEY (token_id) REFERENCES ktlo.tokens(id);


--
-- TOC entry 2790 (class 2606 OID 16441)
-- Name: tokens_authorities fk6j09fuv8fd5xcae5ttxr3mtwt; Type: FK CONSTRAINT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.tokens_authorities
    ADD CONSTRAINT fk6j09fuv8fd5xcae5ttxr3mtwt FOREIGN KEY (authority_id) REFERENCES ktlo.authorities(id);


--
-- TOC entry 2792 (class 2606 OID 16451)
-- Name: users_states fkgk01w77qvei1s789b8co3m7ll; Type: FK CONSTRAINT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.users_states
    ADD CONSTRAINT fkgk01w77qvei1s789b8co3m7ll FOREIGN KEY (token_id) REFERENCES ktlo.tokens(id);


--
-- TOC entry 2793 (class 2606 OID 16456)
-- Name: users_states fklfvu7tqrna6xay5iaj9ryf7vv; Type: FK CONSTRAINT; Schema: ktlo; Owner: ktlo111
--

ALTER TABLE ONLY ktlo.users_states
    ADD CONSTRAINT fklfvu7tqrna6xay5iaj9ryf7vv FOREIGN KEY (user_state_type_id) REFERENCES ktlo.user_state_types(id);


--
-- TOC entry 1702 (class 826 OID 16387)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: ktlo; Owner: postgres
--

GRANT ALL PRIVILEGES ON DATABASE ktloui TO ktlo111;
GRANT ALL PRIVILEGES ON SCHEMA ktlo TO ktlo111;

-- Completed on 2019-07-11 17:17:55

--
-- PostgreSQL database dump complete
--


