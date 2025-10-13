-- ** Database generated with pgModeler (PostgreSQL Database Modeler).
-- ** pgModeler version: 1.2.0
-- ** PostgreSQL version: 17.0
-- ** Project Site: pgmodeler.io
-- ** Model Author: ---

-- ** Database creation must be performed outside a multi lined SQL file. 
-- ** These commands were put in this file only as a convenience.

-- object: mdp_local | type: DATABASE --
-- DROP DATABASE IF EXISTS mdp_local;
CREATE DATABASE mdp_local
	ENCODING = 'UTF8'
	LC_COLLATE = 'Spanish_Spain.1252'
	LC_CTYPE = 'Spanish_Spain.1252'
	TABLESPACE = pg_default
	OWNER = postgres;
-- ddl-end --


SET check_function_bodies = false;
-- ddl-end --

-- object: mdp_producto | type: SCHEMA --
-- DROP SCHEMA IF EXISTS mdp_producto CASCADE;
CREATE SCHEMA mdp_producto;
-- ddl-end --
ALTER SCHEMA mdp_producto OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,mdp_producto;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto (
	cod_producto varchar(10) NOT NULL,
	nom_producto varchar(80) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_pk PRIMARY KEY (cod_producto),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto IS E'Tabla donde se definen los productos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto.cod_producto IS E'Código producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto.nom_producto IS E'Nombre interno del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto.fec_creacion IS E'Timestamp en que se crea el registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto.fec_actualizacion IS E'Timestamp de actualizacion del registro';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_familia | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_familia CASCADE;
CREATE TABLE mdp_producto.tb_mdp_familia (
	cod_familia numeric(10,0) NOT NULL,
	logo bytea,
	cod_familia_padre numeric(10,0),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_familia_pk PRIMARY KEY (cod_familia),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_familia IS E'Tabla para almacenar las familias de productos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia.cod_familia IS E'Código de familia';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia.logo IS E'Imágen asociada a la familia de productos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia.cod_familia_padre IS E'Guarda el id de la familia padre';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_familia IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_familia OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_familia | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_familia CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_familia (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_familia numeric(10,0) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_familia_pk PRIMARY KEY (cod_producto_comercial,cod_familia),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_familia IS E'Tabla que relaciona los productos con la familia a la que pertenecen';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_familia.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil, por sistema';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_familia.cod_familia IS E'Código de familia';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_familia.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_familia.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_familia IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_familia OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_atributo | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_atributo CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_atributo (
	cod_producto varchar(10) NOT NULL,
	fec_alta timestamp NOT NULL,
	fec_baja timestamp,
	num_digitos_cb numeric(2) NOT NULL,
	observ_cb varchar(255),
	paginas_min numeric(5,0),
	palabras_min numeric(5,0),
	ind_log_inversa boolean NOT NULL,
	cod_empresa numeric(4,0) NOT NULL,
	ind_exento_aduana boolean NOT NULL,
	ind_spu boolean NOT NULL,
	ent_orientativa_min numeric(2),
	ent_orientativa_max numeric(2),
	ent_comprometidos_min numeric(2),
	ent_comprometidos_max numeric(2),
	retraso_min numeric(2),
	retraso_max numeric(3),
	retraso_indemnizacion varchar(60),
	robo_min numeric(3),
	robo_max numeric(3),
	robo_indemnizacion varchar(60),
	deterioro_min numeric(2),
	deterioro_max numeric(3),
	deterioro_indemnizacion varchar(255),
	plazo_respuesta_max numeric(3),
	plazo_indemniza_max numeric(3),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_atritubo_pk PRIMARY KEY (cod_producto,fec_alta),
	CONSTRAINT ck_fec_baja CHECK ((fec_baja > fec_alta)),
	CONSTRAINT ck_paginas_min CHECK (((paginas_min IS NOT NULL) AND (paginas_min >= (0)::numeric))),
	CONSTRAINT ck_palabras_min CHECK (((palabras_min IS NOT NULL) AND (palabras_min >= (0)::numeric))),
	CONSTRAINT ck_empresa CHECK ((cod_empresa >= (0)::numeric)),
	CONSTRAINT ck_plazos_entrega CHECK (ent_orientativa_min >=0 and ent_orientativa_max >= 0 and ent_comprometidos_min >= 0 and ent_comprometidos_max >= 0),
	CONSTRAINT ck_retrasos CHECK ((retraso_min is not null and retraso_max is not null)  and (retraso_min >=0 and retraso_max >=0) and(retraso_min <= retraso_max)),
	CONSTRAINT ck_robo CHECK ((robo_min is not null and robo_max is not null) and (robo_min <= robo_max) and (robo_min >=0 and robo_max >=0)),
	CONSTRAINT ck_deterioro CHECK ((deterioro_min is not null and deterioro_max is not null) and (deterioro_min >=0 and deterioro_max >=0) and (deterioro_min <= deterioro_max)),
	CONSTRAINT ck_plazos CHECK ((plazo_respuesta_max is not null and plazo_indemniza_max is not null) AND (plazo_respuesta_max >=0 and plazo_indemniza_max >=0)),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_num_digitos_cb CHECK (num_digitos_cb >= 0),
	CONSTRAINT ck_ent_orientativa CHECK ((ent_orientativa_min <= ent_orientativa_max) and (ent_orientativa_min is not null and ent_orientativa_max is not null) and  (ent_orientativa_min >=0 and ent_orientativa_max >=0)),
	CONSTRAINT ck_ent_comprometida CHECK ((ent_comprometidos_min <= ent_comprometidos_max) and (ent_comprometidos_min is not null and ent_comprometidos_max is not null) and  (ent_comprometidos_min >=0 and ent_comprometidos_max >=0))
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_atributo IS E'Tabla para almacenar los atributos del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.fec_alta IS E'Fecha de alta del atributo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.fec_baja IS E'Fecha de baja del atributo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.num_digitos_cb IS E'Número de dígitos del código de barras';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.observ_cb IS E'Observaciones Código de barras';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.paginas_min IS E'Número mínimo de páginas para un producto tipo burofax';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.palabras_min IS E'Número mínimo de palabras para un producto tipo telegrama';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.ind_log_inversa IS E'Indica el producto está asociado a un envío de logística inversa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.cod_empresa IS E'Código de la empresa que proporciona o comercializa el producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.ind_exento_aduana IS E'Indica si el producto no está obligado a pasar por aduanas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.ind_spu IS E'Indica si el producto es del tipo servicio postal universal';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.ent_orientativa_min IS E'Plazo de entrega orientativo mínimo (en días hábiles)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.ent_orientativa_max IS E'Plazo de entrega orientativo máximo (en días hábiles)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.ent_comprometidos_min IS E'Plazo de entrega comprometido mínimo (en horas)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.ent_comprometidos_max IS E'Plazo de entrega comprometido máximo (en horas)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.retraso_min IS E'Retraso o demora mínimo (en días naturales) antes de poder reclamar';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.retraso_max IS E'Retraso o demora máximo (en días naturales) antes de poder reclamar';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.retraso_indemnizacion IS E'Criterio para calcular la cantidad a devolver en caso de retraso o demora';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.robo_min IS E'Plazo mínimo (en días naturales) antes de poder reclamar por extravío/robo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.robo_max IS E'Plazo máximo (en días naturales) antes de poder reclamar por extravío/robo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.robo_indemnizacion IS E'Criterio para calcular la cantidad a devolver en caso de extravío/robo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.deterioro_min IS E'Plazo mínimo para poder reclamar por deterioro (en días naturales)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.deterioro_max IS E'Plazo máximo para poder reclamar por deterioro (en días naturales)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.deterioro_indemnizacion IS E'Criterio para calcular la cantidad a devolver en caso de deterioro';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.plazo_respuesta_max IS E'Plazo máximo de respuesta (en días)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.plazo_indemniza_max IS E'Plazo máximo de indemnización (en días hábiles desde la respuesta)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_baja ON mdp_producto.tb_mdp_producto_atributo IS E'La fecha de baja del producto no puede ser menor a la de alta';
-- ddl-end --
COMMENT ON CONSTRAINT ck_paginas_min ON mdp_producto.tb_mdp_producto_atributo IS E'El número mínimo de páginas de un producto no puede ser negativo o nulo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_palabras_min ON mdp_producto.tb_mdp_producto_atributo IS E'El número mínimo de palabras de un producto no puede ser negativo o nulo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_empresa ON mdp_producto.tb_mdp_producto_atributo IS E'El código de la empresa no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_plazos_entrega ON mdp_producto.tb_mdp_producto_atributo IS E'Los plazos de entrega orientativos no pueden ser negativos';
-- ddl-end --
COMMENT ON CONSTRAINT ck_retrasos ON mdp_producto.tb_mdp_producto_atributo IS E'Los plazos de reclamación por retraso o demora no pueden ser negativos o nulos y el mínimo no puede ser mayor que el máximo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_robo ON mdp_producto.tb_mdp_producto_atributo IS E'Los plazos de reclamación por extravío o robo no pueden ser negativos o nulos y el periodo mínimo no puede ser mayor que el máximo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_deterioro ON mdp_producto.tb_mdp_producto_atributo IS E'Los plazos de reclamación por deterioro no pueden ser negativos o nulos y el mínimo no puede ser mayor que el máximo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_plazos ON mdp_producto.tb_mdp_producto_atributo IS E'Los plazos de respuesta e indemnización no pueden ser negativos';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_atributo IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
COMMENT ON CONSTRAINT ck_num_digitos_cb ON mdp_producto.tb_mdp_producto_atributo IS E'El número de dígitos del código de barras no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_ent_orientativa ON mdp_producto.tb_mdp_producto_atributo IS E'El plazo de entrega orientativa mínimo no puede ser mayor que el máximo y ambos no pueden ser negativos o nulos';
-- ddl-end --
COMMENT ON CONSTRAINT ck_ent_comprometida ON mdp_producto.tb_mdp_producto_atributo IS E'El plazo de entrega comprometida mínima no puede ser mayor que el máximo y ambos no pueden ser negativos o nulos';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_atributo OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_medida | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_medida CASCADE;
CREATE TABLE mdp_producto.tb_mdp_medida (
	cod_medida varchar(5) NOT NULL,
	nom_medida varchar(60) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_medida_pk PRIMARY KEY (cod_medida),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_medida IS E'Tabla de unidades de medida';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_medida.cod_medida IS E'Código de la unidad de medida';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_medida.nom_medida IS E'Nombre de la unidad de medida';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_medida.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_medida.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_medida IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_medida OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_idioma (
	cod_idioma varchar(3) NOT NULL,
	nom_idioma varchar(80) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	cod_idioma_ref varchar(3),
	cod_idi_alpha2 varchar(2) GENERATED ALWAYS AS (CASE     WHEN (cod_idioma_ref IS NULL) THEN cod_idioma_alpha2     ELSE NULL::character varying END) STORED,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_idioma_pk PRIMARY KEY (cod_idioma),
	CONSTRAINT ck_idioma CHECK ((((cod_idioma)::text ~ '[[:lower:]]'::text) AND (char_length((cod_idioma)::text) = 3))),
	CONSTRAINT ck_idioma_alpha2 CHECK (((cod_idioma_alpha2)::text ~ '[a-z]{2}'::text)),
	CONSTRAINT uq_idi_alpha2 UNIQUE (cod_idi_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_idioma IS E'Tabla donde se definen los idiomas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_idioma.cod_idioma IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_idioma.nom_idioma IS E'Nombre del idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_idioma.cod_idioma_alpha2 IS E'Código de idioma (Alpha-2)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_idioma.cod_idioma_ref IS E'Código de idioma de referencia (Alpha-3).';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_idioma.cod_idi_alpha2 IS E'Columna virtual para permitir el uso de COD_IDIOMA_ALPHA2';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_idioma ON mdp_producto.tb_mdp_idioma IS E'Check para permitir sólo caracteres alfabéticos en minúscula de longitud 3';
-- ddl-end --
COMMENT ON CONSTRAINT ck_idioma_alpha2 ON mdp_producto.tb_mdp_idioma IS E'Check para permitir sólo caracteres alfabéticos en minúscula de longitud 2';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_idioma IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_idioma OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_va | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_va CASCADE;
CREATE TABLE mdp_producto.tb_mdp_va (
	cod_va varchar(7) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_va_pk PRIMARY KEY (cod_va),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_va IS E'Tabla donde se almacenan los valores añadidos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va.cod_va IS E'Código valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_va IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_va OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_idioma (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	fec_alta timestamp NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	fec_baja timestamp,
	nom_comercial varchar(80) NOT NULL,
	desc_producto varchar(255),
	desc_producto_ext varchar(255),
	desc_factura varchar(255),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_idioma_pk PRIMARY KEY (cod_producto_comercial,cod_idioma_alpha2,cod_modalidad,fec_alta),
	CONSTRAINT ck_fecbaja CHECK ((fec_baja > fec_alta)),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_idioma IS E'Tabla relacional que almacena los nombres de productos en distintos idiomas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil, por sistema';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.cod_modalidad IS E'Código de modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.fec_alta IS E'Fecha de alta del nombre del producto para el idioma seleccionado';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.fec_baja IS E'Fecha de baja del nombre del producto para el idioma seleccionado';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.nom_comercial IS E'Nombre comercial del producto para el idioma seleccionado cuyo código está en COD_IDIOMA_ALPHA2';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.desc_producto IS E'Descripción reducida del producto traducida al idioma seleccionado cuyo código está en COD_IDIOMA_ALPHA2';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.desc_producto_ext IS E'Descripción extendida del producto traducida al idioma seleccionado cuyo código está en COD_IDIOMA_ALPHA2';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.desc_factura IS E'Breve descripción para el ticket/factura traducida al idioma seleccionado cuyo código está en COD_IDIOMA_ALPHA2';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fecbaja ON mdp_producto.tb_mdp_producto_idioma IS E'La fecha de baja tiene que ser mayor que la fecha de alta';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_idioma IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_idioma OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_va | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_va CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_va (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	fec_alta timestamp NOT NULL,
	cod_va varchar(7) NOT NULL,
	cod_pais varchar(3) NOT NULL,
	fec_baja timestamp,
	ind_obligatorio boolean NOT NULL,
	cod_grp_va_obligatorio numeric(2),
	tipo_emb varchar(10),
	num_intentos_entrega_min numeric(1),
	num_intentos_entrega_max numeric(1),
	tiempo_lista_min numeric(2),
	tiempo_lista_max numeric(2),
	importe_min numeric(8,2),
	importe_max numeric(8,2),
	tiempo_custodia numeric(3),
	ind_envio boolean NOT NULL DEFAULT false,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_va_pk PRIMARY KEY (cod_producto_comercial,cod_modalidad,fec_alta,cod_va,cod_pais),
	CONSTRAINT ck_fecbaja CHECK ((fec_baja > fec_alta)),
	CONSTRAINT ck_intentos_entrega CHECK ((num_intentos_entrega_max >= (0)::numeric) and (num_intentos_entrega_min >= (0)::numeric) and (num_intentos_entrega_min is not null and num_intentos_entrega_max is not null) and (num_intentos_entrega_max >= num_intentos_entrega_min)),
	CONSTRAINT ck_tiempo_lista CHECK ((tiempo_lista_max >= (0)::numeric) and (tiempo_lista_min >= (0)::numeric) and (tiempo_max_lista is not null and tiempo_lista_min is not null) and (tiempo_max_lista >= tiempo_lista_min)),
	CONSTRAINT ck_importes CHECK (((importe_max >= (0)::numeric) AND (importe_min >= (0)::numeric) AND 
((importe_max IS NOT NULL) AND (importe_min IS NOT NULL)) AND (importe_max >= importe_min))

),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_custodia CHECK ((tiempo_custodia is null) or (tiempo_custodia >= 0))
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_va IS E'Relación entre valores añadidos y productos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.cod_modalidad IS E'Código de modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.fec_alta IS E'Fecha de alta del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.cod_va IS E'Código del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.cod_pais IS E'Código de país';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.fec_baja IS E'Fecha de baja del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.ind_obligatorio IS E'Indica si es obligatorio este valor añadido para el producto al que está asociado y, por tanto, se comportaría como un atributo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.cod_grp_va_obligatorio IS E'Indicador que permite saber si un valor adicional tiene otros valores adicionales que no pueden asociarse a la vez. Si tiene el valor 0 o nulo, no tiene valores adicionales excluyentes. Si tiene otro valor, indica que el resto de valores añadidos con ese mismo valor en el campo son excluyentes entre sí, aunque estén marcados todos como obligatorios.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.tipo_emb IS E'Tipo de embalaje';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.num_intentos_entrega_min IS E'Número mínimo de intentos de entrega para este valor añadido solamente para clientes de contrato. Si está informado tiene preferencia respecto al atributo por defecto del producto (NUM_INTENTOS_ENTREGA)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.num_intentos_entrega_max IS E'Número máximo de intentos de entrega para este valor añadido solamente para clientes de contrato. Si está informado tiene preferencia respecto al atributo por defecto del producto (NUM_INTENTOS_ENTREGA).';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.tiempo_lista_min IS E'Número mínimo de días que un producto permanece en Correos si no se ha podido entregar. \nEste valor añadido se aplica solamente a clientes con contrato y tiene preferencia respecto al atributo del producto (tiempo_lista).';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.tiempo_lista_max IS E'Número máximo de días que un producto permanece en Correos si no se ha podido entregar. \nEste valor añadido se aplica solamente a clientes con contrato y tiene preferencia respecto al atributo del producto (tiempo_lista).';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.importe_min IS E'Importe mínimo del valor añadido asociado a este producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.importe_max IS E'Importe máximo del valor añadido asociado a este producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.tiempo_custodia IS E'Tiempo que se guardan los datos del envío, en meses';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.ind_envio IS E'Indica si el valor añadido asociado al producto se aplica a nivel de envío, en lugar de por bulto, como es el funcionamiento por defecto del Maestro de Productos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_va.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fecbaja ON mdp_producto.tb_mdp_producto_va IS E'La fecha de baja tiene que ser mayor que la fecha de alta';
-- ddl-end --
COMMENT ON CONSTRAINT ck_intentos_entrega ON mdp_producto.tb_mdp_producto_va IS E'El número máximo o mínimo de intentos de entrega no puede ser negativo o nulo, ni el máximo puede ser menor que el mínimo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_tiempo_lista ON mdp_producto.tb_mdp_producto_va IS E'El tiempo en lista máximo o mínimo del producto no puede ser negativo o nulo, ni el tiempo máximo menor del tiempo mínimo.';
-- ddl-end --
COMMENT ON CONSTRAINT ck_importes ON mdp_producto.tb_mdp_producto_va IS E'El importe del producto no puede ser negativo. El importe_min no puede ser mayor que el importe máximo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_va IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
COMMENT ON CONSTRAINT ck_custodia ON mdp_producto.tb_mdp_producto_va IS E'El tiempo de custodia no puede ser negativo';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_va OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tramo | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tramo CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tramo (
	cod_tramo numeric(10,0) NOT NULL,
	limite_min numeric(7,0) NOT NULL,
	limite_max numeric(7,0) NOT NULL,
	cod_medida varchar(5) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tramo_pk PRIMARY KEY (cod_tramo),
	CONSTRAINT ck_limites CHECK (((limite_min >= (0)::numeric) AND (limite_max >= (0)::numeric) AND (limite_max >= limite_min))),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_tramo IS E'Tramos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo.cod_tramo IS E'Código tramo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo.limite_min IS E'Límite inferior del tramo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo.limite_max IS E'Límite máximo del tramo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo.cod_medida IS E'Unidad de medida del tramo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_limites ON mdp_producto.tb_mdp_tramo IS E'Los límites del tramo no pueden ser negativos ni el límite máximo ser menor que el límite mínimo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tramo IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tramo OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_ambito | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_ambito CASCADE;
CREATE TABLE mdp_producto.tb_mdp_ambito (
	cod_ambito numeric(5,0) NOT NULL,
	nom_ambito varchar(250) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_ambito_pk PRIMARY KEY (cod_ambito),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_ambito IS E'Tabla de ámbitos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito.cod_ambito IS E'Código del ámbito';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito.nom_ambito IS E'Nombre del ámbito';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_ambito IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_ambito OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_ambito_perfil_modalidad | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_ambito_perfil_modalidad CASCADE;
CREATE TABLE mdp_producto.tb_mdp_ambito_perfil_modalidad (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	fec_alta timestamp NOT NULL,
	cod_ambito numeric(5,0) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_ambito_perfil_modalidad_pk PRIMARY KEY (cod_producto_comercial,cod_modalidad,fec_alta,cod_ambito),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_ambito_perfil_modalidad IS E'Tabla para relacionar los ámbitos asociados a un producto por su perfil y modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_perfil_modalidad.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_perfil_modalidad.cod_modalidad IS E'Código de modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_perfil_modalidad.fec_alta IS E'Fecha de alta del ambito para el producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_perfil_modalidad.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_perfil_modalidad.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_ambito_perfil_modalidad IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_ambito_perfil_modalidad OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_va_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_va_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_va_idioma (
	cod_va varchar(7) NOT NULL,
	cod_perfil numeric(2) NOT NULL,
	fec_alta timestamp NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	fec_baja timestamp NOT NULL,
	nom_va varchar(80) NOT NULL,
	desc_va varchar(255),
	desc_va_ext varchar(255),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_idioma_va_pk PRIMARY KEY (cod_va,cod_idioma_alpha2,cod_perfil,fec_alta),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_fec_baja CHECK ((fec_baja > fec_alta))
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_va_idioma IS E'Tabla relacional que almacena los nombres de los valores añadidos en distintos idiomas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.cod_va IS E'Código del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.cod_perfil IS E'Código de perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.fec_alta IS E'Fecha de alta de la traducción del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.cod_idioma_alpha2 IS E'Código idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.fec_baja IS E'Fecha de baja de la traducción del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.nom_va IS E'Nombre del valor añadido para el idioma cuyo código está en COD_IDIOMA_ALPHA2';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.desc_va IS E'Descripción detallada del valor añadido traducida en el idioma cuyo código está en COD_IDIOMA_ALPHA2';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.desc_va_ext IS E'Descripción extendida del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_va_idioma IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_baja ON mdp_producto.tb_mdp_va_idioma IS E'La fecha de baja de la traducción del valor añadido no puede ser menor a la de alta';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_va_idioma OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_atributo_pais | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_atributo_pais CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_atributo_pais (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	fec_alta timestamp NOT NULL,
	cod_pais varchar(3) NOT NULL,
	fec_baja timestamp,
	ind_obliga_peso boolean NOT NULL DEFAULT TRUE,
	peso_min numeric(12,3),
	peso_max numeric(12,3),
	importe_min numeric(8,2) NOT NULL DEFAULT 0,
	importe_max numeric(8,2) NOT NULL DEFAULT 0,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_atributo_pais_pk PRIMARY KEY (cod_producto_comercial,cod_modalidad,cod_pais,fec_alta),
	CONSTRAINT ck_pesos CHECK (((peso_min >= (0)::numeric) AND (peso_max >= (0)::numeric) AND ((peso_min IS NOT NULL) AND (peso_max IS NOT NULL)) AND (peso_max >= peso_min))),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_importes CHECK ((importe_max>=0 and importe_min >=0) AND (importe_max >= importe_min))
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_atributo_pais IS E'Tabla que guarda los valores máximos de los atributos de un producto que dependen del destino';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.cod_modalidad IS E'Código de modalidad de entrega/admisión';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.fec_alta IS E'Fecha de alta del atributo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.fec_baja IS E'Fecha de baja del atributo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.ind_obliga_peso IS E'Indica si el peso es obligatorio para el producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.peso_min IS E'Peso mínimo del producto (en g.), que en el caso de España, servirá como valor por defecto de este atributo para el producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.peso_max IS E'Peso máximo del producto (en g.), que en el caso de España, servirá como valor por defecto de este atributo para el producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.importe_min IS E'Importe mínimo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.importe_max IS E'Importe máximo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_atributo_pais.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_pesos ON mdp_producto.tb_mdp_producto_atributo_pais IS E'Los pesos no pueden ser negativos o nulos, y el peso máximo no puede ser menor que el peso mínimo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_atributo_pais IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
COMMENT ON CONSTRAINT ck_importes ON mdp_producto.tb_mdp_producto_atributo_pais IS E'El importe máximo del producto no puede ser menor que el importe mínimo. Ambos valores deben ser positivos.';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_atributo_pais OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tam_simple | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tam_simple CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tam_simple (
	cod_tam_simple numeric(10,0) NOT NULL,
	largo numeric(5,0) NOT NULL,
	alto numeric(5,0) NOT NULL,
	ancho numeric(5,0) NOT NULL,
	peso numeric(12,3),
	logo_tam_simple bytea,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tam_simple_pk PRIMARY KEY (cod_tam_simple),
	CONSTRAINT ck_dimensiones CHECK (((largo >= (0)::numeric) AND (alto >= (0)::numeric) AND (ancho >= (0)::numeric))),
	CONSTRAINT ck_peso CHECK (peso >= 0),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_tam_simple IS E'Tabla para almacenar tamaños predefinidos de productos cuando el usuario no quiere/puede indicar las medidas exactas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple.cod_tam_simple IS E'Código del tamaño amigable';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple.largo IS E'Largo del producto (en mm.)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple.alto IS E'Alto del producto (en mm.)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple.ancho IS E'Ancho del producto (en mm.)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple.peso IS E'Peso máximo de un producto (en g.) aceptado en el tramo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple.logo_tam_simple IS E'Imágen asociada a este tamaño predefinido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_dimensiones ON mdp_producto.tb_mdp_tam_simple IS E'Las dimensiones no pueden ser negativas';
-- ddl-end --
COMMENT ON CONSTRAINT ck_peso ON mdp_producto.tb_mdp_tam_simple IS E'El peso máximo aceptado en el tramo no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tam_simple IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tam_simple OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tam_simple_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tam_simple_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tam_simple_idioma (
	cod_tam_simple numeric(10,0) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	nom_tam_simple varchar(60) NOT NULL,
	desc_tam varchar(255),
	desc_alto varchar(60) NOT NULL,
	desc_ancho varchar(60) NOT NULL,
	desc_largo varchar(60) NOT NULL,
	desc_peso varchar(60) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tam_simple_idioma_pk PRIMARY KEY (cod_tam_simple,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_tam_simple_idioma IS E'Tabla que guarda la relación entre un tamaños amigable y su traducción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.cod_tam_simple IS E'Código del tamaño amigable';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.nom_tam_simple IS E'Nombre del tamaño amigable';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.desc_tam IS E'Descripción del tamaño amigable';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.desc_alto IS E'Literal para el alto del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.desc_ancho IS E'Literal para el ancho del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.desc_largo IS E'Literal para el largo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.desc_peso IS E'Literal para el peso del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tam_simple_idioma IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tam_simple_idioma OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_tam_simple | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_tam_simple CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_tam_simple (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	fec_alta timestamp NOT NULL,
	cod_tam_simple numeric(10,0) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_tam_simple_pk PRIMARY KEY (cod_producto_comercial,cod_modalidad,fec_alta,cod_tam_simple),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_tam_simple IS E'Tabla que relaciona un producto con los tamaños amigables que tenga definidos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tam_simple.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil, por sistema';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tam_simple.cod_modalidad IS E'Código de modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tam_simple.fec_alta IS E'Fecha de alta del tamaño amigable para el producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tam_simple.cod_tam_simple IS E'Código del tamaño amigable';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tam_simple.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tam_simple.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_tam_simple IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_tam_simple OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_va_restriccion | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_va_restriccion CASCADE;
CREATE TABLE mdp_producto.tb_mdp_va_restriccion (
	cod_va varchar(7) NOT NULL,
	cod_va_rest varchar(7) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_va_restriccion_pk PRIMARY KEY (cod_va,cod_va_rest),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_va_restriccion IS E'Tabla que almacena las restricciones entre valores añadidos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion.cod_va IS E'Código del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion.cod_va_rest IS E'Código del valor añadido que tiene una restricción con el valor añadido almacenado en COD_VA';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_va_restriccion IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_va_restriccion OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_perfil_franqueo | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_perfil_franqueo CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_perfil_franqueo (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_franqueo varchar(10) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_productoperfilfranqueo_pk PRIMARY KEY (cod_producto_comercial,cod_franqueo),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_perfil_franqueo IS E'Tabla que guarda la relación entre un producto y los diferentes tipos de franqueo que puede tener';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_franqueo.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_franqueo.cod_franqueo IS E'Código de tipo de franqueo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_franqueo.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_franqueo.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_perfil_franqueo IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_perfil_franqueo OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_empresa | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_empresa CASCADE;
CREATE TABLE mdp_producto.tb_mdp_empresa (
	cod_empresa numeric(4,0) NOT NULL,
	nom_empresa varchar(60),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_empresa_pk PRIMARY KEY (cod_empresa),
	CONSTRAINT ck_nom_empresa_upper CHECK ((upper((nom_empresa)::text) = (nom_empresa)::text)),
	CONSTRAINT ck_nom_empresa_uq UNIQUE (nom_empresa),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_empresa IS E'Tabla para guardar las empresas responsables de un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_empresa.cod_empresa IS E'Código de la empresa que proporciona o comercializa el producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_empresa.nom_empresa IS E'Nombre de la empresa que proporciona el producto para su comercialización';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_empresa.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_empresa.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_nom_empresa_upper ON mdp_producto.tb_mdp_empresa IS E'Se convierte el nombre de la empresa a mayúsculas para evitar duplicidades';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_empresa IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_empresa OWNER TO postgres;
-- ddl-end --

-- object: idx_producto_nom_producto | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_nom_producto CASCADE;
CREATE UNIQUE INDEX idx_producto_nom_producto ON mdp_producto.tb_mdp_producto
USING btree
(
	nom_producto pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --
COMMENT ON INDEX mdp_producto.idx_producto_nom_producto IS E'Indice único por el campo nombre del producto';
-- ddl-end --

-- object: mdp_producto.tb_mdp_sistema | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_sistema CASCADE;
CREATE TABLE mdp_producto.tb_mdp_sistema (
	cod_sistema varchar(3) NOT NULL,
	nom_sistema varchar(60) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_sistema_pk PRIMARY KEY (cod_sistema),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_sistema IS E'Tabla que guarda la lista de aplicaciones o sistemas que van a interactuar con el maestro de productos y para los cuales habrá un grupo de productos asociados a ellos.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sistema.cod_sistema IS E'Código de la aplicación o sistema';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sistema.nom_sistema IS E'Nombre de la aplicación o sistema';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sistema.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sistema.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_sistema IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_sistema OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_perfil | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_perfil CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_perfil (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_producto varchar(10) NOT NULL,
	cod_perfil numeric(2) NOT NULL,
	ind_imei boolean NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_perfil_pk PRIMARY KEY (cod_producto_comercial),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_perfil IS E'Relación entre un producto, el sistema asociado y los diferentes perfiles que puede tener';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil.cod_producto IS E'Código del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil.ind_imei IS E'Indica si es obligatorio el campo IMEI, aplicable a producto de Paq Frío y Paq Farma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_perfil IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_perfil OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tipo | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tipo CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tipo (
	cod_tipo numeric(2,0) NOT NULL,
	nom_tipo varchar(30) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tipo_pk PRIMARY KEY (cod_tipo),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_tipo IS E'Los diferentes tipos en que se pueden clasificar los productos desde el punto de vista financiero';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo.cod_tipo IS E'Código del tipo de producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo.nom_tipo IS E'Nombre del tipo de producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tipo IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tipo OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_tipo | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_tipo CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_tipo (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_tipo numeric(2,0) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_tipo_pk PRIMARY KEY (cod_producto_comercial,cod_tipo),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_tipo IS E'Relación entre un producto y los tipos que tiene asignados';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tipo.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tipo.cod_tipo IS E'Código del tipo de producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tipo.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tipo.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_tipo IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_tipo OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_canal | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_canal CASCADE;
CREATE TABLE mdp_producto.tb_mdp_canal (
	cod_canal numeric(2,0) NOT NULL,
	nom_canal varchar(60) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_canal_pk PRIMARY KEY (cod_canal),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_canal IS E'Canal de distribución del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_canal.cod_canal IS E'Código del canal';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_canal.nom_canal IS E'Nombre del canal de venta';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_canal.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_canal.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_canal IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_canal OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_sistema_canal | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_sistema_canal CASCADE;
CREATE TABLE mdp_producto.tb_mdp_sistema_canal (
	cod_sistema varchar(3) NOT NULL,
	cod_canal numeric(2,0) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_sistema_canal_pk PRIMARY KEY (cod_sistema,cod_canal),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_sistema_canal IS E'La relación entre un canal y las aplicaciones que pueden usar ese canal se encuentra en esta tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sistema_canal.cod_sistema IS E'Código del sistema o aplicación';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sistema_canal.cod_canal IS E'Código del canal';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sistema_canal.fec_creacion IS E'Fecha de creación del registro en la tala';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sistema_canal.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_sistema_canal IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_sistema_canal OWNER TO postgres;
-- ddl-end --

-- object: idx_producto_atributo_empresa | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_atributo_empresa CASCADE;
CREATE INDEX idx_producto_atributo_empresa ON mdp_producto.tb_mdp_producto_atributo
USING btree
(
	cod_empresa pg_catalog.numeric_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_familia_familia | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_familia_familia CASCADE;
CREATE INDEX idx_producto_familia_familia ON mdp_producto.tb_mdp_producto_familia
USING btree
(
	cod_familia pg_catalog.numeric_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_productoperfilfranqueo_franqueo | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_productoperfilfranqueo_franqueo CASCADE;
CREATE INDEX idx_productoperfilfranqueo_franqueo ON mdp_producto.tb_mdp_producto_perfil_franqueo
USING btree
(
	cod_franqueo pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_sistema_sistema | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_sistema_sistema CASCADE;
CREATE UNIQUE INDEX idx_producto_sistema_sistema ON mdp_producto.tb_mdp_producto_perfil
USING btree
(
	cod_producto,
	cod_perfil
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_sistema_canal_canal | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_sistema_canal_canal CASCADE;
CREATE INDEX idx_sistema_canal_canal ON mdp_producto.tb_mdp_sistema_canal
USING btree
(
	cod_canal pg_catalog.numeric_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_va_va | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_va_va CASCADE;
CREATE INDEX idx_producto_va_va ON mdp_producto.tb_mdp_producto_va
USING btree
(
	cod_va pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_idioma_idioma CASCADE;
CREATE INDEX idx_producto_idioma_idioma ON mdp_producto.tb_mdp_producto_idioma
USING btree
(
	cod_idioma_alpha2 pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_va_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_va_idioma_idioma CASCADE;
CREATE INDEX idx_va_idioma_idioma ON mdp_producto.tb_mdp_va_idioma
USING btree
(
	cod_idioma_alpha2 pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_tipo_tipo | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_tipo_tipo CASCADE;
CREATE INDEX idx_producto_tipo_tipo ON mdp_producto.tb_mdp_producto_tipo
USING btree
(
	cod_tipo pg_catalog.numeric_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_tramo_medida | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_tramo_medida CASCADE;
CREATE INDEX idx_tramo_medida ON mdp_producto.tb_mdp_tramo
USING btree
(
	cod_medida pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_tam_simple_tam_simple | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_tam_simple_tam_simple CASCADE;
CREATE INDEX idx_producto_tam_simple_tam_simple ON mdp_producto.tb_mdp_producto_tam_simple
USING btree
(
	cod_tam_simple pg_catalog.numeric_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_tam_simple_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_tam_simple_idioma_idioma CASCADE;
CREATE INDEX idx_tam_simple_idioma_idioma ON mdp_producto.tb_mdp_tam_simple_idioma
USING btree
(
	cod_idioma_alpha2 pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.tb_mdp_tipo_material | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tipo_material CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tipo_material (
	cod_tipo_material numeric(1,0) NOT NULL,
	nom_tipo_material varchar(20) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tipo_material_pk PRIMARY KEY (cod_tipo_material),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_tipo_material IS E'Los productos se pueden clasificar para el HUB financiero como Producto, Servicio o Producto y servicio';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_material.cod_tipo_material IS E'Código del tipo de material';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_material.nom_tipo_material IS E'Nombre del tipo de material';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_material.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_material.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tipo_material IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tipo_material OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_entrega | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_entrega CASCADE;
CREATE TABLE mdp_producto.tb_mdp_entrega (
	cod_entrega numeric(2) NOT NULL,
	ind_citypaq boolean NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_mod_entrega_pk PRIMARY KEY (cod_entrega),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_entrega IS E'Tabla que guarda los diferentes tipos de modalidades de entrega de un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_entrega.cod_entrega IS E'Código de la modalidad de entrega';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_entrega.ind_citypaq IS E'Indica si el producto permite entrega en CityPaq';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_entrega.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_entrega.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_entrega IS E'La fecha de actualización no puede er menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_entrega OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_ambito_detalle_aiu | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_ambito_detalle_aiu() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_ambito_detalle_aiu ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN

  IF EXISTS ( SELECT 1
              FROM mdp_producto.TB_MDP_PRODUCTO_AMBITO PA
              WHERE PA.COD_AMBITO = NEW.COD_AMBITO 
                AND NOT EXISTS ( SELECT 1
                                 FROM mdp_producto.TB_MDP_PRODUCTO_ATRIBUTO_PAIS
                                 WHERE COD_PRODUCTO = PA.COD_PRODUCTO
                                   AND COD_PAIS = NEW.COD_PAIS
                               )
            ) THEN
    RAISE EXCEPTION 'Falta fila en TB_MDP_PRODUCTO_ATRIBUTO_PAIS';
  END IF;
  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_ambito_detalle_aiu() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_ambito_detalle_aiu() IS E'Comprobar que al actualizar una fila de tb_mdp_ambito_detalle los productos y paises relacionados a traves de tb_mdp_producto_ambito y tb_mdp_ambito_pais estan tambien relacionados en tb_mdp_producto_atributo_pais';
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_ambito_perfil_modalidad_aiud | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_ambito_perfil_modalidad_aiud() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_ambito_perfil_modalidad_aiud ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
  IF NOT EXISTS ( SELECT 1
              FROM mdp_producto.TB_MDP_PRODUCTO_ZONA PZ
              WHERE PZ.COD_PRODUCTO_COMERCIAL = NEW.COD_PRODUCTO_COMERCIAL
              AND PZ.COD_MODALIDAD = NEW.COD_MODALIDAD
				AND PZ.FEC_ALTA = NEW.FEC_ALTA
				AND PZ.COD_AMBITO = NEW.COD_AMBITO
            ) THEN
    RAISE EXCEPTION 'Falta fila en TB_MDP_PRODUCTO_ZONA';
  END IF;
  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_ambito_perfil_modalidad_aiud() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_ambito_perfil_modalidad_aiud() IS E'Comprobar que al insertar, actualizar o borrar una fila de tb_mdp_ambito_perfil_modalidad, los ambitos asociados al producto, por modalidad, siguen siendo los mismos que los asociados en tb_mdp_producto_zona, para evitar que haya zonas tarifarias asociadas a un producto en ámbitos no asociados directamente al mismo.';
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_au | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_au() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_au ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
	  IF EXISTS ( SELECT 1
	              FROM mdp_producto.TB_MDP_PRODUCTO_ZONA PZ
	                   JOIN mdp_producto.TB_MDP_ZONA_TARIF_PAIS ZP ON ZP.COD_ZONA_TARIF = PZ.COD_ZONA_TARIF
	              WHERE PZ.COD_PRODUCTO_COMERCIAL = OLD.COD_PRODUCTO_COMERCIAL
	                AND ZP.COD_PAIS = OLD.COD_PAIS
	                AND NOT EXISTS ( SELECT 1
	                                 FROM mdp_producto.TB_MDP_PRODUCTO_ATRIBUTO_PAIS
	                                 WHERE COD_PRODUCTO_COMERCIAL = OLD.COD_PRODUCTO_COMERCIAL
	                                   AND COD_PAIS = OLD.COD_PAIS
	                               )
	            ) THEN
	    RAISE EXCEPTION 'Falta fila en TB_MDP_PRODUCTO_ATRIBUTO_PAIS';
	  END IF;

	  IF NEW.PESO_MIN = 0 AND NEW.PESO_MAX = 0 THEN
	    NULL;
	  ELSIF NOT EXISTS ( SELECT MIN(T.LIMITE_MIN), MAX(T.LIMITE_MAX)
	                     FROM mdp_producto.TB_MDP_SISTEMA_ZONA_TRAMO SZT
                         JOIN mdp_producto.TB_MDP_TRAMO T ON T.COD_TRAMO = SZT.COD_TRAMO
						 JOIN mdp_producto.TB_MDP_PRODUCTO_ZONA PZ ON SZT.COD_ZONA_TARIF = PZ.COD_ZONA_TARIF
	                     WHERE PZ.COD_PRODUCTO_COMERCIAL = NEW.COD_PRODUCTO_COMERCIAL AND (SZT.FEC_BAJA IS NULL OR SZT.FEC_BAJA > now())
	                     HAVING MIN(T.LIMITE_MIN) <= NEW.PESO_MIN
	                       AND MAX(T.LIMITE_MAX) >= NEW.PESO_MAX
	                   ) THEN
	    RAISE EXCEPTION 'Limites de peso fuera de rango segun los ambitos del producto';
	  END IF;

	  RETURN NEW;
	END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_au() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_au() IS E'Comprobar que al actualizar una fila de tb_mdp_producto_atributo_pais los productos y paises relacionados a traves de tb_mdp_producto_zona siguen relacionados en tb_mdp_producto_atributo_pais. \n\nControlar que al actualizar una fila en tb_mdp_producto_atributo_pais el intervalo (PESO_MIN, PESO_MAX) esta cubierto por los tramos de peso asociados al producto';
-- ddl-end --

-- object: tr_tb_mdp_producto_atributo_pais_au | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_tb_mdp_producto_atributo_pais_au ON mdp_producto.tb_mdp_producto_atributo_pais CASCADE;
CREATE OR REPLACE TRIGGER tr_tb_mdp_producto_atributo_pais_au
	AFTER UPDATE
	ON mdp_producto.tb_mdp_producto_atributo_pais
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_au();
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ad | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ad() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ad ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
  IF EXISTS ( SELECT 1
              FROM mdp_producto.TB_MDP_PRODUCTO_ZONA PZ
                   JOIN mdp_producto.TB_MDP_ZONA_TARIF_PAIS ZP ON ZP.COD_ZONA_TARIF = PZ.COD_ZONA_TARIF
              WHERE PZ.COD_PRODUCTO = OLD.COD_PRODUCTO 
                AND ZP.COD_PAIS = OLD.COD_PAIS
                AND NOT EXISTS ( SELECT 1
                                 FROM mdp_producto.TB_MDP_PRODUCTO_ATRIBUTO_PAIS
                                 WHERE COD_PRODUCTO = OLD.COD_PRODUCTO
                                   AND COD_PAIS = OLD.COD_PAIS
                               )
            ) THEN
    RAISE EXCEPTION 'Falta fila en TB_MDP_PRODUCTO_ATRIBUTO_PAIS';
  END IF;
  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ad() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ad() IS E'Comprobar que al borrar una fila de tb_mdp_producto_atributo_pais los productos y paises relacionados a traves de tb_mdp_producto_zona siguen relacionados en tb_mdp_producto_atributo_pais';
-- ddl-end --

-- object: tr_tb_mdp_producto_atributo_pais_ad | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_tb_mdp_producto_atributo_pais_ad ON mdp_producto.tb_mdp_producto_atributo_pais CASCADE;
CREATE OR REPLACE TRIGGER tr_tb_mdp_producto_atributo_pais_ad
	AFTER DELETE 
	ON mdp_producto.tb_mdp_producto_atributo_pais
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ad();
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ai | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ai() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ai ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
IF (NEW.PESO_MIN = 0 AND NEW.PESO_MAX = 0) OR NOT EXISTS ( SELECT 1
															FROM mdp_producto.tb_mdp_producto_zona pz
															WHERE pz.cod_producto_comercial = NEW.cod_producto_comercial
														   ) THEN
    NULL;
  ELSIF NOT EXISTS ( SELECT MIN(T.LIMITE_MIN), MAX(T.LIMITE_MAX)
                     FROM mdp_producto.TB_MDP_ZONA_TRAMO ZT
                          JOIN mdp_producto.TB_MDP_TRAMO T ON T.COD_TRAMO = ZT.COD_TRAMO
																										JOIN mdp_producto.TB_MDP_PRODUCTO_ZONA PZ ON PZ.COD_ZONA_TARIF = ZT.COD_ZONA_TARIF					
                     WHERE PZ.COD_PRODUCTO_COMERCIAL = NEW.COD_PRODUCTO_COMERCIAL
                     HAVING MIN(T.LIMITE_MIN) <= NEW.PESO_MIN
                       AND MAX(T.LIMITE_MAX) >= NEW.PESO_MAX
                   ) THEN
    RAISE EXCEPTION 'Limites de peso fuera de rango segun los ambitos del producto';
  END IF;

  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ai() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ai() IS E'Controlar que al insertar una fila en tb_mdp_producto_atributo_pais el intervalo (PESO_MIN, PESO_MAX) esta cubierto por los tramos de peso asociados al producto';
-- ddl-end --

-- object: tr_tb_mdp_producto_atributo_pais_ai | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_tb_mdp_producto_atributo_pais_ai ON mdp_producto.tb_mdp_producto_atributo_pais CASCADE;
CREATE OR REPLACE TRIGGER tr_tb_mdp_producto_atributo_pais_ai
	AFTER INSERT 
	ON mdp_producto.tb_mdp_producto_atributo_pais
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_producto_atributo_pais_ai();
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_tramo_au | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_tramo_au() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_tramo_au ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
  IF EXISTS ( SELECT 1
              FROM mdp_producto.TB_MDP_ZONA_TRAMO ZT
                JOIN mdp_producto.TB_MDP_PRODUCTO_ZONA PZ ON PZ.COD_ZONA_TARIF = ZT.COD_ZONA_TARIF
                   JOIN mdp_producto.TB_MDP_PRODUCTO_ATRIBUTO_PAIS PAP ON PAP.COD_PRODUCTO_COMERCIAL = PZ.COD_PRODUCTO_COMERCIAL AND PAP.COD_MODALIDAD = PZ.COD_MODALIDAD AND PAP.FEC_ALTA = PZ.FEC_ALTA
              WHERE ZT.COD_TRAMO = NEW.COD_TRAMO
                AND NOT EXISTS ( SELECT MIN(T.LIMITE_MIN), MAX(T.LIMITE_MAX)
                                 FROM mdp_producto.TB_MDP_ZONA_TRAMO ZT2
                                    JOIN mdp_producto.TB_MDP_TRAMO T ON T.COD_TRAMO = ZT2.COD_TRAMO
                                    JOIN mdp_producto.TB_MDP_PRODUCTO_ZONA PZ2 ON PZ2.COD_ZONA_TARIF = ZT2.COD_ZONA_TARIF
                                 WHERE PZ2.COD_PRODUCTO_COMERCIAL =PAP.COD_PRODUCTO_COMERCIAL AND PAP.COD_MODALIDAD = PZ2.COD_MODALIDAD AND PAP.FEC_ALTA = PZ2.FEC_ALTA
                                 HAVING MIN(T.LIMITE_MIN) <= PAP.PESO_MIN
                                    AND MAX(T.LIMITE_MAX) >= PAP.PESO_MAX
                               )
            ) THEN
    RAISE EXCEPTION 'Limites de peso en tb_mdp_producto_atributo_pais fuera de rango segun tb_mdp_tramo';
  END IF;

  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_tramo_au() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_tramo_au() IS E'Controlar que al actualizar una fila en tb_mdp_tramo en los registros de tb_mdp_producto_atributo_pais con productos que tienen ese tramo el intervalo (PESO_MIN, PESO_MAX) sigue cubierto por los tramos de peso asociados al producto';
-- ddl-end --

-- object: tr_tb_mdp_tramo_au | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_tb_mdp_tramo_au ON mdp_producto.tb_mdp_tramo CASCADE;
CREATE OR REPLACE TRIGGER tr_tb_mdp_tramo_au
	AFTER UPDATE
	ON mdp_producto.tb_mdp_tramo
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_tramo_au();
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_producto_tramo_aud | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_producto_tramo_aud() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_producto_tramo_aud ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
  IF EXISTS ( SELECT 1
              FROM mdp_producto.TB_MDP_PRODUCTO_ATRIBUTO_PAIS PAP
              WHERE PAP.COD_PRODUCTO = OLD.COD_PRODUCTO
                AND NOT EXISTS ( SELECT MIN(T.LIMITE_MIN), MAX(T.LIMITE_MAX)
                                 FROM mdp_producto.TB_MDP_PRODUCTO_TRAMO PT
                                      JOIN mdp_producto.TB_MDP_TRAMO T ON T.COD_TRAMO = PT.COD_TRAMO
                                 WHERE PT.COD_PRODUCTO = PAP.COD_PRODUCTO
                                 HAVING MIN(T.LIMITE_MIN) <= PAP.PESO_MIN
                                    AND MAX(T.LIMITE_MAX) >= PAP.PESO_MAX
                               )
            ) THEN
    RAISE EXCEPTION 'Limites de peso en tb_mdp_producto_atributo_pais fuera de rango segun tb_mdp_tramo';
  END IF;

  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_producto_tramo_aud() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_producto_tramo_aud() IS E'Controlar que al actualizar o borrar una fila en tb_mdp_producto_tramo en los registros con el mismo producto de tb_mdp_producto_atributo_pais el intervalo (PESO_MIN, PESO_MAX) sigue cubierto por los tramos de peso asociados al producto';
-- ddl-end --

-- object: mdp_producto.tb_mdp_va_restriccion_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_va_restriccion_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_va_restriccion_idioma (
	cod_va varchar(7) NOT NULL,
	cod_va_rest varchar(7) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	desc_restriccion varchar(255) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_va_restriccion_idioma_pk PRIMARY KEY (cod_va,cod_va_rest,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_va_restriccion_idioma IS E'tabla que relaciona las restricciones de los valores añadidos con el idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion_idioma.cod_va IS E'Código del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion_idioma.cod_va_rest IS E'Código del valor añadido que tiene una restricción con el valor añadido almacenado en COD_VA';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion_idioma.desc_restriccion IS E'Detalle de la restricción entre los valores añadidos almacenados en COD_VA y COD_VA_REST';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_restriccion_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_va_restriccion_idioma IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_va_restriccion_idioma OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_familia_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_familia_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_familia_idioma (
	cod_familia numeric(10,0) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	nom_familia varchar(100) NOT NULL,
	desc_familia varchar(255),
	mas_info varchar(255),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_familia_idioma_pk PRIMARY KEY (cod_familia,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_familia_idioma IS E'Tabla que almacena los nombres de las familias en los distintos idiomas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia_idioma.cod_familia IS E'Código de familia';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia_idioma.nom_familia IS E'Nombre familia';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia_idioma.desc_familia IS E'Descripción de la familia de productos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia_idioma.mas_info IS E'Información ampliada sobre los productos de la familia';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_familia_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_familia_idioma IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_familia_idioma OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tipo_formato | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tipo_formato CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tipo_formato (
	cod_tipo_formato numeric(2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tipo_producto_pk PRIMARY KEY (cod_tipo_formato),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_tipo_formato IS E'Tabla que guarda los tipos de formato de un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_formato.cod_tipo_formato IS E'Código del tipo de formato';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_formato.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_formato.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tipo_formato IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tipo_formato OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_tipo_formato | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_tipo_formato CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_tipo_formato (
	cod_producto varchar(10) NOT NULL,
	cod_tipo_formato numeric(2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_tipo_formato_pk PRIMARY KEY (cod_producto,cod_tipo_formato),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_tipo_formato IS E'Relación entre un producto y los tipos de formato posibles asociados';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tipo_formato.cod_producto IS E'Código de producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tipo_formato.cod_tipo_formato IS E'Código del tipo de formato';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tipo_formato.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_tipo_formato.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_tipo_formato IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_tipo_formato OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_franja_horaria | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_franja_horaria CASCADE;
CREATE TABLE mdp_producto.tb_mdp_franja_horaria (
	cod_franja numeric(2) NOT NULL,
	hora_inicio time NOT NULL,
	hora_fin time NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_franja_horaria_pk PRIMARY KEY (cod_franja),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_franja_horaria IS E'Tabla que guarda las franjas horarias que pueden elegirse para la entrega de un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria.cod_franja IS E'Código de la franja horaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria.hora_inicio IS E'Hora de inicio de la franja horaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria.hora_fin IS E'Hora de fin de la franja horaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_franja_horaria IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_franja_horaria OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_va_franja_horaria | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_va_franja_horaria CASCADE;
CREATE TABLE mdp_producto.tb_mdp_va_franja_horaria (
	cod_va varchar(7) NOT NULL,
	cod_perfil numeric(2) NOT NULL,
	fec_alta timestamp NOT NULL,
	cod_franja numeric(2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_va_franjahoraria_pk PRIMARY KEY (cod_va,cod_perfil,fec_alta,cod_franja),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_va_franja_horaria IS E'Relación entre el valor añadido y las franjas horarias en que se puede entregar un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franja_horaria.cod_va IS E'Código del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franja_horaria.cod_perfil IS E'Código de perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franja_horaria.fec_alta IS E'Fecha de alta de la franja horaria del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franja_horaria.cod_franja IS E'Código de la franja horaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franja_horaria.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franja_horaria.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_va_franja_horaria IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_va_franja_horaria OWNER TO postgres;
-- ddl-end --

-- object: idx_va_franjahoraria_franja_horaria | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_va_franjahoraria_franja_horaria CASCADE;
CREATE INDEX idx_va_franjahoraria_franja_horaria ON mdp_producto.tb_mdp_va_franja_horaria
USING btree
(
	cod_franja
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_tipoformato_tipo_formato | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_tipoformato_tipo_formato CASCADE;
CREATE INDEX idx_producto_tipoformato_tipo_formato ON mdp_producto.tb_mdp_producto_tipo_formato
USING btree
(
	cod_tipo_formato
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.tb_mdp_franja_horaria_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_franja_horaria_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_franja_horaria_idioma (
	cod_franja numeric(2) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	nom_franja varchar(30) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_franja_horaria_idioma_pk PRIMARY KEY (cod_franja,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_franja_horaria_idioma IS E'Tabla que guarda la relación entre una franja horaria y su traducción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria_idioma.cod_franja IS E'Código de la franja horaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria_idioma.nom_franja IS E'Nombre de la franja horaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_franja_horaria_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_franja_horaria_idioma IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_franja_horaria_idioma OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tramo_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tramo_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tramo_idioma (
	cod_tramo numeric(10,0) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	nom_tramo varchar(50) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tramo_idioma_pk PRIMARY KEY (cod_tramo,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_tramo_idioma IS E'Tabla que guarda la relación entre un tramo y su traducción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo_idioma.cod_tramo IS E'Código del tramo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo_idioma.nom_tramo IS E'Nombre del tramo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tramo_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tramo_idioma IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tramo_idioma OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_entrega_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_entrega_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_entrega_idioma (
	cod_entrega numeric(2) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	nom_entrega varchar(60) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_entrega_idioma_pk PRIMARY KEY (cod_entrega,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_entrega_idioma IS E'Tabla que guarda la relación entre una modalidad de entrega y su traducción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_entrega_idioma.cod_entrega IS E'Código modalidad entrega';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_entrega_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_entrega_idioma.nom_entrega IS E'Nombre de la modalidad de entrega';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_entrega_idioma.fec_creacion IS E'Fecha de creacion del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_entrega_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_entrega_idioma IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_entrega_idioma OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tipo_formato_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tipo_formato_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tipo_formato_idioma (
	cod_tipo_formato numeric(2) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	nom_tipo_formato varchar(20) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tipo_formato_idioma_pk PRIMARY KEY (cod_tipo_formato,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_tipo_formato_idioma IS E'Tabla que guarda la relación entre un tipo de formato de producto y su traducción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_formato_idioma.cod_tipo_formato IS E'Código del tipo de formato';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_formato_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_formato_idioma.nom_tipo_formato IS E'Nombre del tipo de formato';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_formato_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_formato_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tipo_formato_idioma IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tipo_formato_idioma OWNER TO postgres;
-- ddl-end --

-- object: idx_tramo_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_tramo_idioma_idioma CASCADE;
CREATE INDEX idx_tramo_idioma_idioma ON mdp_producto.tb_mdp_tramo_idioma
USING btree
(
	cod_idioma_alpha2
);
-- ddl-end --

-- object: idx_tipo_formato_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_tipo_formato_idioma_idioma CASCADE;
CREATE INDEX idx_tipo_formato_idioma_idioma ON mdp_producto.tb_mdp_tipo_formato_idioma
USING btree
(
	cod_idioma_alpha2
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_entrega_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_entrega_idioma_idioma CASCADE;
CREATE INDEX idx_entrega_idioma_idioma ON mdp_producto.tb_mdp_entrega_idioma
USING btree
(
	cod_idioma_alpha2
);
-- ddl-end --

-- object: idx_franja_horaria_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_franja_horaria_idioma_idioma CASCADE;
CREATE INDEX idx_franja_horaria_idioma_idioma ON mdp_producto.tb_mdp_franja_horaria_idioma
USING btree
(
	cod_idioma_alpha2
);
-- ddl-end --

-- object: idx_va_restriccion_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_va_restriccion_idioma_idioma CASCADE;
CREATE INDEX idx_va_restriccion_idioma_idioma ON mdp_producto.tb_mdp_va_restriccion_idioma
USING btree
(
	cod_idioma_alpha2
);
-- ddl-end --

-- object: mdp_producto.tb_mdp_atributo_va | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_atributo_va CASCADE;
CREATE TABLE mdp_producto.tb_mdp_atributo_va (
	cod_atributo_va numeric(5) NOT NULL,
	tipo_atributo varchar(1) NOT NULL,
	tam_atributo numeric(3) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_va_atributo_pk PRIMARY KEY (cod_atributo_va),
	CONSTRAINT ck_tipo_atributo CHECK (tipo_atributo IN ('T','B','N', 'F','M')),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_atributo_va IS E'Tabla que guarda todos los atributos de los valores añadidos, sus características y si son obligatorios o no';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va.tipo_atributo IS E'Tipo de dato del atributo del valor añadido. Valores permitidos: "T" para un alfanumérico, "B" para booleanos, "N" para numérico, "F" para campos tipo fecha y "M" para campos que guarden minutos.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va.tam_atributo IS E'Tamaño del atributo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_tipo_atributo ON mdp_producto.tb_mdp_atributo_va IS E'El tipo de atributo toma como valores posibles: "N" para un campo numérico, "B" para booleanos, "T" para un campo alfanumérico, "F" para un campo del tipo fecha, que tendrá el formato "AAAAMMDD", "M" para campos que guarden minutos.';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_atributo_va IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_atributo_va OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_va_atributo_va | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_va_atributo_va CASCADE;
CREATE TABLE mdp_producto.tb_mdp_va_atributo_va (
	cod_va varchar(7) NOT NULL,
	cod_atributo_va numeric(5) NOT NULL,
	ind_obligatorio boolean NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_va_atributova_pk PRIMARY KEY (cod_va,cod_atributo_va),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_va_atributo_va IS E'Relación entre un valor añadido y sus atributos asociados';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_atributo_va.cod_va IS E'Código del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_atributo_va.cod_atributo_va IS E'Código del atributo del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_atributo_va.ind_obligatorio IS E'Indica si el atributo es obligatorio para el valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_atributo_va.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_atributo_va.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_va_atributo_va IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_va_atributo_va OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_atributo_va_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_atributo_va_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_atributo_va_idioma (
	cod_atributo_va numeric(5) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	nom_atributo_va varchar(60) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_atributo_va_idioma_pk PRIMARY KEY (cod_atributo_va,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_atributo_va_idioma IS E'Tabla relacional que almacena los nombres de los atributos de los valores añadidos en distintos idiomas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va_idioma.cod_atributo_va IS E'Código del atributo del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va_idioma.cod_idioma_alpha2 IS E'Código idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va_idioma.nom_atributo_va IS E'Nombre del atributo para el idioma cuyo código está en COD_IDIOMA_ALPHA2';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_atributo_va_idioma IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_atributo_va_idioma OWNER TO postgres;
-- ddl-end --

-- object: idx_va_atributo_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_va_atributo_idioma CASCADE;
CREATE INDEX idx_va_atributo_idioma ON mdp_producto.tb_mdp_atributo_va_idioma
USING btree
(
	cod_idioma_alpha2 pg_catalog.text_ops
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_va_atributo_va_atributo | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_va_atributo_va_atributo CASCADE;
CREATE INDEX idx_va_atributo_va_atributo ON mdp_producto.tb_mdp_va_atributo_va
USING btree
(
	cod_atributo_va
);
-- ddl-end --

-- object: mdp_producto.tb_mdp_documento | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_documento CASCADE;
CREATE TABLE mdp_producto.tb_mdp_documento (
	cod_documento numeric(2) NOT NULL,
	ind_validacion boolean NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_documento_pk PRIMARY KEY (cod_documento),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_documento IS E'Tabla que contiene los documentos posibles para el valor añadido de Escaneo/Validación';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_documento.cod_documento IS E'Código del documento';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_documento.ind_validacion IS E'Indica que el documento escaneado es para validación';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_documento.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_documento.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_documento IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_documento OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_documento_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_documento_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_documento_idioma (
	cod_documento numeric(2) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	desc_documento varchar(120) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_documento_idioma_pk PRIMARY KEY (cod_documento,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_documento_idioma IS E'Tabla relacional que almacena la traducción de los nombres de los tipos de documentos de escaneo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_documento_idioma.cod_documento IS E'Código del documento';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_documento_idioma.cod_idioma_alpha2 IS E'Código del idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_documento_idioma.desc_documento IS E'Descripción del documento a escanear';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_documento_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_documento_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_documento_idioma IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_documento_idioma OWNER TO postgres;
-- ddl-end --

-- object: idx_documento_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_documento_idioma_idioma CASCADE;
CREATE INDEX idx_documento_idioma_idioma ON mdp_producto.tb_mdp_documento_idioma
USING btree
(
	cod_idioma_alpha2
);
-- ddl-end --

-- object: mdp_producto.tb_mdp_atributo_va_documento | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_atributo_va_documento CASCADE;
CREATE TABLE mdp_producto.tb_mdp_atributo_va_documento (
	cod_atributo_va numeric(5) NOT NULL,
	cod_documento numeric(2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_atributo_va_documento_pk PRIMARY KEY (cod_atributo_va,cod_documento),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_atributo_va_documento IS E'Relación entre un atributo de un valor añadido y el tipo de documento que puede tener ese atributo. Pensado incialmente para el valor añadido "Escaneo/Validación"';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va_documento.cod_atributo_va IS E'Código del atributo del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va_documento.cod_documento IS E'Código del documento';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va_documento.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_atributo_va_documento.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_atributo_va_documento IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_atributo_va_documento OWNER TO postgres;
-- ddl-end --

-- object: idx_va_documento_documento | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_va_documento_documento CASCADE;
CREATE INDEX idx_va_documento_documento ON mdp_producto.tb_mdp_atributo_va_documento
USING btree
(
	cod_documento
);
-- ddl-end --

-- object: mdp_producto.tb_mdp_va_franqueo_perfil | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_va_franqueo_perfil CASCADE;
CREATE TABLE mdp_producto.tb_mdp_va_franqueo_perfil (
	cod_va varchar(7) NOT NULL,
	cod_perfil numeric(2) NOT NULL,
	cod_franqueo varchar(10) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_vafranqueoperfil_pk PRIMARY KEY (cod_va,cod_franqueo,cod_perfil),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_va_franqueo_perfil IS E'Tabla que guarda la relación entre un valor añadido y los diferentes tipos de franqueo que puede tener, por perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franqueo_perfil.cod_va IS E'Código del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franqueo_perfil.cod_perfil IS E'Código del perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franqueo_perfil.cod_franqueo IS E'Código de tipo de franqueo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franqueo_perfil.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_franqueo_perfil.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_va_franqueo_perfil IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_va_franqueo_perfil OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_producto_va_aiu | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_producto_va_aiu() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_producto_va_aiu ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
		IF NOT EXISTS ( SELECT 1 
			FROM mdp_products.TB_MDP_VA_FRANQUEO_PERFIL vaf 
			join mdp_products.TB_MDP_PRODUCTO_PERFIL_FRANQUEO ppf on vaf.cod_franqueo = ppf.cod_franqueo
			WHERE vaf.cod_va = NEW.cod_va AND ppf.cod_producto_comercial = NEW.cod_producto_comercial AND vaf.cod_franqueo IN (SELECT cod_franqueo
	                                          FROM mdp_products.TB_MDP_PRODUCTO_PERFIL_FRANQUEO
	                                          WHERE cod_producto_comercial = NEW.cod_producto_comercial)
	    ) THEN
	    	RAISE EXCEPTION 'Falta fila en TB_MDP_VA_FRANQUEO_PERFIL/TB_MDP_PRODUCTO_PERFIL_FRANQUEO';
	  	END IF;

	  	IF NOT EXISTS ( SELECT 1 
		FROM mdp_products.TB_MDP_VA_PERFIL vp
		JOIN mdp_products.TB_MDP_PRODUCTO_PERFIL pp on pp.cod_perfil = vp.cod_perfil
		WHERE vp.cod_va = NEW.cod_va AND pp.cod_producto_comercial = NEW.cod_producto_comercial AND vp.cod_perfil IN (SELECT cod_perfil
                                          FROM mdp_products.TB_MDP_PRODUCTO_PERFIL
                                          WHERE cod_producto_comercial = NEW.cod_producto_comercial)
	    ) THEN
	    	RAISE EXCEPTION 'Falta fila en TB_MDP_VA_PERFIL/TB_MDP_PRODUCTO_VA';
	  	END IF;
		RETURN NEW;
	END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_producto_va_aiu() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_producto_va_aiu() IS E'Comprobar que al actualizar una fila de tb_mdp_producto_va, el código de franqueo del valor añadido sigue estando en la lista de códigos de franqueo asignados a ese producto';
-- ddl-end --

-- object: tr_tb_mdp_producto_va_aiu | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_tb_mdp_producto_va_aiu ON mdp_producto.tb_mdp_producto_va CASCADE;
CREATE OR REPLACE TRIGGER tr_tb_mdp_producto_va_aiu
	AFTER INSERT OR UPDATE
	ON mdp_producto.tb_mdp_producto_va
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_producto_va_aiu();
-- ddl-end --
COMMENT ON TRIGGER tr_tb_mdp_producto_va_aiu ON mdp_producto.tb_mdp_producto_va IS E'Para poder asociar un valor añadido a un producto, los franqueos y sistemas de ambos deben coincidir';
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_va_franqueo_aud | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_va_franqueo_aud() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_va_franqueo_aud ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN

  -- si no ha cambiado nada, no hacemos nada
  IF old.cod_va = new.cod_va and old.cod_franqueo = new.cod_franqueo  THEN
    RETURN NEW;
  ELSIF NOT EXISTS ( 
                  SELECT 1 
                  FROM mdp_producto.TB_MDP_PRODUCTO_VA pva
                       join mdp_producto.TB_MDP_PRODUCTO_PERFIL_FRANQUEO pf on pf.cod_producto_comercial = pva.cod_producto_comercial
                       join mdp_producto.TB_MDP_VA_FRANQUEO_PERFIL vaf on vaf.cod_franqueo = pf.cod_franqueo and vaf.cod_va = pva.cod_va
                  WHERE old.cod_va = pva.cod_va
                    and old.cod_franqueo = pf.cod_franqueo
                    -- y no estamos usando la fila que hemos cambiado
                    and not ( vaf.cod_va = old.cod_va and vaf.cod_franqueo = old.cod_franqueo )
  ) THEN
    RAISE EXCEPTION 'Existe fila dependiente en TB_MDP_PRODUCTO_VA';
  END IF;
  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_va_franqueo_aud() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_va_franqueo_aud() IS E'Comprobar que al actualizar una fila de tb_mdp_va_franqueo, si hay un registro en tb_mdp_producto_va, el código de franqueo del valor añadido sigue estando en la lista de códigos de franqueo asignados a ese producto';
-- ddl-end --

-- object: tr_tb_mdp_va_franqueo_aud | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_tb_mdp_va_franqueo_aud ON mdp_producto.tb_mdp_va_franqueo_perfil CASCADE;
CREATE OR REPLACE TRIGGER tr_tb_mdp_va_franqueo_aud
	AFTER DELETE OR UPDATE
	ON mdp_producto.tb_mdp_va_franqueo_perfil
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_va_franqueo_aud();
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_producto_franqueo_aud | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_producto_franqueo_aud() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_producto_franqueo_aud ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN

  -- si no ha cambiado nada, no hacemos nada
  IF old.cod_producto_comercial = new.cod_producto_comercial and old.cod_franqueo = new.cod_franqueo then
    RETURN NEW;
  ELSIF NOT EXISTS ( 
                  SELECT 1 
                  FROM mdp_products.TB_MDP_PRODUCTO_VA pva
                   join mdp_products.TB_MDP_PRODUCTO_PERFIL_FRANQUEO ppf on ppf.cod_producto_comercial = pva.cod_producto_comercial
                   join mdp_products.TB_MDP_VA_FRANQUEO_PERFIL vaf on vaf.cod_franqueo = ppf.cod_franqueo and vaf.cod_va = pva.cod_va
                  WHERE old.cod_producto_comercial = pva.cod_producto_comercial
                    and old.cod_franqueo = ppf.cod_franqueo
                    -- y no estamos usando la fila que hemos cambiado
                    and not ( ppf.cod_producto_comercial = old.cod_producto_comercial and ppf.cod_franqueo = old.cod_franqueo )
  ) THEN
    RAISE EXCEPTION 'Existe fila dependiente en TB_MDP_PRODUCTO_VA';
  END IF;
  RETURN NEW;
END;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_producto_franqueo_aud() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_producto_franqueo_aud() IS E'Comprobar que al actualizar una fila de tb_mdp_producto_franqueo, si hay un registro en tb_mdp_producto_va, el código de franqueo del valor añadido sigue estando en la lista de códigos de franqueo asignados a ese producto';
-- ddl-end --

-- object: tr_tb_mdp_producto_franqueo_aud | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_tb_mdp_producto_franqueo_aud ON mdp_producto.tb_mdp_producto_perfil_franqueo CASCADE;
CREATE OR REPLACE TRIGGER tr_tb_mdp_producto_franqueo_aud
	AFTER DELETE OR UPDATE
	ON mdp_producto.tb_mdp_producto_perfil_franqueo
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_producto_franqueo_aud();
-- ddl-end --

-- object: mdp_producto.tb_mdp_promocion | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_promocion CASCADE;
CREATE TABLE mdp_producto.tb_mdp_promocion (
	cod_promocion numeric(10) NOT NULL,
	nom_promocion varchar(8) NOT NULL,
	desc_promocion varchar(255),
	ind_estado varchar(1) NOT NULL DEFAULT 'I',
	fec_inicio_promocion timestamp NOT NULL,
	fec_fin_promocion timestamp NOT NULL,
	cod_sistema varchar(3) NOT NULL,
	tipo_promocion varchar(2) NOT NULL,
	ind_promocion_envio boolean NOT NULL DEFAULT false,
	promocion_envio_aplicable varchar(1),
	importe_min numeric(10),
	importe_max numeric(10),
	ind_dto_modificable boolean NOT NULL DEFAULT false,
	ind_promocion_acumulable boolean NOT NULL DEFAULT false,
	min_productos numeric(10),
	max_productos numeric(10),
	tipo_descuento varchar(1) NOT NULL,
	importe_descuento numeric(7,2) NOT NULL,
	masc_ini_rango numeric(8),
	masc_fin_rango numeric(8),
	masc_num_usos numeric(8),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_promocion_pk PRIMARY KEY (cod_promocion),
	CONSTRAINT ck_estado CHECK (ind_estado IN ('I','A','P')),
	CONSTRAINT ck_fec_fin_promocion CHECK (fec_fin_promocion >= fec_inicio_promocion),
	CONSTRAINT ck_tipo_promocion CHECK (tipo_promocion IN ('MP','AU','CO')),
	CONSTRAINT ck_promocion_envio_aplicable CHECK (promocion_envio_aplicable IN ('P','V','C')),
	CONSTRAINT ck_precios CHECK ((importe_max >= importe_min) and (importe_min >= 0) and (importe_max >= 0)),
	CONSTRAINT ck_productos CHECK ((max_productos >= min_productos) AND (min_productos >= 0) AND (max_productos >= 0)),
	CONSTRAINT ck_tipo_descuento CHECK (tipo_descuento IN ('P','F','T')),
	CONSTRAINT ck_importe_descuento CHECK (importe_descuento >= 0),
	CONSTRAINT ck_masc_rango CHECK ((masc_fin_rango >= masc_ini_rango) AND (masc_ini_rango >= 0) AND (masc_fin_rango >= 0)),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_masc_num_usos CHECK ((masc_num_usos IS NOT NULL AND masc_num_usos >= 0) OR masc_num_usos IS NULL)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_promocion IS E'Tabla para las promociones en las tarifas de los productos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.cod_promocion IS E'Código de promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.nom_promocion IS E'Nombre de la promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.desc_promocion IS E'Descripción detallada de la promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.ind_estado IS E'Indicador del estado de la promoción:\nINICIAL (I) (valor por defecto al crearla)\nPDTE APROBACION  (P)\nAPROBADO (A)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.fec_inicio_promocion IS E'Fecha de inicio de la promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.fec_fin_promocion IS E'Fecha de fin de la promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.cod_sistema IS E'Código del sistema donde la promoción es aplicable';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.tipo_promocion IS E'El tipo de promoción puede tomar los siguientes valores:\nMP - MEDIO DE PAGO\nAU - AUTOMATICA\nCO - CODIGO PROMOCIONAL';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.ind_promocion_envio IS E'Indicador de promoción de valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.promocion_envio_aplicable IS E'Atributo sobre el que se aplica la promoción\nP -> PRECIO \nV -> VOLUMEN DE ENVIOS\nC -> CARACTERISTICAS';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.importe_min IS E'Rango mínimo en euros cuando la promocion es aplicable sobre volumen de envios (promocion x envios). \nAplicable si "promo_envio_aplicable" tiene un valor de ''P'' o ''V''';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.importe_max IS E'Rango máximo euros cuando la promocion es aplicable sobre volumen de envios (promocion x envios). \nAplicable si "promo_envio_aplicable" tiene un valor de ''P'' o ''V''';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.ind_dto_modificable IS E'Indica si el descuento se puede modificar en bolsa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.ind_promocion_acumulable IS E'Indica si es una promocion acumulable a distintos productos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.min_productos IS E'Cantidad mí­nima de productos necesarios para la PROMO';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.max_productos IS E'Cantidad máxima de productos necesarios para la PROMO';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.tipo_descuento IS E'Tipo de descuento a aplicar en la promoción\nP - % PORCENTAJE\nF - IMPORTE FIJO\nT - TARIFA PLANA';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.importe_descuento IS E'Importe del descuento que aplica la promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.masc_ini_rango IS E'Inicio del rango de la mascara promocional';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.masc_fin_rango IS E'Fin del rango de la máscara promocional';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.masc_num_usos IS E'Número de usos de la promoción. Si está vacío indica que el número es ilimitado';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_estado ON mdp_producto.tb_mdp_promocion IS E'Los únicos valores posibles para el indicador de estado son: \nINICIAL (I)\nPDTE APROBACION  (P)\nAPROBADO (A)';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_fin_promocion ON mdp_producto.tb_mdp_promocion IS E'La fecha de inicio de la promoción no puede ser mayor que la fecha de fin de la promoción';
-- ddl-end --
COMMENT ON CONSTRAINT ck_tipo_promocion ON mdp_producto.tb_mdp_promocion IS E'Los valores permitidos para el tipo de promoción son solamente tres:\nMP - MEDIO DE PAGO\nAU - AUTOMATICA\nCO - CODIGO PROMOCIONAL';
-- ddl-end --
COMMENT ON CONSTRAINT ck_promocion_envio_aplicable ON mdp_producto.tb_mdp_promocion IS E'Valores posibles admitidos son:\nP -> PRECIO \nV -> VOLUMEN DE ENVIOS\nC -> CARACTERISTICAS';
-- ddl-end --
COMMENT ON CONSTRAINT ck_precios ON mdp_producto.tb_mdp_promocion IS E'El rango mínimo de precios ha de ser menor que el rango mayor y no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_productos ON mdp_producto.tb_mdp_promocion IS E'El mínimo de productos ha de ser menor o igual que el máximo de productos de la promoción y no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_tipo_descuento ON mdp_producto.tb_mdp_promocion IS E'La lista de valores permitidos es:\nP - % PORCENTAJE\nF - IMPORTE FIJO\nT - TARIFA PLANA';
-- ddl-end --
COMMENT ON CONSTRAINT ck_importe_descuento ON mdp_producto.tb_mdp_promocion IS E'El importe del descuento de la promoción no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_masc_rango ON mdp_producto.tb_mdp_promocion IS E'El rango final de la máscara promocional deber ser mayor al rango inicial y no pueden ser negativos';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_promocion IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
COMMENT ON CONSTRAINT ck_masc_num_usos ON mdp_producto.tb_mdp_promocion IS E'Si el número de usos de la promoción está informado, no puede ser negativo';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_promocion OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_promocion_codigo | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_promocion_codigo CASCADE;
CREATE TABLE mdp_producto.tb_mdp_promocion_codigo (
	cod_promocional varchar(20) NOT NULL,
	cod_promocion numeric(10) NOT NULL,
	num_usos numeric(8),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_promocion_codigo_pk PRIMARY KEY (cod_promocional),
	CONSTRAINT ck_num_usos CHECK (num_usos >= 0),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_promocion_codigo IS E'Tabla de códigos promocionales';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_codigo.cod_promocional IS E'Valor del código generado para validar las promociones.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_codigo.cod_promocion IS E'Código de promoción al que se aplica el código';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_codigo.num_usos IS E'Número de usos que tiene el código promocional. Si está vacío significa que es ilimitado';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_codigo.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_codigo.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_num_usos ON mdp_producto.tb_mdp_promocion_codigo IS E'No puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_promocion_codigo IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_promocion_codigo OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_promocion_cliente | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_promocion_cliente CASCADE;
CREATE TABLE mdp_producto.tb_mdp_promocion_cliente (
	cod_promocion numeric(10) NOT NULL,
	cod_cliente numeric(10) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_promocion_cliente_pk PRIMARY KEY (cod_promocion,cod_cliente),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_promocion_cliente IS E'Tabla que relaciona las promociones con los clientes vip';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_cliente.cod_promocion IS E'Código de promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_cliente.cod_cliente IS E'Código del cliente VIP';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_cliente.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_cliente.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_promocion_cliente IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_promocion_cliente OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_promocion_oficina | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_promocion_oficina CASCADE;
CREATE TABLE mdp_producto.tb_mdp_promocion_oficina (
	cod_promo_oficina numeric(10) NOT NULL,
	cod_promocion numeric(10) NOT NULL,
	cod_zona numeric(2) NOT NULL,
	cod_sector numeric(4) NOT NULL,
	codired varchar(10) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_promocion_oficina_pk PRIMARY KEY (cod_promo_oficina),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion  >= fec_creacion),
	CONSTRAINT ck_datos_oficina CHECK (cod_zona >= 0 and cod_sector >= 0)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_promocion_oficina IS E'Tabla que relaciona las promociones con las oficinas donde se pueden aplicar';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_oficina.cod_promo_oficina IS E'Código de la relación entre oficina y promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_oficina.cod_promocion IS E'Código de la promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_oficina.cod_zona IS E'Código de la zona';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_oficina.cod_sector IS E'Código del sector';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_oficina.codired IS E'Código de una unidad de Correos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_oficina.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_oficina.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_promocion_oficina IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
COMMENT ON CONSTRAINT ck_datos_oficina ON mdp_producto.tb_mdp_promocion_oficina IS E'Los valores de zona y sector no pueden ser negativos';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_promocion_oficina OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_promocion_producto | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_promocion_producto CASCADE;
CREATE TABLE mdp_producto.tb_mdp_promocion_producto (
	cod_producto varchar(10) NOT NULL,
	cod_promocion numeric(10) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_promocion_pk PRIMARY KEY (cod_producto,cod_promocion),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_promocion_producto IS E'Relación de promociones aplicables al producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_producto.cod_producto IS E'Código del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_producto.cod_promocion IS E'Código de la promoción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_producto.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_promocion_producto.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_promocion_producto IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_promocion_producto OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_zona_tarifaria | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_zona_tarifaria CASCADE;
CREATE TABLE mdp_producto.tb_mdp_zona_tarifaria (
	cod_zona_tarif varchar(10) NOT NULL,
	nom_zona_tarif varchar(60) NOT NULL,
	desc_zona_tarif varchar(600),
	cod_sap_destino varchar(4),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_zona_tarifaria_pk PRIMARY KEY (cod_zona_tarif),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_zona_tarifaria IS E'Tabla de zonas tarifarias que contienen las tarifas agrupadas por ámbitos de destino';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarifaria.cod_zona_tarif IS E'Código de zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarifaria.nom_zona_tarif IS E'Nombre de la zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarifaria.desc_zona_tarif IS E'Descripción detallada de la zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarifaria.cod_sap_destino IS E'Código sap del ámbito destino';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarifaria.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarifaria.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_zona_tarifaria IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_zona_tarifaria OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_zona | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_zona CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_zona (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	fec_alta timestamp NOT NULL,
	cod_ambito numeric(5) NOT NULL,
	cod_zona_tarif varchar(10) NOT NULL,
	cod_tasa_impositiva numeric(3) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_zona_pk PRIMARY KEY (cod_producto_comercial,cod_zona_tarif,cod_tasa_impositiva,cod_ambito,cod_modalidad,fec_alta),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_zona IS E'Relación de zonas tarifarias (y por tanto, sus tarifas) asociadas a un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_zona.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_zona.cod_modalidad IS E'Código de modalidad de entrega/admisión';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_zona.fec_alta IS E'Fecha de alta de la asociación de zonas tarifarias e impuesto para el producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_zona.cod_ambito IS E'Código del ámbito origen';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_zona.cod_zona_tarif IS E'Código de la zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_zona.cod_tasa_impositiva IS E'Código de la tasa impositiva que se usará para calcular el impuesto para un producto y una zona tarifaria determinados';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_zona.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_zona.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_zona IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_zona OWNER TO postgres;
-- ddl-end --

-- object: idx_producto_zona_zona | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_zona_zona CASCADE;
CREATE INDEX idx_producto_zona_zona ON mdp_producto.tb_mdp_producto_zona
USING btree
(
	cod_zona_tarif
)
INCLUDE (cod_zona_tarif)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.tb_mdp_zona_tarif_provincia | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_zona_tarif_provincia CASCADE;
CREATE TABLE mdp_producto.tb_mdp_zona_tarif_provincia (
	cod_zona_tarif varchar(10) NOT NULL,
	cod_provincia_origen varchar(2) NOT NULL,
	cod_provincia_destino varchar(2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_zona_tarif_provincia_pk PRIMARY KEY (cod_zona_tarif,cod_provincia_origen,cod_provincia_destino),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_zona_tarif_provincia IS E'Relación de provincias asociadas a una zona tarifaria, aplicable cuando el origen y destino son nacionales';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_provincia.cod_zona_tarif IS E'Código de zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_provincia.cod_provincia_origen IS E'Código de provincia origen';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_provincia.cod_provincia_destino IS E'Código de provincia destino';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_provincia.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_provincia.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_zona_tarif_provincia IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_zona_tarif_provincia OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_zona_tarif_pais | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_zona_tarif_pais CASCADE;
CREATE TABLE mdp_producto.tb_mdp_zona_tarif_pais (
	cod_zona_tarif varchar(10) NOT NULL,
	cod_pais varchar(3) NOT NULL,
	ind_bloqueado boolean NOT NULL,
	ind_pais_origen boolean NOT NULL DEFAULT FALSE,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_zona_tarif_pais_pk PRIMARY KEY (cod_zona_tarif,cod_pais),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_zona_tarif_pais IS E'Relación de países que pertenecen a una zona tarifaria determinada';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_pais.cod_zona_tarif IS E'Código de zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_pais.cod_pais IS E'Código de país';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_pais.ind_bloqueado IS E'Indica si el país está bloqueado para envíos en esta zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_pais.ind_pais_origen IS E'Este campo está pensado para envíos que se han generado en España, la empresa le da a su cliente un nº de días para hacer la devolución y si lo hace, se genera un envío de devolución.\nSolamente una lista reducida de países permite esta situación. Nunca se va a dar una devolución de un país que no tenga este check marcado.\nNo hay que confundir esta devolución "voluntaria" con una devolución motivada por una dirección incorrecta o un remitente ausente, etc. En esos casos no es una devolución y no aplica este indicador.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_pais.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_pais.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_zona_tarif_pais IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_zona_tarif_pais OWNER TO postgres;
-- ddl-end --

-- object: idx_zona_tarif_provincia_provincia_origen | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_zona_tarif_provincia_provincia_origen CASCADE;
CREATE INDEX idx_zona_tarif_provincia_provincia_origen ON mdp_producto.tb_mdp_zona_tarif_provincia
USING btree
(
	cod_provincia_origen
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_zona_tarif_provincia_provincia_destino | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_zona_tarif_provincia_provincia_destino CASCADE;
CREATE INDEX idx_zona_tarif_provincia_provincia_destino ON mdp_producto.tb_mdp_zona_tarif_provincia
USING btree
(
	cod_provincia_destino
);
-- ddl-end --

-- object: idx_promocion_producto_promocion | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_promocion_producto_promocion CASCADE;
CREATE INDEX idx_promocion_producto_promocion ON mdp_producto.tb_mdp_promocion_producto
USING btree
(
	cod_promocion
);
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_zona_tarif_pais_aiu | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_zona_tarif_pais_aiu() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_zona_tarif_pais_aiu ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN

  IF EXISTS ( SELECT 1
              FROM mdp_producto.TB_MDP_PRODUCTO_ZONA PZ
              WHERE PZ.COD_ZONA_TARIF= NEW.COD_ZONA_TARIF 
                AND NOT EXISTS ( SELECT 1
                                 FROM mdp_producto.TB_MDP_PRODUCTO_ATRIBUTO_PAIS
                                 WHERE COD_PRODUCTO_COMERCIAL = PZ.COD_PRODUCTO_COMERCIAL
                                   AND COD_PAIS = NEW.COD_PAIS
                               )
            ) THEN
    RAISE EXCEPTION 'Falta fila en TB_MDP_PRODUCTO_ATRIBUTO_PAIS';
  END IF;
  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_zona_tarif_pais_aiu() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_zona_tarif_pais_aiu() IS E'Comprobar que al actualizar una fila de tb_mdp_zona_tarif_pais los productos de esa zona tarifaria contienen datos para ese país en la tabla tb_mdp_producto_atributo_pais.\nDe esta forma no se permite que un producto esté asignado a una zona tarifaria sin tener datos de peso o medidas para todos los países de esa zona tarifaria.';
-- ddl-end --

-- object: tr_aiu_tb_mdp_zona_tarif_pais | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_aiu_tb_mdp_zona_tarif_pais ON mdp_producto.tb_mdp_zona_tarif_pais CASCADE;
CREATE OR REPLACE TRIGGER tr_aiu_tb_mdp_zona_tarif_pais
	AFTER INSERT OR UPDATE
	ON mdp_producto.tb_mdp_zona_tarif_pais
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_zona_tarif_pais_aiu();
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_producto_zona_aiu | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_producto_zona_aiu() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_producto_zona_aiu ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
  IF EXISTS ( SELECT 1
              FROM mdp_producto.TB_MDP_ZONA_TARIF_PAIS ZP
              WHERE ZP.COD_ZONA_TARIF = NEW.COD_ZONA_TARIF
                AND NOT EXISTS ( SELECT 1
                                 FROM mdp_producto.TB_MDP_PRODUCTO_ATRIBUTO_PAIS
                                 WHERE COD_PRODUCTO_COMERCIAL = NEW.COD_PRODUCTO_COMERCIAL
                                   AND COD_PAIS = ZP.COD_PAIS
                               )
            ) THEN
    RAISE EXCEPTION 'Falta fila en TB_MDP_PRODUCTO_ATRIBUTO_PAIS';
  END IF;
  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_producto_zona_aiu() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_producto_zona_aiu() IS E'Comprueba que al asociar un producto a una zona tarifaria, los países incluidos en ésta, tienen su correspondiente registro en la tabla tb_mdp_producto_atributo_pais.';
-- ddl-end --

-- object: tr_aiu_tb_mdp_producto_zona | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_aiu_tb_mdp_producto_zona ON mdp_producto.tb_mdp_producto_zona CASCADE;
CREATE OR REPLACE TRIGGER tr_aiu_tb_mdp_producto_zona
	AFTER INSERT OR UPDATE
	ON mdp_producto.tb_mdp_producto_zona
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_producto_zona_aiu();
-- ddl-end --

-- object: mdp_producto.tb_mdp_complemento | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_complemento CASCADE;
CREATE TABLE mdp_producto.tb_mdp_complemento (
	cod_complemento numeric(10) NOT NULL,
	desc_complemento varchar(255),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tarifa_complemento_pk PRIMARY KEY (cod_complemento),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_complemento IS E'Tabla de complementos al importe del tramo que se añaden en casos como exceso de peso del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_complemento.cod_complemento IS E'Código de complemento';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_complemento.desc_complemento IS E'Descripción del complemento a aplicar a la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_complemento.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_complemento.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_complemento IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_complemento OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_va_perfil | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_va_perfil CASCADE;
CREATE TABLE mdp_producto.tb_mdp_va_perfil (
	cod_va varchar(7) NOT NULL,
	cod_perfil numeric(2) NOT NULL,
	fec_alta timestamp NOT NULL,
	fec_baja timestamp,
	cod_sap varchar(18),
	importe_base numeric(7,2) NOT NULL,
	importe_min numeric(7,2) NOT NULL,
	por_incremento numeric(7,2) NOT NULL,
	valor_complejidad numeric(1),
	desc_precio_va varchar(255),
	cod_formula numeric(1) NOT NULL,
	desc_formula varchar(100) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_va_perfil_pk PRIMARY KEY (cod_va,cod_perfil,fec_alta),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_valor_complejidad CHECK (valor_complejidad IN (1,2,3)),
	CONSTRAINT ck_importe_base CHECK (importe_base >= 0),
	CONSTRAINT ck_importe_min CHECK (importe_min >= 0),
	CONSTRAINT ck_por_incremento CHECK (por_incremento >= 0),
	CONSTRAINT ck_fecbaja CHECK (fec_baja is null or fec_baja > fec_alta),
	CONSTRAINT ck_formula CHECK (cod_formula between 1 and 6)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_va_perfil IS E'Relación entre los valores añadidos y las tarifas que se le pueden aplicar por perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.cod_va IS E'Código del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.cod_perfil IS E'Código del perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.fec_alta IS E'Fecha de alta de la tarifa del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.fec_baja IS E'Fecha de baja de la tarifa del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.cod_sap IS E'Código sap del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.importe_base IS E'Precio base de la tarifa del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.importe_min IS E'Importe mínimo que aplica a la tarifa del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.por_incremento IS E'Porcentaje de incremento sobre el precio base de la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.valor_complejidad IS E'Para el valor añadido "Gestión de la entrega" se guarda en este campo el nivel de complejidad.\n\nLos valores admitidos son 1, 2 o 3';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.desc_precio_va IS E'Descripción de la tarifa del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.cod_formula IS E'Código del tipo de cálculo a aplicar para el valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.desc_formula IS E'Descripción detallada de la fórmula a aplicar para el cálculo de importe del valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_perfil.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_va_perfil IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
COMMENT ON CONSTRAINT ck_valor_complejidad ON mdp_producto.tb_mdp_va_perfil IS E'El nivel de complejidad para el valor añadido "Gestión en la entrega" solo puede tomar un valor de 1-3';
-- ddl-end --
COMMENT ON CONSTRAINT ck_importe_base ON mdp_producto.tb_mdp_va_perfil IS E'El importe base de la tarifa del valor añadido no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_importe_min ON mdp_producto.tb_mdp_va_perfil IS E'El importe mínimo de la tarifa no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_por_incremento ON mdp_producto.tb_mdp_va_perfil IS E'El valor del porcentaje que se incremanta la tarifa del valor añadido no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fecbaja ON mdp_producto.tb_mdp_va_perfil IS E'La fecha de baja tiene que ser nula o mayor que la fecha de alta';
-- ddl-end --
COMMENT ON CONSTRAINT ck_formula ON mdp_producto.tb_mdp_va_perfil IS E'Actualmente existen 6 posibles fórmulas de cálculo para el importe de un valor añadido y este constraint evita que se pueda elegir nada fuera de ese rango';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_va_perfil OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tipo_impuesto | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tipo_impuesto CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tipo_impuesto (
	cod_tipo_impuesto varchar(4) NOT NULL,
	nom_tipo_impuesto varchar(25) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tipo_impuesto_pk PRIMARY KEY (cod_tipo_impuesto),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_impuesto.cod_tipo_impuesto IS E'Código de tipo de impuesto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_impuesto.nom_tipo_impuesto IS E'Nombre de tipo de impuesto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_impuesto.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_impuesto.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tipo_impuesto IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tipo_impuesto OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tipo_gravamen | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tipo_gravamen CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tipo_gravamen (
	cod_tipo_gravamen varchar(4) NOT NULL,
	nom_tipo_gravamen varchar(25) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tipo_gravamen_pk PRIMARY KEY (cod_tipo_gravamen),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_gravamen.cod_tipo_gravamen IS E'Código de tipo de gravamen';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_gravamen.nom_tipo_gravamen IS E'Nombre de tipo de gravamen';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_gravamen.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tipo_gravamen.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tipo_gravamen IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tipo_gravamen OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_impuesto_gravamen | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_impuesto_gravamen CASCADE;
CREATE TABLE mdp_producto.tb_mdp_impuesto_gravamen (
	cod_tasa_impositiva numeric(3) NOT NULL,
	cod_tipo_impuesto varchar(4) NOT NULL,
	cod_tipo_gravamen varchar(4) NOT NULL,
	por_gravamen numeric(5,2) NOT NULL,
	cod_sap varchar(8),
	fec_inicio timestamp NOT NULL,
	fec_fin timestamp,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_impuesto_gravamen_pk PRIMARY KEY (cod_tasa_impositiva),
	CONSTRAINT ck_fec_fin CHECK ((fec_fin IS NULL) OR 
(fec_fin IS NOT NULL AND fec_fin >= fec_inicio)),
	CONSTRAINT ck_por_gravamen CHECK (por_gravamen BETWEEN 0 AND 100),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_impuesto_gravamen IS E'Relación de gravámenes para cada tipo de impuesto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_impuesto_gravamen.cod_tasa_impositiva IS E'Código de la tasa impositiva';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_impuesto_gravamen.cod_tipo_impuesto IS E'Código del tipo de impuesto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_impuesto_gravamen.cod_tipo_gravamen IS E'Código del tipo de gravamen';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_impuesto_gravamen.por_gravamen IS E'Porcentaje a aplicar al total de conceptos de la tarifa para calcular el importe del impuesto correspondiente';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_impuesto_gravamen.cod_sap IS E'Código SAP';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_impuesto_gravamen.fec_inicio IS E'Fecha de inicio de validez del gravamen asociado al impuesto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_impuesto_gravamen.fec_fin IS E'Fecha de fin de validez del gravamen asociado al impuesto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_impuesto_gravamen.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_impuesto_gravamen.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_fin ON mdp_producto.tb_mdp_impuesto_gravamen IS E'La fecha de fin de validez del gravamen asociado al impuesto no puede ser mayor que la fecha de inicio';
-- ddl-end --
COMMENT ON CONSTRAINT ck_por_gravamen ON mdp_producto.tb_mdp_impuesto_gravamen IS E'El porcentaje de gravamen no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_impuesto_gravamen IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_impuesto_gravamen OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_ambito_detalle | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_ambito_detalle CASCADE;
CREATE TABLE mdp_producto.tb_mdp_ambito_detalle (
	cod_ambito_detalle numeric(5) NOT NULL,
	cod_ambito numeric(5) NOT NULL,
	cod_provincia varchar(2),
	cod_pais varchar(3),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_ambito_detalle_pk PRIMARY KEY (cod_ambito_detalle),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_detalle.cod_ambito IS E'Código del ámbito';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_detalle.cod_provincia IS E'Código de la provincia';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_detalle.cod_pais IS E'Código de país';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_detalle.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_ambito_detalle.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_ambito_detalle IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_ambito_detalle OWNER TO postgres;
-- ddl-end --

-- object: idx_ambito_detalle_ambito | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_ambito_detalle_ambito CASCADE;
CREATE INDEX idx_ambito_detalle_ambito ON mdp_producto.tb_mdp_ambito_detalle
USING btree
(
	cod_ambito
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_ambito_detalle_provincia | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_ambito_detalle_provincia CASCADE;
CREATE INDEX idx_ambito_detalle_provincia ON mdp_producto.tb_mdp_ambito_detalle
USING btree
(
	cod_provincia
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.tb_mdp_sobrecoste | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_sobrecoste CASCADE;
CREATE TABLE mdp_producto.tb_mdp_sobrecoste (
	cod_sobrecoste numeric(2) NOT NULL,
	desc_sobrecoste varchar(255),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_sobrecoste_pk PRIMARY KEY (cod_sobrecoste),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_sobrecoste IS E'Tabla con los porcentajes de sobrecoste que hay que aplicar si el producto supera medidas o peso máximos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sobrecoste.cod_sobrecoste IS E'Código del sobrecoste';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sobrecoste.desc_sobrecoste IS E'Descripción del sobrecoste';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sobrecoste.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_sobrecoste.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_sobrecoste IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_sobrecoste OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_sobrecoste | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_sobrecoste CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_sobrecoste (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	fec_alta timestamp NOT NULL,
	cod_sobrecoste numeric(2) NOT NULL,
	importe_fijo numeric(7,2) NOT NULL,
	por_sobrecoste numeric(5,2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_sobrecoste_pk PRIMARY KEY (cod_producto_comercial,cod_modalidad,fec_alta,cod_sobrecoste),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_importe CHECK (importe_fijo >= 0),
	CONSTRAINT ck_por_sobrecoste CHECK (por_sobrecoste BETWEEN 0 AND 100)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_sobrecoste IS E'Tabla que relaciona los productos con los importes de sobrecoste que se pueden aplicar\n\nLos sobrecostes asociados a un producto pueden ser diferentes a los sobrecostes asociados a sus tamaños amigables, si los tuviera.\nNo son dependientes ni excluyentes entre sí.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sobrecoste.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sobrecoste.cod_modalidad IS E'Código de modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sobrecoste.fec_alta IS E'Fecha de alta del sobrecoste para el producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sobrecoste.cod_sobrecoste IS E'Código del sobrecoste';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sobrecoste.importe_fijo IS E'Importe fijo a aplicar si el porcentaje de sobrecoste no llega a superar este valor';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sobrecoste.por_sobrecoste IS E'Porcentaje de sobrecoste a incrementar la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sobrecoste.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sobrecoste.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_sobrecoste IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
COMMENT ON CONSTRAINT ck_importe ON mdp_producto.tb_mdp_producto_sobrecoste IS E'El importe mínimo a cobrar no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_por_sobrecoste ON mdp_producto.tb_mdp_producto_sobrecoste IS E'El porcentaje de sobrecoste no puede ser negativo';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_sobrecoste OWNER TO postgres;
-- ddl-end --

-- object: idx_producto_sobrecoste_sobrecoste | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_sobrecoste_sobrecoste CASCADE;
CREATE INDEX idx_producto_sobrecoste_sobrecoste ON mdp_producto.tb_mdp_producto_sobrecoste
USING btree
(
	cod_sobrecoste
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_promocion_oficina_promocion | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_promocion_oficina_promocion CASCADE;
CREATE INDEX idx_promocion_oficina_promocion ON mdp_producto.tb_mdp_promocion_oficina
USING btree
(
	cod_promocion
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_promocion_codigo_promocion | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_promocion_codigo_promocion CASCADE;
CREATE INDEX idx_promocion_codigo_promocion ON mdp_producto.tb_mdp_promocion_codigo
USING btree
(
	cod_promocion
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_impuesto_gravamen_gravamen | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_impuesto_gravamen_gravamen CASCADE;
CREATE INDEX idx_impuesto_gravamen_gravamen ON mdp_producto.tb_mdp_impuesto_gravamen
USING btree
(
	cod_tipo_gravamen
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_producto_zona_ambito_aiu | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_producto_zona_ambito_aiu() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_producto_zona_ambito_aiu ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
  IF NOT EXISTS ( SELECT 1
                                 FROM mdp_producto.TB_MDP_AMBITO_PERFIL_MODALIDAD
                                 WHERE COD_PRODUCTO_COMERCIAL  = NEW.COD_PRODUCTO_COMERCIAL
									AND COD_MODALIDAD = NEW.COD_MODALIDAD 
									AND FEC_ALTA = NEW.FEC_ALTA 
									AND COD_AMBITO = NEW.COD_AMBITO
            ) THEN
    RAISE EXCEPTION 'Falta fila en TB_MDP_AMBITO_PERFIL_MODALIDAD';
  END IF;
  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_producto_zona_ambito_aiu() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_producto_zona_ambito_aiu() IS E'Comprueba que al asociar un producto a una zona tarifaria, el ámbito elegido es uno de los ámbitos asociados al producto en la tabla tb_mdp_producto_ambito.';
-- ddl-end --

-- object: tr_aiu_tb_mdp_producto_zona_ambito | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_aiu_tb_mdp_producto_zona_ambito ON mdp_producto.tb_mdp_producto_zona CASCADE;
CREATE OR REPLACE TRIGGER tr_aiu_tb_mdp_producto_zona_ambito
	AFTER INSERT OR UPDATE
	ON mdp_producto.tb_mdp_producto_zona
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_producto_zona_ambito_aiu();
-- ddl-end --

-- object: idx_producto_zona_impuesto | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_zona_impuesto CASCADE;
CREATE INDEX idx_producto_zona_impuesto ON mdp_producto.tb_mdp_producto_zona
USING btree
(
	cod_tasa_impositiva
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_zona_ambito | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_zona_ambito CASCADE;
CREATE INDEX idx_producto_zona_ambito ON mdp_producto.tb_mdp_producto_zona
USING btree
(
	cod_ambito
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_ambito_detalle_pais | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_ambito_detalle_pais CASCADE;
CREATE INDEX idx_ambito_detalle_pais ON mdp_producto.tb_mdp_ambito_detalle
USING btree
(
	cod_pais
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.tb_mdp_va_impuesto_gravamen | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_va_impuesto_gravamen CASCADE;
CREATE TABLE mdp_producto.tb_mdp_va_impuesto_gravamen (
	cod_va varchar(7) NOT NULL,
	cod_tasa_impositiva numeric(3) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_va_impuesto_gravamen_pk PRIMARY KEY (cod_va,cod_tasa_impositiva),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_va_impuesto_gravamen IS E'Tabla con el tipo de gravamen que se aplica a un VA';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_impuesto_gravamen.cod_va IS E'Código de valor añadido';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_impuesto_gravamen.cod_tasa_impositiva IS E'Código de tasa impositiva';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_impuesto_gravamen.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_va_impuesto_gravamen.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_va_impuesto_gravamen IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_va_impuesto_gravamen OWNER TO postgres;
-- ddl-end --

-- object: idx_tasa_impositiva | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_tasa_impositiva CASCADE;
CREATE INDEX idx_tasa_impositiva ON mdp_producto.tb_mdp_va_impuesto_gravamen
USING btree
(
	cod_tasa_impositiva
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.tb_mdp_zona_tarif_postal | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_zona_tarif_postal CASCADE;
CREATE TABLE mdp_producto.tb_mdp_zona_tarif_postal (
	cod_zona_tarif varchar(10) NOT NULL,
	cod_postal_origen varchar(10) NOT NULL,
	cod_postal_destino varchar(10) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_zona_tarif_postal_pk PRIMARY KEY (cod_zona_tarif,cod_postal_origen,cod_postal_destino),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_zona_tarif_postal IS E'Tabla de códigos postales que componen una zona tarifaria para envíos que no son de paquetería';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_postal.cod_zona_tarif IS E'Código de zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_postal.cod_postal_origen IS E'Código postal de origen';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_postal.cod_postal_destino IS E'Código postal de destino';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_postal.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tarif_postal.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_zona_tarif_postal IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_zona_tarif_postal OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_zona_tramo | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_zona_tramo CASCADE;
CREATE TABLE mdp_producto.tb_mdp_zona_tramo (
	cod_zona_tarif varchar(10) NOT NULL,
	cod_tramo numeric(10) NOT NULL,
	fec_alta timestamp NOT NULL,
	fec_baja timestamp,
	importe_tramo numeric(5,2) NOT NULL,
	importe_complemento numeric(7,2) NOT NULL,
	por_complemento numeric(5,2) NOT NULL,
	cod_complemento numeric(10) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_zona_tramo_pk PRIMARY KEY (cod_zona_tarif,cod_tramo,fec_alta),
	CONSTRAINT ck_importe CHECK (importe_tramo >= 0),
	CONSTRAINT ck_importe_complemento CHECK ((importe_complemento > 0 AND por_complemento = 0) OR (por_complemento > 0 AND importe_complemento = 0) OR (importe_complemento = 0 AND por_complemento = 0)),
	CONSTRAINT ck_por_complemento CHECK ((por_complemento >0 AND importe_base = 0) OR (por_complemento = 0 AND importe_base > 0)),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_fec_baja CHECK ((fec_baja is null) or (fec_baja >= fec_alta))
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_zona_tramo IS E'Tabla que relaciona un sistema con las tarifas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tramo.cod_zona_tarif IS E'Código de zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tramo.cod_tramo IS E'Código de tramo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tramo.fec_baja IS E'Fecha de baja de la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tramo.importe_tramo IS E'Importe de la tarifa para el tramo de peso seleccionado';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tramo.importe_complemento IS E'Importe del complemento que se añadirá a la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tramo.por_complemento IS E'Porcentaje de incremento que se aplicará a la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tramo.cod_complemento IS E'Código de complemento';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tramo.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_zona_tramo.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_importe ON mdp_producto.tb_mdp_zona_tramo IS E'El importe de la tarifa no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_importe_complemento ON mdp_producto.tb_mdp_zona_tramo IS E'El importe del complemento no puede ser negativo. Si el atributo de porcentaje de complemento está informado, el precio base no puede ser mayor que 0 y viceversa';
-- ddl-end --
COMMENT ON CONSTRAINT ck_por_complemento ON mdp_producto.tb_mdp_zona_tramo IS E'El porcentaje de incremento del complemento no puede ser negativo. Si el atributo de porcentaje de complemento está informado, el precio base no puede ser mayor que 0 y viceversa';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_zona_tramo IS E'La fecha de actualización no puede ser menor que la fecha de creación';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_baja ON mdp_producto.tb_mdp_zona_tramo IS E'Si la fecha de baja de la tarifa está informada, no puede ser menor a la de alta.';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_zona_tramo OWNER TO postgres;
-- ddl-end --

-- object: idx_zonatramo_tramo | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_zonatramo_tramo CASCADE;
CREATE INDEX idx_zonatramo_tramo ON mdp_producto.tb_mdp_zona_tramo
USING btree
(
	cod_tramo,
	fec_alta
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_zona_tramo_aud | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_zona_tramo_aud() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_zona_tramo_aud ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
  IF EXISTS ( SELECT 1
              FROM mdp_products.TB_MDP_PRODUCTO_ATRIBUTO_PAIS PAP
	             JOIN mdp_products.TB_MDP_PRODUCTO_ZONA PZ ON PZ.COD_PRODUCTO_COMERCIAL = PAP.COD_PRODUCTO_COMERCIAL
              WHERE PZ.COD_ZONA_TARIF = OLD.COD_ZONA_TARIF
                AND NOT EXISTS ( SELECT MIN(T.LIMITE_MIN), MAX(T.LIMITE_MAX)
                                 FROM mdp_products.TB_MDP_ZONA_TRAMO ZT 
                                 JOIN mdp_products.TB_MDP_TRAMO T ON T.COD_TRAMO = ZT.COD_TRAMO
                                 WHERE PZ.COD_ZONA_TARIF = ZT.COD_ZONA_TARIF
                                 HAVING MIN(T.LIMITE_MIN) <= PAP.PESO_MIN
                                    AND MAX(T.LIMITE_MAX) >= PAP.PESO_MAX
                               )
            ) THEN
    RAISE EXCEPTION 'Limites de peso en tb_mdp_producto_atributo_pais fuera de rango segun tb_mdp_tramo';
  END IF;

  RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_zona_tramo_aud() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_zona_tramo_aud() IS E'Controlar que al actualizar o borrar una fila en tb_mdp_zona_tramo en los registros con el mismo producto de tb_mdp_producto_atributo_pais el intervalo (PESO_MIN, PESO_MAX) sigue cubierto por los tramos de peso asociados al producto';
-- ddl-end --

-- object: tr_tb_mdp_zona_tramo_aud | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_tb_mdp_zona_tramo_aud ON mdp_producto.tb_mdp_zona_tramo CASCADE;
CREATE OR REPLACE TRIGGER tr_tb_mdp_zona_tramo_aud
	AFTER DELETE OR UPDATE
	ON mdp_producto.tb_mdp_zona_tramo
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_zona_tramo_aud();
-- ddl-end --

-- object: mdp_producto.tb_mdp_prefijo | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_prefijo CASCADE;
CREATE TABLE mdp_producto.tb_mdp_prefijo (
	cod_prod_prefijo varchar(2) NOT NULL,
	desc_prefijo varchar(120),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_prefijo_pk PRIMARY KEY (cod_prod_prefijo),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_prefijo IS E'Tabla con los códigos de prefijo que puede tener un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_prefijo.cod_prod_prefijo IS E'código de prefijo del producto para el código de barras';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_prefijo.desc_prefijo IS E'Descripción del prefijo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_prefijo.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_prefijo.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_prefijo IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_prefijo OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_sistema_prefijo | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_sistema_prefijo CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_sistema_prefijo (
	cod_prod_prefijo varchar(2) NOT NULL,
	cod_producto varchar(10) NOT NULL,
	cod_sistema varchar(3) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	ind_valor_declarado boolean NOT NULL,
	ind_entrega_recogida boolean NOT NULL DEFAULT false,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_sistema_prefijo_pk PRIMARY KEY (cod_producto,cod_prod_prefijo,cod_sistema,cod_modalidad),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_sistema_prefijo IS E'Relación de prefijos que puede tener el producto, por sistema y modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sistema_prefijo.cod_prod_prefijo IS E'código de prefijo del producto para el código de barras';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sistema_prefijo.cod_producto IS E'Código de producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sistema_prefijo.cod_sistema IS E'Código de sistema';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sistema_prefijo.cod_modalidad IS E'Código de modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sistema_prefijo.ind_valor_declarado IS E'Indica si el prefijo se utiliza para el valor añadido "Valor declarado", ya que es el único caso en que el prefijo cambia en función del valor añadido.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sistema_prefijo.ind_entrega_recogida IS E'Cuando se contrata el valor añadido "Entrega con recogida", de todos los prefijos asociados al producto, se debe utilizar el prefijo "LI". Este campo sirve para indicar esta situación a una aplicación que deba seleccionar el prefijo a usar por el producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sistema_prefijo.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_sistema_prefijo.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_sistema_prefijo IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_sistema_prefijo OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_clonar | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_clonar CASCADE;
CREATE TABLE mdp_producto.tb_mdp_clonar (
	id serial NOT NULL,
	cod_sistema_origen varchar(3) NOT NULL,
	cod_sistema_destino varchar(3),
	cod_producto_origen varchar(10),
	cod_producto_destino varchar(10),
	cod_zona_tarif varchar(10),
	por_tarifa numeric(5,2),
	fec_origen timestamp NOT NULL,
	fec_alta timestamp NOT NULL,
	fec_baja timestamp NOT NULL,
	tipo_clonacion numeric(1) NOT NULL,
	ind_porcentaje boolean NOT NULL,
	fec_creacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_clonar_pk PRIMARY KEY (id),
	CONSTRAINT ck_fechas CHECK (fec_baja >= fec_alta),
	CONSTRAINT ck_tipos CHECK (tipo_clonacion IN (1,2,3))
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_clonar IS E'Tabla interna para los parámetros de peticiones de clonación de tarifas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.id IS E'Clave primaria de la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.cod_sistema_origen IS E'Código de sistema origen de las tarifas';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.cod_sistema_destino IS E'Código del sistema destino de las tarifas a clonar';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.cod_producto_origen IS E'Código del producto origen de las tarifas a clonar';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.cod_producto_destino IS E'Código del producto destino de las tarifas a clonar';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.cod_zona_tarif IS E'Código de la zona tarifaria';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.por_tarifa IS E'Incremento en un porcentaje fijo de la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.fec_origen IS E'Fecha de origen de los registros a clonar';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.fec_alta IS E'Fecha de inicio de vigencia de la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.fec_baja IS E'Fecha de fin de vigencia de la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.tipo_clonacion IS E'Actualmente existen 3 tipos definidos de clonación de tarifas: \n1 - Dentro del mismo sistema, ya sea un producto o un sistema entero\n2 - De un sistema a otro\n3 - Un subconjunto de tarifas de un producto, ya sea en el mismo sistema o a otro';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.ind_porcentaje IS E'Indica si hay que aplicar un redondeo al cálculo de la tarifa';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_clonar.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fechas ON mdp_producto.tb_mdp_clonar IS E'La fecha de fin de vigencia de la tarifa no puede ser menor que la fecha de incio de vigencia';
-- ddl-end --
COMMENT ON CONSTRAINT ck_tipos ON mdp_producto.tb_mdp_clonar IS E'El campo tipo_clonacion solo acepta 3 valores posibles:\n1 - Dentro del mismo sistema, ya sea un producto o un sistema entero\n2 - De un sistema a otro\n3 - Un subconjunto de tarifas de un producto, ya sea en el mismo sistema o a otro';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_clonar OWNER TO postgres;
-- ddl-end --

-- object: idx_vaperfil_perfil | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_vaperfil_perfil CASCADE;
CREATE INDEX idx_vaperfil_perfil ON mdp_producto.tb_mdp_va_perfil
USING btree
(
	cod_perfil
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_va_pais | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_va_pais CASCADE;
CREATE INDEX idx_producto_va_pais ON mdp_producto.tb_mdp_producto_va
USING btree
(
	cod_pais
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.tb_mdp_perfil | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_perfil CASCADE;
CREATE TABLE mdp_producto.tb_mdp_perfil (
	cod_perfil numeric(2) NOT NULL,
	nom_perfil varchar(100) NOT NULL,
	ind_cliente_contrato boolean NOT NULL,
	ind_oferta_comercial boolean NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_perfil_pk PRIMARY KEY (cod_perfil),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_perfil IS E'Tabla que recoge los perfiles del producto en función del cliente objetivo al que van destinados';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_perfil.cod_perfil IS E'Código del perfil del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_perfil.nom_perfil IS E'Nombre del perfil del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_perfil.ind_cliente_contrato IS E'Indicador para clasificar este perfil como perteneciente a clientes de contrato.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_perfil.ind_oferta_comercial IS E'Indica si el perfil es válido para utilizar en una oferta comercial';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_perfil.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_perfil.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_perfil IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_perfil OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_admision | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_admision CASCADE;
CREATE TABLE mdp_producto.tb_mdp_admision (
	cod_admision numeric(2) NOT NULL,
	ind_citypaq boolean NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_mod_admision_pk PRIMARY KEY (cod_admision),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_admision IS E'Tabla que guarda los diferentes tipos de modalidades de admisión de un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_admision.cod_admision IS E'Código de la modalidad de admisión';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_admision.ind_citypaq IS E'Indica si el producto permite admisión en CityPaq';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_admision.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_admision.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_admision IS E'La fecha de actualización no puede er menor que la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_admision OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_perfil_modalidad | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_perfil_modalidad CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_perfil_modalidad (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	fec_alta timestamp NOT NULL,
	fec_baja timestamp,
	cod_sap varchar(18),
	cod_upu varchar(19),
	ind_obliga_cb boolean NOT NULL,
	num_intentos_entrega numeric(1),
	num_bultos_max numeric(2),
	logo bytea,
	ind_obliga_medidas boolean NOT NULL DEFAULT TRUE,
	largo_min numeric(5),
	largo_max numeric(5),
	largo_extra_max numeric(5,0),
	ancho_min numeric(5) NOT NULL,
	ancho_max numeric(5) NOT NULL,
	ancho_extra_max numeric(5,0),
	alto_min numeric(5) NOT NULL,
	alto_max numeric(5) NOT NULL,
	alto_extra_max numeric(5,0),
	criterio_max numeric(5),
	criterio_extra numeric(5,0) NOT NULL,
	dimension_rollo_min numeric(5),
	dimension_rollo_max numeric(5),
	diametro_min numeric(5),
	diametro_max numeric(5),
	criterio_rollo_max numeric(5),
	peso_volumetrico_max numeric(7),
	volumen numeric(7,2),
	caducidad_min numeric(3) NOT NULL DEFAULT 0,
	caducidad_max numeric(3) NOT NULL DEFAULT 0,
	tiempo_lista numeric(2),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_perfil_modalidad_pk PRIMARY KEY (cod_producto_comercial,cod_modalidad,fec_alta),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_peso_vol_max CHECK (((peso_volumetrico_max >= (0)::numeric) AND (peso_volumetrico_max IS NOT NULL))),
	CONSTRAINT ck_num_bultos_max CHECK (((num_bultos_max IS NOT NULL) AND (num_bultos_max >= (0)::numeric))),
	CONSTRAINT ck_dimensiones_extra CHECK (((largo_extra_max >= (0)::numeric) AND (largo_extra_max IS NOT NULL) AND ((ancho_extra_max >= (0)::numeric) AND (ancho_extra_max IS NOT NULL)) AND ((alto_extra_max >= (0)::numeric) AND (alto_extra_max IS NOT NULL)))),
	CONSTRAINT ck_criterio_extra CHECK (criterio_extra >= (0)::numeric),
	CONSTRAINT ck_criterios_max CHECK (((criterio_max >= (0)::numeric) AND (criterio_rollo_max >= (0)::numeric) AND ((criterio_max IS NOT NULL) AND (criterio_rollo_max IS NOT NULL)))),
	CONSTRAINT ck_volumen CHECK ((volumen is null) or (volumen >= 0)),
	CONSTRAINT ck_dimensiones_largo CHECK (((largo_min >= (0)::numeric) AND (largo_max >= (0)::numeric) AND ((largo_min IS NOT NULL) AND (largo_max IS NOT NULL)) AND (largo_max >= largo_min))),
	CONSTRAINT ck_dimensiones_alto CHECK (((alto_min >= (0)::numeric) AND (alto_max >= (0)::numeric))),
	CONSTRAINT ck_dimensiones_ancho CHECK (((ancho_min >= (0)::numeric) AND (ancho_max >= (0)::numeric))),
	CONSTRAINT ck_diametros CHECK (((diametro_min >= (0)::numeric) AND (diametro_max >= (0)::numeric) AND ((diametro_min IS NOT NULL) AND (diametro_max IS NOT NULL)) AND (diametro_max >= diametro_min))),
	CONSTRAINT ck_altos CHECK ((alto_max >= alto_min) and (alto_min >=0 and alto_max >=0)),
	CONSTRAINT ck_anchos CHECK ((ancho_max >= ancho_min) and (ancho_min >= 0 and ancho_max => 0)),
	CONSTRAINT ck_fec_baja CHECK ((fec_baja > fec_alta)),
	CONSTRAINT ck_num_intentos_entrega CHECK (((num_intentos_entrega IS NOT NULL) AND (num_intentos_entrega >= (0)::numeric))),
	CONSTRAINT ck_dimension_rollo CHECK ((dimension_rollo_min <= dimension_rollo_max) AND (dimension_rollo_min >= 0 and dimension_rollo_max >=0) AND (dimension_rollo_min IS NOT NULL and dimension_rollo_max IS NOT NULL)),
	CONSTRAINT ck_caducidad CHECK (caducidad_max >= caducidad_min),
	CONSTRAINT ck_tiempo_lista CHECK (((tiempo_lista IS NOT NULL) AND (tiempo_lista >= (0)::numeric)))
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_perfil_modalidad IS E'Tabla con los atributos cuyo valor depende de las diferentes modalidades de entrega y admisión, así como el sistema y perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.cod_modalidad IS E'Código de modalidad de entrega/admisión';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.fec_alta IS E'Fecha de alta del atributo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.fec_baja IS E'Fecha de baja del atributo del producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.cod_sap IS E'Código SAP asociado al producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.cod_upu IS E'Código upu necesario para que sistemas como IRIS puedan mapear los productos del Maestro de Productos.\nEste campo es temporal y llegado el momento se borrará cuando las aplicaciones que lo usan conecten directamente con el Maestro de Productos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.ind_obliga_cb IS E'Indica si es obligatorio el código de barras para este producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.num_intentos_entrega IS E'Número intentos entrega por defecto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.num_bultos_max IS E'Número máximo de bultos que admite un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.logo IS E'Imágen asociada a este producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.ind_obliga_medidas IS E'Indica si las medidas (alto, ancho y largo) para este producto son obligatorias';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.largo_min IS E'Largo mínimo del producto (en mm.), que en el caso de España, servirá como valor por defecto de este atributo para el producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.largo_max IS E'Largo máximo del producto (en mm.), que en el caso de España, servirá como valor por defecto de este atributo para el producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.largo_extra_max IS E'largo_extra_max';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.ancho_min IS E'Ancho mínimo del producto (en mm.), que en el caso de España, servirá como valor por defecto de este atributo para el producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.ancho_max IS E'Ancho máximo del producto (en mm.), que en el caso de España, servirá como valor por defecto de este atributo para el producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.ancho_extra_max IS E'Ancho máximo extra que se permite (en mm.)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.alto_min IS E'Alto mínimo del producto (en mm.), que en el caso de España, servirá como valor por defecto de este atributo para el producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.alto_max IS E'Alto máximo del producto (en mm.), que en el caso de España, servirá como valor por defecto de este atributo para el producto.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.alto_extra_max IS E'Alto máximo extra que se permite (en mm.)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.criterio_max IS E'Valor máximo que debe cumplir el conjunto de dimensiones de un producto (en mm.) cuando su formato no es rollo (en mm.).\nSe considera el valor por defecto para el producto cuando el país es España';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.criterio_extra IS E'Valor máximo que debe cumplir el conjunto de dimensiones extra de un producto (en mm.) cuando su formato no es rollo (en mm.).';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.dimension_rollo_max IS E'Tamaño máximo por separado de cualquiera de las dimensiones del producto (en mm.) cuando el formato se trata de un rollo';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.diametro_min IS E'Diámetro mínimo de un producto con formato rollo (en mm.)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.diametro_max IS E'Diámetro máximo de un producto con formato rollo (en mm.)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.criterio_rollo_max IS E'Valor máximo que debe cumplir el conjunto de dimensiones de un producto cuando su formato es un rollo (en mm.).';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.peso_volumetrico_max IS E'Volumen máximo que acepta este producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.volumen IS E'Metros cúbicos del bulto (para paletería)';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.caducidad_min IS E'Número mínimo de días que tiene que pasar antes de aceptar un envío pre-registrado';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.caducidad_max IS E'Número máximo de días que pueden pasar para aceptar un envío pre-registrado';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.tiempo_lista IS E'Tiempo que permanece un producto en correos si no se ha podido entregar, medido en días';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_modalidad.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'La fecha de actualización no puede er menor que la fecha de creación';
-- ddl-end --
COMMENT ON CONSTRAINT ck_peso_vol_max ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El peso volumétrico del producto no puede ser negativo o nulo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_num_bultos_max ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El número máximo de bultos de un producto no puede ser negativo o nulo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_dimensiones_extra ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'Si el producto puede tener dimensiones extra, no pueden ser negativas o nulas';
-- ddl-end --
COMMENT ON CONSTRAINT ck_criterio_extra ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El valor máximo que deben cumplir el conjunto de dimensiones extra de un producto no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_criterios_max ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El valor máximo que deben cumplir el conjunto de dimensiones de un producto para un formato de rollo no puede ser negativo o nulo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_volumen ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El volumen no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_dimensiones_largo ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'Las dimensión LARGO del producto no puede ser negativa o nula, ni el largo máximo ser menor que el largo mínimo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_dimensiones_alto ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El alto de un producto no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_dimensiones_ancho ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El ancho de un producto no puede ser negativo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_diametros ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El diámetro del producto cuando su formato es rollo, no puede ser negativo o nulo, así como el diámetro máximo no puede ser menor que el diámetro mínimo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_altos ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El valor del alto máximo no puede ser menor que el alto mínimo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_anchos ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El valor del ancho máximo no puede ser menor que el ancho mínimo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_baja ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'La fecha de baja del producto no puede ser menor a la de alta';
-- ddl-end --
COMMENT ON CONSTRAINT ck_num_intentos_entrega ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El número máximo de intentos de entrega no puede ser negativo o nulo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_dimension_rollo ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'La dimensión mínima de un paquete tipo rollo no puede ser mayor que la máxima y ambas no pueden ser negativas ni nulas';
-- ddl-end --
COMMENT ON CONSTRAINT ck_caducidad ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El número máximo de días de caducidad de un envío de pre-registro no puede ser menor que el mínimo';
-- ddl-end --
COMMENT ON CONSTRAINT ck_tiempo_lista ON mdp_producto.tb_mdp_producto_perfil_modalidad IS E'El tiempo en lista del producto no puede ser negativo o nulo';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_perfil_modalidad OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_admision_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_admision_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_admision_idioma (
	cod_admision numeric(2) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	nom_admision varchar(60) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_admision_idioma_pk PRIMARY KEY (cod_admision,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_admision_idioma IS E'Tabla que guarda la relación entre una modalidad de admisión y su traducción';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_admision_idioma.cod_admision IS E'Código modalidad entrega';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_admision_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_admision_idioma.nom_admision IS E'Nombre de la modalidad de admisión';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_admision_idioma.fec_creacion IS E'Fecha de creacion del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_admision_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_admision_idioma IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_admision_idioma OWNER TO postgres;
-- ddl-end --

-- object: idx_admision_idioma_idioma | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_admision_idioma_idioma CASCADE;
CREATE INDEX idx_admision_idioma_idioma ON mdp_producto.tb_mdp_admision_idioma
USING btree
(
	cod_idioma_alpha2
);
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_material | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_material CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_material (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_tipo_material numeric(1) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_material_pk PRIMARY KEY (cod_producto_comercial,cod_tipo_material),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_material IS E'Tabla que relaciona los tipos de material que puede tener un producto en función de su sistema y perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_material.cod_producto_comercial IS E'Código de la relación entre el producto y su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_material.cod_tipo_material IS E'Código del tipo de material';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_material.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_material.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_material IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_material OWNER TO postgres;
-- ddl-end --

-- object: idx_producto_comercial_modalidad | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_comercial_modalidad CASCADE;
CREATE INDEX idx_producto_comercial_modalidad ON mdp_producto.tb_mdp_producto_perfil_modalidad
USING btree
(
	cod_modalidad
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_producto_perfil_material | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_producto_perfil_material CASCADE;
CREATE INDEX idx_producto_perfil_material ON mdp_producto.tb_mdp_producto_material
USING btree
(
	cod_tipo_material
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.tb_mdp_modalidad | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_modalidad CASCADE;
CREATE TABLE mdp_producto.tb_mdp_modalidad (
	cod_modalidad varchar(6) NOT NULL,
	cod_entrega numeric(2),
	cod_admision numeric(2),
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_modalidad_pk PRIMARY KEY (cod_modalidad),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_modalidad IS E'Tabla que guarda las combinaciones de modalides de entrega/admisión que puede aceptar un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad.cod_modalidad IS E'Código de modalidad de entrega/admisión';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad.cod_entrega IS E'Código modalidad de entrega';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad.cod_admision IS E'Código modalidad de admisión';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_modalidad IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_modalidad OWNER TO postgres;
-- ddl-end --

-- object: idx_modalidad | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_modalidad CASCADE;
CREATE UNIQUE INDEX idx_modalidad ON mdp_producto.tb_mdp_modalidad
USING btree
(
	cod_entrega,
	cod_admision
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_perfil_sistema | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_perfil_sistema CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_perfil_sistema (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_sistema varchar(3) NOT NULL,
	cod_modalidad varchar(6) NOT NULL,
	cuenta_cont numeric(20) NOT NULL,
	fec_inicio_destacado timestamp,
	fec_fin_destacado timestamp,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_perfil_sistema_pk PRIMARY KEY (cod_producto_comercial,cod_sistema,cod_modalidad),
	CONSTRAINT ck_cuenta_cont CHECK (((cuenta_cont IS NOT NULL) AND (cuenta_cont >= (0)::numeric))),
	CONSTRAINT ck_fechas CHECK ((fec_inicio_destacado IS NULL AND fec_fin_destacado IS NULL) OR (fec_inicio_destacado IS NOT NULL AND fec_fin_destacado IS NOT NULL AND fec_fin_destacado > fec_inicio_destacado)),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_perfil_sistema IS E'Tabla que guarda los sistemas asociados a un producto dependiendo de su perfil';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_sistema.cod_producto_comercial IS E'Código de producto comercial';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_sistema.cod_sistema IS E'Código de sistema';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_sistema.cod_modalidad IS E'Código de modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_sistema.cuenta_cont IS E'Cuenta contable asociada al producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_sistema.fec_inicio_destacado IS E'Fecha en que se inicia el periodo en que un producto está destacado para una aplicación';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_sistema.fec_fin_destacado IS E'Fecha en que finaliza el periodo en que un producto está destacado para una aplicación';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_sistema.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_perfil_sistema.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_cuenta_cont ON mdp_producto.tb_mdp_producto_perfil_sistema IS E'Cualquier producto tiene asociada siempre una cuenta contabke, que no puede ser nula o negativa';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fechas ON mdp_producto.tb_mdp_producto_perfil_sistema IS E'La fecha de fin de vigencia del producto como destacado no puede ser menor que la fecha de inicio.';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_perfil_sistema IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_perfil_sistema OWNER TO postgres;
-- ddl-end --

-- object: idx_productoperfilsistema_sistema | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_productoperfilsistema_sistema CASCADE;
CREATE INDEX idx_productoperfilsistema_sistema ON mdp_producto.tb_mdp_producto_perfil_sistema
USING btree
(
	cod_sistema
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: mdp_producto.fn_tr_tb_mdp_producto_sistema_prefijo_aiu | type: FUNCTION --
-- DROP FUNCTION IF EXISTS mdp_producto.fn_tr_tb_mdp_producto_sistema_prefijo_aiu() CASCADE;
CREATE OR REPLACE FUNCTION mdp_producto.fn_tr_tb_mdp_producto_sistema_prefijo_aiu ()
	RETURNS trigger
	LANGUAGE plpgsql
	STABLE 
	RETURNS NULL ON NULL INPUT
	SECURITY INVOKER
	PARALLEL UNSAFE
	COST 1
	AS 
$function$
BEGIN
	IF NOT EXISTS ( SELECT 1
					FROM mdp_products.tb_mdp_producto_perfil pp
					WHERE pp.cod_producto = NEW.cod_producto
				   ) THEN
    NULL;
  	ELSIF NOT EXISTS ( SELECT 1
                     FROM mdp_products.tb_mdp_producto_perfil pp
                        JOIN mdp_products.tb_mdp_producto_perfil_modalidad ppm ON ppm.cod_producto_comercial = pp.cod_producto_comercial
                     WHERE pp.cod_producto = NEW.cod_producto AND ppm.cod_modalidad = NEW.cod_modalidad
                   ) THEN
    	RAISE EXCEPTION 'La modalidad seleccionada no es una de las modalidades asociadas a este producto';
  	END IF;

  	RETURN NEW;
END;
$function$;
-- ddl-end --
ALTER FUNCTION mdp_producto.fn_tr_tb_mdp_producto_sistema_prefijo_aiu() OWNER TO postgres;
-- ddl-end --
COMMENT ON FUNCTION mdp_producto.fn_tr_tb_mdp_producto_sistema_prefijo_aiu() IS E'Función que impide que un nuevo registro en esta tabla tenga asociada una modalidad que no esté recogida en el conjunto de modalidades asociadas al producto en producto_perfil_modalidad';
-- ddl-end --

-- object: tr_tb_mdp_producto_sistema_prefijo | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_tb_mdp_producto_sistema_prefijo ON mdp_producto.tb_mdp_producto_sistema_prefijo CASCADE;
CREATE OR REPLACE TRIGGER tr_tb_mdp_producto_sistema_prefijo
	AFTER INSERT OR UPDATE
	ON mdp_producto.tb_mdp_producto_sistema_prefijo
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_producto_sistema_prefijo_aiu();
-- ddl-end --

-- object: mdp_producto.tb_mdp_trazabilidad_temperatura | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_trazabilidad_temperatura CASCADE;
CREATE TABLE mdp_producto.tb_mdp_trazabilidad_temperatura (
	cod_trazabilidad_temperatura numeric(2) NOT NULL,
	desc_trazabilidad_temperatura varchar(255) NOT NULL,
	ind_datalogger boolean NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_trazabilidad_temperatura_pk PRIMARY KEY (cod_trazabilidad_temperatura),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_trazabilidad_temperatura IS E'Tabla que guarda el tipo de trazabilidad de temperatura que tendrá el envío';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_trazabilidad_temperatura.cod_trazabilidad_temperatura IS E'Código de trazabilidad de temperatura';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_trazabilidad_temperatura.desc_trazabilidad_temperatura IS E'Descripción de la trazabilidad de temperatura';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_trazabilidad_temperatura.ind_datalogger IS E'Indica si es obligatorio informar el código del datalogger';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_trazabilidad_temperatura.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_trazabilidad_temperatura.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_trazabilidad_temperatura IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_trazabilidad_temperatura OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_trazabilidad_temperatura | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_trazabilidad_temperatura CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_trazabilidad_temperatura (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_trazabilidad_temperatura numeric(2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_trazabilidad_pk PRIMARY KEY (cod_producto_comercial,cod_trazabilidad_temperatura),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_trazabilidad_temperatura IS E'Tabla que guarda las trazabilidades disponibles para un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_trazabilidad_temperatura.cod_trazabilidad_temperatura IS E'Código de trazabilidad de temperatura';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_trazabilidad_temperatura.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_trazabilidad_temperatura.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_trazabilidad_temperatura IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_trazabilidad_temperatura OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_rango_temperatura | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_rango_temperatura CASCADE;
CREATE TABLE mdp_producto.tb_mdp_rango_temperatura (
	cod_rango_temperatura numeric(2) NOT NULL,
	desc_rango_temperatura varchar(255) NOT NULL,
	temperatura_min numeric(5,2) NOT NULL,
	temperatura_max numeric(5,2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_rango_temperatura_pk PRIMARY KEY (cod_rango_temperatura),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_rangos CHECK ((temperatura_min <= temperatura_max))
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_rango_temperatura IS E'Tabla que controla el rango de temperatura del producto en un envío';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_rango_temperatura.cod_rango_temperatura IS E'Código de rango de temperatura';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_rango_temperatura.desc_rango_temperatura IS E'Descripción detallada del rango de temperatura';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_rango_temperatura.temperatura_min IS E'Rango mínimo de temperatura, medido en ºC';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_rango_temperatura.temperatura_max IS E'Rango máximo de temperatura, medido en ºC';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_rango_temperatura.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_rango_temperatura.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_rango_temperatura IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
COMMENT ON CONSTRAINT ck_rangos ON mdp_producto.tb_mdp_rango_temperatura IS E'El rango mínimo de temperatura no puede ser mayor que el máximo';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_rango_temperatura OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_producto_rango_temperatura | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_producto_rango_temperatura CASCADE;
CREATE TABLE mdp_producto.tb_mdp_producto_rango_temperatura (
	cod_producto_comercial varchar(10) NOT NULL,
	cod_rango_temperatura numeric(2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_producto_rango_pk PRIMARY KEY (cod_producto_comercial,cod_rango_temperatura),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_producto_rango_temperatura IS E'Tabla que guarda los rangos de temperatura disponibles para un producto';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_rango_temperatura.cod_rango_temperatura IS E'Código de rango de temperatura';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_rango_temperatura.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_producto_rango_temperatura.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_producto_rango_temperatura IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_producto_rango_temperatura OWNER TO postgres;
-- ddl-end --

-- object: mdp_producto.tb_mdp_tam_simple_sobrecoste | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_tam_simple_sobrecoste CASCADE;
CREATE TABLE mdp_producto.tb_mdp_tam_simple_sobrecoste (
	cod_tam_simple numeric(10) NOT NULL,
	cod_sobrecoste numeric(2) NOT NULL,
	exceso_simple numeric(2) NOT NULL,
	exceso_ampliado numeric(2) NOT NULL,
	exceso_peso_altura numeric(2) NOT NULL,
	coeficiente_ampliado numeric(4,2) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_tam_simple_sobrecoste_pk PRIMARY KEY (cod_tam_simple,cod_sobrecoste),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion),
	CONSTRAINT ck_excesos CHECK (exceso_simple >=0 and exceso_ampliado >=0 and exceso_peso_altura >= 0),
	CONSTRAINT ck_coeficiente CHECK (coeficiente_ampliado >= 0)
);
-- ddl-end --
COMMENT ON TABLE mdp_producto.tb_mdp_tam_simple_sobrecoste IS E'Tabla que guarda los parámetros para calcular el tipo de sobrecoste a aplicar en los tamaños amigables de un producto.\nCuando un producto tiene asociados tamaños amigables, estos pueden tener sobrecostes asociados que no tienen por qué ser los mismos sobrecostes que tiene ese mismo producto.\nNo son dependientes ni excluyentes entre sí.';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_sobrecoste.cod_tam_simple IS E'Código de tamaño amigable';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_sobrecoste.cod_sobrecoste IS E'Código de sobrecoste';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_sobrecoste.exceso_simple IS E'Valor que controla el primer tramo de exceso permitido para el ancho y largo del palet';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_sobrecoste.exceso_ampliado IS E'Valor que controla el segundo tramo de exceso permitido para el ancho y largo del palet';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_sobrecoste.exceso_peso_altura IS E'Valor que controla el exceso de peso o altura permitidos';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_sobrecoste.coeficiente_ampliado IS E'Valor corrector que se aplica cuando las medidas de longitud pasan del estándar';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_sobrecoste.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_tam_simple_sobrecoste.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_tam_simple_sobrecoste IS E'La fecha de creación no puede ser mayor que la fecha de actualización';
-- ddl-end --
COMMENT ON CONSTRAINT ck_excesos ON mdp_producto.tb_mdp_tam_simple_sobrecoste IS E'Los valores de control de las dimensiones no pueden ser negativos';
-- ddl-end --
COMMENT ON CONSTRAINT ck_coeficiente ON mdp_producto.tb_mdp_tam_simple_sobrecoste IS E'El coeficiente no puede ser negativo';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_tam_simple_sobrecoste OWNER TO postgres;
-- ddl-end --

-- object: idx_tamsimplesobrecoste_sobrecoste | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_tamsimplesobrecoste_sobrecoste CASCADE;
CREATE INDEX idx_tamsimplesobrecoste_sobrecoste ON mdp_producto.tb_mdp_tam_simple_sobrecoste
USING btree
(
	cod_sobrecoste
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: idx_ambitoperfilmodalidad_ambito | type: INDEX --
-- DROP INDEX IF EXISTS mdp_producto.idx_ambitoperfilmodalidad_ambito CASCADE;
CREATE INDEX idx_ambitoperfilmodalidad_ambito ON mdp_producto.tb_mdp_ambito_perfil_modalidad
USING btree
(
	cod_ambito
)
WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: tr_aiud_tb_mdp_ambito_perfil_modalidad | type: TRIGGER --
-- DROP TRIGGER IF EXISTS tr_aiud_tb_mdp_ambito_perfil_modalidad ON mdp_producto.tb_mdp_ambito_perfil_modalidad CASCADE;
CREATE OR REPLACE TRIGGER tr_aiud_tb_mdp_ambito_perfil_modalidad
	AFTER INSERT OR DELETE OR UPDATE
	ON mdp_producto.tb_mdp_ambito_perfil_modalidad
	FOR EACH ROW
	EXECUTE PROCEDURE mdp_producto.fn_tr_tb_mdp_ambito_perfil_modalidad_aiud();
-- ddl-end --

-- object: mdp_producto.tb_mdp_modalidad_idioma | type: TABLE --
-- DROP TABLE IF EXISTS mdp_producto.tb_mdp_modalidad_idioma CASCADE;
CREATE TABLE mdp_producto.tb_mdp_modalidad_idioma (
	cod_modalidad varchar(6) NOT NULL,
	cod_idioma_alpha2 varchar(2) NOT NULL,
	nom_modalidad varchar(60) NOT NULL,
	fec_creacion timestamp NOT NULL,
	fec_actualizacion timestamp NOT NULL,
	CONSTRAINT tb_mdp_modalidad_idioma_pk PRIMARY KEY (cod_modalidad,cod_idioma_alpha2),
	CONSTRAINT ck_fec_actualizacion CHECK (fec_actualizacion >= fec_creacion)
);
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad_idioma.cod_modalidad IS E'Código de modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad_idioma.cod_idioma_alpha2 IS E'Código de idioma';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad_idioma.nom_modalidad IS E'Nombre de la modalidad';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad_idioma.fec_creacion IS E'Fecha de creación del registro en la tabla';
-- ddl-end --
COMMENT ON COLUMN mdp_producto.tb_mdp_modalidad_idioma.fec_actualizacion IS E'Fecha de actualización del registro en la tabla';
-- ddl-end --
COMMENT ON CONSTRAINT ck_fec_actualizacion ON mdp_producto.tb_mdp_modalidad_idioma IS E'La fecha de actualización no puede ser menor a la fecha de creación';
-- ddl-end --
ALTER TABLE mdp_producto.tb_mdp_modalidad_idioma OWNER TO postgres;
-- ddl-end --

-- object: fk_familia_familia | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_familia DROP CONSTRAINT IF EXISTS fk_familia_familia CASCADE;
ALTER TABLE mdp_producto.tb_mdp_familia ADD CONSTRAINT fk_familia_familia FOREIGN KEY (cod_familia_padre)
REFERENCES mdp_producto.tb_mdp_familia (cod_familia) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productofamilia_familia | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_familia DROP CONSTRAINT IF EXISTS fk_productofamilia_familia CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_familia ADD CONSTRAINT fk_productofamilia_familia FOREIGN KEY (cod_familia)
REFERENCES mdp_producto.tb_mdp_familia (cod_familia) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productofamilia_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_familia DROP CONSTRAINT IF EXISTS fk_productofamilia_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_familia ADD CONSTRAINT fk_productofamilia_producto FOREIGN KEY (cod_producto_comercial)
REFERENCES mdp_producto.tb_mdp_producto_perfil (cod_producto_comercial) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productoatributo_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_atributo DROP CONSTRAINT IF EXISTS fk_productoatributo_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_atributo ADD CONSTRAINT fk_productoatributo_producto FOREIGN KEY (cod_producto)
REFERENCES mdp_producto.tb_mdp_producto (cod_producto) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productoatributo_empresa | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_atributo DROP CONSTRAINT IF EXISTS fk_productoatributo_empresa CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_atributo ADD CONSTRAINT fk_productoatributo_empresa FOREIGN KEY (cod_empresa)
REFERENCES mdp_producto.tb_mdp_empresa (cod_empresa) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_idioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_idioma DROP CONSTRAINT IF EXISTS fk_idioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_idioma ADD CONSTRAINT fk_idioma_idioma FOREIGN KEY (cod_idioma_ref)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idioma) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT fk_idioma_idioma ON mdp_producto.tb_mdp_idioma IS E'Existirá un FK sobre la propia tabla al campo COD_IDIOMA. Sólo se completará en casos donde existan entradas bibliográficas y terminológicas para el mismo idioma, por ejemplo baq (B) y eus (T) para el vasco marcando en estos casos la bibliográfica haciendo referencia a la terminológica o en aquellos donde existan variantes ancestrales como el inglés antiguo (ang) o el medio (enm) que harían referencia al actual (eng).';
-- ddl-end --


-- object: fk_productoidioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_idioma DROP CONSTRAINT IF EXISTS fk_productoidioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_idioma ADD CONSTRAINT fk_productoidioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productoidioma_modalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_idioma DROP CONSTRAINT IF EXISTS fk_productoidioma_modalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_idioma ADD CONSTRAINT fk_productoidioma_modalidad FOREIGN KEY (cod_producto_comercial,cod_modalidad,fec_alta)
REFERENCES mdp_producto.tb_mdp_producto_perfil_modalidad (cod_producto_comercial,cod_modalidad,fec_alta) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productova_va | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_va DROP CONSTRAINT IF EXISTS fk_productova_va CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_va ADD CONSTRAINT fk_productova_va FOREIGN KEY (cod_va)
REFERENCES mdp_producto.tb_mdp_va (cod_va) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productova_perfilmodalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_va DROP CONSTRAINT IF EXISTS fk_productova_perfilmodalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_va ADD CONSTRAINT fk_productova_perfilmodalidad FOREIGN KEY (cod_producto_comercial,cod_modalidad,fec_alta)
REFERENCES mdp_producto.tb_mdp_producto_perfil_modalidad (cod_producto_comercial,cod_modalidad,fec_alta) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_tramo_medida | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_tramo DROP CONSTRAINT IF EXISTS fk_tramo_medida CASCADE;
ALTER TABLE mdp_producto.tb_mdp_tramo ADD CONSTRAINT fk_tramo_medida FOREIGN KEY (cod_medida)
REFERENCES mdp_producto.tb_mdp_medida (cod_medida) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_ambitoperfilmodalidad_ambito | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_ambito_perfil_modalidad DROP CONSTRAINT IF EXISTS fk_ambitoperfilmodalidad_ambito CASCADE;
ALTER TABLE mdp_producto.tb_mdp_ambito_perfil_modalidad ADD CONSTRAINT fk_ambitoperfilmodalidad_ambito FOREIGN KEY (cod_ambito)
REFERENCES mdp_producto.tb_mdp_ambito (cod_ambito) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_ambitoperfilmodalidad_modalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_ambito_perfil_modalidad DROP CONSTRAINT IF EXISTS fk_ambitoperfilmodalidad_modalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_ambito_perfil_modalidad ADD CONSTRAINT fk_ambitoperfilmodalidad_modalidad FOREIGN KEY (cod_producto_comercial,cod_modalidad,fec_alta)
REFERENCES mdp_producto.tb_mdp_producto_perfil_modalidad (cod_producto_comercial,cod_modalidad,fec_alta) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_vaidioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_idioma DROP CONSTRAINT IF EXISTS fk_vaidioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_idioma ADD CONSTRAINT fk_vaidioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_vaidioma_perfil | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_idioma DROP CONSTRAINT IF EXISTS fk_vaidioma_perfil CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_idioma ADD CONSTRAINT fk_vaidioma_perfil FOREIGN KEY (cod_va,cod_perfil,fec_alta)
REFERENCES mdp_producto.tb_mdp_va_perfil (cod_va,cod_perfil,fec_alta) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productopais_perfil_modalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_atributo_pais DROP CONSTRAINT IF EXISTS fk_productopais_perfil_modalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_atributo_pais ADD CONSTRAINT fk_productopais_perfil_modalidad FOREIGN KEY (cod_producto_comercial,cod_modalidad,fec_alta)
REFERENCES mdp_producto.tb_mdp_producto_perfil_modalidad (cod_producto_comercial,cod_modalidad,fec_alta) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_tamsimpleidioma_tam_simple | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_tam_simple_idioma DROP CONSTRAINT IF EXISTS fk_tamsimpleidioma_tam_simple CASCADE;
ALTER TABLE mdp_producto.tb_mdp_tam_simple_idioma ADD CONSTRAINT fk_tamsimpleidioma_tam_simple FOREIGN KEY (cod_tam_simple)
REFERENCES mdp_producto.tb_mdp_tam_simple (cod_tam_simple) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_tamsimpleidioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_tam_simple_idioma DROP CONSTRAINT IF EXISTS fk_tamsimpleidioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_tam_simple_idioma ADD CONSTRAINT fk_tamsimpleidioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productotamsimple_tam_simple | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_tam_simple DROP CONSTRAINT IF EXISTS fk_productotamsimple_tam_simple CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_tam_simple ADD CONSTRAINT fk_productotamsimple_tam_simple FOREIGN KEY (cod_tam_simple)
REFERENCES mdp_producto.tb_mdp_tam_simple (cod_tam_simple) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productotamsimple_modalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_tam_simple DROP CONSTRAINT IF EXISTS fk_productotamsimple_modalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_tam_simple ADD CONSTRAINT fk_productotamsimple_modalidad FOREIGN KEY (cod_producto_comercial,cod_modalidad)
REFERENCES mdp_producto.tb_mdp_producto_perfil_modalidad (cod_producto_comercial,cod_modalidad) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_mdp_varestriccion_va | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_restriccion DROP CONSTRAINT IF EXISTS fk_mdp_varestriccion_va CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_restriccion ADD CONSTRAINT fk_mdp_varestriccion_va FOREIGN KEY (cod_va)
REFERENCES mdp_producto.tb_mdp_va (cod_va) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_mdp_varestriccion_va_rest | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_restriccion DROP CONSTRAINT IF EXISTS fk_mdp_varestriccion_va_rest CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_restriccion ADD CONSTRAINT fk_mdp_varestriccion_va_rest FOREIGN KEY (cod_va_rest)
REFERENCES mdp_producto.tb_mdp_va (cod_va) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productoperfilfranqueo_perfil | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_perfil_franqueo DROP CONSTRAINT IF EXISTS fk_productoperfilfranqueo_perfil CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_perfil_franqueo ADD CONSTRAINT fk_productoperfilfranqueo_perfil FOREIGN KEY (cod_producto_comercial)
REFERENCES mdp_producto.tb_mdp_producto_perfil (cod_producto_comercial) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productoperfil_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_perfil DROP CONSTRAINT IF EXISTS fk_productoperfil_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_perfil ADD CONSTRAINT fk_productoperfil_producto FOREIGN KEY (cod_producto)
REFERENCES mdp_producto.tb_mdp_producto (cod_producto) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productoperfil_perfil | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_perfil DROP CONSTRAINT IF EXISTS fk_productoperfil_perfil CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_perfil ADD CONSTRAINT fk_productoperfil_perfil FOREIGN KEY (cod_perfil)
REFERENCES mdp_producto.tb_mdp_perfil (cod_perfil) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productotipo_tipo | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_tipo DROP CONSTRAINT IF EXISTS fk_productotipo_tipo CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_tipo ADD CONSTRAINT fk_productotipo_tipo FOREIGN KEY (cod_tipo)
REFERENCES mdp_producto.tb_mdp_tipo (cod_tipo) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_producto_tipo_comercial | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_tipo DROP CONSTRAINT IF EXISTS fk_producto_tipo_comercial CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_tipo ADD CONSTRAINT fk_producto_tipo_comercial FOREIGN KEY (cod_producto_comercial)
REFERENCES mdp_producto.tb_mdp_producto_perfil (cod_producto_comercial) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_sistemacanal_sistema | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_sistema_canal DROP CONSTRAINT IF EXISTS fk_sistemacanal_sistema CASCADE;
ALTER TABLE mdp_producto.tb_mdp_sistema_canal ADD CONSTRAINT fk_sistemacanal_sistema FOREIGN KEY (cod_sistema)
REFERENCES mdp_producto.tb_mdp_sistema (cod_sistema) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_sistemacanal_canal | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_sistema_canal DROP CONSTRAINT IF EXISTS fk_sistemacanal_canal CASCADE;
ALTER TABLE mdp_producto.tb_mdp_sistema_canal ADD CONSTRAINT fk_sistemacanal_canal FOREIGN KEY (cod_canal)
REFERENCES mdp_producto.tb_mdp_canal (cod_canal) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_varestidioma_va_restriccion | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_restriccion_idioma DROP CONSTRAINT IF EXISTS fk_varestidioma_va_restriccion CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_restriccion_idioma ADD CONSTRAINT fk_varestidioma_va_restriccion FOREIGN KEY (cod_va,cod_va_rest)
REFERENCES mdp_producto.tb_mdp_va_restriccion (cod_va,cod_va_rest) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_varestidioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_restriccion_idioma DROP CONSTRAINT IF EXISTS fk_varestidioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_restriccion_idioma ADD CONSTRAINT fk_varestidioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_familia_idioma_familia | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_familia_idioma DROP CONSTRAINT IF EXISTS fk_familia_idioma_familia CASCADE;
ALTER TABLE mdp_producto.tb_mdp_familia_idioma ADD CONSTRAINT fk_familia_idioma_familia FOREIGN KEY (cod_familia)
REFERENCES mdp_producto.tb_mdp_familia (cod_familia) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_familia_idioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_familia_idioma DROP CONSTRAINT IF EXISTS fk_familia_idioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_familia_idioma ADD CONSTRAINT fk_familia_idioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_producto_tipoformato_tipo_formato | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_tipo_formato DROP CONSTRAINT IF EXISTS fk_producto_tipoformato_tipo_formato CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_tipo_formato ADD CONSTRAINT fk_producto_tipoformato_tipo_formato FOREIGN KEY (cod_tipo_formato)
REFERENCES mdp_producto.tb_mdp_tipo_formato (cod_tipo_formato) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_producto_tipoformato_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_tipo_formato DROP CONSTRAINT IF EXISTS fk_producto_tipoformato_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_tipo_formato ADD CONSTRAINT fk_producto_tipoformato_producto FOREIGN KEY (cod_producto)
REFERENCES mdp_producto.tb_mdp_producto (cod_producto) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_va_franjahoraria_franja_horaria | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_franja_horaria DROP CONSTRAINT IF EXISTS fk_va_franjahoraria_franja_horaria CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_franja_horaria ADD CONSTRAINT fk_va_franjahoraria_franja_horaria FOREIGN KEY (cod_franja)
REFERENCES mdp_producto.tb_mdp_franja_horaria (cod_franja) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_va_franjahoraria_va_perfil | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_franja_horaria DROP CONSTRAINT IF EXISTS fk_va_franjahoraria_va_perfil CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_franja_horaria ADD CONSTRAINT fk_va_franjahoraria_va_perfil FOREIGN KEY (cod_va,cod_perfil,fec_alta)
REFERENCES mdp_producto.tb_mdp_va_perfil (cod_va,cod_perfil,fec_alta) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_franja_horaria_idioma_franja_horaria | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_franja_horaria_idioma DROP CONSTRAINT IF EXISTS fk_franja_horaria_idioma_franja_horaria CASCADE;
ALTER TABLE mdp_producto.tb_mdp_franja_horaria_idioma ADD CONSTRAINT fk_franja_horaria_idioma_franja_horaria FOREIGN KEY (cod_franja)
REFERENCES mdp_producto.tb_mdp_franja_horaria (cod_franja) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_franja_horaria_idioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_franja_horaria_idioma DROP CONSTRAINT IF EXISTS fk_franja_horaria_idioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_franja_horaria_idioma ADD CONSTRAINT fk_franja_horaria_idioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_tramo_idioma_tramo | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_tramo_idioma DROP CONSTRAINT IF EXISTS fk_tramo_idioma_tramo CASCADE;
ALTER TABLE mdp_producto.tb_mdp_tramo_idioma ADD CONSTRAINT fk_tramo_idioma_tramo FOREIGN KEY (cod_tramo)
REFERENCES mdp_producto.tb_mdp_tramo (cod_tramo) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_tramo_idioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_tramo_idioma DROP CONSTRAINT IF EXISTS fk_tramo_idioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_tramo_idioma ADD CONSTRAINT fk_tramo_idioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_entregaidioma_entrega | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_entrega_idioma DROP CONSTRAINT IF EXISTS fk_entregaidioma_entrega CASCADE;
ALTER TABLE mdp_producto.tb_mdp_entrega_idioma ADD CONSTRAINT fk_entregaidioma_entrega FOREIGN KEY (cod_entrega)
REFERENCES mdp_producto.tb_mdp_entrega (cod_entrega) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_entregaidioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_entrega_idioma DROP CONSTRAINT IF EXISTS fk_entregaidioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_entrega_idioma ADD CONSTRAINT fk_entregaidioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_tipoformato_idioma_tipo_formato | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_tipo_formato_idioma DROP CONSTRAINT IF EXISTS fk_tipoformato_idioma_tipo_formato CASCADE;
ALTER TABLE mdp_producto.tb_mdp_tipo_formato_idioma ADD CONSTRAINT fk_tipoformato_idioma_tipo_formato FOREIGN KEY (cod_tipo_formato)
REFERENCES mdp_producto.tb_mdp_tipo_formato (cod_tipo_formato) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_tipoformato_idioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_tipo_formato_idioma DROP CONSTRAINT IF EXISTS fk_tipoformato_idioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_tipo_formato_idioma ADD CONSTRAINT fk_tipoformato_idioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_atributova_va | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_atributo_va DROP CONSTRAINT IF EXISTS fk_atributova_va CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_atributo_va ADD CONSTRAINT fk_atributova_va FOREIGN KEY (cod_va)
REFERENCES mdp_producto.tb_mdp_va (cod_va) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_atributova_atributo | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_atributo_va DROP CONSTRAINT IF EXISTS fk_atributova_atributo CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_atributo_va ADD CONSTRAINT fk_atributova_atributo FOREIGN KEY (cod_atributo_va)
REFERENCES mdp_producto.tb_mdp_atributo_va (cod_atributo_va) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_atributovaidioma_atributo_va | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_atributo_va_idioma DROP CONSTRAINT IF EXISTS fk_atributovaidioma_atributo_va CASCADE;
ALTER TABLE mdp_producto.tb_mdp_atributo_va_idioma ADD CONSTRAINT fk_atributovaidioma_atributo_va FOREIGN KEY (cod_atributo_va)
REFERENCES mdp_producto.tb_mdp_atributo_va (cod_atributo_va) MATCH FULL
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_atributovaidioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_atributo_va_idioma DROP CONSTRAINT IF EXISTS fk_atributovaidioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_atributo_va_idioma ADD CONSTRAINT fk_atributovaidioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_documentoidioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_documento_idioma DROP CONSTRAINT IF EXISTS fk_documentoidioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_documento_idioma ADD CONSTRAINT fk_documentoidioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_documentoidioma_documento | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_documento_idioma DROP CONSTRAINT IF EXISTS fk_documentoidioma_documento CASCADE;
ALTER TABLE mdp_producto.tb_mdp_documento_idioma ADD CONSTRAINT fk_documentoidioma_documento FOREIGN KEY (cod_documento)
REFERENCES mdp_producto.tb_mdp_documento (cod_documento) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_atributovadocumento_atributo_va | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_atributo_va_documento DROP CONSTRAINT IF EXISTS fk_atributovadocumento_atributo_va CASCADE;
ALTER TABLE mdp_producto.tb_mdp_atributo_va_documento ADD CONSTRAINT fk_atributovadocumento_atributo_va FOREIGN KEY (cod_atributo_va)
REFERENCES mdp_producto.tb_mdp_atributo_va (cod_atributo_va) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_atributovadocumento_documento | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_atributo_va_documento DROP CONSTRAINT IF EXISTS fk_atributovadocumento_documento CASCADE;
ALTER TABLE mdp_producto.tb_mdp_atributo_va_documento ADD CONSTRAINT fk_atributovadocumento_documento FOREIGN KEY (cod_documento)
REFERENCES mdp_producto.tb_mdp_documento (cod_documento) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_vafranqueoperfil_va | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_franqueo_perfil DROP CONSTRAINT IF EXISTS fk_vafranqueoperfil_va CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_franqueo_perfil ADD CONSTRAINT fk_vafranqueoperfil_va FOREIGN KEY (cod_va)
REFERENCES mdp_producto.tb_mdp_va (cod_va) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_vafranqueoperfil_perfil | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_franqueo_perfil DROP CONSTRAINT IF EXISTS fk_vafranqueoperfil_perfil CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_franqueo_perfil ADD CONSTRAINT fk_vafranqueoperfil_perfil FOREIGN KEY (cod_perfil)
REFERENCES mdp_producto.tb_mdp_perfil (cod_perfil) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_promocion_sistema | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_promocion DROP CONSTRAINT IF EXISTS fk_promocion_sistema CASCADE;
ALTER TABLE mdp_producto.tb_mdp_promocion ADD CONSTRAINT fk_promocion_sistema FOREIGN KEY (cod_sistema)
REFERENCES mdp_producto.tb_mdp_sistema (cod_sistema) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_promocioncodigo_promocion | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_promocion_codigo DROP CONSTRAINT IF EXISTS fk_promocioncodigo_promocion CASCADE;
ALTER TABLE mdp_producto.tb_mdp_promocion_codigo ADD CONSTRAINT fk_promocioncodigo_promocion FOREIGN KEY (cod_promocion)
REFERENCES mdp_producto.tb_mdp_promocion (cod_promocion) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_promocioncliente_promocion | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_promocion_cliente DROP CONSTRAINT IF EXISTS fk_promocioncliente_promocion CASCADE;
ALTER TABLE mdp_producto.tb_mdp_promocion_cliente ADD CONSTRAINT fk_promocioncliente_promocion FOREIGN KEY (cod_promocion)
REFERENCES mdp_producto.tb_mdp_promocion (cod_promocion) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_promocionoficina_promocion | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_promocion_oficina DROP CONSTRAINT IF EXISTS fk_promocionoficina_promocion CASCADE;
ALTER TABLE mdp_producto.tb_mdp_promocion_oficina ADD CONSTRAINT fk_promocionoficina_promocion FOREIGN KEY (cod_promocion)
REFERENCES mdp_producto.tb_mdp_promocion (cod_promocion) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productopromocion_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_promocion_producto DROP CONSTRAINT IF EXISTS fk_productopromocion_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_promocion_producto ADD CONSTRAINT fk_productopromocion_producto FOREIGN KEY (cod_producto)
REFERENCES mdp_producto.tb_mdp_producto (cod_producto) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productopromocion_promocion | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_promocion_producto DROP CONSTRAINT IF EXISTS fk_productopromocion_promocion CASCADE;
ALTER TABLE mdp_producto.tb_mdp_promocion_producto ADD CONSTRAINT fk_productopromocion_promocion FOREIGN KEY (cod_promocion)
REFERENCES mdp_producto.tb_mdp_promocion (cod_promocion) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productozona_zona | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_zona DROP CONSTRAINT IF EXISTS fk_productozona_zona CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_zona ADD CONSTRAINT fk_productozona_zona FOREIGN KEY (cod_zona_tarif)
REFERENCES mdp_producto.tb_mdp_zona_tarifaria (cod_zona_tarif) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productozona_tasa_impositiva | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_zona DROP CONSTRAINT IF EXISTS fk_productozona_tasa_impositiva CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_zona ADD CONSTRAINT fk_productozona_tasa_impositiva FOREIGN KEY (cod_tasa_impositiva)
REFERENCES mdp_producto.tb_mdp_impuesto_gravamen (cod_tasa_impositiva) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productozona_ambito | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_zona DROP CONSTRAINT IF EXISTS fk_productozona_ambito CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_zona ADD CONSTRAINT fk_productozona_ambito FOREIGN KEY (cod_ambito)
REFERENCES mdp_producto.tb_mdp_ambito (cod_ambito) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productozona_perfilmodalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_zona DROP CONSTRAINT IF EXISTS fk_productozona_perfilmodalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_zona ADD CONSTRAINT fk_productozona_perfilmodalidad FOREIGN KEY (cod_producto_comercial,cod_modalidad,fec_alta)
REFERENCES mdp_producto.tb_mdp_producto_perfil_modalidad (cod_producto_comercial,cod_modalidad,fec_alta) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_zonatarifprovincia_zona | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_zona_tarif_provincia DROP CONSTRAINT IF EXISTS fk_zonatarifprovincia_zona CASCADE;
ALTER TABLE mdp_producto.tb_mdp_zona_tarif_provincia ADD CONSTRAINT fk_zonatarifprovincia_zona FOREIGN KEY (cod_zona_tarif)
REFERENCES mdp_producto.tb_mdp_zona_tarifaria (cod_zona_tarif) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_zonatarifpais_zona_tarifaria | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_zona_tarif_pais DROP CONSTRAINT IF EXISTS fk_zonatarifpais_zona_tarifaria CASCADE;
ALTER TABLE mdp_producto.tb_mdp_zona_tarif_pais ADD CONSTRAINT fk_zonatarifpais_zona_tarifaria FOREIGN KEY (cod_zona_tarif)
REFERENCES mdp_producto.tb_mdp_zona_tarifaria (cod_zona_tarif) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_vaperfil_va | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_perfil DROP CONSTRAINT IF EXISTS fk_vaperfil_va CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_perfil ADD CONSTRAINT fk_vaperfil_va FOREIGN KEY (cod_va)
REFERENCES mdp_producto.tb_mdp_va (cod_va) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_vaperfil_perfil | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_perfil DROP CONSTRAINT IF EXISTS fk_vaperfil_perfil CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_perfil ADD CONSTRAINT fk_vaperfil_perfil FOREIGN KEY (cod_perfil)
REFERENCES mdp_producto.tb_mdp_perfil (cod_perfil) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_impuestogravamen_impuesto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_impuesto_gravamen DROP CONSTRAINT IF EXISTS fk_impuestogravamen_impuesto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_impuesto_gravamen ADD CONSTRAINT fk_impuestogravamen_impuesto FOREIGN KEY (cod_tipo_impuesto)
REFERENCES mdp_producto.tb_mdp_tipo_impuesto (cod_tipo_impuesto) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_impuestogravamen_gravamen | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_impuesto_gravamen DROP CONSTRAINT IF EXISTS fk_impuestogravamen_gravamen CASCADE;
ALTER TABLE mdp_producto.tb_mdp_impuesto_gravamen ADD CONSTRAINT fk_impuestogravamen_gravamen FOREIGN KEY (cod_tipo_gravamen)
REFERENCES mdp_producto.tb_mdp_tipo_gravamen (cod_tipo_gravamen) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_ambitodetalle_ambito | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_ambito_detalle DROP CONSTRAINT IF EXISTS fk_ambitodetalle_ambito CASCADE;
ALTER TABLE mdp_producto.tb_mdp_ambito_detalle ADD CONSTRAINT fk_ambitodetalle_ambito FOREIGN KEY (cod_ambito)
REFERENCES mdp_producto.tb_mdp_ambito (cod_ambito) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productosobrecoste_sobrecoste | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_sobrecoste DROP CONSTRAINT IF EXISTS fk_productosobrecoste_sobrecoste CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_sobrecoste ADD CONSTRAINT fk_productosobrecoste_sobrecoste FOREIGN KEY (cod_sobrecoste)
REFERENCES mdp_producto.tb_mdp_sobrecoste (cod_sobrecoste) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productosobrecoste_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_sobrecoste DROP CONSTRAINT IF EXISTS fk_productosobrecoste_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_sobrecoste ADD CONSTRAINT fk_productosobrecoste_producto FOREIGN KEY (cod_producto_comercial,cod_modalidad)
REFERENCES mdp_producto.tb_mdp_producto_perfil_modalidad (cod_producto_comercial,cod_modalidad) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_vaimpuestogravamen_va | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_impuesto_gravamen DROP CONSTRAINT IF EXISTS fk_vaimpuestogravamen_va CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_impuesto_gravamen ADD CONSTRAINT fk_vaimpuestogravamen_va FOREIGN KEY (cod_va)
REFERENCES mdp_producto.tb_mdp_va (cod_va) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_vaimpuestogravamen_impuestogravamen | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_va_impuesto_gravamen DROP CONSTRAINT IF EXISTS fk_vaimpuestogravamen_impuestogravamen CASCADE;
ALTER TABLE mdp_producto.tb_mdp_va_impuesto_gravamen ADD CONSTRAINT fk_vaimpuestogravamen_impuestogravamen FOREIGN KEY (cod_tasa_impositiva)
REFERENCES mdp_producto.tb_mdp_impuesto_gravamen (cod_tasa_impositiva) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_zona_tarif_postal_zona_tarif | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_zona_tarif_postal DROP CONSTRAINT IF EXISTS fk_zona_tarif_postal_zona_tarif CASCADE;
ALTER TABLE mdp_producto.tb_mdp_zona_tarif_postal ADD CONSTRAINT fk_zona_tarif_postal_zona_tarif FOREIGN KEY (cod_zona_tarif)
REFERENCES mdp_producto.tb_mdp_zona_tarifaria (cod_zona_tarif) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_zonatramo_zona | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_zona_tramo DROP CONSTRAINT IF EXISTS fk_zonatramo_zona CASCADE;
ALTER TABLE mdp_producto.tb_mdp_zona_tramo ADD CONSTRAINT fk_zonatramo_zona FOREIGN KEY (cod_zona_tarif)
REFERENCES mdp_producto.tb_mdp_zona_tarifaria (cod_zona_tarif) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_zonatramo_tramo | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_zona_tramo DROP CONSTRAINT IF EXISTS fk_zonatramo_tramo CASCADE;
ALTER TABLE mdp_producto.tb_mdp_zona_tramo ADD CONSTRAINT fk_zonatramo_tramo FOREIGN KEY (cod_tramo)
REFERENCES mdp_producto.tb_mdp_tramo (cod_tramo) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_zonatramo_complemento | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_zona_tramo DROP CONSTRAINT IF EXISTS fk_zonatramo_complemento CASCADE;
ALTER TABLE mdp_producto.tb_mdp_zona_tramo ADD CONSTRAINT fk_zonatramo_complemento FOREIGN KEY (cod_complemento)
REFERENCES mdp_producto.tb_mdp_complemento (cod_complemento) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sistemaprefijomodalidad_prefijo | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_sistema_prefijo DROP CONSTRAINT IF EXISTS fk_sistemaprefijomodalidad_prefijo CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_sistema_prefijo ADD CONSTRAINT fk_sistemaprefijomodalidad_prefijo FOREIGN KEY (cod_prod_prefijo)
REFERENCES mdp_producto.tb_mdp_prefijo (cod_prod_prefijo) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sistemaprefijomodalidad_sistema | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_sistema_prefijo DROP CONSTRAINT IF EXISTS fk_sistemaprefijomodalidad_sistema CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_sistema_prefijo ADD CONSTRAINT fk_sistemaprefijomodalidad_sistema FOREIGN KEY (cod_sistema)
REFERENCES mdp_producto.tb_mdp_sistema (cod_sistema) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sistemaprefijomodalidad_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_sistema_prefijo DROP CONSTRAINT IF EXISTS fk_sistemaprefijomodalidad_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_sistema_prefijo ADD CONSTRAINT fk_sistemaprefijomodalidad_producto FOREIGN KEY (cod_producto)
REFERENCES mdp_producto.tb_mdp_producto (cod_producto) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sistemaprefijomodalidad_modalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_sistema_prefijo DROP CONSTRAINT IF EXISTS fk_sistemaprefijomodalidad_modalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_sistema_prefijo ADD CONSTRAINT fk_sistemaprefijomodalidad_modalidad FOREIGN KEY (cod_modalidad)
REFERENCES mdp_producto.tb_mdp_modalidad (cod_modalidad) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_clonar_sistema | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_clonar DROP CONSTRAINT IF EXISTS fk_clonar_sistema CASCADE;
ALTER TABLE mdp_producto.tb_mdp_clonar ADD CONSTRAINT fk_clonar_sistema FOREIGN KEY (cod_sistema_origen)
REFERENCES mdp_producto.tb_mdp_sistema (cod_sistema) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_clonar_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_clonar DROP CONSTRAINT IF EXISTS fk_clonar_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_clonar ADD CONSTRAINT fk_clonar_producto FOREIGN KEY (cod_producto_origen)
REFERENCES mdp_producto.tb_mdp_producto (cod_producto) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productoperfil_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_perfil_modalidad DROP CONSTRAINT IF EXISTS fk_productoperfil_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_perfil_modalidad ADD CONSTRAINT fk_productoperfil_producto FOREIGN KEY (cod_producto_comercial)
REFERENCES mdp_producto.tb_mdp_producto_perfil (cod_producto_comercial) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productoperfil_modalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_perfil_modalidad DROP CONSTRAINT IF EXISTS fk_productoperfil_modalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_perfil_modalidad ADD CONSTRAINT fk_productoperfil_modalidad FOREIGN KEY (cod_modalidad)
REFERENCES mdp_producto.tb_mdp_modalidad (cod_modalidad) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_admisionidioma_admision | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_admision_idioma DROP CONSTRAINT IF EXISTS fk_admisionidioma_admision CASCADE;
ALTER TABLE mdp_producto.tb_mdp_admision_idioma ADD CONSTRAINT fk_admisionidioma_admision FOREIGN KEY (cod_admision)
REFERENCES mdp_producto.tb_mdp_admision (cod_admision) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_admisionidioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_admision_idioma DROP CONSTRAINT IF EXISTS fk_admisionidioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_admision_idioma ADD CONSTRAINT fk_admisionidioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_productomaterial_material | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_material DROP CONSTRAINT IF EXISTS fk_productomaterial_material CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_material ADD CONSTRAINT fk_productomaterial_material FOREIGN KEY (cod_tipo_material)
REFERENCES mdp_producto.tb_mdp_tipo_material (cod_tipo_material) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productomaterial_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_material DROP CONSTRAINT IF EXISTS fk_productomaterial_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_material ADD CONSTRAINT fk_productomaterial_producto FOREIGN KEY (cod_producto_comercial)
REFERENCES mdp_producto.tb_mdp_producto_perfil (cod_producto_comercial) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_modalidad_admision | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_modalidad DROP CONSTRAINT IF EXISTS fk_modalidad_admision CASCADE;
ALTER TABLE mdp_producto.tb_mdp_modalidad ADD CONSTRAINT fk_modalidad_admision FOREIGN KEY (cod_admision)
REFERENCES mdp_producto.tb_mdp_admision (cod_admision) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_modalidad_entrega | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_modalidad DROP CONSTRAINT IF EXISTS fk_modalidad_entrega CASCADE;
ALTER TABLE mdp_producto.tb_mdp_modalidad ADD CONSTRAINT fk_modalidad_entrega FOREIGN KEY (cod_entrega)
REFERENCES mdp_producto.tb_mdp_entrega (cod_entrega) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productoperfilsistema_sistema | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_perfil_sistema DROP CONSTRAINT IF EXISTS fk_productoperfilsistema_sistema CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_perfil_sistema ADD CONSTRAINT fk_productoperfilsistema_sistema FOREIGN KEY (cod_sistema)
REFERENCES mdp_producto.tb_mdp_sistema (cod_sistema) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productoperfilsistema_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_perfil_sistema DROP CONSTRAINT IF EXISTS fk_productoperfilsistema_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_perfil_sistema ADD CONSTRAINT fk_productoperfilsistema_producto FOREIGN KEY (cod_producto_comercial)
REFERENCES mdp_producto.tb_mdp_producto_perfil (cod_producto_comercial) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productoperfilsistema_modalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_perfil_sistema DROP CONSTRAINT IF EXISTS fk_productoperfilsistema_modalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_perfil_sistema ADD CONSTRAINT fk_productoperfilsistema_modalidad FOREIGN KEY (cod_modalidad)
REFERENCES mdp_producto.tb_mdp_modalidad (cod_modalidad) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productotrazabilidad_trazabilidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_trazabilidad_temperatura DROP CONSTRAINT IF EXISTS fk_productotrazabilidad_trazabilidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_trazabilidad_temperatura ADD CONSTRAINT fk_productotrazabilidad_trazabilidad FOREIGN KEY (cod_trazabilidad_temperatura)
REFERENCES mdp_producto.tb_mdp_trazabilidad_temperatura (cod_trazabilidad_temperatura) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productotrazabilidad_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_trazabilidad_temperatura DROP CONSTRAINT IF EXISTS fk_productotrazabilidad_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_trazabilidad_temperatura ADD CONSTRAINT fk_productotrazabilidad_producto FOREIGN KEY (cod_producto_comercial)
REFERENCES mdp_producto.tb_mdp_producto_perfil (cod_producto_comercial) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productorango_rango | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_rango_temperatura DROP CONSTRAINT IF EXISTS fk_productorango_rango CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_rango_temperatura ADD CONSTRAINT fk_productorango_rango FOREIGN KEY (cod_rango_temperatura)
REFERENCES mdp_producto.tb_mdp_rango_temperatura (cod_rango_temperatura) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_productorango_producto | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_producto_rango_temperatura DROP CONSTRAINT IF EXISTS fk_productorango_producto CASCADE;
ALTER TABLE mdp_producto.tb_mdp_producto_rango_temperatura ADD CONSTRAINT fk_productorango_producto FOREIGN KEY (cod_producto_comercial)
REFERENCES mdp_producto.tb_mdp_producto_perfil (cod_producto_comercial) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_tamsimplesobrecoste_tamsimple | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_tam_simple_sobrecoste DROP CONSTRAINT IF EXISTS fk_tamsimplesobrecoste_tamsimple CASCADE;
ALTER TABLE mdp_producto.tb_mdp_tam_simple_sobrecoste ADD CONSTRAINT fk_tamsimplesobrecoste_tamsimple FOREIGN KEY (cod_tam_simple)
REFERENCES mdp_producto.tb_mdp_tam_simple (cod_tam_simple) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_tamsimplesobrecoste_sobrecoste | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_tam_simple_sobrecoste DROP CONSTRAINT IF EXISTS fk_tamsimplesobrecoste_sobrecoste CASCADE;
ALTER TABLE mdp_producto.tb_mdp_tam_simple_sobrecoste ADD CONSTRAINT fk_tamsimplesobrecoste_sobrecoste FOREIGN KEY (cod_sobrecoste)
REFERENCES mdp_producto.tb_mdp_sobrecoste (cod_sobrecoste) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_modalidadidioma_idioma | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_modalidad_idioma DROP CONSTRAINT IF EXISTS fk_modalidadidioma_idioma CASCADE;
ALTER TABLE mdp_producto.tb_mdp_modalidad_idioma ADD CONSTRAINT fk_modalidadidioma_idioma FOREIGN KEY (cod_idioma_alpha2)
REFERENCES mdp_producto.tb_mdp_idioma (cod_idi_alpha2) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_modalidadidioma_modalidad | type: CONSTRAINT --
-- ALTER TABLE mdp_producto.tb_mdp_modalidad_idioma DROP CONSTRAINT IF EXISTS fk_modalidadidioma_modalidad CASCADE;
ALTER TABLE mdp_producto.tb_mdp_modalidad_idioma ADD CONSTRAINT fk_modalidadidioma_modalidad FOREIGN KEY (cod_modalidad)
REFERENCES mdp_producto.tb_mdp_modalidad (cod_modalidad) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: "grant_CU_eb94f049ac" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO postgres;

-- ddl-end --


-- object: "grant_CU_cd8e46e7b6" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO PUBLIC;

-- ddl-end --



