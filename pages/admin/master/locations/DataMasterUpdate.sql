--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

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
-- Name: booking; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA booking;


ALTER SCHEMA booking OWNER TO postgres;

--
-- Name: hotel; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hotel;


ALTER SCHEMA hotel OWNER TO postgres;

--
-- Name: humanresource; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA humanresource;


ALTER SCHEMA humanresource OWNER TO postgres;

--
-- Name: master; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA master;


ALTER SCHEMA master OWNER TO postgres;

--
-- Name: payment; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA payment;


ALTER SCHEMA payment OWNER TO postgres;

--
-- Name: purchasing; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA purchasing;


ALTER SCHEMA purchasing OWNER TO postgres;

--
-- Name: resto; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA resto;


ALTER SCHEMA resto OWNER TO postgres;

--
-- Name: users; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA users;


ALTER SCHEMA users OWNER TO postgres;

--
-- Name: locationsfunctions(); Type: FUNCTION; Schema: master; Owner: postgres
--

CREATE FUNCTION master.locationsfunctions() RETURNS TABLE(region_code integer, region_name character varying, country_id integer, country_name character varying, prov_id integer, prov_name character varying, addr_id integer, addr_line2 character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY 
		--LOCATIONS--
		SELECT rg.region_code, rg.region_name, co.country_id, co.country_name, pr.prov_id, pr.prov_name, ad.addr_id, ad.addr_line2
		FROM master.country co
		JOIN master.regions rg ON co.country_region_id = rg.region_code
		JOIN master.provinces pr ON pr.prov_country_id = co.country_id
		JOIN master.address ad ON ad.addr_prov_id = pr.prov_id;
END;
$$;


ALTER FUNCTION master.locationsfunctions() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: booking_order_detail; Type: TABLE; Schema: booking; Owner: postgres
--

CREATE TABLE booking.booking_order_detail (
    border_boor_id integer,
    borde_id integer NOT NULL,
    borde_checkin timestamp without time zone,
    borde_checkout timestamp without time zone,
    borde_adults integer,
    borde_kids integer,
    borde_price money,
    borde_extra money,
    borde_discount money,
    borde_tax money,
    borde_subtotal money,
    borde_faci_id integer
);


ALTER TABLE booking.booking_order_detail OWNER TO postgres;

--
-- Name: booking_order_detail_borde_id_seq; Type: SEQUENCE; Schema: booking; Owner: postgres
--

CREATE SEQUENCE booking.booking_order_detail_borde_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE booking.booking_order_detail_borde_id_seq OWNER TO postgres;

--
-- Name: booking_order_detail_borde_id_seq; Type: SEQUENCE OWNED BY; Schema: booking; Owner: postgres
--

ALTER SEQUENCE booking.booking_order_detail_borde_id_seq OWNED BY booking.booking_order_detail.borde_id;


--
-- Name: booking_order_detail_extra; Type: TABLE; Schema: booking; Owner: postgres
--

CREATE TABLE booking.booking_order_detail_extra (
    boex_id integer NOT NULL,
    boex_price money,
    boex_qty smallint,
    boex_subtotal money,
    boex_measure_unit character varying(50),
    boex_borde_id integer,
    boex_prit_id integer
);


ALTER TABLE booking.booking_order_detail_extra OWNER TO postgres;

--
-- Name: booking_order_detail_extra_boex_id_seq; Type: SEQUENCE; Schema: booking; Owner: postgres
--

CREATE SEQUENCE booking.booking_order_detail_extra_boex_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE booking.booking_order_detail_extra_boex_id_seq OWNER TO postgres;

--
-- Name: booking_order_detail_extra_boex_id_seq; Type: SEQUENCE OWNED BY; Schema: booking; Owner: postgres
--

ALTER SEQUENCE booking.booking_order_detail_extra_boex_id_seq OWNED BY booking.booking_order_detail_extra.boex_id;


--
-- Name: booking_orders; Type: TABLE; Schema: booking; Owner: postgres
--

CREATE TABLE booking.booking_orders (
    boor_id integer NOT NULL,
    boor_order_number character varying(20),
    boor_order_date timestamp without time zone,
    boor_arrival_date timestamp without time zone,
    boor_total_room smallint,
    boor_total_guest smallint,
    boor_discount money,
    boor_total_tax money,
    boor_total_amount money,
    boor_down_payment money,
    boor_pay_type character(2),
    boor_is_paid character(2),
    boor_type character varying(15),
    boor_cardnumber character varying(25),
    boor_member_type character varying(15),
    boor_status character varying(15),
    boor_user_id integer,
    boor_hotel_id integer
);


ALTER TABLE booking.booking_orders OWNER TO postgres;

--
-- Name: booking_orders_boor_id_seq; Type: SEQUENCE; Schema: booking; Owner: postgres
--

CREATE SEQUENCE booking.booking_orders_boor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE booking.booking_orders_boor_id_seq OWNER TO postgres;

--
-- Name: booking_orders_boor_id_seq; Type: SEQUENCE OWNED BY; Schema: booking; Owner: postgres
--

ALTER SEQUENCE booking.booking_orders_boor_id_seq OWNED BY booking.booking_orders.boor_id;


--
-- Name: special_offer_coupons; Type: TABLE; Schema: booking; Owner: postgres
--

CREATE TABLE booking.special_offer_coupons (
    soco_id integer NOT NULL,
    soco_borde_id integer,
    soco_spof_id integer
);


ALTER TABLE booking.special_offer_coupons OWNER TO postgres;

--
-- Name: special_offer_coupons_soco_id_seq; Type: SEQUENCE; Schema: booking; Owner: postgres
--

CREATE SEQUENCE booking.special_offer_coupons_soco_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE booking.special_offer_coupons_soco_id_seq OWNER TO postgres;

--
-- Name: special_offer_coupons_soco_id_seq; Type: SEQUENCE OWNED BY; Schema: booking; Owner: postgres
--

ALTER SEQUENCE booking.special_offer_coupons_soco_id_seq OWNED BY booking.special_offer_coupons.soco_id;


--
-- Name: special_offers; Type: TABLE; Schema: booking; Owner: postgres
--

CREATE TABLE booking.special_offers (
    spof_id integer NOT NULL,
    spof_name character varying(55),
    spof_description character varying(255),
    spof_type character varying(50),
    spof_discount money,
    spof_start_date timestamp without time zone,
    spof_end_date timestamp without time zone,
    spof_min_qty integer,
    spof_max_qty integer,
    spof_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE booking.special_offers OWNER TO postgres;

--
-- Name: special_offers_spof_id_seq; Type: SEQUENCE; Schema: booking; Owner: postgres
--

CREATE SEQUENCE booking.special_offers_spof_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE booking.special_offers_spof_id_seq OWNER TO postgres;

--
-- Name: special_offers_spof_id_seq; Type: SEQUENCE OWNED BY; Schema: booking; Owner: postgres
--

ALTER SEQUENCE booking.special_offers_spof_id_seq OWNED BY booking.special_offers.spof_id;


--
-- Name: user_breakfeast; Type: TABLE; Schema: booking; Owner: postgres
--

CREATE TABLE booking.user_breakfeast (
    usbr_borde_id integer,
    usbr_modified_date timestamp without time zone DEFAULT now() NOT NULL,
    usbr_total_vacant smallint
);


ALTER TABLE booking.user_breakfeast OWNER TO postgres;

--
-- Name: facilities; Type: TABLE; Schema: hotel; Owner: postgres
--

CREATE TABLE hotel.facilities (
    faci_id integer NOT NULL,
    faci_name character varying(155),
    faci_description character varying(255),
    faci_max_number integer,
    faci_measure_unit character varying(15),
    faci_room_number character varying(6),
    faci_startdate timestamp without time zone,
    faci_endate timestamp without time zone,
    faci_low_price money,
    faci_hight_price money,
    faci_rate_price money,
    faci_discount money,
    faci_tax_rate money,
    faci_modified_date timestamp without time zone DEFAULT now(),
    faci_cagro_id integer,
    faci_hotel_id integer
);


ALTER TABLE hotel.facilities OWNER TO postgres;

--
-- Name: facilities_faci_id_seq; Type: SEQUENCE; Schema: hotel; Owner: postgres
--

CREATE SEQUENCE hotel.facilities_faci_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hotel.facilities_faci_id_seq OWNER TO postgres;

--
-- Name: facilities_faci_id_seq; Type: SEQUENCE OWNED BY; Schema: hotel; Owner: postgres
--

ALTER SEQUENCE hotel.facilities_faci_id_seq OWNED BY hotel.facilities.faci_id;


--
-- Name: facility_photos; Type: TABLE; Schema: hotel; Owner: postgres
--

CREATE TABLE hotel.facility_photos (
    fapho_faci_id integer,
    fapho_id integer NOT NULL,
    fapho_thumbnail_filename character varying(50),
    fapho_photo_filename character varying(50),
    fapho_primary bit(1),
    fapho_url character varying(255),
    fapho_modifield_date timestamp without time zone
);


ALTER TABLE hotel.facility_photos OWNER TO postgres;

--
-- Name: facility_photos_fapho_id_seq; Type: SEQUENCE; Schema: hotel; Owner: postgres
--

CREATE SEQUENCE hotel.facility_photos_fapho_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hotel.facility_photos_fapho_id_seq OWNER TO postgres;

--
-- Name: facility_photos_fapho_id_seq; Type: SEQUENCE OWNED BY; Schema: hotel; Owner: postgres
--

ALTER SEQUENCE hotel.facility_photos_fapho_id_seq OWNED BY hotel.facility_photos.fapho_id;


--
-- Name: facility_price_history; Type: TABLE; Schema: hotel; Owner: postgres
--

CREATE TABLE hotel.facility_price_history (
    faph_faci_id integer,
    faph_id integer NOT NULL,
    faph_startdate timestamp without time zone,
    faph_enddate timestamp without time zone,
    faph_low_price money,
    faph_high_price money,
    faph_discount money,
    faph_tax_rate money,
    faph_modified_date timestamp without time zone,
    faph_user_id integer
);


ALTER TABLE hotel.facility_price_history OWNER TO postgres;

--
-- Name: facility_price_history_faph_id_seq; Type: SEQUENCE; Schema: hotel; Owner: postgres
--

CREATE SEQUENCE hotel.facility_price_history_faph_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hotel.facility_price_history_faph_id_seq OWNER TO postgres;

--
-- Name: facility_price_history_faph_id_seq; Type: SEQUENCE OWNED BY; Schema: hotel; Owner: postgres
--

ALTER SEQUENCE hotel.facility_price_history_faph_id_seq OWNED BY hotel.facility_price_history.faph_id;


--
-- Name: hotel_reviews; Type: TABLE; Schema: hotel; Owner: postgres
--

CREATE TABLE hotel.hotel_reviews (
    hore_id integer NOT NULL,
    hore_user_review character varying(125),
    hore_rating integer,
    hore_created_on timestamp without time zone,
    hore_user_id integer,
    hore_hotel_id integer
);


ALTER TABLE hotel.hotel_reviews OWNER TO postgres;

--
-- Name: hotel_reviews_hore_id_seq; Type: SEQUENCE; Schema: hotel; Owner: postgres
--

CREATE SEQUENCE hotel.hotel_reviews_hore_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hotel.hotel_reviews_hore_id_seq OWNER TO postgres;

--
-- Name: hotel_reviews_hore_id_seq; Type: SEQUENCE OWNED BY; Schema: hotel; Owner: postgres
--

ALTER SEQUENCE hotel.hotel_reviews_hore_id_seq OWNED BY hotel.hotel_reviews.hore_id;


--
-- Name: hotels; Type: TABLE; Schema: hotel; Owner: postgres
--

CREATE TABLE hotel.hotels (
    hotel_id integer NOT NULL,
    hotel_name character varying(85),
    hotel_description character varying(500),
    hotel_rating_star smallint,
    hotel_phonenumber character varying(25),
    hotel_modified_date timestamp without time zone DEFAULT now(),
    hotel_addr_id integer
);


ALTER TABLE hotel.hotels OWNER TO postgres;

--
-- Name: hotels_hotel_id_seq; Type: SEQUENCE; Schema: hotel; Owner: postgres
--

CREATE SEQUENCE hotel.hotels_hotel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hotel.hotels_hotel_id_seq OWNER TO postgres;

--
-- Name: hotels_hotel_id_seq; Type: SEQUENCE OWNED BY; Schema: hotel; Owner: postgres
--

ALTER SEQUENCE hotel.hotels_hotel_id_seq OWNED BY hotel.hotels.hotel_id;


--
-- Name: department; Type: TABLE; Schema: humanresource; Owner: postgres
--

CREATE TABLE humanresource.department (
    dept_id integer NOT NULL,
    dept_name character varying(50),
    dept_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE humanresource.department OWNER TO postgres;

--
-- Name: department_dept_id_seq; Type: SEQUENCE; Schema: humanresource; Owner: postgres
--

CREATE SEQUENCE humanresource.department_dept_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresource.department_dept_id_seq OWNER TO postgres;

--
-- Name: department_dept_id_seq; Type: SEQUENCE OWNED BY; Schema: humanresource; Owner: postgres
--

ALTER SEQUENCE humanresource.department_dept_id_seq OWNED BY humanresource.department.dept_id;


--
-- Name: employee; Type: TABLE; Schema: humanresource; Owner: postgres
--

CREATE TABLE humanresource.employee (
    emp_id integer NOT NULL,
    emp_national_id character varying(25),
    emp_birth_date timestamp without time zone,
    emp_marital_status character(1),
    emp_gender character(1),
    emp_hire_date timestamp without time zone,
    emp_salaried_flag character(1),
    emp_vacation_hours smallint,
    emp_sickleave_hours smallint,
    emp_current_flag smallint,
    emp_photo character varying(225),
    emp_modified_date timestamp without time zone DEFAULT now(),
    emp_emp_id integer,
    emp_joro_id integer
);


ALTER TABLE humanresource.employee OWNER TO postgres;

--
-- Name: employee_department_history; Type: TABLE; Schema: humanresource; Owner: postgres
--

CREATE TABLE humanresource.employee_department_history (
    edhi_id integer NOT NULL,
    edhi_emp_id integer,
    edhi_start_date timestamp without time zone,
    edhi_end_date timestamp without time zone,
    edhi_modified_date timestamp without time zone DEFAULT now(),
    edhi_dept_id integer,
    edhi_shift_id integer
);


ALTER TABLE humanresource.employee_department_history OWNER TO postgres;

--
-- Name: employee_department_history_edhi_id_seq; Type: SEQUENCE; Schema: humanresource; Owner: postgres
--

CREATE SEQUENCE humanresource.employee_department_history_edhi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresource.employee_department_history_edhi_id_seq OWNER TO postgres;

--
-- Name: employee_department_history_edhi_id_seq; Type: SEQUENCE OWNED BY; Schema: humanresource; Owner: postgres
--

ALTER SEQUENCE humanresource.employee_department_history_edhi_id_seq OWNED BY humanresource.employee_department_history.edhi_id;


--
-- Name: employee_emp_id_seq; Type: SEQUENCE; Schema: humanresource; Owner: postgres
--

CREATE SEQUENCE humanresource.employee_emp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresource.employee_emp_id_seq OWNER TO postgres;

--
-- Name: employee_emp_id_seq; Type: SEQUENCE OWNED BY; Schema: humanresource; Owner: postgres
--

ALTER SEQUENCE humanresource.employee_emp_id_seq OWNED BY humanresource.employee.emp_id;


--
-- Name: employee_pay_history; Type: TABLE; Schema: humanresource; Owner: postgres
--

CREATE TABLE humanresource.employee_pay_history (
    ephi_emp_id integer,
    ephi_rate_change_date date NOT NULL,
    ephi_rate_salary money,
    ephi_pay_frequence smallint,
    ephi_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE humanresource.employee_pay_history OWNER TO postgres;

--
-- Name: job_role; Type: TABLE; Schema: humanresource; Owner: postgres
--

CREATE TABLE humanresource.job_role (
    joro_id integer NOT NULL,
    joro_name character varying(55),
    joro_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE humanresource.job_role OWNER TO postgres;

--
-- Name: job_role_joro_id_seq; Type: SEQUENCE; Schema: humanresource; Owner: postgres
--

CREATE SEQUENCE humanresource.job_role_joro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresource.job_role_joro_id_seq OWNER TO postgres;

--
-- Name: job_role_joro_id_seq; Type: SEQUENCE OWNED BY; Schema: humanresource; Owner: postgres
--

ALTER SEQUENCE humanresource.job_role_joro_id_seq OWNED BY humanresource.job_role.joro_id;


--
-- Name: shift; Type: TABLE; Schema: humanresource; Owner: postgres
--

CREATE TABLE humanresource.shift (
    shift_id integer NOT NULL,
    shift_name character varying(25),
    shift_start_time timestamp without time zone,
    shift_end_time timestamp without time zone
);


ALTER TABLE humanresource.shift OWNER TO postgres;

--
-- Name: shift_shift_id_seq; Type: SEQUENCE; Schema: humanresource; Owner: postgres
--

CREATE SEQUENCE humanresource.shift_shift_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresource.shift_shift_id_seq OWNER TO postgres;

--
-- Name: shift_shift_id_seq; Type: SEQUENCE OWNED BY; Schema: humanresource; Owner: postgres
--

ALTER SEQUENCE humanresource.shift_shift_id_seq OWNED BY humanresource.shift.shift_id;


--
-- Name: work_order_detail; Type: TABLE; Schema: humanresource; Owner: postgres
--

CREATE TABLE humanresource.work_order_detail (
    wode_id integer NOT NULL,
    wode_task_name character varying(255),
    wode_status character varying(15),
    wode_start_date timestamp without time zone,
    wode_end_date timestamp without time zone,
    wode_notes character varying(255),
    wode_emp_id integer,
    wode_seta_id integer,
    wode_faci_id integer,
    wode_woro_id integer
);


ALTER TABLE humanresource.work_order_detail OWNER TO postgres;

--
-- Name: work_order_detail_wode_id_seq; Type: SEQUENCE; Schema: humanresource; Owner: postgres
--

CREATE SEQUENCE humanresource.work_order_detail_wode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresource.work_order_detail_wode_id_seq OWNER TO postgres;

--
-- Name: work_order_detail_wode_id_seq; Type: SEQUENCE OWNED BY; Schema: humanresource; Owner: postgres
--

ALTER SEQUENCE humanresource.work_order_detail_wode_id_seq OWNED BY humanresource.work_order_detail.wode_id;


--
-- Name: work_orders; Type: TABLE; Schema: humanresource; Owner: postgres
--

CREATE TABLE humanresource.work_orders (
    woro_id integer NOT NULL,
    woro_start_date timestamp without time zone,
    woro_status character varying(15),
    woro_user_id integer
);


ALTER TABLE humanresource.work_orders OWNER TO postgres;

--
-- Name: work_orders_woro_id_seq; Type: SEQUENCE; Schema: humanresource; Owner: postgres
--

CREATE SEQUENCE humanresource.work_orders_woro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresource.work_orders_woro_id_seq OWNER TO postgres;

--
-- Name: work_orders_woro_id_seq; Type: SEQUENCE OWNED BY; Schema: humanresource; Owner: postgres
--

ALTER SEQUENCE humanresource.work_orders_woro_id_seq OWNED BY humanresource.work_orders.woro_id;


--
-- Name: address; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.address (
    addr_id integer NOT NULL,
    addr_line1 character varying(225),
    addr_line2 character varying(225),
    addr_postal_code character varying(5),
    addr_spatial_location json,
    addr_prov_id integer
);


ALTER TABLE master.address OWNER TO postgres;

--
-- Name: address_addr_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.address_addr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.address_addr_id_seq OWNER TO postgres;

--
-- Name: address_addr_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.address_addr_id_seq OWNED BY master.address.addr_id;


--
-- Name: category_group; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.category_group (
    cagro_id integer NOT NULL,
    cagro_name character varying(25),
    cagro_description character varying(1000),
    cagro_type character varying(25),
    cagro_icon character varying(255),
    cagro_icon_url character varying(255)
);


ALTER TABLE master.category_group OWNER TO postgres;

--
-- Name: category_group_cagro_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.category_group_cagro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.category_group_cagro_id_seq OWNER TO postgres;

--
-- Name: category_group_cagro_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.category_group_cagro_id_seq OWNED BY master.category_group.cagro_id;


--
-- Name: country; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.country (
    country_id integer NOT NULL,
    country_name character varying(55),
    country_region_id integer
);


ALTER TABLE master.country OWNER TO postgres;

--
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.country_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.country_country_id_seq OWNER TO postgres;

--
-- Name: country_country_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.country_country_id_seq OWNED BY master.country.country_id;


--
-- Name: members; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.members (
    memb_name character varying(15) NOT NULL,
    memb_description character varying(100)
);


ALTER TABLE master.members OWNER TO postgres;

--
-- Name: policy; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.policy (
    poli_id integer NOT NULL,
    poli_name character varying(55),
    poli_description character varying(255)
);


ALTER TABLE master.policy OWNER TO postgres;

--
-- Name: policy_category_group; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.policy_category_group (
    poca_poli_id integer NOT NULL,
    poca_cagro_id integer
);


ALTER TABLE master.policy_category_group OWNER TO postgres;

--
-- Name: policy_category_group_poca_poli_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.policy_category_group_poca_poli_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.policy_category_group_poca_poli_id_seq OWNER TO postgres;

--
-- Name: policy_category_group_poca_poli_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.policy_category_group_poca_poli_id_seq OWNED BY master.policy_category_group.poca_poli_id;


--
-- Name: policy_poli_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.policy_poli_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.policy_poli_id_seq OWNER TO postgres;

--
-- Name: policy_poli_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.policy_poli_id_seq OWNED BY master.policy.poli_id;


--
-- Name: price_items; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.price_items (
    prit_id integer NOT NULL,
    prit_name character varying(55),
    prit_price money,
    prit_description character varying(255),
    prit_type character varying(25),
    prit_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE master.price_items OWNER TO postgres;

--
-- Name: price_items_prit_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.price_items_prit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.price_items_prit_id_seq OWNER TO postgres;

--
-- Name: price_items_prit_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.price_items_prit_id_seq OWNED BY master.price_items.prit_id;


--
-- Name: provinces; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.provinces (
    prov_id integer NOT NULL,
    prov_name character varying(85),
    prov_country_id integer
);


ALTER TABLE master.provinces OWNER TO postgres;

--
-- Name: provinces_prov_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.provinces_prov_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.provinces_prov_id_seq OWNER TO postgres;

--
-- Name: provinces_prov_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.provinces_prov_id_seq OWNED BY master.provinces.prov_id;


--
-- Name: regions; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.regions (
    region_code integer NOT NULL,
    region_name character varying(35)
);


ALTER TABLE master.regions OWNER TO postgres;

--
-- Name: regions_region_code_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.regions_region_code_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.regions_region_code_seq OWNER TO postgres;

--
-- Name: regions_region_code_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.regions_region_code_seq OWNED BY master.regions.region_code;


--
-- Name: service_task; Type: TABLE; Schema: master; Owner: postgres
--

CREATE TABLE master.service_task (
    seta_id integer NOT NULL,
    seta_name character varying(85),
    seta_seq smallint
);


ALTER TABLE master.service_task OWNER TO postgres;

--
-- Name: service_task_seta_id_seq; Type: SEQUENCE; Schema: master; Owner: postgres
--

CREATE SEQUENCE master.service_task_seta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.service_task_seta_id_seq OWNER TO postgres;

--
-- Name: service_task_seta_id_seq; Type: SEQUENCE OWNED BY; Schema: master; Owner: postgres
--

ALTER SEQUENCE master.service_task_seta_id_seq OWNED BY master.service_task.seta_id;


--
-- Name: bank; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.bank (
    bank_entity_id integer NOT NULL,
    bank_code character varying(10),
    bank_name character varying(55),
    bank_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE payment.bank OWNER TO postgres;

--
-- Name: entities; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.entities (
    entity_id integer NOT NULL
);


ALTER TABLE payment.entities OWNER TO postgres;

--
-- Name: entities_entity_id_seq; Type: SEQUENCE; Schema: payment; Owner: postgres
--

CREATE SEQUENCE payment.entities_entity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment.entities_entity_id_seq OWNER TO postgres;

--
-- Name: entities_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: payment; Owner: postgres
--

ALTER SEQUENCE payment.entities_entity_id_seq OWNED BY payment.entities.entity_id;


--
-- Name: payment_gateaway; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.payment_gateaway (
    paga_entity_id integer NOT NULL,
    paga_code character varying(10),
    paga_name character varying(55),
    paga_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE payment.payment_gateaway OWNER TO postgres;

--
-- Name: payment_transaction; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.payment_transaction (
    patr_id integer NOT NULL,
    patr_trx_number character varying(55),
    patr_debet numeric,
    patr_credit numeric,
    patr_type character(3),
    patr_note character varying(255),
    patr_modified_date timestamp without time zone DEFAULT now(),
    patr_order_number character varying(55),
    patr_trx_number_ref character varying(55),
    patr_source_id integer,
    patr_target_id integer,
    patr_user_id integer
);


ALTER TABLE payment.payment_transaction OWNER TO postgres;

--
-- Name: payment_transaction_patr_id_seq; Type: SEQUENCE; Schema: payment; Owner: postgres
--

CREATE SEQUENCE payment.payment_transaction_patr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment.payment_transaction_patr_id_seq OWNER TO postgres;

--
-- Name: payment_transaction_patr_id_seq; Type: SEQUENCE OWNED BY; Schema: payment; Owner: postgres
--

ALTER SEQUENCE payment.payment_transaction_patr_id_seq OWNED BY payment.payment_transaction.patr_id;


--
-- Name: user_accounts; Type: TABLE; Schema: payment; Owner: postgres
--

CREATE TABLE payment.user_accounts (
    usac_entity_id integer NOT NULL,
    usac_user_id integer NOT NULL,
    usac_account_number character varying(25),
    usac_saldo numeric,
    usac_type character varying(15),
    usac_expmonth smallint,
    usac_expyear smallint,
    usac_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE payment.user_accounts OWNER TO postgres;

--
-- Name: purchase_order_detail; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_order_detail (
    pode_pohe_id integer,
    pode_id integer NOT NULL,
    pode_order_qty smallint,
    pode_price money,
    pode_line_total money,
    pode_received_qty numeric,
    pode_rejected_qty numeric,
    pode_stocked_qty numeric,
    pode_modified_date timestamp without time zone DEFAULT now(),
    pode_stock_id integer
);


ALTER TABLE purchasing.purchase_order_detail OWNER TO postgres;

--
-- Name: purchase_order_detail_pode_id_seq; Type: SEQUENCE; Schema: purchasing; Owner: postgres
--

CREATE SEQUENCE purchasing.purchase_order_detail_pode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.purchase_order_detail_pode_id_seq OWNER TO postgres;

--
-- Name: purchase_order_detail_pode_id_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: postgres
--

ALTER SEQUENCE purchasing.purchase_order_detail_pode_id_seq OWNED BY purchasing.purchase_order_detail.pode_id;


--
-- Name: purchase_order_header; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_order_header (
    pohe_id integer NOT NULL,
    pohe_number character varying(20),
    pohe_status smallint,
    pohe_order_date timestamp without time zone,
    pohe_subtotal money,
    pohe_tax money,
    pohe_total_amount money,
    pohe_refund money,
    pohe_arrival_date timestamp without time zone,
    pohe_pay_tipe character varying(2),
    pohe_emp_id integer,
    pohe_vendor_id integer
);


ALTER TABLE purchasing.purchase_order_header OWNER TO postgres;

--
-- Name: purchase_order_header_pohe_id_seq; Type: SEQUENCE; Schema: purchasing; Owner: postgres
--

CREATE SEQUENCE purchasing.purchase_order_header_pohe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.purchase_order_header_pohe_id_seq OWNER TO postgres;

--
-- Name: purchase_order_header_pohe_id_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: postgres
--

ALTER SEQUENCE purchasing.purchase_order_header_pohe_id_seq OWNED BY purchasing.purchase_order_header.pohe_id;


--
-- Name: stock_detail; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.stock_detail (
    stod_stock_id integer,
    stod_id integer NOT NULL,
    stod_barcode_number character varying(225),
    stod_status character varying(2),
    stod_notes character varying(1024),
    stod_faci_id integer,
    stod_pohe_id integer
);


ALTER TABLE purchasing.stock_detail OWNER TO postgres;

--
-- Name: stock_detail_stod_id_seq; Type: SEQUENCE; Schema: purchasing; Owner: postgres
--

CREATE SEQUENCE purchasing.stock_detail_stod_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.stock_detail_stod_id_seq OWNER TO postgres;

--
-- Name: stock_detail_stod_id_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: postgres
--

ALTER SEQUENCE purchasing.stock_detail_stod_id_seq OWNED BY purchasing.stock_detail.stod_id;


--
-- Name: stock_photo; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.stock_photo (
    spho_id integer NOT NULL,
    spho_thumbnail_filename character varying(50),
    spho_photo_filename character varying(50),
    spho_primary integer,
    spho_url character varying(255),
    spho_stock_id integer
);


ALTER TABLE purchasing.stock_photo OWNER TO postgres;

--
-- Name: stock_photo_spho_id_seq; Type: SEQUENCE; Schema: purchasing; Owner: postgres
--

CREATE SEQUENCE purchasing.stock_photo_spho_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.stock_photo_spho_id_seq OWNER TO postgres;

--
-- Name: stock_photo_spho_id_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: postgres
--

ALTER SEQUENCE purchasing.stock_photo_spho_id_seq OWNED BY purchasing.stock_photo.spho_id;


--
-- Name: stocks; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.stocks (
    stock_id integer NOT NULL,
    stock_name character varying(255),
    stock_description character varying(255),
    stock_quantity smallint,
    stock_reorder_point smallint,
    stock_used smallint,
    stock_scrap smallint,
    stock_price money,
    stock_standar_cost money,
    stock_size character varying(25),
    stock_color character varying(15),
    stock_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE purchasing.stocks OWNER TO postgres;

--
-- Name: stocks_stock_id_seq; Type: SEQUENCE; Schema: purchasing; Owner: postgres
--

CREATE SEQUENCE purchasing.stocks_stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.stocks_stock_id_seq OWNER TO postgres;

--
-- Name: stocks_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: postgres
--

ALTER SEQUENCE purchasing.stocks_stock_id_seq OWNED BY purchasing.stocks.stock_id;


--
-- Name: vendor; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.vendor (
    vendor_id integer NOT NULL,
    vendor_name character varying(55),
    vendor_active integer,
    vendor_priority integer,
    vendor_register_date timestamp without time zone,
    vendor_weburi character varying(1024),
    vendor_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE purchasing.vendor OWNER TO postgres;

--
-- Name: vendor_vendor_id_seq; Type: SEQUENCE; Schema: purchasing; Owner: postgres
--

CREATE SEQUENCE purchasing.vendor_vendor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.vendor_vendor_id_seq OWNER TO postgres;

--
-- Name: vendor_vendor_id_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: postgres
--

ALTER SEQUENCE purchasing.vendor_vendor_id_seq OWNED BY purchasing.vendor.vendor_id;


--
-- Name: order_menu_detail; Type: TABLE; Schema: resto; Owner: postgres
--

CREATE TABLE resto.order_menu_detail (
    omde_id integer NOT NULL,
    orme_price money,
    orme_qty smallint,
    orme_subtotal money,
    orme_discount money,
    omde_orme_id integer,
    omde_reme_id integer
);


ALTER TABLE resto.order_menu_detail OWNER TO postgres;

--
-- Name: order_menu_detail_omde_id_seq; Type: SEQUENCE; Schema: resto; Owner: postgres
--

CREATE SEQUENCE resto.order_menu_detail_omde_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE resto.order_menu_detail_omde_id_seq OWNER TO postgres;

--
-- Name: order_menu_detail_omde_id_seq; Type: SEQUENCE OWNED BY; Schema: resto; Owner: postgres
--

ALTER SEQUENCE resto.order_menu_detail_omde_id_seq OWNED BY resto.order_menu_detail.omde_id;


--
-- Name: order_menus; Type: TABLE; Schema: resto; Owner: postgres
--

CREATE TABLE resto.order_menus (
    orme_id integer NOT NULL,
    orme_order_number character varying(20),
    orme_order_date timestamp without time zone,
    orme_total_item smallint,
    orme_total_discount money,
    orme_total_amount money,
    orme_pay_type character(2),
    orme_cardnumber character varying(25),
    orme_is_paid character(2),
    orme_modified_date timestamp without time zone DEFAULT now(),
    orme_user_id integer
);


ALTER TABLE resto.order_menus OWNER TO postgres;

--
-- Name: order_menus_orme_id_seq; Type: SEQUENCE; Schema: resto; Owner: postgres
--

CREATE SEQUENCE resto.order_menus_orme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE resto.order_menus_orme_id_seq OWNER TO postgres;

--
-- Name: order_menus_orme_id_seq; Type: SEQUENCE OWNED BY; Schema: resto; Owner: postgres
--

ALTER SEQUENCE resto.order_menus_orme_id_seq OWNED BY resto.order_menus.orme_id;


--
-- Name: resto_menu_photos; Type: TABLE; Schema: resto; Owner: postgres
--

CREATE TABLE resto.resto_menu_photos (
    remp_id integer NOT NULL,
    remp_thumbnail_filename character varying(50),
    remp_photo_filename character varying(50),
    remp_primary bit(1),
    remp_url character varying(255),
    remp_reme_id integer
);


ALTER TABLE resto.resto_menu_photos OWNER TO postgres;

--
-- Name: resto_menu_photos_remp_id_seq; Type: SEQUENCE; Schema: resto; Owner: postgres
--

CREATE SEQUENCE resto.resto_menu_photos_remp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE resto.resto_menu_photos_remp_id_seq OWNER TO postgres;

--
-- Name: resto_menu_photos_remp_id_seq; Type: SEQUENCE OWNED BY; Schema: resto; Owner: postgres
--

ALTER SEQUENCE resto.resto_menu_photos_remp_id_seq OWNED BY resto.resto_menu_photos.remp_id;


--
-- Name: resto_menus; Type: TABLE; Schema: resto; Owner: postgres
--

CREATE TABLE resto.resto_menus (
    reme_faci_id integer,
    reme_id integer NOT NULL,
    reme_name character varying(55),
    reme_description character varying(255),
    reme_price money,
    reme_status character varying(15),
    reme_modified_date timestamp without time zone
);


ALTER TABLE resto.resto_menus OWNER TO postgres;

--
-- Name: resto_menus_reme_id_seq; Type: SEQUENCE; Schema: resto; Owner: postgres
--

CREATE SEQUENCE resto.resto_menus_reme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE resto.resto_menus_reme_id_seq OWNER TO postgres;

--
-- Name: resto_menus_reme_id_seq; Type: SEQUENCE OWNED BY; Schema: resto; Owner: postgres
--

ALTER SEQUENCE resto.resto_menus_reme_id_seq OWNED BY resto.resto_menus.reme_id;


--
-- Name: roles; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.roles (
    role_id integer NOT NULL,
    role_name character varying(35)
);


ALTER TABLE users.roles OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.roles_role_id_seq OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.roles_role_id_seq OWNED BY users.roles.role_id;


--
-- Name: user_bonus_points; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.user_bonus_points (
    ubpo_id integer NOT NULL,
    ubpo_user_id integer,
    ubpo_total_points integer,
    ubpo_bonus_type character(1),
    ubpo_create_on timestamp without time zone
);


ALTER TABLE users.user_bonus_points OWNER TO postgres;

--
-- Name: user_bonus_points_ubpo_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.user_bonus_points_ubpo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.user_bonus_points_ubpo_id_seq OWNER TO postgres;

--
-- Name: user_bonus_points_ubpo_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.user_bonus_points_ubpo_id_seq OWNED BY users.user_bonus_points.ubpo_id;


--
-- Name: user_members; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.user_members (
    usme_id integer NOT NULL,
    usme_user_id integer,
    usme_memb_name character varying(15),
    usme_promote_date timestamp without time zone,
    usme_points integer,
    usme_type character varying(15)
);


ALTER TABLE users.user_members OWNER TO postgres;

--
-- Name: user_members_usme_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.user_members_usme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.user_members_usme_id_seq OWNER TO postgres;

--
-- Name: user_members_usme_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.user_members_usme_id_seq OWNED BY users.user_members.usme_id;


--
-- Name: user_password; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.user_password (
    uspa_user_id integer NOT NULL,
    uspa_passwordhash character varying(128),
    uspa_passwordsalt character varying(10)
);


ALTER TABLE users.user_password OWNER TO postgres;

--
-- Name: user_profiles; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.user_profiles (
    uspro_id integer NOT NULL,
    uspro_national_id character varying(20),
    uspro_birth date,
    uspro_photo text DEFAULT 'user.png'::text,
    uspro_job_title character varying(50),
    uspro_marital_status character(1),
    uspro_gender character(1),
    uspro_addr_id integer,
    uspro_user_id integer
);


ALTER TABLE users.user_profiles OWNER TO postgres;

--
-- Name: user_profiles_uspro_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.user_profiles_uspro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.user_profiles_uspro_id_seq OWNER TO postgres;

--
-- Name: user_profiles_uspro_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.user_profiles_uspro_id_seq OWNED BY users.user_profiles.uspro_id;


--
-- Name: user_roles; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.user_roles (
    usro_user_id integer NOT NULL,
    usro_role_id integer
);


ALTER TABLE users.user_roles OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.users (
    user_id integer NOT NULL,
    user_full_name character varying(55),
    user_type character varying(15),
    user_company_name character varying(255),
    user_email character varying(256),
    user_phone_number character varying(25),
    user_isverified integer,
    user_modified_date timestamp without time zone DEFAULT now()
);


ALTER TABLE users.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.users_user_id_seq OWNED BY users.users.user_id;


--
-- Name: booking_order_detail borde_id; Type: DEFAULT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_order_detail ALTER COLUMN borde_id SET DEFAULT nextval('booking.booking_order_detail_borde_id_seq'::regclass);


--
-- Name: booking_order_detail_extra boex_id; Type: DEFAULT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_order_detail_extra ALTER COLUMN boex_id SET DEFAULT nextval('booking.booking_order_detail_extra_boex_id_seq'::regclass);


--
-- Name: booking_orders boor_id; Type: DEFAULT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_orders ALTER COLUMN boor_id SET DEFAULT nextval('booking.booking_orders_boor_id_seq'::regclass);


--
-- Name: special_offer_coupons soco_id; Type: DEFAULT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.special_offer_coupons ALTER COLUMN soco_id SET DEFAULT nextval('booking.special_offer_coupons_soco_id_seq'::regclass);


--
-- Name: special_offers spof_id; Type: DEFAULT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.special_offers ALTER COLUMN spof_id SET DEFAULT nextval('booking.special_offers_spof_id_seq'::regclass);


--
-- Name: facilities faci_id; Type: DEFAULT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facilities ALTER COLUMN faci_id SET DEFAULT nextval('hotel.facilities_faci_id_seq'::regclass);


--
-- Name: facility_photos fapho_id; Type: DEFAULT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facility_photos ALTER COLUMN fapho_id SET DEFAULT nextval('hotel.facility_photos_fapho_id_seq'::regclass);


--
-- Name: facility_price_history faph_id; Type: DEFAULT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facility_price_history ALTER COLUMN faph_id SET DEFAULT nextval('hotel.facility_price_history_faph_id_seq'::regclass);


--
-- Name: hotel_reviews hore_id; Type: DEFAULT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.hotel_reviews ALTER COLUMN hore_id SET DEFAULT nextval('hotel.hotel_reviews_hore_id_seq'::regclass);


--
-- Name: hotels hotel_id; Type: DEFAULT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.hotels ALTER COLUMN hotel_id SET DEFAULT nextval('hotel.hotels_hotel_id_seq'::regclass);


--
-- Name: department dept_id; Type: DEFAULT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.department ALTER COLUMN dept_id SET DEFAULT nextval('humanresource.department_dept_id_seq'::regclass);


--
-- Name: employee emp_id; Type: DEFAULT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee ALTER COLUMN emp_id SET DEFAULT nextval('humanresource.employee_emp_id_seq'::regclass);


--
-- Name: employee_department_history edhi_id; Type: DEFAULT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee_department_history ALTER COLUMN edhi_id SET DEFAULT nextval('humanresource.employee_department_history_edhi_id_seq'::regclass);


--
-- Name: job_role joro_id; Type: DEFAULT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.job_role ALTER COLUMN joro_id SET DEFAULT nextval('humanresource.job_role_joro_id_seq'::regclass);


--
-- Name: shift shift_id; Type: DEFAULT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.shift ALTER COLUMN shift_id SET DEFAULT nextval('humanresource.shift_shift_id_seq'::regclass);


--
-- Name: work_order_detail wode_id; Type: DEFAULT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.work_order_detail ALTER COLUMN wode_id SET DEFAULT nextval('humanresource.work_order_detail_wode_id_seq'::regclass);


--
-- Name: work_orders woro_id; Type: DEFAULT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.work_orders ALTER COLUMN woro_id SET DEFAULT nextval('humanresource.work_orders_woro_id_seq'::regclass);


--
-- Name: address addr_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address ALTER COLUMN addr_id SET DEFAULT nextval('master.address_addr_id_seq'::regclass);


--
-- Name: category_group cagro_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.category_group ALTER COLUMN cagro_id SET DEFAULT nextval('master.category_group_cagro_id_seq'::regclass);


--
-- Name: country country_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.country ALTER COLUMN country_id SET DEFAULT nextval('master.country_country_id_seq'::regclass);


--
-- Name: policy poli_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.policy ALTER COLUMN poli_id SET DEFAULT nextval('master.policy_poli_id_seq'::regclass);


--
-- Name: policy_category_group poca_poli_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.policy_category_group ALTER COLUMN poca_poli_id SET DEFAULT nextval('master.policy_category_group_poca_poli_id_seq'::regclass);


--
-- Name: price_items prit_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.price_items ALTER COLUMN prit_id SET DEFAULT nextval('master.price_items_prit_id_seq'::regclass);


--
-- Name: provinces prov_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.provinces ALTER COLUMN prov_id SET DEFAULT nextval('master.provinces_prov_id_seq'::regclass);


--
-- Name: regions region_code; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.regions ALTER COLUMN region_code SET DEFAULT nextval('master.regions_region_code_seq'::regclass);


--
-- Name: service_task seta_id; Type: DEFAULT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.service_task ALTER COLUMN seta_id SET DEFAULT nextval('master.service_task_seta_id_seq'::regclass);


--
-- Name: entities entity_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.entities ALTER COLUMN entity_id SET DEFAULT nextval('payment.entities_entity_id_seq'::regclass);


--
-- Name: payment_transaction patr_id; Type: DEFAULT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payment_transaction ALTER COLUMN patr_id SET DEFAULT nextval('payment.payment_transaction_patr_id_seq'::regclass);


--
-- Name: purchase_order_detail pode_id; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail ALTER COLUMN pode_id SET DEFAULT nextval('purchasing.purchase_order_detail_pode_id_seq'::regclass);


--
-- Name: purchase_order_header pohe_id; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header ALTER COLUMN pohe_id SET DEFAULT nextval('purchasing.purchase_order_header_pohe_id_seq'::regclass);


--
-- Name: stock_detail stod_id; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stock_detail ALTER COLUMN stod_id SET DEFAULT nextval('purchasing.stock_detail_stod_id_seq'::regclass);


--
-- Name: stock_photo spho_id; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stock_photo ALTER COLUMN spho_id SET DEFAULT nextval('purchasing.stock_photo_spho_id_seq'::regclass);


--
-- Name: stocks stock_id; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stocks ALTER COLUMN stock_id SET DEFAULT nextval('purchasing.stocks_stock_id_seq'::regclass);


--
-- Name: vendor vendor_id; Type: DEFAULT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.vendor ALTER COLUMN vendor_id SET DEFAULT nextval('purchasing.vendor_vendor_id_seq'::regclass);


--
-- Name: order_menu_detail omde_id; Type: DEFAULT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.order_menu_detail ALTER COLUMN omde_id SET DEFAULT nextval('resto.order_menu_detail_omde_id_seq'::regclass);


--
-- Name: order_menus orme_id; Type: DEFAULT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.order_menus ALTER COLUMN orme_id SET DEFAULT nextval('resto.order_menus_orme_id_seq'::regclass);


--
-- Name: resto_menu_photos remp_id; Type: DEFAULT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.resto_menu_photos ALTER COLUMN remp_id SET DEFAULT nextval('resto.resto_menu_photos_remp_id_seq'::regclass);


--
-- Name: resto_menus reme_id; Type: DEFAULT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.resto_menus ALTER COLUMN reme_id SET DEFAULT nextval('resto.resto_menus_reme_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.roles ALTER COLUMN role_id SET DEFAULT nextval('users.roles_role_id_seq'::regclass);


--
-- Name: user_bonus_points ubpo_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_bonus_points ALTER COLUMN ubpo_id SET DEFAULT nextval('users.user_bonus_points_ubpo_id_seq'::regclass);


--
-- Name: user_members usme_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_members ALTER COLUMN usme_id SET DEFAULT nextval('users.user_members_usme_id_seq'::regclass);


--
-- Name: user_profiles uspro_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_profiles ALTER COLUMN uspro_id SET DEFAULT nextval('users.user_profiles_uspro_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users ALTER COLUMN user_id SET DEFAULT nextval('users.users_user_id_seq'::regclass);


--
-- Data for Name: booking_order_detail; Type: TABLE DATA; Schema: booking; Owner: postgres
--

COPY booking.booking_order_detail (border_boor_id, borde_id, borde_checkin, borde_checkout, borde_adults, borde_kids, borde_price, borde_extra, borde_discount, borde_tax, borde_subtotal, borde_faci_id) FROM stdin;
\.


--
-- Data for Name: booking_order_detail_extra; Type: TABLE DATA; Schema: booking; Owner: postgres
--

COPY booking.booking_order_detail_extra (boex_id, boex_price, boex_qty, boex_subtotal, boex_measure_unit, boex_borde_id, boex_prit_id) FROM stdin;
\.


--
-- Data for Name: booking_orders; Type: TABLE DATA; Schema: booking; Owner: postgres
--

COPY booking.booking_orders (boor_id, boor_order_number, boor_order_date, boor_arrival_date, boor_total_room, boor_total_guest, boor_discount, boor_total_tax, boor_total_amount, boor_down_payment, boor_pay_type, boor_is_paid, boor_type, boor_cardnumber, boor_member_type, boor_status, boor_user_id, boor_hotel_id) FROM stdin;
\.


--
-- Data for Name: special_offer_coupons; Type: TABLE DATA; Schema: booking; Owner: postgres
--

COPY booking.special_offer_coupons (soco_id, soco_borde_id, soco_spof_id) FROM stdin;
\.


--
-- Data for Name: special_offers; Type: TABLE DATA; Schema: booking; Owner: postgres
--

COPY booking.special_offers (spof_id, spof_name, spof_description, spof_type, spof_discount, spof_start_date, spof_end_date, spof_min_qty, spof_max_qty, spof_modified_date) FROM stdin;
\.


--
-- Data for Name: user_breakfeast; Type: TABLE DATA; Schema: booking; Owner: postgres
--

COPY booking.user_breakfeast (usbr_borde_id, usbr_modified_date, usbr_total_vacant) FROM stdin;
\.


--
-- Data for Name: facilities; Type: TABLE DATA; Schema: hotel; Owner: postgres
--

COPY hotel.facilities (faci_id, faci_name, faci_description, faci_max_number, faci_measure_unit, faci_room_number, faci_startdate, faci_endate, faci_low_price, faci_hight_price, faci_rate_price, faci_discount, faci_tax_rate, faci_modified_date, faci_cagro_id, faci_hotel_id) FROM stdin;
\.


--
-- Data for Name: facility_photos; Type: TABLE DATA; Schema: hotel; Owner: postgres
--

COPY hotel.facility_photos (fapho_faci_id, fapho_id, fapho_thumbnail_filename, fapho_photo_filename, fapho_primary, fapho_url, fapho_modifield_date) FROM stdin;
\.


--
-- Data for Name: facility_price_history; Type: TABLE DATA; Schema: hotel; Owner: postgres
--

COPY hotel.facility_price_history (faph_faci_id, faph_id, faph_startdate, faph_enddate, faph_low_price, faph_high_price, faph_discount, faph_tax_rate, faph_modified_date, faph_user_id) FROM stdin;
\.


--
-- Data for Name: hotel_reviews; Type: TABLE DATA; Schema: hotel; Owner: postgres
--

COPY hotel.hotel_reviews (hore_id, hore_user_review, hore_rating, hore_created_on, hore_user_id, hore_hotel_id) FROM stdin;
\.


--
-- Data for Name: hotels; Type: TABLE DATA; Schema: hotel; Owner: postgres
--

COPY hotel.hotels (hotel_id, hotel_name, hotel_description, hotel_rating_star, hotel_phonenumber, hotel_modified_date, hotel_addr_id) FROM stdin;
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: humanresource; Owner: postgres
--

COPY humanresource.department (dept_id, dept_name, dept_modified_date) FROM stdin;
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: humanresource; Owner: postgres
--

COPY humanresource.employee (emp_id, emp_national_id, emp_birth_date, emp_marital_status, emp_gender, emp_hire_date, emp_salaried_flag, emp_vacation_hours, emp_sickleave_hours, emp_current_flag, emp_photo, emp_modified_date, emp_emp_id, emp_joro_id) FROM stdin;
\.


--
-- Data for Name: employee_department_history; Type: TABLE DATA; Schema: humanresource; Owner: postgres
--

COPY humanresource.employee_department_history (edhi_id, edhi_emp_id, edhi_start_date, edhi_end_date, edhi_modified_date, edhi_dept_id, edhi_shift_id) FROM stdin;
\.


--
-- Data for Name: employee_pay_history; Type: TABLE DATA; Schema: humanresource; Owner: postgres
--

COPY humanresource.employee_pay_history (ephi_emp_id, ephi_rate_change_date, ephi_rate_salary, ephi_pay_frequence, ephi_modified_date) FROM stdin;
\.


--
-- Data for Name: job_role; Type: TABLE DATA; Schema: humanresource; Owner: postgres
--

COPY humanresource.job_role (joro_id, joro_name, joro_modified_date) FROM stdin;
\.


--
-- Data for Name: shift; Type: TABLE DATA; Schema: humanresource; Owner: postgres
--

COPY humanresource.shift (shift_id, shift_name, shift_start_time, shift_end_time) FROM stdin;
\.


--
-- Data for Name: work_order_detail; Type: TABLE DATA; Schema: humanresource; Owner: postgres
--

COPY humanresource.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id) FROM stdin;
\.


--
-- Data for Name: work_orders; Type: TABLE DATA; Schema: humanresource; Owner: postgres
--

COPY humanresource.work_orders (woro_id, woro_start_date, woro_status, woro_user_id) FROM stdin;
\.


--
-- Data for Name: address; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.address (addr_id, addr_line1, addr_line2, addr_postal_code, addr_spatial_location, addr_prov_id) FROM stdin;
1	\N	Jakarta Selatan	\N	\N	1
2	\N	Jakarta Utara	\N	\N	1
\.


--
-- Data for Name: category_group; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.category_group (cagro_id, cagro_name, cagro_description, cagro_type, cagro_icon, cagro_icon_url) FROM stdin;
4	Gym	Salah satu rekomendasi gym terbaik  Bogor adalah Fitness Larasati. Di tempat ini, kamu bisa melakukan berbagai gerakan weight-lifting dengan bantuan alat-alat olahraga yang memadai.	Fasility	gym.jpeg	https://firebasestorage.googleapis.com/v0/b/hotelrealta-9cdce.appspot.com/o/image%2Fgym.jpeg?alt=media&token=68785a6c-22eb-4953-8e42-82214292ab0c
5	Aula	Merupakan salah satu aula yang ada di Kota Bogor. Aula ini sering digunakan untuk kegiatan seperti seminar, pertemuan, rapat, workshop, pelatihan, sosialisasi dan kegiatan sejenis.\r\n\r\nSegera kunjungi aula terdekat ini untuk informasi lebih lanjut seperti proses penyewaan aula, izin menggunakan aula dan lainnya.	Fasility	Aula.jpeg	https://firebasestorage.googleapis.com/v0/b/hotelrealta-9cdce.appspot.com/o/image%2FAula.jpeg?alt=media&token=22b10290-5af5-465c-b5ac-03704bf24c90
6	SwimmingPool	Swimming pool (kolam renang) yang berada di Kota Bogor. Swimming pool ini sering dimanfaatkan oleh warga Kota Bogor untuk olahraga renang dan rekreasi air. Sagara Swimming Pool memiliki desain dengan baik, aman, terawat, air jernih serta dilengkapi fasilitas yang lengkap seperti kantin, kamar ganti dan kamar mandi.		pool.jpeg	https://firebasestorage.googleapis.com/v0/b/hotelrealta-9cdce.appspot.com/o/image%2Fpool.jpeg?alt=media&token=f092dfc8-7037-4f80-a6aa-13a75ec27493
7	Balroom	Salah satu pilihan ballroom di Kota Bogor. Ballroom ini cocok digunakan untuk melangsungkan berbagai acara seperti konferensi / conference, rapat, seminar, workshop, pertemuan, dan kegiatan umum lainnya. Selain itu, GD. POETRI BALLROOM juga bisa menjadi pilihan lokasi resepsi, pernikahan dan hajatan.	Fasility	Balroom.jpeg	https://firebasestorage.googleapis.com/v0/b/hotelrealta-9cdce.appspot.com/o/image%2FBalroom.jpeg?alt=media&token=06897e20-9a51-410a-83a3-ad669d71f7b1
1	Restaurant	Rincian : \r\n- MASAKAN\r\nMakanan Laut, Asia, Indonesia\r\n\r\n- DIET KHUSUS\r\nHalal\r\n\r\n- MAKANAN\r\nMakan Siang, Makan Malam	Fasility	restaurant.jpeg	https://firebasestorage.googleapis.com/v0/b/hotelrealta-9cdce.appspot.com/o/image%2Frestaurant.jpeg?alt=media&token=140ec854-cd7a-447f-a266-cfb42189f316
2	Room	Kamar Superior seluas 32 meter persegi menawarkan shower, Mini Bar, AC, akses Internet berkecepatan tinggi, tersedia kamar bebas rokok, televisi kabel, pengering rambut, setrika & papan besi (atas permintaan), telepon IDD, pembuat kopi &teh, brankas, layanan Shoeshine 24 jam, bantal tambahan dengan berbagai jenis	Fasility	rooms.jpeg	https://firebasestorage.googleapis.com/v0/b/hotelrealta-9cdce.appspot.com/o/image%2Frooms.jpeg?alt=media&token=ba9014a7-7ac6-4de5-abde-6cb1853ea496
3	Meeting-Room	untuk pertemuan skala-menengah, ASTON Bogor Menyediakan empat ruang pertemuan modern berperabotan lengkap yang dapat menampung hingga 300 tamu. Sempurna untuk diskusi bisnis dan seminar skala kecil, serta acara pesta pribadi.	Fasility	Meeting Rooms.jpeg	https://firebasestorage.googleapis.com/v0/b/hotelrealta-9cdce.appspot.com/o/image%2FMeeting%20Rooms.jpeg?alt=media&token=6839e78d-1b93-4294-961d-bc43f44c1f1e
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.country (country_id, country_name, country_region_id) FROM stdin;
2	Malaysia	1
3	Jepang	1
4	Tiongkok	1
5	Singapura	1
1	Indonesia	1
6	Vietnam	1
7	Myanmar	1
8	Korea Selatan	1
9	Africa	2
10	Ghana	2
11	Afrika Selatan	2
12	Kamerun	2
13	Kenya	2
14	Madagaskar	2
15	Malawi	2
16	Maroko	2
17	New South Wales	3
18	Victoia 	3
19	Queensland 	3
\.


--
-- Data for Name: members; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.members (memb_name, memb_description) FROM stdin;
SILVER	Akses ke fasilitas hotel dasar
GOLD	Akses ke fasilitas dasar dan premium hotel, termasuk sarapan gratis dan upgrade kamar
VIP	Akses ke semua fasilitas hotel, termasuk layanan concierge yang didedikasikan dan diskon eksklusif
WIZARD	Akses prioritas ke semua fasilitas dan layanan hotel,  concierge pribadi  kamar 24 jam
\.


--
-- Data for Name: policy; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.policy (poli_id, poli_name, poli_description) FROM stdin;
1	Check-in Policy	Check-in time is at 2:00 PM, early check-in is subject to availability
2	Cancellation Policy	Cancellations must be made 48 hours prior to arrival to avoid charges
3	Pet Policy	Pets are not allowed in the hotel
4	Smoking Policy	Smoking is not permitted inside the hotel
5	Child Policy	Children under 12 years old stay for free when using existing bedding
6	Extra Bed Policy	Extra beds are available for an additional charge
7	Wifi Policy	Complimentary WiFi is available in all guest rooms
8	Parking Policy	Valet parking is available for a fee
9	Food Policy	All-day dining is available in the hotel restaurant
10	Check-out Policy	Check-out time is at 12:00 PM, late check-out is subject to availability
11	Payment Policy	We accept all major credit cards and cash
12	Fitness Policy	Complimentary access to the fitness center is available for guests
13	Pool Policy	The pool is open from 6:00 AM to 10:00 PM
14	Spa Policy	Spa treatments must be booked in advance
15	Luggage Policy	Luggage storage is available for a fee
16	Business Policy	Business center services are available for guests
17	Group Policy	Group rates are available for parties of 10 or more
18	Disability Policy	Disability-friendly rooms are available upon request
19	Alcohol Policy	Alcoholic beverages are available for purchase in the hotel
20	Jack Daniel's	Strong
21	Martels	Medium
\.


--
-- Data for Name: policy_category_group; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.policy_category_group (poca_poli_id, poca_cagro_id) FROM stdin;
\.


--
-- Data for Name: price_items; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.price_items (prit_id, prit_name, prit_price, prit_description, prit_type, prit_modified_date) FROM stdin;
10	Penyimpanan Bagasi	$30,000.00	Harga untuk penyimpanan bagasi per tas per hari	Service	2023-03-12 23:04:50.016
11	Layanan Pusat Bisnis	$50,000.00	Harga untuk layanan pusat bisnis per jam	Service	2023-03-12 23:04:50.016
12	Layanan Kamar	$80,000.00	Harga untuk layanan kamar per pesanan	Service	2023-03-12 23:04:50.016
13	Akses Kolam Renang	$30,000.00	Harga untuk akses ke kolam renang per hari	Fasility	2023-03-12 23:04:50.016
16	Wi-Fi	$50,000.00	Harga untuk akses Wi-Fi per hari	Fasility	2023-03-12 23:04:50.016
17	Gym Instructor	$300,000.00	Harga untuk layanan pelatih pribadi per jam	Fasility	2023-03-12 23:04:50.016
1	Ekstra Bed	$200,000.00	Harga untuk tambahan tempat tidur per malam	Fasility	2023-03-12 22:52:55.981
2	Sarapan	$80,000.00	Harga untuk sarapan per orang per hari	Food	2023-03-12 22:54:17.5
3	Makan Siang	$120,000.00	Harga untuk makan siang per orang per hari	Food	2023-03-12 22:54:49.224
5	Pengobatan Spa	$500,000.00	Harga untuk pengobatan spa per jam	Service	2023-03-12 22:56:26.051
14	Minuman Beralkohol	$60,000.00	Harga untuk minuman beralkohol per gelas	SOFTDRINK	2023-03-12 23:04:50.016844
15	Laundry	$30,000.00	Harga untuk layanan laundry per kg	SERVICE	2023-03-12 23:04:50.016844
4	Makan Malam	$150,000.00	Harga untuk makan malam per orang per hari	Food	2023-03-12 22:55:31.645
6	Akses Kebugaran	$60,000.00	Harga untuk akses ke pusat kebugaran per hari	Fasility	2023-03-12 23:04:50.016
7	Parkir Valet	$100,000.00	Harga untuk parkir valet per hari	Fasility	2023-03-12 23:04:50.016
8	Check-in Awal	$250,000.00	Harga untuk check-in awal	Service	2023-03-12 23:04:50.016
9	Check-out Terlambat	$250,000.00	Harga untuk check-out terlambat	Service	2023-03-12 23:04:50.016
\.


--
-- Data for Name: provinces; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.provinces (prov_id, prov_name, prov_country_id) FROM stdin;
1	Jakarta	1
5	Jawa Timur	1
9	Sumatra Barat	1
10	Sumatra Selatan	1
11	Sumatra Utara	1
12	Kalimantan Timur	1
13	Kalimatan Barat	1
14	Tokyo	3
15	KualaLumpur	2
16	Negeri Sembilan	2
2	DKI Jakarta	1
3	Jawa Barat	1
4	Jawa Tengah	1
6	Bali	1
7	Banten	1
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.regions (region_code, region_name) FROM stdin;
1	Asia
2	Africa
3	Autralia
4	Antartica
5	Europe
6	Green LAnd
7	Nourt America
8	South America
\.


--
-- Data for Name: service_task; Type: TABLE DATA; Schema: master; Owner: postgres
--

COPY master.service_task (seta_id, seta_name, seta_seq) FROM stdin;
2	Making Bed	2
3	Restocking Amenities	3
4	Restocking Minibar	4
5	Laundry Service	5
6	Room Service	6
7	Housekeeping Inspection	7
8	Deep Cleaning	8
9	Linen Replacement	9
10	Pool Maintenance	10
11	Spa Maintenance	11
12	Gym Maintenance	12
13	Lobby Cleaning	13
14	Public Area Cleaning	14
15	Landscaping Maintenance	15
16	Pest Control	16
17	Fire Safety Inspection	17
18	Elevator Maintenance	18
19	Security Patrol	19
20	Front Desk Assistance	20
1	Cleaning Rooms	1
\.


--
-- Data for Name: bank; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.bank (bank_entity_id, bank_code, bank_name, bank_modified_date) FROM stdin;
\.


--
-- Data for Name: entities; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.entities (entity_id) FROM stdin;
\.


--
-- Data for Name: payment_gateaway; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.payment_gateaway (paga_entity_id, paga_code, paga_name, paga_modified_date) FROM stdin;
\.


--
-- Data for Name: payment_transaction; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.payment_transaction (patr_id, patr_trx_number, patr_debet, patr_credit, patr_type, patr_note, patr_modified_date, patr_order_number, patr_trx_number_ref, patr_source_id, patr_target_id, patr_user_id) FROM stdin;
\.


--
-- Data for Name: user_accounts; Type: TABLE DATA; Schema: payment; Owner: postgres
--

COPY payment.user_accounts (usac_entity_id, usac_user_id, usac_account_number, usac_saldo, usac_type, usac_expmonth, usac_expyear, usac_modified_date) FROM stdin;
\.


--
-- Data for Name: purchase_order_detail; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_order_detail (pode_pohe_id, pode_id, pode_order_qty, pode_price, pode_line_total, pode_received_qty, pode_rejected_qty, pode_stocked_qty, pode_modified_date, pode_stock_id) FROM stdin;
\.


--
-- Data for Name: purchase_order_header; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_order_header (pohe_id, pohe_number, pohe_status, pohe_order_date, pohe_subtotal, pohe_tax, pohe_total_amount, pohe_refund, pohe_arrival_date, pohe_pay_tipe, pohe_emp_id, pohe_vendor_id) FROM stdin;
\.


--
-- Data for Name: stock_detail; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.stock_detail (stod_stock_id, stod_id, stod_barcode_number, stod_status, stod_notes, stod_faci_id, stod_pohe_id) FROM stdin;
\.


--
-- Data for Name: stock_photo; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.stock_photo (spho_id, spho_thumbnail_filename, spho_photo_filename, spho_primary, spho_url, spho_stock_id) FROM stdin;
\.


--
-- Data for Name: stocks; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.stocks (stock_id, stock_name, stock_description, stock_quantity, stock_reorder_point, stock_used, stock_scrap, stock_price, stock_standar_cost, stock_size, stock_color, stock_modified_date) FROM stdin;
\.


--
-- Data for Name: vendor; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.vendor (vendor_id, vendor_name, vendor_active, vendor_priority, vendor_register_date, vendor_weburi, vendor_modified_date) FROM stdin;
\.


--
-- Data for Name: order_menu_detail; Type: TABLE DATA; Schema: resto; Owner: postgres
--

COPY resto.order_menu_detail (omde_id, orme_price, orme_qty, orme_subtotal, orme_discount, omde_orme_id, omde_reme_id) FROM stdin;
\.


--
-- Data for Name: order_menus; Type: TABLE DATA; Schema: resto; Owner: postgres
--

COPY resto.order_menus (orme_id, orme_order_number, orme_order_date, orme_total_item, orme_total_discount, orme_total_amount, orme_pay_type, orme_cardnumber, orme_is_paid, orme_modified_date, orme_user_id) FROM stdin;
\.


--
-- Data for Name: resto_menu_photos; Type: TABLE DATA; Schema: resto; Owner: postgres
--

COPY resto.resto_menu_photos (remp_id, remp_thumbnail_filename, remp_photo_filename, remp_primary, remp_url, remp_reme_id) FROM stdin;
\.


--
-- Data for Name: resto_menus; Type: TABLE DATA; Schema: resto; Owner: postgres
--

COPY resto.resto_menus (reme_faci_id, reme_id, reme_name, reme_description, reme_price, reme_status, reme_modified_date) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.roles (role_id, role_name) FROM stdin;
\.


--
-- Data for Name: user_bonus_points; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.user_bonus_points (ubpo_id, ubpo_user_id, ubpo_total_points, ubpo_bonus_type, ubpo_create_on) FROM stdin;
\.


--
-- Data for Name: user_members; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.user_members (usme_id, usme_user_id, usme_memb_name, usme_promote_date, usme_points, usme_type) FROM stdin;
\.


--
-- Data for Name: user_password; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.user_password (uspa_user_id, uspa_passwordhash, uspa_passwordsalt) FROM stdin;
\.


--
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.user_profiles (uspro_id, uspro_national_id, uspro_birth, uspro_photo, uspro_job_title, uspro_marital_status, uspro_gender, uspro_addr_id, uspro_user_id) FROM stdin;
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.user_roles (usro_user_id, usro_role_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: users; Owner: postgres
--

COPY users.users (user_id, user_full_name, user_type, user_company_name, user_email, user_phone_number, user_isverified, user_modified_date) FROM stdin;
\.


--
-- Name: booking_order_detail_borde_id_seq; Type: SEQUENCE SET; Schema: booking; Owner: postgres
--

SELECT pg_catalog.setval('booking.booking_order_detail_borde_id_seq', 1, false);


--
-- Name: booking_order_detail_extra_boex_id_seq; Type: SEQUENCE SET; Schema: booking; Owner: postgres
--

SELECT pg_catalog.setval('booking.booking_order_detail_extra_boex_id_seq', 1, false);


--
-- Name: booking_orders_boor_id_seq; Type: SEQUENCE SET; Schema: booking; Owner: postgres
--

SELECT pg_catalog.setval('booking.booking_orders_boor_id_seq', 1, false);


--
-- Name: special_offer_coupons_soco_id_seq; Type: SEQUENCE SET; Schema: booking; Owner: postgres
--

SELECT pg_catalog.setval('booking.special_offer_coupons_soco_id_seq', 1, false);


--
-- Name: special_offers_spof_id_seq; Type: SEQUENCE SET; Schema: booking; Owner: postgres
--

SELECT pg_catalog.setval('booking.special_offers_spof_id_seq', 1, false);


--
-- Name: facilities_faci_id_seq; Type: SEQUENCE SET; Schema: hotel; Owner: postgres
--

SELECT pg_catalog.setval('hotel.facilities_faci_id_seq', 1, false);


--
-- Name: facility_photos_fapho_id_seq; Type: SEQUENCE SET; Schema: hotel; Owner: postgres
--

SELECT pg_catalog.setval('hotel.facility_photos_fapho_id_seq', 1, false);


--
-- Name: facility_price_history_faph_id_seq; Type: SEQUENCE SET; Schema: hotel; Owner: postgres
--

SELECT pg_catalog.setval('hotel.facility_price_history_faph_id_seq', 1, false);


--
-- Name: hotel_reviews_hore_id_seq; Type: SEQUENCE SET; Schema: hotel; Owner: postgres
--

SELECT pg_catalog.setval('hotel.hotel_reviews_hore_id_seq', 1, false);


--
-- Name: hotels_hotel_id_seq; Type: SEQUENCE SET; Schema: hotel; Owner: postgres
--

SELECT pg_catalog.setval('hotel.hotels_hotel_id_seq', 1, false);


--
-- Name: department_dept_id_seq; Type: SEQUENCE SET; Schema: humanresource; Owner: postgres
--

SELECT pg_catalog.setval('humanresource.department_dept_id_seq', 1, false);


--
-- Name: employee_department_history_edhi_id_seq; Type: SEQUENCE SET; Schema: humanresource; Owner: postgres
--

SELECT pg_catalog.setval('humanresource.employee_department_history_edhi_id_seq', 1, false);


--
-- Name: employee_emp_id_seq; Type: SEQUENCE SET; Schema: humanresource; Owner: postgres
--

SELECT pg_catalog.setval('humanresource.employee_emp_id_seq', 1, false);


--
-- Name: job_role_joro_id_seq; Type: SEQUENCE SET; Schema: humanresource; Owner: postgres
--

SELECT pg_catalog.setval('humanresource.job_role_joro_id_seq', 1, false);


--
-- Name: shift_shift_id_seq; Type: SEQUENCE SET; Schema: humanresource; Owner: postgres
--

SELECT pg_catalog.setval('humanresource.shift_shift_id_seq', 1, false);


--
-- Name: work_order_detail_wode_id_seq; Type: SEQUENCE SET; Schema: humanresource; Owner: postgres
--

SELECT pg_catalog.setval('humanresource.work_order_detail_wode_id_seq', 1, false);


--
-- Name: work_orders_woro_id_seq; Type: SEQUENCE SET; Schema: humanresource; Owner: postgres
--

SELECT pg_catalog.setval('humanresource.work_orders_woro_id_seq', 1, false);


--
-- Name: address_addr_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.address_addr_id_seq', 2, true);


--
-- Name: category_group_cagro_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.category_group_cagro_id_seq', 7, true);


--
-- Name: country_country_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.country_country_id_seq', 19, true);


--
-- Name: policy_category_group_poca_poli_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.policy_category_group_poca_poli_id_seq', 1, false);


--
-- Name: policy_poli_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.policy_poli_id_seq', 23, true);


--
-- Name: price_items_prit_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.price_items_prit_id_seq', 17, true);


--
-- Name: provinces_prov_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.provinces_prov_id_seq', 16, true);


--
-- Name: regions_region_code_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.regions_region_code_seq', 8, true);


--
-- Name: service_task_seta_id_seq; Type: SEQUENCE SET; Schema: master; Owner: postgres
--

SELECT pg_catalog.setval('master.service_task_seta_id_seq', 20, true);


--
-- Name: entities_entity_id_seq; Type: SEQUENCE SET; Schema: payment; Owner: postgres
--

SELECT pg_catalog.setval('payment.entities_entity_id_seq', 1, false);


--
-- Name: payment_transaction_patr_id_seq; Type: SEQUENCE SET; Schema: payment; Owner: postgres
--

SELECT pg_catalog.setval('payment.payment_transaction_patr_id_seq', 1, false);


--
-- Name: purchase_order_detail_pode_id_seq; Type: SEQUENCE SET; Schema: purchasing; Owner: postgres
--

SELECT pg_catalog.setval('purchasing.purchase_order_detail_pode_id_seq', 1, false);


--
-- Name: purchase_order_header_pohe_id_seq; Type: SEQUENCE SET; Schema: purchasing; Owner: postgres
--

SELECT pg_catalog.setval('purchasing.purchase_order_header_pohe_id_seq', 1, false);


--
-- Name: stock_detail_stod_id_seq; Type: SEQUENCE SET; Schema: purchasing; Owner: postgres
--

SELECT pg_catalog.setval('purchasing.stock_detail_stod_id_seq', 1, false);


--
-- Name: stock_photo_spho_id_seq; Type: SEQUENCE SET; Schema: purchasing; Owner: postgres
--

SELECT pg_catalog.setval('purchasing.stock_photo_spho_id_seq', 1, false);


--
-- Name: stocks_stock_id_seq; Type: SEQUENCE SET; Schema: purchasing; Owner: postgres
--

SELECT pg_catalog.setval('purchasing.stocks_stock_id_seq', 1, false);


--
-- Name: vendor_vendor_id_seq; Type: SEQUENCE SET; Schema: purchasing; Owner: postgres
--

SELECT pg_catalog.setval('purchasing.vendor_vendor_id_seq', 1, false);


--
-- Name: order_menu_detail_omde_id_seq; Type: SEQUENCE SET; Schema: resto; Owner: postgres
--

SELECT pg_catalog.setval('resto.order_menu_detail_omde_id_seq', 1, false);


--
-- Name: order_menus_orme_id_seq; Type: SEQUENCE SET; Schema: resto; Owner: postgres
--

SELECT pg_catalog.setval('resto.order_menus_orme_id_seq', 1, false);


--
-- Name: resto_menu_photos_remp_id_seq; Type: SEQUENCE SET; Schema: resto; Owner: postgres
--

SELECT pg_catalog.setval('resto.resto_menu_photos_remp_id_seq', 1, false);


--
-- Name: resto_menus_reme_id_seq; Type: SEQUENCE SET; Schema: resto; Owner: postgres
--

SELECT pg_catalog.setval('resto.resto_menus_reme_id_seq', 1, false);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.roles_role_id_seq', 20, true);


--
-- Name: user_bonus_points_ubpo_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.user_bonus_points_ubpo_id_seq', 96, true);


--
-- Name: user_members_usme_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.user_members_usme_id_seq', 96, true);


--
-- Name: user_profiles_uspro_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.user_profiles_uspro_id_seq', 24, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.users_user_id_seq', 98, true);


--
-- Name: booking_orders booking_orders_boor_order_number_key; Type: CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_orders
    ADD CONSTRAINT booking_orders_boor_order_number_key UNIQUE (boor_order_number);


--
-- Name: booking_order_detail_extra pk_boex_id; Type: CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_order_detail_extra
    ADD CONSTRAINT pk_boex_id PRIMARY KEY (boex_id);


--
-- Name: booking_order_detail pk_boor_borde_id; Type: CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_order_detail
    ADD CONSTRAINT pk_boor_borde_id PRIMARY KEY (borde_id);


--
-- Name: booking_orders pk_boor_id; Type: CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_orders
    ADD CONSTRAINT pk_boor_id PRIMARY KEY (boor_id);


--
-- Name: user_breakfeast pk_borde_modified_id; Type: CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.user_breakfeast
    ADD CONSTRAINT pk_borde_modified_id PRIMARY KEY (usbr_modified_date);


--
-- Name: special_offer_coupons pk_soco_id; Type: CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.special_offer_coupons
    ADD CONSTRAINT pk_soco_id PRIMARY KEY (soco_id);


--
-- Name: special_offers pk_spof_id; Type: CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.special_offers
    ADD CONSTRAINT pk_spof_id PRIMARY KEY (spof_id);


--
-- Name: facilities faci_id_pk; Type: CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facilities
    ADD CONSTRAINT faci_id_pk PRIMARY KEY (faci_id);


--
-- Name: facilities facilities_faci_room_number_key; Type: CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facilities
    ADD CONSTRAINT facilities_faci_room_number_key UNIQUE (faci_room_number);


--
-- Name: facility_photos facility_photos_pk; Type: CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facility_photos
    ADD CONSTRAINT facility_photos_pk PRIMARY KEY (fapho_id);


--
-- Name: facility_price_history facility_price_history_pk; Type: CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facility_price_history
    ADD CONSTRAINT facility_price_history_pk PRIMARY KEY (faph_id);


--
-- Name: hotel_reviews hore_id_pk; Type: CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.hotel_reviews
    ADD CONSTRAINT hore_id_pk PRIMARY KEY (hore_id);


--
-- Name: hotels hotel_id_pk; Type: CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.hotels
    ADD CONSTRAINT hotel_id_pk PRIMARY KEY (hotel_id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (dept_id);


--
-- Name: employee_department_history employee_department_history_pkey; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee_department_history
    ADD CONSTRAINT employee_department_history_pkey PRIMARY KEY (edhi_id);


--
-- Name: employee employee_emp_national_id_key; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee
    ADD CONSTRAINT employee_emp_national_id_key UNIQUE (emp_national_id);


--
-- Name: employee_pay_history employee_pay_history_pkey; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee_pay_history
    ADD CONSTRAINT employee_pay_history_pkey PRIMARY KEY (ephi_rate_change_date);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (emp_id);


--
-- Name: job_role job_role_joro_name_key; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.job_role
    ADD CONSTRAINT job_role_joro_name_key UNIQUE (joro_name);


--
-- Name: job_role job_role_pkey; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.job_role
    ADD CONSTRAINT job_role_pkey PRIMARY KEY (joro_id);


--
-- Name: shift shift_pkey; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.shift
    ADD CONSTRAINT shift_pkey PRIMARY KEY (shift_id);


--
-- Name: shift shift_shift_end_time_key; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.shift
    ADD CONSTRAINT shift_shift_end_time_key UNIQUE (shift_end_time);


--
-- Name: shift shift_shift_name_key; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.shift
    ADD CONSTRAINT shift_shift_name_key UNIQUE (shift_name);


--
-- Name: shift shift_shift_start_time_key; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.shift
    ADD CONSTRAINT shift_shift_start_time_key UNIQUE (shift_start_time);


--
-- Name: work_order_detail work_order_detail_pkey; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.work_order_detail
    ADD CONSTRAINT work_order_detail_pkey PRIMARY KEY (wode_id);


--
-- Name: work_orders work_orders_pkey; Type: CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.work_orders
    ADD CONSTRAINT work_orders_pkey PRIMARY KEY (woro_id);


--
-- Name: address addr_id; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address
    ADD CONSTRAINT addr_id PRIMARY KEY (addr_id);


--
-- Name: category_group cagro_id_pk; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.category_group
    ADD CONSTRAINT cagro_id_pk PRIMARY KEY (cagro_id);


--
-- Name: category_group category_group_cagro_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.category_group
    ADD CONSTRAINT category_group_cagro_name_key UNIQUE (cagro_name);


--
-- Name: country country_country_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);


--
-- Name: country country_id_pk; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.country
    ADD CONSTRAINT country_id_pk PRIMARY KEY (country_id);


--
-- Name: members memb_name; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.members
    ADD CONSTRAINT memb_name PRIMARY KEY (memb_name);


--
-- Name: policy poli_id_pk; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.policy
    ADD CONSTRAINT poli_id_pk PRIMARY KEY (poli_id);


--
-- Name: policy_category_group policy_category_group_pkey; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.policy_category_group
    ADD CONSTRAINT policy_category_group_pkey PRIMARY KEY (poca_poli_id);


--
-- Name: price_items price_items_prit_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.price_items
    ADD CONSTRAINT price_items_prit_name_key UNIQUE (prit_name);


--
-- Name: price_items prit_id_pk; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.price_items
    ADD CONSTRAINT prit_id_pk PRIMARY KEY (prit_id);


--
-- Name: provinces prov_id_pk; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.provinces
    ADD CONSTRAINT prov_id_pk PRIMARY KEY (prov_id);


--
-- Name: regions region_code_pk; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.regions
    ADD CONSTRAINT region_code_pk PRIMARY KEY (region_code);


--
-- Name: regions regions_region_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.regions
    ADD CONSTRAINT regions_region_name_key UNIQUE (region_name);


--
-- Name: service_task service_task_seta_name_key; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.service_task
    ADD CONSTRAINT service_task_seta_name_key UNIQUE (seta_name);


--
-- Name: service_task seta_id_pk; Type: CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.service_task
    ADD CONSTRAINT seta_id_pk PRIMARY KEY (seta_id);


--
-- Name: bank bank_bank_code_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.bank
    ADD CONSTRAINT bank_bank_code_key UNIQUE (bank_code);


--
-- Name: bank bank_bank_name_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.bank
    ADD CONSTRAINT bank_bank_name_key UNIQUE (bank_name);


--
-- Name: bank bank_pkey; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.bank
    ADD CONSTRAINT bank_pkey PRIMARY KEY (bank_entity_id);


--
-- Name: entities entities_pkey; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (entity_id);


--
-- Name: payment_gateaway payment_gateaway_paga_code_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payment_gateaway
    ADD CONSTRAINT payment_gateaway_paga_code_key UNIQUE (paga_code);


--
-- Name: payment_gateaway payment_gateaway_paga_name_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payment_gateaway
    ADD CONSTRAINT payment_gateaway_paga_name_key UNIQUE (paga_name);


--
-- Name: payment_gateaway payment_gateaway_pkey; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payment_gateaway
    ADD CONSTRAINT payment_gateaway_pkey PRIMARY KEY (paga_entity_id);


--
-- Name: payment_transaction payment_transaction_patr_trx_number_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payment_transaction
    ADD CONSTRAINT payment_transaction_patr_trx_number_key UNIQUE (patr_trx_number);


--
-- Name: payment_transaction payment_transaction_patr_trx_number_ref_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payment_transaction
    ADD CONSTRAINT payment_transaction_patr_trx_number_ref_key UNIQUE (patr_trx_number_ref);


--
-- Name: payment_transaction payment_transaction_pkey; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payment_transaction
    ADD CONSTRAINT payment_transaction_pkey PRIMARY KEY (patr_id);


--
-- Name: user_accounts user_accounts_pk; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.user_accounts
    ADD CONSTRAINT user_accounts_pk PRIMARY KEY (usac_entity_id, usac_user_id);


--
-- Name: user_accounts user_accounts_usac_account_number_key; Type: CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.user_accounts
    ADD CONSTRAINT user_accounts_usac_account_number_key UNIQUE (usac_account_number);


--
-- Name: purchase_order_detail pode_id_pk; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail
    ADD CONSTRAINT pode_id_pk PRIMARY KEY (pode_id);


--
-- Name: purchase_order_header pohe_id_pk; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT pohe_id_pk PRIMARY KEY (pohe_id);


--
-- Name: purchase_order_header purchase_order_header_pohe_number_key; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT purchase_order_header_pohe_number_key UNIQUE (pohe_number);


--
-- Name: stock_photo spho_id_pk; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stock_photo
    ADD CONSTRAINT spho_id_pk PRIMARY KEY (spho_id);


--
-- Name: stock_detail stock_detail_stod_barcode_number_key; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stock_detail
    ADD CONSTRAINT stock_detail_stod_barcode_number_key UNIQUE (stod_barcode_number);


--
-- Name: stocks stock_id_pk; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stocks
    ADD CONSTRAINT stock_id_pk PRIMARY KEY (stock_id);


--
-- Name: stock_detail stod_id_pk; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stock_detail
    ADD CONSTRAINT stod_id_pk PRIMARY KEY (stod_id);


--
-- Name: vendor vendor_id_pk; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.vendor
    ADD CONSTRAINT vendor_id_pk PRIMARY KEY (vendor_id);


--
-- Name: order_menu_detail pk_omde_id; Type: CONSTRAINT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.order_menu_detail
    ADD CONSTRAINT pk_omde_id PRIMARY KEY (omde_id);


--
-- Name: order_menus pk_orme_id; Type: CONSTRAINT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.order_menus
    ADD CONSTRAINT pk_orme_id PRIMARY KEY (orme_id);


--
-- Name: resto_menu_photos pk_remp_id; Type: CONSTRAINT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.resto_menu_photos
    ADD CONSTRAINT pk_remp_id PRIMARY KEY (remp_id);


--
-- Name: resto_menus pk_resto_menus; Type: CONSTRAINT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.resto_menus
    ADD CONSTRAINT pk_resto_menus PRIMARY KEY (reme_id);


--
-- Name: roles pk_role_id; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.roles
    ADD CONSTRAINT pk_role_id PRIMARY KEY (role_id);


--
-- Name: users pk_user_id; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT pk_user_id PRIMARY KEY (user_id);


--
-- Name: user_roles pk_usro_user_id; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_roles
    ADD CONSTRAINT pk_usro_user_id PRIMARY KEY (usro_user_id);


--
-- Name: users u_user_email; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT u_user_email UNIQUE (user_email);


--
-- Name: users u_user_phone_number; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT u_user_phone_number UNIQUE (user_phone_number);


--
-- Name: user_bonus_points user_bonus_points_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_bonus_points
    ADD CONSTRAINT user_bonus_points_pkey PRIMARY KEY (ubpo_id);


--
-- Name: user_members user_members_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_members
    ADD CONSTRAINT user_members_pkey PRIMARY KEY (usme_id);


--
-- Name: user_password user_password_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_password
    ADD CONSTRAINT user_password_pkey PRIMARY KEY (uspa_user_id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (uspro_id);


--
-- Name: booking_order_detail_extra fk_boex_borde_id; Type: FK CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_order_detail_extra
    ADD CONSTRAINT fk_boex_borde_id FOREIGN KEY (boex_borde_id) REFERENCES booking.booking_order_detail(borde_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: booking_order_detail_extra fk_boex_prit_id; Type: FK CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_order_detail_extra
    ADD CONSTRAINT fk_boex_prit_id FOREIGN KEY (boex_prit_id) REFERENCES master.price_items(prit_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: booking_orders fk_boor_hotel_id; Type: FK CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_orders
    ADD CONSTRAINT fk_boor_hotel_id FOREIGN KEY (boor_hotel_id) REFERENCES hotel.hotels(hotel_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: booking_orders fk_boor_user_id; Type: FK CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_orders
    ADD CONSTRAINT fk_boor_user_id FOREIGN KEY (boor_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: booking_order_detail fk_borde_boor_id; Type: FK CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_order_detail
    ADD CONSTRAINT fk_borde_boor_id FOREIGN KEY (border_boor_id) REFERENCES booking.booking_orders(boor_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: booking_order_detail fk_borde_faci_id; Type: FK CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.booking_order_detail
    ADD CONSTRAINT fk_borde_faci_id FOREIGN KEY (borde_faci_id) REFERENCES hotel.facilities(faci_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: special_offer_coupons fk_soco_borde_id; Type: FK CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.special_offer_coupons
    ADD CONSTRAINT fk_soco_borde_id FOREIGN KEY (soco_borde_id) REFERENCES booking.booking_order_detail(borde_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: special_offer_coupons fk_soco_spof_id; Type: FK CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.special_offer_coupons
    ADD CONSTRAINT fk_soco_spof_id FOREIGN KEY (soco_spof_id) REFERENCES booking.special_offers(spof_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_breakfeast fk_usbr_borde_id; Type: FK CONSTRAINT; Schema: booking; Owner: postgres
--

ALTER TABLE ONLY booking.user_breakfeast
    ADD CONSTRAINT fk_usbr_borde_id FOREIGN KEY (usbr_borde_id) REFERENCES booking.booking_order_detail(borde_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: facilities fk_faci_cagro_id; Type: FK CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facilities
    ADD CONSTRAINT fk_faci_cagro_id FOREIGN KEY (faci_cagro_id) REFERENCES master.category_group(cagro_id);


--
-- Name: facilities fk_faci_hotel_id; Type: FK CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facilities
    ADD CONSTRAINT fk_faci_hotel_id FOREIGN KEY (faci_hotel_id) REFERENCES hotel.hotels(hotel_id);


--
-- Name: facility_price_history fk_faph_faci_id; Type: FK CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facility_price_history
    ADD CONSTRAINT fk_faph_faci_id FOREIGN KEY (faph_faci_id) REFERENCES hotel.facilities(faci_id);


--
-- Name: facility_photos fk_fapho_faci_id; Type: FK CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facility_photos
    ADD CONSTRAINT fk_fapho_faci_id FOREIGN KEY (fapho_faci_id) REFERENCES hotel.facilities(faci_id);


--
-- Name: hotel_reviews fk_hore_hotel_id; Type: FK CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.hotel_reviews
    ADD CONSTRAINT fk_hore_hotel_id FOREIGN KEY (hore_hotel_id) REFERENCES hotel.hotels(hotel_id);


--
-- Name: hotel_reviews fk_hore_user_id; Type: FK CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.hotel_reviews
    ADD CONSTRAINT fk_hore_user_id FOREIGN KEY (hore_user_id) REFERENCES users.users(user_id);


--
-- Name: hotels fk_hotel_addr_id; Type: FK CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.hotels
    ADD CONSTRAINT fk_hotel_addr_id FOREIGN KEY (hotel_addr_id) REFERENCES master.address(addr_id);


--
-- Name: facility_price_history fk_user_faci_id; Type: FK CONSTRAINT; Schema: hotel; Owner: postgres
--

ALTER TABLE ONLY hotel.facility_price_history
    ADD CONSTRAINT fk_user_faci_id FOREIGN KEY (faph_user_id) REFERENCES users.users(user_id);


--
-- Name: employee_department_history employee_department_history_edhi_dept_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee_department_history
    ADD CONSTRAINT employee_department_history_edhi_dept_id_fkey FOREIGN KEY (edhi_dept_id) REFERENCES humanresource.department(dept_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: employee_department_history employee_department_history_edhi_emp_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee_department_history
    ADD CONSTRAINT employee_department_history_edhi_emp_id_fkey FOREIGN KEY (edhi_emp_id) REFERENCES humanresource.employee(emp_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: employee_department_history employee_department_history_edhi_shift_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee_department_history
    ADD CONSTRAINT employee_department_history_edhi_shift_id_fkey FOREIGN KEY (edhi_shift_id) REFERENCES humanresource.shift(shift_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: employee employee_emp_emp_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee
    ADD CONSTRAINT employee_emp_emp_id_fkey FOREIGN KEY (emp_emp_id) REFERENCES humanresource.employee(emp_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: employee employee_emp_emp_id_fkey1; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee
    ADD CONSTRAINT employee_emp_emp_id_fkey1 FOREIGN KEY (emp_emp_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: employee employee_emp_joro_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee
    ADD CONSTRAINT employee_emp_joro_id_fkey FOREIGN KEY (emp_joro_id) REFERENCES humanresource.job_role(joro_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: employee_pay_history employee_pay_history_ephi_emp_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.employee_pay_history
    ADD CONSTRAINT employee_pay_history_ephi_emp_id_fkey FOREIGN KEY (ephi_emp_id) REFERENCES humanresource.employee(emp_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: work_order_detail work_order_detail_wode_emp_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.work_order_detail
    ADD CONSTRAINT work_order_detail_wode_emp_id_fkey FOREIGN KEY (wode_emp_id) REFERENCES humanresource.employee(emp_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: work_order_detail work_order_detail_wode_faci_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.work_order_detail
    ADD CONSTRAINT work_order_detail_wode_faci_id_fkey FOREIGN KEY (wode_faci_id) REFERENCES hotel.facilities(faci_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: work_order_detail work_order_detail_wode_seta_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.work_order_detail
    ADD CONSTRAINT work_order_detail_wode_seta_id_fkey FOREIGN KEY (wode_seta_id) REFERENCES master.service_task(seta_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: work_order_detail work_order_detail_wode_woro_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.work_order_detail
    ADD CONSTRAINT work_order_detail_wode_woro_id_fkey FOREIGN KEY (wode_woro_id) REFERENCES humanresource.work_orders(woro_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: work_orders work_orders_woro_user_id_fkey; Type: FK CONSTRAINT; Schema: humanresource; Owner: postgres
--

ALTER TABLE ONLY humanresource.work_orders
    ADD CONSTRAINT work_orders_woro_user_id_fkey FOREIGN KEY (woro_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: address addr_prov_id_fk; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.address
    ADD CONSTRAINT addr_prov_id_fk FOREIGN KEY (addr_prov_id) REFERENCES master.provinces(prov_id);


--
-- Name: country country_region_id_fk; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.country
    ADD CONSTRAINT country_region_id_fk FOREIGN KEY (country_region_id) REFERENCES master.regions(region_code);


--
-- Name: policy_category_group poca_cagro_id_fk; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.policy_category_group
    ADD CONSTRAINT poca_cagro_id_fk FOREIGN KEY (poca_cagro_id) REFERENCES master.category_group(cagro_id);


--
-- Name: policy_category_group poca_poli_id_fk; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.policy_category_group
    ADD CONSTRAINT poca_poli_id_fk FOREIGN KEY (poca_poli_id) REFERENCES master.policy(poli_id);


--
-- Name: provinces prov_country_id_fk; Type: FK CONSTRAINT; Schema: master; Owner: postgres
--

ALTER TABLE ONLY master.provinces
    ADD CONSTRAINT prov_country_id_fk FOREIGN KEY (prov_country_id) REFERENCES master.country(country_id);


--
-- Name: bank bank_entity_id_fk; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.bank
    ADD CONSTRAINT bank_entity_id_fk FOREIGN KEY (bank_entity_id) REFERENCES payment.entities(entity_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_gateaway paga_entity_id; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payment_gateaway
    ADD CONSTRAINT paga_entity_id FOREIGN KEY (paga_entity_id) REFERENCES payment.entities(entity_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_transaction patr_user_id_fk; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.payment_transaction
    ADD CONSTRAINT patr_user_id_fk FOREIGN KEY (patr_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_accounts usac_entity_id_fk; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.user_accounts
    ADD CONSTRAINT usac_entity_id_fk FOREIGN KEY (usac_entity_id) REFERENCES payment.entities(entity_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_accounts usac_user_id_fk; Type: FK CONSTRAINT; Schema: payment; Owner: postgres
--

ALTER TABLE ONLY payment.user_accounts
    ADD CONSTRAINT usac_user_id_fk FOREIGN KEY (usac_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: purchase_order_detail pode_pohe_id_fk; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_detail
    ADD CONSTRAINT pode_pohe_id_fk FOREIGN KEY (pode_pohe_id) REFERENCES purchasing.purchase_order_header(pohe_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: purchase_order_header pohe_emp_id_fk; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT pohe_emp_id_fk FOREIGN KEY (pohe_emp_id) REFERENCES humanresource.employee(emp_id);


--
-- Name: purchase_order_header pohe_vendor_id_fk; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order_header
    ADD CONSTRAINT pohe_vendor_id_fk FOREIGN KEY (pohe_vendor_id) REFERENCES purchasing.vendor(vendor_id);


--
-- Name: stock_photo spho_stock_id_fk; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stock_photo
    ADD CONSTRAINT spho_stock_id_fk FOREIGN KEY (spho_stock_id) REFERENCES purchasing.stocks(stock_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stock_detail stod_faci_id_fk; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stock_detail
    ADD CONSTRAINT stod_faci_id_fk FOREIGN KEY (stod_faci_id) REFERENCES hotel.facilities(faci_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stock_detail stod_pohe_id_fk; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stock_detail
    ADD CONSTRAINT stod_pohe_id_fk FOREIGN KEY (stod_pohe_id) REFERENCES purchasing.purchase_order_header(pohe_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stock_detail stod_stoc_id_fk; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.stock_detail
    ADD CONSTRAINT stod_stoc_id_fk FOREIGN KEY (stod_stock_id) REFERENCES purchasing.stocks(stock_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_menu_detail fk_omde_orme_id; Type: FK CONSTRAINT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.order_menu_detail
    ADD CONSTRAINT fk_omde_orme_id FOREIGN KEY (omde_orme_id) REFERENCES resto.order_menus(orme_id);


--
-- Name: order_menu_detail fk_omde_reme_id; Type: FK CONSTRAINT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.order_menu_detail
    ADD CONSTRAINT fk_omde_reme_id FOREIGN KEY (omde_reme_id) REFERENCES resto.resto_menus(reme_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_menus fk_orme_user_id; Type: FK CONSTRAINT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.order_menus
    ADD CONSTRAINT fk_orme_user_id FOREIGN KEY (orme_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: resto_menus fk_reme_faci_id; Type: FK CONSTRAINT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.resto_menus
    ADD CONSTRAINT fk_reme_faci_id FOREIGN KEY (reme_faci_id) REFERENCES hotel.facilities(faci_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: resto_menu_photos fk_remp_reme_id; Type: FK CONSTRAINT; Schema: resto; Owner: postgres
--

ALTER TABLE ONLY resto.resto_menu_photos
    ADD CONSTRAINT fk_remp_reme_id FOREIGN KEY (remp_reme_id) REFERENCES resto.resto_menus(reme_id);


--
-- Name: user_members fk_useme_memb_name; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_members
    ADD CONSTRAINT fk_useme_memb_name FOREIGN KEY (usme_memb_name) REFERENCES master.members(memb_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_members fk_usme_user_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_members
    ADD CONSTRAINT fk_usme_user_id FOREIGN KEY (usme_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_password fk_uspa_user_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_password
    ADD CONSTRAINT fk_uspa_user_id FOREIGN KEY (uspa_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_roles fk_usro_role_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_roles
    ADD CONSTRAINT fk_usro_role_id FOREIGN KEY (usro_role_id) REFERENCES users.roles(role_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_roles fk_usro_user_id; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_roles
    ADD CONSTRAINT fk_usro_user_id FOREIGN KEY (usro_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_bonus_points user_bonus_points_ubpo_user_id_fkey; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_bonus_points
    ADD CONSTRAINT user_bonus_points_ubpo_user_id_fkey FOREIGN KEY (ubpo_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_profiles user_profiles_uspro_addr_id_fkey; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_profiles
    ADD CONSTRAINT user_profiles_uspro_addr_id_fkey FOREIGN KEY (uspro_addr_id) REFERENCES master.address(addr_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_profiles user_profiles_uspro_user_id_fkey; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.user_profiles
    ADD CONSTRAINT user_profiles_uspro_user_id_fkey FOREIGN KEY (uspro_user_id) REFERENCES users.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

