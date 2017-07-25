--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts_users (
    id integer NOT NULL,
    email character varying(255),
    username character varying(255),
    password_hash character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: accounts_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE accounts_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE accounts_users_id_seq OWNED BY accounts_users.id;


--
-- Name: fiction_chapters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fiction_chapters (
    id integer NOT NULL,
    title character varying(255),
    raw text,
    body text,
    number integer,
    story_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fiction_chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fiction_chapters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fiction_chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fiction_chapters_id_seq OWNED BY fiction_chapters.id;


--
-- Name: fiction_stories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fiction_stories (
    id integer NOT NULL,
    title character varying(255),
    summary text,
    chapter_count integer,
    author_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: fiction_stories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fiction_stories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fiction_stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fiction_stories_id_seq OWNED BY fiction_stories.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts_users ALTER COLUMN id SET DEFAULT nextval('accounts_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiction_chapters ALTER COLUMN id SET DEFAULT nextval('fiction_chapters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiction_stories ALTER COLUMN id SET DEFAULT nextval('fiction_stories_id_seq'::regclass);


--
-- Name: accounts_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts_users
    ADD CONSTRAINT accounts_users_pkey PRIMARY KEY (id);


--
-- Name: fiction_chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiction_chapters
    ADD CONSTRAINT fiction_chapters_pkey PRIMARY KEY (id);


--
-- Name: fiction_stories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiction_stories
    ADD CONSTRAINT fiction_stories_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: accounts_users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX accounts_users_email_index ON accounts_users USING btree (email);


--
-- Name: accounts_users_username_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX accounts_users_username_index ON accounts_users USING btree (username);


--
-- Name: fiction_chapters_story_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fiction_chapters_story_id_index ON fiction_chapters USING btree (story_id);


--
-- Name: fiction_chapters_story_id_number_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX fiction_chapters_story_id_number_index ON fiction_chapters USING btree (story_id, number);


--
-- Name: fiction_stories_author_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fiction_stories_author_id_index ON fiction_stories USING btree (author_id);


--
-- Name: fiction_chapters_story_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiction_chapters
    ADD CONSTRAINT fiction_chapters_story_id_fkey FOREIGN KEY (story_id) REFERENCES fiction_stories(id) ON DELETE CASCADE;


--
-- Name: fiction_stories_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fiction_stories
    ADD CONSTRAINT fiction_stories_author_id_fkey FOREIGN KEY (author_id) REFERENCES accounts_users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20170715015910), (20170717172231), (20170717212739);

