 
CREATE SCHEMA dal;

CREATE TABLE dal.usuario (
	id serial,
	twitter_id numeric NOT NULL,
	nombre character varying(255) NOT NULL,
	usuario character varying(255) NOT NULL,
	foto_perfil text,
	fecha_ultimo_acceso timestamp without time zone,
	CONSTRAINT pk_usuario PRIMARY KEY (id)
);

-- casificacion: para desplegar el mapa y para adicionar nuevos puntos de reciclaje
CREATE TABLE dal.clasificacion (
	id serial,
	nombre character varying(255) NOT NULL,
	codigo character varying(10) NOT NULL,
	activo character varying(5),
	fecha_registro timestamp without time zone,
	CONSTRAINT pk_categoria PRIMARY KEY (id)
);


CREATE TABLE dal.denuncia (
	id serial,
	id_usuario integer NOT NULL,
	id_clasificacion integer NOT NULL,
	descripcion character varying(255) NOT NULL,
	direccion character varying(255),
	activo character varying(5),
	fecha_denuncia timestamp without time zone,
	fecha_registro timestamp without time zone,
	CONSTRAINT pk_denuncia PRIMARY KEY (id),
	CONSTRAINT fk_usuario_denuncia FOREIGN KEY (id_usuario)
      REFERENCES dal.usuario (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_clasificacion_denuncia FOREIGN KEY (id_clasificacion)
      REFERENCES dal.clasificacion (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE dal.comentario (
	id serial,
	id_denuncia integer NOT NULL,
	id_usuario  integer NOT NULL,
	comentario_detalle character varying(255) NOT NULL,
	activo character varying(5) NOT NULL,
	fecha_comentario timestamp without time zone,
	fecha_registro timestamp without time zone,
	CONSTRAINT pk_comentario PRIMARY KEY (id),
	CONSTRAINT fk_denuncia_comentario FOREIGN KEY (id_denuncia)
      REFERENCES dal.denuncia (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT fk_usuario_comentario FOREIGN KEY (id_usuario)
      REFERENCES dal.usuario (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE dal.localizacion (
	id serial,
	id_clasificacion integer NOT NULL,
	nombre character varying(255) NOT NULL,
	descripcion character varying(255),
	direccion character varying(255),
	fecha_registro timestamp without time zone,
	latitud  numeric(16,8),  --K
	longitud numeric(16,8), --B
	activo character varying(5),
	CONSTRAINT pk_localizacion PRIMARY KEY (id),
	CONSTRAINT fk_clasificacion_localizacion FOREIGN KEY (id_clasificacion)
      REFERENCES dal.clasificacion (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


insert into dal.clasificacion (nombre,codigo,activo,fecha_registro) VALUES('Basura','BASURA','SI',current_timestamp);
insert into dal.clasificacion (nombre,codigo,activo,fecha_registro) VALUES('Papel','PAPEL','SI',current_timestamp);
insert into dal.clasificacion (nombre,codigo,activo,fecha_registro) VALUES('Botella de Platico','BOTELLA','SI',current_timestamp);
insert into dal.clasificacion (nombre,codigo,activo,fecha_registro) VALUES('Todo Vidrio','VIDRIO','SI',current_timestamp);
insert into dal.clasificacion (nombre,codigo,activo,fecha_registro) VALUES('','SI',current_timestamp);

/*
Latitud  -16.50413534
Longitud -68.14241471
*/


insert into dal.localizacion(id_clasificacion, nombre, descripcion, direccion, fecha_registro, latitud, longitud)
  values(2,'', '', '', current_timestamp,16.52, -68.15);

insert into dal.localizacion(id_clasificacion, nombre, descripcion, direccion, fecha_registro, latitud, longitud)
  values(2,'', '', '', current_timestamp,-16.5003 , -68.15003);

insert into dal.localizacion(id_clasificacion, nombre, descripcion, direccion, fecha_registro, latitud, longitud)
  values(4,'', '', '', current_timestamp,-16.5, -68.14);

insert into dal.localizacion(id_clasificacion, nombre, descripcion, direccion, fecha_registro, latitud, longitud)
  values(4,'', '', '', current_timestamp,-16.5009 , -68.1506);

insert into dal.localizacion(id_clasificacion, nombre, descripcion, direccion, fecha_registro, latitud, longitud)
  values(3,'', '', '', current_timestamp,-16.5006, -68.149993);