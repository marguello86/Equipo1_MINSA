/*
Created: 7/7/2022
Modified: 29/7/2022
Model: RE Oracle 19c
Database: Oracle 19c
*/


-- Create tables section -------------------------------------------------

-- Table HOSPITALARIO.SNH_MST_HISTORIA_CLINICA

CREATE TABLE "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"(
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "ADMISION_SERVICIO_ID" Number(10,0) NOT NULL,
  "TIPO_HISTORIA" Number(10,0) NOT NULL,
  "EXPEDIENTE_ID" Number(10,0) NOT NULL,
  "UNIDAD_SALUD_ID" Number(10,0) NOT NULL,
  "PERSONAL_SALUD_ID" Number(10,0) NOT NULL,
 -- "DIVISIONP_ID" Number(10,0) NOT NULL,
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)


-- Add keys for table HOSPITALARIO.SNH_MST_HISTORIA_CLINICA

ALTER TABLE "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ADD CONSTRAINT "PK_SNH_MST_HISTORIA_CLINICA" PRIMARY KEY ("HISTORIA_CLINICA_ID");


-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" IS 'Tabla Maestra que contiene datos que conforman la historia clinica de un paciente';

COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."HISTORIA_CLINICA_ID" IS 'Llave Principal';

COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."ADMISION_SERVICIO_ID" IS 'Llave Foránea de la Tabla SNH_MST_ADMISION_SERVICIOS';

COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."TIPO_HISTORIA" IS 'Catalogo que especifica si la historia es pediatrica, de adolescente o de adulto';

COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."EXPEDIENTE_ID" IS 'Llave Foránea de la tabla SNH_MST_CODIGO_EXPEDIENTE';

COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."UNIDAD_SALUD_ID" IS 'Llave foránea para obtener la unidad de salud en la que se está creando la historia clinica. La tabla se encuentra dentro del esquema Catalogos SBC_CAT_UNIDADES_SALUD'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."PERSONAL_SALUD_ID" IS 'Llave Foránea para obtener el personal de salud que elaboró la historia Clinica, la tabla se encuenta en el esquema de Catalogo SBC_MST_MINSA_PERSONALES'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."ESTADO_REGISTRO" IS 'Estado del registro, el valor 1 indica que esta activo, el valor 0 indica que está inactivo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."USUARIO_REGISTRO" IS 'Usuario con el que se realizó la historia clinica. '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."FECHA_REGISTRO" IS 'Fecha en la que se guardó la historia clínica '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."USUARIO_MODIFICACION" IS 'Último usuario que modificó la historia clínica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."FECHA_MODIFICACION" IS 'Última Fecha  en la que se modificó la historia clínica '
;






-- Create tables section -------------------------------------------------

-- Table HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA

