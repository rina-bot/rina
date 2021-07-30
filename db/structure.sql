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
-- Name: message_phase; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.message_phase AS ENUM (
    'main',
    'keyword',
    'after'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achievement_triggers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achievement_triggers (
    id bigint NOT NULL,
    achievements_id bigint,
    trigger_type character varying NOT NULL,
    trigger_id bigint NOT NULL
);


--
-- Name: achievement_triggers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.achievement_triggers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: achievement_triggers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.achievement_triggers_id_seq OWNED BY public.achievement_triggers.id;


--
-- Name: achievements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achievements (
    id bigint NOT NULL,
    name text DEFAULT ''::text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    keywords text[] DEFAULT '{}'::text[] NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.achievements_id_seq OWNED BY public.achievements.id;


--
-- Name: achievements_players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achievements_players (
    achievement_id bigint,
    player_id bigint
);


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: message_grant_achievements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message_grant_achievements (
    message_id bigint NOT NULL,
    achievement_id bigint NOT NULL
);


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    trigger_id bigint NOT NULL,
    phase public.message_phase DEFAULT 'main'::public.message_phase NOT NULL,
    flag boolean DEFAULT false NOT NULL,
    keywords text[] DEFAULT '{}'::text[] NOT NULL,
    text text,
    delay double precision,
    "order" integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    trigger_type character varying NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: player_flagged_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.player_flagged_messages (
    player_id bigint NOT NULL,
    message_id bigint NOT NULL
);


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.players (
    id bigint NOT NULL,
    name text,
    line_uid text,
    line_reply_token text,
    telegram_uid integer,
    flags text[] DEFAULT '{}'::text[] NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    current_scene_id bigint
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: remote_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.remote_jobs (
    id bigint NOT NULL,
    player_id bigint NOT NULL,
    channel text NOT NULL,
    request_id uuid NOT NULL,
    started boolean DEFAULT false NOT NULL,
    finished boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: remote_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.remote_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: remote_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.remote_jobs_id_seq OWNED BY public.remote_jobs.id;


--
-- Name: scenes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scenes (
    id bigint NOT NULL,
    rails_type text,
    title text DEFAULT ''::text NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: scenes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scenes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scenes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scenes_id_seq OWNED BY public.scenes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    email character varying NOT NULL,
    encrypted_password character varying(128) NOT NULL,
    confirmation_token character varying(128),
    remember_token character varying(128) NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: achievement_triggers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement_triggers ALTER COLUMN id SET DEFAULT nextval('public.achievement_triggers_id_seq'::regclass);


--
-- Name: achievements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievements ALTER COLUMN id SET DEFAULT nextval('public.achievements_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: remote_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remote_jobs ALTER COLUMN id SET DEFAULT nextval('public.remote_jobs_id_seq'::regclass);


--
-- Name: scenes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scenes ALTER COLUMN id SET DEFAULT nextval('public.scenes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: achievement_triggers achievement_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement_triggers
    ADD CONSTRAINT achievement_triggers_pkey PRIMARY KEY (id);


--
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: remote_jobs remote_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remote_jobs
    ADD CONSTRAINT remote_jobs_pkey PRIMARY KEY (id);


--
-- Name: scenes scenes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scenes
    ADD CONSTRAINT scenes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_achievement_triggers_on_achievements_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_achievement_triggers_on_achievements_id ON public.achievement_triggers USING btree (achievements_id);


--
-- Name: index_achievements_players_on_achievement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_achievements_players_on_achievement_id ON public.achievements_players USING btree (achievement_id);


--
-- Name: index_achievements_players_on_achievement_id_and_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_achievements_players_on_achievement_id_and_player_id ON public.achievements_players USING btree (achievement_id, player_id);


--
-- Name: index_achievements_players_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_achievements_players_on_player_id ON public.achievements_players USING btree (player_id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_message_grant_achievements_on_achievement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_message_grant_achievements_on_achievement_id ON public.message_grant_achievements USING btree (achievement_id);


--
-- Name: index_message_grant_achievements_on_message_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_message_grant_achievements_on_message_id ON public.message_grant_achievements USING btree (message_id);


--
-- Name: index_messages_on_trigger_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_trigger_id ON public.messages USING btree (trigger_id);


--
-- Name: index_player_flagged_messages_on_message_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_player_flagged_messages_on_message_id ON public.player_flagged_messages USING btree (message_id);


--
-- Name: index_player_flagged_messages_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_player_flagged_messages_on_player_id ON public.player_flagged_messages USING btree (player_id);


--
-- Name: index_players_on_current_scene_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_players_on_current_scene_id ON public.players USING btree (current_scene_id);


--
-- Name: index_remote_jobs_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_remote_jobs_on_player_id ON public.remote_jobs USING btree (player_id);


--
-- Name: index_remote_jobs_on_player_id_and_channel; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_remote_jobs_on_player_id_and_channel ON public.remote_jobs USING btree (player_id, channel);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_remember_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_remember_token ON public.users USING btree (remember_token);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: player_flagged_messages fk_rails_b37a332732; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_flagged_messages
    ADD CONSTRAINT fk_rails_b37a332732 FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: players fk_rails_b81eae60cc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT fk_rails_b81eae60cc FOREIGN KEY (current_scene_id) REFERENCES public.scenes(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: player_flagged_messages fk_rails_c852989bc0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.player_flagged_messages
    ADD CONSTRAINT fk_rails_c852989bc0 FOREIGN KEY (message_id) REFERENCES public.messages(id);


--
-- Name: message_grant_achievements fk_rails_cedeeea8d4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_grant_achievements
    ADD CONSTRAINT fk_rails_cedeeea8d4 FOREIGN KEY (message_id) REFERENCES public.messages(id);


--
-- Name: message_grant_achievements fk_rails_e2576aebca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_grant_achievements
    ADD CONSTRAINT fk_rails_e2576aebca FOREIGN KEY (achievement_id) REFERENCES public.achievements(id);


--
-- Name: remote_jobs fk_rails_fb76c01f02; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.remote_jobs
    ADD CONSTRAINT fk_rails_fb76c01f02 FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210409055214'),
('20210409055728'),
('20210415095822'),
('20210416043915'),
('20210421073631'),
('20210421093852'),
('20210428031419'),
('20210428062817'),
('20210429033417'),
('20210429065630'),
('20210429113758'),
('20210430132403'),
('20210714091600');


