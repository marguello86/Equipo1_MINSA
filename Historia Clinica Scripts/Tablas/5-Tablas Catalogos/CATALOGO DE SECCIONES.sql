-- Table HOSPITALARIO.SNH_CAT_SECCIONES_HISTORIA

CREATE TABLE "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"(
  "SECCIONES_HISTORIA_ID" Number(10,0) NOT NULL,
  "TIPO_HISTORIA" Number(10,0),
  "SECCION_PADRE" Number(10,0),
  "CODIGO" Varchar2(30 ) NOT NULL,
  "VALOR" Varchar2(50 ),
  "DESCRIPCION" Varchar2(100 ),
  "ORDEN" Number(10,0),
  "ES_PASO" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_REGISTRO" Varchar2(50 ) NOT NULL,
  "FECHA_MODIFICACION" Date,
  "USUARIO_MODIFICACION" Varchar2(50 )
);

ALTER TABLE "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA" ADD CONSTRAINT "PK_SNH_CAT_SECCIONES_HISTORIA" PRIMARY KEY ("SECCIONES_HISTORIA_ID");


-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA" IS 'Esta tabla almacena los valores catalogo de las secciones por cada historia Clinica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."SECCIONES_HISTORIA_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."TIPO_HISTORIA" IS 'Catalogo Predefinido del tipo de historia clinica '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."SECCION_PADRE" IS 'Id de la sección padre a la que pertenece'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."CODIGO" IS 'Codigo único para identificar la sección'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."VALOR" IS 'Valor Etiqueta de la seccion'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."DESCRIPCION" IS 'Descripcion de la seccion'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."ORDEN" IS 'Ubicación de la Sección en la historia Clinica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."ES_PASO" IS 'Valor 1 Indica que es un Paso del llenado de la historia Clinica. Valor 0 Corresponde a una Seccion'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."ESTADO_REGISTRO" IS 'Catalogo Predefinido del estado del registro'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."FECHA_REGISTRO" IS 'Fecha en la que se agregó el dato de la sección'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."USUARIO_REGISTRO" IS 'Usuario que agregó el registro'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."FECHA_MODIFICACION" IS 'Última Fecha en la que fue modificado el registro'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA"."USUARIO_MODIFICACION" IS 'Último usuario que modificó el registro'
;


-- Table HOSPITALARIO.SNH_MST_PROGRESO_HISTORIA

CREATE TABLE "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA"(
  "PROGRESO_HISTORIA_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "SECCIONES_HISTORIA_ID" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_REGISTRO" Varchar2(50 ) NOT NULL,
  "FECHA_MODIFICACION" Date,
  "USUARIO_MODIFICACION" Varchar2(50 )
);

ALTER TABLE "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA" ADD CONSTRAINT "PK_PROGRESO_HISTORIA_ID" PRIMARY KEY ("PROGRESO_HISTORIA_ID");

-- Table and Columns comments section

COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA"."PROGRESO_HISTORIA_ID" IS 'Llave Primaria'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA"."ESTADO_REGISTRO" IS 'Catalogo Predefinido del estado del registro'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA"."FECHA_REGISTRO" IS 'Fecha en la que se agregó el dato de la sección'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA"."USUARIO_REGISTRO" IS 'Usuario que agregó el registro'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA"."FECHA_MODIFICACION" IS 'Última Fecha en la que fue modificado el registro'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA"."USUARIO_MODIFICACION" IS 'Último usuario que modificó el registro'
;

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA" ADD CONSTRAINT "FRK_PROGRESO_HISTORIAID" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA" ADD CONSTRAINT "FRK_SECCION_HISTORIA_ID" FOREIGN KEY ("SECCIONES_HISTORIA_ID") REFERENCES "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA" ("SECCIONES_HISTORIA_ID")
;



ALTER TABLE "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA" ADD CONSTRAINT "FRK_SECCION_PADRE" FOREIGN KEY ("SECCION_PADRE") REFERENCES "HOSPITALARIO"."SNH_CAT_SECCIONES_HISTORIA" ("SECCIONES_HISTORIA_ID")
;


---- SEQUENCE TABLA  SNH_CAT_SECCIONES_HISTORIA
CREATE SEQUENCE  "HOSPITALARIO"."SEQ_SNH_SECCIONES_HISTORIA_ID" 
MINVALUE 1 MAXVALUE 999999999999999999
INCREMENT BY 1 START WITH 1 
CACHE 20 
NOORDER  
NOCYCLE  
NOKEEP 
NOSCALE  
GLOBAL ;

ALTER TABLE HOSPITALARIO.SNH_CAT_SECCIONES_HISTORIA MODIFY SECCIONES_HISTORIA_ID   DEFAULT SEQ_SNH_SECCIONES_HISTORIA_ID.nextval;




CREATE SEQUENCE  "HOSPITALARIO"."SNH_MST_PROGRESO_HISTORIA_ID" 
MINVALUE 1 MAXVALUE 999999999999999999
INCREMENT BY 1 START WITH 1 
CACHE 20 
NOORDER  
NOCYCLE  
NOKEEP 
NOSCALE  
GLOBAL ;

ALTER TABLE HOSPITALARIO.SNH_MST_PROGRESO_HISTORIA MODIFY PROGRESO_HISTORIA_ID   DEFAULT SNH_MST_PROGRESO_HISTORIA_ID.nextval;