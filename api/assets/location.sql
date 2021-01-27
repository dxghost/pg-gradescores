--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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
-- Name: calculate_points(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculate_points() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
		total int;
	BEGIN
		delete from main_examevaluation where exam_id = old.exam_id;
		select sum(main_submission.points) from main_submission where main_submission.student_id = old.student_id and main_submission.exam_id = old.exam_id into total;
		insert into main_examevaluation(points,exam_id,student_id) values(total,old.exam_id,old.student_id);
		return new;
	END;
$$;


ALTER FUNCTION public.calculate_points() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO gradescoresuser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO gradescoresuser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO gradescoresuser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO gradescoresuser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO gradescoresuser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO gradescoresuser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO gradescoresuser;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO gradescoresuser;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO gradescoresuser;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO gradescoresuser;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO gradescoresuser;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO gradescoresuser;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO gradescoresuser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO gradescoresuser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO gradescoresuser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO gradescoresuser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO gradescoresuser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO gradescoresuser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO gradescoresuser;

--
-- Name: main_address; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_address (
    id integer NOT NULL,
    province character varying(50) NOT NULL,
    city character varying(50) NOT NULL,
    district character varying(50) NOT NULL,
    street character varying(50) NOT NULL,
    zipcode character varying(10) NOT NULL
);


ALTER TABLE public.main_address OWNER TO gradescoresuser;

--
-- Name: main_address_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_address_id_seq OWNER TO gradescoresuser;

--
-- Name: main_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_address_id_seq OWNED BY public.main_address.id;


--
-- Name: main_class; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_class (
    id integer NOT NULL,
    course_id integer NOT NULL,
    school_id integer NOT NULL,
    teacher_id integer NOT NULL
);


ALTER TABLE public.main_class OWNER TO gradescoresuser;

--
-- Name: main_class_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_class_id_seq OWNER TO gradescoresuser;

--
-- Name: main_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_class_id_seq OWNED BY public.main_class.id;


--
-- Name: main_class_students; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_class_students (
    id integer NOT NULL,
    class_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE public.main_class_students OWNER TO gradescoresuser;

--
-- Name: main_class_students_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_class_students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_class_students_id_seq OWNER TO gradescoresuser;

--
-- Name: main_class_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_class_students_id_seq OWNED BY public.main_class_students.id;


--
-- Name: main_course; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_course (
    id integer NOT NULL,
    title character varying(40) NOT NULL
);


ALTER TABLE public.main_course OWNER TO gradescoresuser;

--
-- Name: main_course_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_course_id_seq OWNER TO gradescoresuser;

--
-- Name: main_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_course_id_seq OWNED BY public.main_course.id;


--
-- Name: main_exam; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_exam (
    id integer NOT NULL,
    title character varying(60) NOT NULL,
    exam_type character varying(10) NOT NULL,
    points integer NOT NULL,
    corresponding_class_id integer NOT NULL
);


ALTER TABLE public.main_exam OWNER TO gradescoresuser;

--
-- Name: main_exam_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_exam_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_exam_id_seq OWNER TO gradescoresuser;

--
-- Name: main_exam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_exam_id_seq OWNED BY public.main_exam.id;


--
-- Name: main_examevaluation; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_examevaluation (
    id integer NOT NULL,
    points integer NOT NULL,
    exam_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE public.main_examevaluation OWNER TO gradescoresuser;

--
-- Name: main_examevaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_examevaluation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_examevaluation_id_seq OWNER TO gradescoresuser;

--
-- Name: main_examevaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_examevaluation_id_seq OWNED BY public.main_examevaluation.id;


--
-- Name: main_examquestion; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_examquestion (
    id integer NOT NULL,
    points integer,
    exam_id integer NOT NULL,
    question_id integer NOT NULL
);


ALTER TABLE public.main_examquestion OWNER TO gradescoresuser;

--
-- Name: main_examquestion_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_examquestion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_examquestion_id_seq OWNER TO gradescoresuser;

--
-- Name: main_examquestion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_examquestion_id_seq OWNED BY public.main_examquestion.id;


--
-- Name: main_fourchoice; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_fourchoice (
    id integer NOT NULL,
    first_choice character varying(100) NOT NULL,
    second_choice character varying(100) NOT NULL,
    third_choice character varying(100) NOT NULL,
    fourth_choice character varying(100) NOT NULL
);


ALTER TABLE public.main_fourchoice OWNER TO gradescoresuser;

--
-- Name: main_fourchoice_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_fourchoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_fourchoice_id_seq OWNER TO gradescoresuser;

--
-- Name: main_fourchoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_fourchoice_id_seq OWNED BY public.main_fourchoice.id;


--
-- Name: main_person; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_person (
    id integer NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(40) NOT NULL,
    national_no integer NOT NULL,
    date_of_birth date NOT NULL,
    gender character varying(1) NOT NULL
);


ALTER TABLE public.main_person OWNER TO gradescoresuser;

--
-- Name: main_person_children; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_person_children (
    id integer NOT NULL,
    person_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE public.main_person_children OWNER TO gradescoresuser;

--
-- Name: main_person_children_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_person_children_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_person_children_id_seq OWNER TO gradescoresuser;

--
-- Name: main_person_children_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_person_children_id_seq OWNED BY public.main_person_children.id;


--
-- Name: main_person_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_person_id_seq OWNER TO gradescoresuser;

--
-- Name: main_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_person_id_seq OWNED BY public.main_person.id;


--
-- Name: main_question; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_question (
    id integer NOT NULL,
    question_text character varying(300) NOT NULL,
    answer_text character varying(500) NOT NULL,
    comments character varying(200),
    correct_choice integer,
    choices_id integer,
    issuer_id integer
);


ALTER TABLE public.main_question OWNER TO gradescoresuser;

--
-- Name: main_question_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_question_id_seq OWNER TO gradescoresuser;

--
-- Name: main_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_question_id_seq OWNED BY public.main_question.id;


--
-- Name: main_school; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_school (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    gender character varying(1) NOT NULL,
    address_id integer NOT NULL,
    manager_id integer NOT NULL
);


ALTER TABLE public.main_school OWNER TO gradescoresuser;

--
-- Name: main_school_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_school_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_school_id_seq OWNER TO gradescoresuser;

--
-- Name: main_school_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_school_id_seq OWNED BY public.main_school.id;


--
-- Name: main_school_teachers; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_school_teachers (
    id integer NOT NULL,
    school_id integer NOT NULL,
    teacher_id integer NOT NULL
);


ALTER TABLE public.main_school_teachers OWNER TO gradescoresuser;

--
-- Name: main_school_teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_school_teachers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_school_teachers_id_seq OWNER TO gradescoresuser;

--
-- Name: main_school_teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_school_teachers_id_seq OWNED BY public.main_school_teachers.id;


--
-- Name: main_schoolgrade; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_schoolgrade (
    id integer NOT NULL,
    grade_no integer NOT NULL,
    school_id integer NOT NULL
);


ALTER TABLE public.main_schoolgrade OWNER TO gradescoresuser;

--
-- Name: main_schoolgrade_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_schoolgrade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_schoolgrade_id_seq OWNER TO gradescoresuser;

--
-- Name: main_schoolgrade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_schoolgrade_id_seq OWNED BY public.main_schoolgrade.id;


--
-- Name: main_student; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_student (
    personal_id integer NOT NULL,
    educational_id integer NOT NULL,
    educational_grade integer NOT NULL,
    school_id integer NOT NULL
);


ALTER TABLE public.main_student OWNER TO gradescoresuser;

--
-- Name: main_submission; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_submission (
    id integer NOT NULL,
    points integer NOT NULL,
    answer character varying(500) NOT NULL,
    sts character varying(10) NOT NULL,
    answered_choice integer NOT NULL,
    exam_id integer NOT NULL,
    question_id integer NOT NULL,
    examinar_id integer,
    student_id integer NOT NULL
);


ALTER TABLE public.main_submission OWNER TO gradescoresuser;

--
-- Name: main_submission_id_seq; Type: SEQUENCE; Schema: public; Owner: gradescoresuser
--

CREATE SEQUENCE public.main_submission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_submission_id_seq OWNER TO gradescoresuser;

--
-- Name: main_submission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gradescoresuser
--

ALTER SEQUENCE public.main_submission_id_seq OWNED BY public.main_submission.id;


--
-- Name: main_teacher; Type: TABLE; Schema: public; Owner: gradescoresuser
--

CREATE TABLE public.main_teacher (
    personal_id integer NOT NULL,
    teacher_id integer NOT NULL,
    degrees character varying(200) NOT NULL
);


ALTER TABLE public.main_teacher OWNER TO gradescoresuser;

--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: main_address id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_address ALTER COLUMN id SET DEFAULT nextval('public.main_address_id_seq'::regclass);


--
-- Name: main_class id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class ALTER COLUMN id SET DEFAULT nextval('public.main_class_id_seq'::regclass);


--
-- Name: main_class_students id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class_students ALTER COLUMN id SET DEFAULT nextval('public.main_class_students_id_seq'::regclass);


--
-- Name: main_course id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_course ALTER COLUMN id SET DEFAULT nextval('public.main_course_id_seq'::regclass);


--
-- Name: main_exam id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_exam ALTER COLUMN id SET DEFAULT nextval('public.main_exam_id_seq'::regclass);


--
-- Name: main_examevaluation id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examevaluation ALTER COLUMN id SET DEFAULT nextval('public.main_examevaluation_id_seq'::regclass);


--
-- Name: main_examquestion id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examquestion ALTER COLUMN id SET DEFAULT nextval('public.main_examquestion_id_seq'::regclass);


--
-- Name: main_fourchoice id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_fourchoice ALTER COLUMN id SET DEFAULT nextval('public.main_fourchoice_id_seq'::regclass);


--
-- Name: main_person id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_person ALTER COLUMN id SET DEFAULT nextval('public.main_person_id_seq'::regclass);


--
-- Name: main_person_children id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_person_children ALTER COLUMN id SET DEFAULT nextval('public.main_person_children_id_seq'::regclass);


--
-- Name: main_question id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_question ALTER COLUMN id SET DEFAULT nextval('public.main_question_id_seq'::regclass);


--
-- Name: main_school id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_school ALTER COLUMN id SET DEFAULT nextval('public.main_school_id_seq'::regclass);


--
-- Name: main_school_teachers id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_school_teachers ALTER COLUMN id SET DEFAULT nextval('public.main_school_teachers_id_seq'::regclass);


--
-- Name: main_schoolgrade id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_schoolgrade ALTER COLUMN id SET DEFAULT nextval('public.main_schoolgrade_id_seq'::regclass);


--
-- Name: main_submission id; Type: DEFAULT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_submission ALTER COLUMN id SET DEFAULT nextval('public.main_submission_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add address	7	add_address
26	Can change address	7	change_address
27	Can delete address	7	delete_address
28	Can view address	7	view_address
29	Can add class	8	add_class
30	Can change class	8	change_class
31	Can delete class	8	delete_class
32	Can view class	8	view_class
33	Can add course	9	add_course
34	Can change course	9	change_course
35	Can delete course	9	delete_course
36	Can view course	9	view_course
37	Can add exam	10	add_exam
38	Can change exam	10	change_exam
39	Can delete exam	10	delete_exam
40	Can view exam	10	view_exam
41	Can add four choice	11	add_fourchoice
42	Can change four choice	11	change_fourchoice
43	Can delete four choice	11	delete_fourchoice
44	Can view four choice	11	view_fourchoice
45	Can add person	12	add_person
46	Can change person	12	change_person
47	Can delete person	12	delete_person
48	Can view person	12	view_person
49	Can add question	13	add_question
50	Can change question	13	change_question
51	Can delete question	13	delete_question
52	Can view question	13	view_question
53	Can add school	14	add_school
54	Can change school	14	change_school
55	Can delete school	14	delete_school
56	Can view school	14	view_school
57	Can add student	15	add_student
58	Can change student	15	change_student
59	Can delete student	15	delete_student
60	Can view student	15	view_student
61	Can add teacher	16	add_teacher
62	Can change teacher	16	change_teacher
63	Can delete teacher	16	delete_teacher
64	Can view teacher	16	view_teacher
65	Can add exam question	17	add_examquestion
66	Can change exam question	17	change_examquestion
67	Can delete exam question	17	delete_examquestion
68	Can view exam question	17	view_examquestion
69	Can add school grade	18	add_schoolgrade
70	Can change school grade	18	change_schoolgrade
71	Can delete school grade	18	delete_schoolgrade
72	Can view school grade	18	view_schoolgrade
73	Can add submission	19	add_submission
74	Can change submission	19	change_submission
75	Can delete submission	19	delete_submission
76	Can view submission	19	view_submission
77	Can add exam evaluation	20	add_examevaluation
78	Can change exam evaluation	20	change_examevaluation
79	Can delete exam evaluation	20	delete_examevaluation
80	Can view exam evaluation	20	view_examevaluation
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	main	address
8	main	class
9	main	course
10	main	exam
11	main	fourchoice
12	main	person
13	main	question
14	main	school
15	main	student
16	main	teacher
17	main	examquestion
18	main	schoolgrade
19	main	submission
20	main	examevaluation
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-01-26 23:18:51.88844+00
2	auth	0001_initial	2021-01-26 23:18:51.939688+00
3	admin	0001_initial	2021-01-26 23:18:51.996319+00
4	admin	0002_logentry_remove_auto_add	2021-01-26 23:18:52.014676+00
5	admin	0003_logentry_add_action_flag_choices	2021-01-26 23:18:52.024169+00
6	contenttypes	0002_remove_content_type_name	2021-01-26 23:18:52.04249+00
7	auth	0002_alter_permission_name_max_length	2021-01-26 23:18:52.053249+00
8	auth	0003_alter_user_email_max_length	2021-01-26 23:18:52.063058+00
9	auth	0004_alter_user_username_opts	2021-01-26 23:18:52.074344+00
10	auth	0005_alter_user_last_login_null	2021-01-26 23:18:52.085387+00
11	auth	0006_require_contenttypes_0002	2021-01-26 23:18:52.087749+00
12	auth	0007_alter_validators_add_error_messages	2021-01-26 23:18:52.097326+00
13	auth	0008_alter_user_username_max_length	2021-01-26 23:18:52.110309+00
14	auth	0009_alter_user_last_name_max_length	2021-01-26 23:18:52.119026+00
15	auth	0010_alter_group_name_max_length	2021-01-26 23:18:52.129761+00
16	auth	0011_update_proxy_permissions	2021-01-26 23:18:52.13864+00
17	auth	0012_alter_user_first_name_max_length	2021-01-26 23:18:52.148232+00
18	main	0001_initial	2021-01-26 23:18:52.3742+00
19	sessions	0001_initial	2021-01-26 23:18:52.481204+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: main_address; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_address (id, province, city, district, street, zipcode) FROM stdin;
1	Tehran	thran	narmak	heydarkhani	zzzzz
\.


--
-- Data for Name: main_class; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_class (id, course_id, school_id, teacher_id) FROM stdin;
1	1	1	1
\.


--
-- Data for Name: main_class_students; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_class_students (id, class_id, student_id) FROM stdin;
1	1	2
\.


--
-- Data for Name: main_course; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_course (id, title) FROM stdin;
1	AI
2	AI
\.


--
-- Data for Name: main_exam; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_exam (id, title, exam_type, points, corresponding_class_id) FROM stdin;
1	Final Harvard Exam	f	50	1
\.


--
-- Data for Name: main_examevaluation; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_examevaluation (id, points, exam_id, student_id) FROM stdin;
2	20	1	2
\.


--
-- Data for Name: main_examquestion; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_examquestion (id, points, exam_id, question_id) FROM stdin;
1	20	1	1
2	30	1	2
\.


--
-- Data for Name: main_fourchoice; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_fourchoice (id, first_choice, second_choice, third_choice, fourth_choice) FROM stdin;
1	3	4	8	2
2	3	4	5	2
\.


--
-- Data for Name: main_person; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_person (id, first_name, last_name, national_no, date_of_birth, gender) FROM stdin;
1	Mahdi	Ostad	123312	2021-01-26	m
2	Hasan	Shagerd	12321	2021-01-26	m
\.


--
-- Data for Name: main_person_children; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_person_children (id, person_id, student_id) FROM stdin;
\.


--
-- Data for Name: main_question; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_question (id, question_text, answer_text, comments, correct_choice, choices_id, issuer_id) FROM stdin;
1	How many feet do you have?	two	no	4	1	1
2	How many eyes do you have?	fice	no	3	2	1
\.


--
-- Data for Name: main_school; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_school (id, name, gender, address_id, manager_id) FROM stdin;
1	Elmos	m	1	1
\.


--
-- Data for Name: main_school_teachers; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_school_teachers (id, school_id, teacher_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: main_schoolgrade; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_schoolgrade (id, grade_no, school_id) FROM stdin;
\.


--
-- Data for Name: main_student; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_student (personal_id, educational_id, educational_grade, school_id) FROM stdin;
2	32	7	1
\.


--
-- Data for Name: main_submission; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_submission (id, points, answer, sts, answered_choice, exam_id, question_id, examinar_id, student_id) FROM stdin;
1	20	3	n	1	1	1	\N	2
\.


--
-- Data for Name: main_teacher; Type: TABLE DATA; Schema: public; Owner: gradescoresuser
--

COPY public.main_teacher (personal_id, teacher_id, degrees) FROM stdin;
1	32	msc
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 80, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, false);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 20, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 19, true);


--
-- Name: main_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_address_id_seq', 1, true);


--
-- Name: main_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_class_id_seq', 1, true);


--
-- Name: main_class_students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_class_students_id_seq', 1, true);


--
-- Name: main_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_course_id_seq', 2, true);


--
-- Name: main_exam_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_exam_id_seq', 1, true);


--
-- Name: main_examevaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_examevaluation_id_seq', 2, true);


--
-- Name: main_examquestion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_examquestion_id_seq', 2, true);


--
-- Name: main_fourchoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_fourchoice_id_seq', 2, true);


--
-- Name: main_person_children_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_person_children_id_seq', 1, false);


--
-- Name: main_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_person_id_seq', 2, true);


--
-- Name: main_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_question_id_seq', 2, true);


--
-- Name: main_school_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_school_id_seq', 1, true);


--
-- Name: main_school_teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_school_teachers_id_seq', 1, true);


--
-- Name: main_schoolgrade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_schoolgrade_id_seq', 1, false);


--
-- Name: main_submission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gradescoresuser
--

SELECT pg_catalog.setval('public.main_submission_id_seq', 1, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: main_address main_address_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_address
    ADD CONSTRAINT main_address_pkey PRIMARY KEY (id);


--
-- Name: main_address main_address_zipcode_key; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_address
    ADD CONSTRAINT main_address_zipcode_key UNIQUE (zipcode);


--
-- Name: main_class main_class_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class
    ADD CONSTRAINT main_class_pkey PRIMARY KEY (id);


--
-- Name: main_class_students main_class_students_class_id_student_id_d0226078_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class_students
    ADD CONSTRAINT main_class_students_class_id_student_id_d0226078_uniq UNIQUE (class_id, student_id);


--
-- Name: main_class_students main_class_students_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class_students
    ADD CONSTRAINT main_class_students_pkey PRIMARY KEY (id);


--
-- Name: main_class main_class_teacher_id_course_id_school_id_89ea21d0_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class
    ADD CONSTRAINT main_class_teacher_id_course_id_school_id_89ea21d0_uniq UNIQUE (teacher_id, course_id, school_id);


--
-- Name: main_course main_course_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_course
    ADD CONSTRAINT main_course_pkey PRIMARY KEY (id);


--
-- Name: main_exam main_exam_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_exam
    ADD CONSTRAINT main_exam_pkey PRIMARY KEY (id);


--
-- Name: main_examevaluation main_examevaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examevaluation
    ADD CONSTRAINT main_examevaluation_pkey PRIMARY KEY (id);


--
-- Name: main_examevaluation main_examevaluation_student_id_exam_id_96f1409f_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examevaluation
    ADD CONSTRAINT main_examevaluation_student_id_exam_id_96f1409f_uniq UNIQUE (student_id, exam_id);


--
-- Name: main_examquestion main_examquestion_exam_id_question_id_3e628d6c_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examquestion
    ADD CONSTRAINT main_examquestion_exam_id_question_id_3e628d6c_uniq UNIQUE (exam_id, question_id);


--
-- Name: main_examquestion main_examquestion_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examquestion
    ADD CONSTRAINT main_examquestion_pkey PRIMARY KEY (id);


--
-- Name: main_fourchoice main_fourchoice_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_fourchoice
    ADD CONSTRAINT main_fourchoice_pkey PRIMARY KEY (id);


--
-- Name: main_person_children main_person_children_person_id_student_id_809945e1_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_person_children
    ADD CONSTRAINT main_person_children_person_id_student_id_809945e1_uniq UNIQUE (person_id, student_id);


--
-- Name: main_person_children main_person_children_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_person_children
    ADD CONSTRAINT main_person_children_pkey PRIMARY KEY (id);


--
-- Name: main_person main_person_national_no_key; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_person
    ADD CONSTRAINT main_person_national_no_key UNIQUE (national_no);


--
-- Name: main_person main_person_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_person
    ADD CONSTRAINT main_person_pkey PRIMARY KEY (id);


--
-- Name: main_question main_question_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_question
    ADD CONSTRAINT main_question_pkey PRIMARY KEY (id);


--
-- Name: main_school main_school_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_school
    ADD CONSTRAINT main_school_pkey PRIMARY KEY (id);


--
-- Name: main_school_teachers main_school_teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_school_teachers
    ADD CONSTRAINT main_school_teachers_pkey PRIMARY KEY (id);


--
-- Name: main_school_teachers main_school_teachers_school_id_teacher_id_fb994d50_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_school_teachers
    ADD CONSTRAINT main_school_teachers_school_id_teacher_id_fb994d50_uniq UNIQUE (school_id, teacher_id);


--
-- Name: main_schoolgrade main_schoolgrade_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_schoolgrade
    ADD CONSTRAINT main_schoolgrade_pkey PRIMARY KEY (id);


--
-- Name: main_schoolgrade main_schoolgrade_school_id_grade_no_d500ef4a_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_schoolgrade
    ADD CONSTRAINT main_schoolgrade_school_id_grade_no_d500ef4a_uniq UNIQUE (school_id, grade_no);


--
-- Name: main_student main_student_educational_id_key; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_student
    ADD CONSTRAINT main_student_educational_id_key UNIQUE (educational_id);


--
-- Name: main_student main_student_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_student
    ADD CONSTRAINT main_student_pkey PRIMARY KEY (personal_id);


--
-- Name: main_submission main_submission_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_submission
    ADD CONSTRAINT main_submission_pkey PRIMARY KEY (id);


--
-- Name: main_submission main_submission_student_id_exam_id_question_id_d9c84aef_uniq; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_submission
    ADD CONSTRAINT main_submission_student_id_exam_id_question_id_d9c84aef_uniq UNIQUE (student_id, exam_id, question_id);


--
-- Name: main_teacher main_teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_teacher
    ADD CONSTRAINT main_teacher_pkey PRIMARY KEY (personal_id);


--
-- Name: main_teacher main_teacher_teacher_id_key; Type: CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_teacher
    ADD CONSTRAINT main_teacher_teacher_id_key UNIQUE (teacher_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: main_address_zipcode_ed401679_like; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_address_zipcode_ed401679_like ON public.main_address USING btree (zipcode varchar_pattern_ops);


--
-- Name: main_class_course_id_7d20eb5c; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_class_course_id_7d20eb5c ON public.main_class USING btree (course_id);


--
-- Name: main_class_school_id_a5a95772; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_class_school_id_a5a95772 ON public.main_class USING btree (school_id);


--
-- Name: main_class_students_class_id_50b8867f; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_class_students_class_id_50b8867f ON public.main_class_students USING btree (class_id);


--
-- Name: main_class_students_student_id_6aa19a2c; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_class_students_student_id_6aa19a2c ON public.main_class_students USING btree (student_id);


--
-- Name: main_class_teacher_id_89f98fda; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_class_teacher_id_89f98fda ON public.main_class USING btree (teacher_id);


--
-- Name: main_exam_corresponding_class_id_e398f3dd; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_exam_corresponding_class_id_e398f3dd ON public.main_exam USING btree (corresponding_class_id);


--
-- Name: main_examevaluation_exam_id_0dc9846b; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_examevaluation_exam_id_0dc9846b ON public.main_examevaluation USING btree (exam_id);


--
-- Name: main_examevaluation_student_id_e8ea4624; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_examevaluation_student_id_e8ea4624 ON public.main_examevaluation USING btree (student_id);


--
-- Name: main_examquestion_exam_id_64aa9e9d; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_examquestion_exam_id_64aa9e9d ON public.main_examquestion USING btree (exam_id);


--
-- Name: main_examquestion_question_id_30144a04; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_examquestion_question_id_30144a04 ON public.main_examquestion USING btree (question_id);


--
-- Name: main_person_children_person_id_211d4f91; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_person_children_person_id_211d4f91 ON public.main_person_children USING btree (person_id);


--
-- Name: main_person_children_student_id_56cf3986; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_person_children_student_id_56cf3986 ON public.main_person_children USING btree (student_id);


--
-- Name: main_question_choices_id_4b900488; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_question_choices_id_4b900488 ON public.main_question USING btree (choices_id);


--
-- Name: main_question_issuer_id_2678391c; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_question_issuer_id_2678391c ON public.main_question USING btree (issuer_id);


--
-- Name: main_school_address_id_32789934; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_school_address_id_32789934 ON public.main_school USING btree (address_id);


--
-- Name: main_school_manager_id_75af1fcb; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_school_manager_id_75af1fcb ON public.main_school USING btree (manager_id);


--
-- Name: main_school_teachers_school_id_b3447d4a; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_school_teachers_school_id_b3447d4a ON public.main_school_teachers USING btree (school_id);


--
-- Name: main_school_teachers_teacher_id_608b08a9; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_school_teachers_teacher_id_608b08a9 ON public.main_school_teachers USING btree (teacher_id);


--
-- Name: main_schoolgrade_school_id_90a0a852; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_schoolgrade_school_id_90a0a852 ON public.main_schoolgrade USING btree (school_id);


--
-- Name: main_student_school_id_bebbf0a8; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_student_school_id_bebbf0a8 ON public.main_student USING btree (school_id);


--
-- Name: main_submission_exam_id_f65dd28e; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_submission_exam_id_f65dd28e ON public.main_submission USING btree (exam_id);


--
-- Name: main_submission_examinar_id_9fc2e2dd; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_submission_examinar_id_9fc2e2dd ON public.main_submission USING btree (examinar_id);


--
-- Name: main_submission_question_id_6fbd3757; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_submission_question_id_6fbd3757 ON public.main_submission USING btree (question_id);


--
-- Name: main_submission_student_id_49dd63c7; Type: INDEX; Schema: public; Owner: gradescoresuser
--

CREATE INDEX main_submission_student_id_49dd63c7 ON public.main_submission USING btree (student_id);


--
-- Name: main_submission calculate_points_trigger; Type: TRIGGER; Schema: public; Owner: gradescoresuser
--

CREATE TRIGGER calculate_points_trigger AFTER UPDATE ON public.main_submission FOR EACH ROW EXECUTE FUNCTION public.calculate_points();


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_class main_class_course_id_7d20eb5c_fk_main_course_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class
    ADD CONSTRAINT main_class_course_id_7d20eb5c_fk_main_course_id FOREIGN KEY (course_id) REFERENCES public.main_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_class main_class_school_id_a5a95772_fk_main_school_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class
    ADD CONSTRAINT main_class_school_id_a5a95772_fk_main_school_id FOREIGN KEY (school_id) REFERENCES public.main_school(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_class_students main_class_students_class_id_50b8867f_fk_main_class_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class_students
    ADD CONSTRAINT main_class_students_class_id_50b8867f_fk_main_class_id FOREIGN KEY (class_id) REFERENCES public.main_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_class_students main_class_students_student_id_6aa19a2c_fk_main_stud; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class_students
    ADD CONSTRAINT main_class_students_student_id_6aa19a2c_fk_main_stud FOREIGN KEY (student_id) REFERENCES public.main_student(personal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_class main_class_teacher_id_89f98fda_fk_main_teacher_personal_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_class
    ADD CONSTRAINT main_class_teacher_id_89f98fda_fk_main_teacher_personal_id FOREIGN KEY (teacher_id) REFERENCES public.main_teacher(personal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_exam main_exam_corresponding_class_id_e398f3dd_fk_main_class_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_exam
    ADD CONSTRAINT main_exam_corresponding_class_id_e398f3dd_fk_main_class_id FOREIGN KEY (corresponding_class_id) REFERENCES public.main_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_examevaluation main_examevaluation_exam_id_0dc9846b_fk_main_exam_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examevaluation
    ADD CONSTRAINT main_examevaluation_exam_id_0dc9846b_fk_main_exam_id FOREIGN KEY (exam_id) REFERENCES public.main_exam(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_examevaluation main_examevaluation_student_id_e8ea4624_fk_main_stud; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examevaluation
    ADD CONSTRAINT main_examevaluation_student_id_e8ea4624_fk_main_stud FOREIGN KEY (student_id) REFERENCES public.main_student(personal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_examquestion main_examquestion_exam_id_64aa9e9d_fk_main_exam_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examquestion
    ADD CONSTRAINT main_examquestion_exam_id_64aa9e9d_fk_main_exam_id FOREIGN KEY (exam_id) REFERENCES public.main_exam(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_examquestion main_examquestion_question_id_30144a04_fk_main_question_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_examquestion
    ADD CONSTRAINT main_examquestion_question_id_30144a04_fk_main_question_id FOREIGN KEY (question_id) REFERENCES public.main_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_person_children main_person_children_person_id_211d4f91_fk_main_person_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_person_children
    ADD CONSTRAINT main_person_children_person_id_211d4f91_fk_main_person_id FOREIGN KEY (person_id) REFERENCES public.main_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_person_children main_person_children_student_id_56cf3986_fk_main_stud; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_person_children
    ADD CONSTRAINT main_person_children_student_id_56cf3986_fk_main_stud FOREIGN KEY (student_id) REFERENCES public.main_student(personal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_question main_question_choices_id_4b900488_fk_main_fourchoice_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_question
    ADD CONSTRAINT main_question_choices_id_4b900488_fk_main_fourchoice_id FOREIGN KEY (choices_id) REFERENCES public.main_fourchoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_question main_question_issuer_id_2678391c_fk_main_teacher_personal_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_question
    ADD CONSTRAINT main_question_issuer_id_2678391c_fk_main_teacher_personal_id FOREIGN KEY (issuer_id) REFERENCES public.main_teacher(personal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_school main_school_address_id_32789934_fk_main_address_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_school
    ADD CONSTRAINT main_school_address_id_32789934_fk_main_address_id FOREIGN KEY (address_id) REFERENCES public.main_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_school main_school_manager_id_75af1fcb_fk_main_person_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_school
    ADD CONSTRAINT main_school_manager_id_75af1fcb_fk_main_person_id FOREIGN KEY (manager_id) REFERENCES public.main_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_school_teachers main_school_teachers_school_id_b3447d4a_fk_main_school_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_school_teachers
    ADD CONSTRAINT main_school_teachers_school_id_b3447d4a_fk_main_school_id FOREIGN KEY (school_id) REFERENCES public.main_school(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_school_teachers main_school_teachers_teacher_id_608b08a9_fk_main_teac; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_school_teachers
    ADD CONSTRAINT main_school_teachers_teacher_id_608b08a9_fk_main_teac FOREIGN KEY (teacher_id) REFERENCES public.main_teacher(personal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_schoolgrade main_schoolgrade_school_id_90a0a852_fk_main_school_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_schoolgrade
    ADD CONSTRAINT main_schoolgrade_school_id_90a0a852_fk_main_school_id FOREIGN KEY (school_id) REFERENCES public.main_school(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_student main_student_personal_id_e81d44ef_fk_main_person_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_student
    ADD CONSTRAINT main_student_personal_id_e81d44ef_fk_main_person_id FOREIGN KEY (personal_id) REFERENCES public.main_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_student main_student_school_id_bebbf0a8_fk_main_school_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_student
    ADD CONSTRAINT main_student_school_id_bebbf0a8_fk_main_school_id FOREIGN KEY (school_id) REFERENCES public.main_school(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_submission main_submission_exam_id_f65dd28e_fk_main_exam_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_submission
    ADD CONSTRAINT main_submission_exam_id_f65dd28e_fk_main_exam_id FOREIGN KEY (exam_id) REFERENCES public.main_exam(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_submission main_submission_examinar_id_9fc2e2dd_fk_main_teac; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_submission
    ADD CONSTRAINT main_submission_examinar_id_9fc2e2dd_fk_main_teac FOREIGN KEY (examinar_id) REFERENCES public.main_teacher(personal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_submission main_submission_question_id_6fbd3757_fk_main_question_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_submission
    ADD CONSTRAINT main_submission_question_id_6fbd3757_fk_main_question_id FOREIGN KEY (question_id) REFERENCES public.main_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_submission main_submission_student_id_49dd63c7_fk_main_student_personal_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_submission
    ADD CONSTRAINT main_submission_student_id_49dd63c7_fk_main_student_personal_id FOREIGN KEY (student_id) REFERENCES public.main_student(personal_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_teacher main_teacher_personal_id_86f4f314_fk_main_person_id; Type: FK CONSTRAINT; Schema: public; Owner: gradescoresuser
--

ALTER TABLE ONLY public.main_teacher
    ADD CONSTRAINT main_teacher_personal_id_86f4f314_fk_main_person_id FOREIGN KEY (personal_id) REFERENCES public.main_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