CREATE TABLE "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"(
  "ALIMEN_PEDIATRICA_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "LACTANCIA_EXCLUSIVA" Number(10,0),
  "LACTANCIA_MIXTA" Number(10,0),
  "DURACION_LACT_MIXTA" Number(10,0),
  "DURACION_LACT_EXCLUSIVA" Number(10,0),
  "ABLACTACION" Varchar2(1000 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA

ALTER TABLE "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA" ADD CONSTRAINT "PK_SNH_MST_ALIMEN_PEDIATRICA" PRIMARY KEY ("ALIMEN_PEDIATRICA_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA" IS 'Esta tabla almacena los datos de la sección de alimentación pediátrica de la historia Clínica Pediátrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."ALIMEN_PEDIATRICA_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la Tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."LACTANCIA_EXCLUSIVA" IS 'Catalogo Prestablecido para conocer si la Lactancia fue Exclusiva, los valores SI;NO'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."LACTANCIA_MIXTA" IS 'Catalogo Prestablecido para conocer si la Lactancia fue Mixta, los valores SI;NO'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."DURACION_LACT_MIXTA" IS 'Duración de Lactancia Mixta en meses'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."DURACION_LACT_EXCLUSIVA" IS 'Duración de Lactancia Exclusiva en meses'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."ABLACTACION" IS 'Descripción del proceso de Ablactación'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."ESTADO_REGISTRO" IS 'Catalogo prestablecido del estado del registro de Alimentación pediátrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."USUARIO_REGISTRO" IS 'Usuario que agregó la alimentación pediátrica '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."FECHA_REGISTRO" IS 'Fecha en la que se agregó la alimentación pediátrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."USUARIO_MODIFICACION" IS 'Ultimo Usuario que modificó los datos de alimentación pediátrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."FECHA_MODIFICACION" IS 'Ultima Fecha que se Modificó el datos de alimentación pediátrica'
;


-- Table HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR

CREATE TABLE "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"(
  "ANTE_PSICOMOTOR_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "TIPO_DESARROLLO" Number(10,0) NOT NULL,
  "CONFIRMA_DESARROLLO" Number(10,0) NOT NULL,
  "EDAD" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR" ADD CONSTRAINT "PK_SNH_MST_ANTE_PSICOMOTOR" PRIMARY KEY ("ANTE_PSICOMOTOR_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR" IS 'Esta tabla almacena los datos de la sección Desarrollo psicomotor de la historia clínica pediatrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."ANTE_PSICOMOTOR_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."TIPO_DESARROLLO" IS 'Catalogo prestablecido del tipo de desarrollo que  se está describiendo. Ejemplo Fijó la mirada, sostuvo la cabeza, gateó, Caminó, Se proyectó etc.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."CONFIRMA_DESARROLLO" IS 'Catalogo Prestablecido con valores si/no para indicar que si presentó el tipo de desarrollo agregado'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."EDAD" IS 'Edad en la que presentó el desarrollo psicomotor. '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."ESTADO_REGISTRO" IS 'Catalogo prestablecido con posibles valores de estado de registro'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."USUARIO_REGISTRO" IS 'Usuario que agregó los datos de desarrollo psicomotor en la historia clínica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."FECHA_REGISTRO" IS 'Fecha en la que se agregó el registro de desarrollo psicomotor'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."USUARIO_MODIFICACION" IS 'Ultimo usuario que modificó los datos de desarrollo psicomotor'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."FECHA_MODIFICACION" IS 'Ultima Fecha que se modificó los datos de desarrollo psicomotor'
;


-- Table HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO

CREATE TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"(
  "ANTE_SOCIOECONOMICO_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "CASA" Number(10,0),
  "PAREDES" Number(10,0),
  "PISO" Number(10,0),
  "TECHO" Number(10,0),
  "SERVICIOS_HIGIENICOS" Varchar2(50 ),
  "HABITACIONES" Number(10,0),
  "AGUA" Number(10,0),
  "LUGAR_AGUA" Number(10,0),
  "LUZ" Number(10,0),
  "LUGAR_EXCRETAS" Number(10,0),
  "NUMERO_PERSONAS" Number(10,0),
  "ANIMALES" Number(10,0),
  "TELEFONO" Number(10,0),
  "OBSERVACIONES" Varchar2(250 ),
  "OTROS" Varchar2(1000 ),
  "HACIMIENTO" Number,
  "ESTADO_REGISTRO" Number NOT NULL,
  "USUARIO_REGISTRO" Number NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number,
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "PK_SNH_MST_ANTE_SOCIOECONOMICO" PRIMARY KEY ("ANTE_SOCIOECONOMICO_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" IS 'Esta Tabla almacena los antecedentes socioeconomicos de la historia clinica pediatrica y los datos de la vivivienda de la historia clínica de adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."ANTE_SOCIOECONOMICO_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."CASA" IS 'Catalogo Prestablecido Tipo de casa en la que habita'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."PAREDES" IS 'Catalogo Prestablecido tipo de paredes de la casa en la que habita'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."PISO" IS 'Catalogo Prestablecido tipo de piso de la vivienda en la que habita. ejemplo ladrillo, tierra, embaldosado etc'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."TECHO" IS 'Catalogo Prestablecido tipo de techo de la vivienda en la que habita, ejmplo zinc teja, paja etc.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."SERVICIOS_HIGIENICOS" IS 'Descripción Servicios higiénicos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."HABITACIONES" IS 'Numero de habitaciones de la vivienda en la que habita'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."AGUA" IS 'Catalogo prestablecido con posible valor si/no que indica si tiene servicio de agua en la vivienda'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."LUGAR_AGUA" IS 'Catalogo Prestablecido para indicar si el agua la tiene en casa o fuera de casa'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."LUZ" IS 'Catalogo prestablecido con posible valor si; no que indica si tiene servicio de luz. Aplica para la historia de adolescentes y pediatrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."LUGAR_EXCRETAS" IS 'Catalogo Prestablecido que indica que lugar excreta si en el hogar o fuera del hogar'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."NUMERO_PERSONAS" IS 'Numero de personas con la que convive'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."ANIMALES" IS 'Catalogo Prestablecido que indica si en el hogar hay animales si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."TELEFONO" IS 'Numero de Teléfono de la vivienda'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."OBSERVACIONES" IS 'Observaciones de los antecedentes socioeconómicos, aplica tanto para la historia clinica de adolescente como la pediátrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."OTROS" IS 'Otro Indicador socioeconómico '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."HACIMIENTO" IS 'Catalogo prestablecido para indicar si está en hacimiento si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."ESTADO_REGISTRO" IS 'Catalogo Prestablecido estado del registro de antecedentes socioeconómicos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."USUARIO_REGISTRO" IS 'Usuario que agregó los antecedentes socioeconómicos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."FECHA_REGISTRO" IS 'Fecha en que se agregaron los antecedentes socioeconómicos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."USUARIO_MODIFICACION" IS 'Último usuario que modificó los antecendentes socioeconómicos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."FECHA_MODIFICACION" IS 'Última Fecha en la que se modificó los antecedentes socioeconómicos'
;

-- Table HOSPITALARIO.SNH_DET_HISTORIA_CLINICA

CREATE TABLE "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"(
  "DET_HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "OBSERVACIONES" Varchar2(250 ),
  "DIAGNOSTICO" Varchar2(250 ),
  "INTERCONSULTAS" Varchar2(1000 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_DET_HISTORIA_CLINICA

ALTER TABLE "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA" ADD CONSTRAINT "PK_SNH_DET_HISTORIA_CLINICA" PRIMARY KEY ("DET_HISTORIA_CLINICA_ID")
;

-- Table and Columns comments section

COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."DET_HISTORIA_CLINICA_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."OBSERVACIONES" IS 'Observaciones de la historia Clínica, aplica para todas las historias clínicas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."DIAGNOSTICO" IS 'Diagnóstico relevante de la historia clínica. Aplica para todas la historias clínicas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."INTERCONSULTAS" IS 'Datos de indicaciones e interconsultas. Aplica solo para la historia clínica de adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."ESTADO_REGISTRO" IS 'Estado del registro, el valor 1 indica que esta activo, el valor 0 indica que está inactivo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."USUARIO_REGISTRO" IS 'Usuario con el que se realizó la historia clinica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."FECHA_REGISTRO" IS 'Fecha en la que se guardó la historia clínica '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."USUARIO_MODIFICACION" IS 'Ultimo Usuario que modificó la historia clínica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."FECHA_MODIFICACION" IS 'Última Fecha  en la que se modificó la historia clínica'
;
-- Table HOSPITALARIO.SNH_MST_VACUNAS

CREATE TABLE "HOSPITALARIO"."SNH_MST_VACUNAS"(
  "VACUNAS_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "TIPO_VACUNA" Number(10,0),
  "DOSIS" Number(10,0),
  "FECHA_DOSIS" Date,
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_VACUNAS

ALTER TABLE "HOSPITALARIO"."SNH_MST_VACUNAS" ADD CONSTRAINT "PK_SNH_MST_VACUNAS" PRIMARY KEY ("VACUNAS_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_VACUNAS" IS 'Esta tabla almacena los datos de vacunas correspondiente a la historia clínica pediátrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."VACUNAS_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."TIPO_VACUNA" IS 'Catalogo Predefinido del tipo de vacuna'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."DOSIS" IS 'Catalogo Predefinido del numero de dosis de la vacuna'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."FECHA_DOSIS" IS 'Fecha en la que se aplicó la dosis'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."ESTADO_REGISTRO" IS 'Catalogo Predefinido del Estado del registro de vacunas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."USUARIO_REGISTRO" IS 'Usuario que registró la vacuna'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."FECHA_REGISTRO" IS 'Fecha en la que se registró la vacuna'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."USUARIO_MODIFICACION" IS 'Último usuario que modificó el registro de vacunas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VACUNAS"."FECHA_MODIFICACION" IS 'Última Fecha de modificación del registro de Vacunas'
;




-- Table HOSPITALARIO.SNH_MST_ANTE_PARTO

CREATE TABLE "HOSPITALARIO"."SNH_MST_ANTE_PARTO"(
  "ANTE_PARTO_ID" Number(19,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "LUGAR_PARTO" Number,
  "FECHA_NACIMIENTO" Date,
  "EDAD_GESTACIONAL" Number,
  "DURACION_PARTO" Number,
  "ATENCION_PARTO" Number,
  "VIA" Number,
  "PRESENTACION" Varchar2(250 ),
  "EVENTUALIDADES" Varchar2(1000 ),
  "ESTADO_REGISTRO" Number NOT NULL,
  "USUARIO_REGISTRO" Number NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number,
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ANTE_PARTO

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PARTO" ADD CONSTRAINT "PK_SNH_MST_ANTE_PARTO" PRIMARY KEY ("ANTE_PARTO_ID")
;

-- Table and Columns comments section

COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."ANTE_PARTO_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."LUGAR_PARTO" IS 'Catalogo, lugar donde sucedió el parto si en un domicilio o en una institución. Aplica solo para la Historia Clínica Pediátrica INSTITUCIONAL / DOMICILIAR'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."FECHA_NACIMIENTO*" IS 'Fecha en la que nació el paciente. Aplica solo para la historia Clinica Pediátrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."EDAD_GESTACIONAL" IS 'Edad Gestacional en Semanas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."DURACION_PARTO" IS 'Duracion de parto en horas '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."ATENCION_PARTO" IS 'Catalogo, personal que atendió el parto. Ejemplo Atención Multiple, Medico General, Partera etc'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."VIA" IS 'Catologo, la vía en la que se realizó el parto, ejemplo vaginal o cesarea'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."PRESENTACION" IS 'Descripción de Presentación'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."EVENTUALIDADES" IS 'Descripción de Eventualidades del parto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."ESTADO_REGISTRO" IS 'Estado del registro, el valor 1 indica que esta activo, el valor 0 indica que está inactivo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."USUARIO_REGISTRO" IS 'Usuario con el que se agregaron los antecedentes del Parto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."FECHA_REGISTRO" IS 'Fecha en la que se guardaron los antecedentes del Parto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."USUARIO_MODIFICACION" IS 'Ultimo Usuario que modificó los antecedentes del Parto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PARTO"."FECHA_MODIFICACION" IS 'Última Fecha  en la que se modificó los antecedentes del Parto'
;


-- Table HOSPITALARIO.SNH_MST_ANTE_POSTNATALES

CREATE TABLE "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"(
  "ANTE_POSTNATALES_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "APGAR1" Number(10,0),
  "APGAR5" Number(10,0),
  "PESO" Number(10,2),
  "TALLA" Number(10,2),
  "ASFIXIA" Number(10,0),
  "DESCRIPCION_ASFIXIA" Varchar2(1000 ),
  "ALOJAMIENTO_CONJUNTO" Number(10,0),
  "TIEMPO_MADRE" Number(10,0),
  "HORAS_MADRE" Number(10,0),
  "HOSPITALIZACION" Varchar2(1000 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ANTE_POSTNATALES

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES" ADD CONSTRAINT "PK_SNH_MST_ANTE_POSTNATALES" PRIMARY KEY ("ANTE_POSTNATALES_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES" IS 'Esta tabla almacena los datos de la sección de antecedentes postnatales de la historia clínica pediátrica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."ANTE_POSTNATALES_ID" IS 'Llave Primaria'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."HISTORIA_CLINICA_ID" IS 'Llave Foránea Tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."APGAR1" IS 'Prueba apgar primer minuto despues del nacimiento'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."APGAR5" IS 'Prueba apgar quinto minuto despues del nacimiento'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."PESO" IS 'Peso en Gramos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."TALLA" IS 'Talla en Centimetros'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."ASFIXIA" IS 'Catalogo prestablecido con posibles respuestas de Sí/No.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."DESCRIPCION_ASFIXIA" IS 'Descripción de Asfixia'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."ALOJAMIENTO_CONJUNTO" IS 'Catalogo prestablecido con posibles respuestas Si/No'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."TIEMPO_MADRE" IS 'Catalogo Prestablecido el tiempo puede ser Permanente o Transitorio'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."HORAS_MADRE" IS 'Cantidad de Horas que pasó con la Madre'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."HOSPITALIZACION" IS 'Descripción de Hospitalización el lugar y el Tiempo '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."ESTADO_REGISTRO" IS 'Catalogo Prestablecido del Estado del Registro, posibles valores Activo, Inactivo, Pasivado etc'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."USUARIO_REGISTRO" IS 'Usuario que agregó los antecedentes postnatales	'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."FECHA_REGISTRO" IS 'Fecha en que se crearon los antecedentes postnatales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."USUARIO_MODIFICACION" IS 'Ultimo Usuario que modificó los antecedentes Postnatales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."FECHA_MODIFICACION" IS 'Ultima Fecha de Modificación de los antecedentes postnatales'
;
