
-- Table HOSPITALARIO.SNH_MST_ENFER_FAMILIARES

CREATE TABLE "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"(
  "ENFER_FAMILIARES_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "TIPO_ENFERMEDAD" Number(10,0),
  "VALOR_ENFERMEDAD" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ENFER_FAMILIARES

ALTER TABLE "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES" ADD CONSTRAINT "PK_SNH_MST_ENFER_FAMILIARES" PRIMARY KEY ("ENFER_FAMILIARES_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES" IS 'Esta tabla almacena los datos de los antecedentes familiares correspondientes a la seccion Antecedentes familiares de la historia clínica del adolescente y antecedentes familiares patológicos de la historia clínica del adulto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"."ENFER_FAMILIARES_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"."TIPO_ENFERMEDAD" IS 'Catalogo Predefinido del tipo de enfermedad '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"."VALOR_ENFERMEDAD" IS 'Catalogo Predefinido de las enfermedades de acuerdo al tipo de enfermedad'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"."ESTADO_REGISTRO" IS 'Catalogo Predefinido del estado del registro de los antecedentes de las enfermedades familiares '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"."USUARIO_REGISTRO" IS 'Usuario que registró los datos de  los antecedentes de las enfermedades familiares'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"."FECHA_REGISTRO" IS 'Fecha en la  que se registró los datos de  los antecedentes de las enfermedades familiares'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"."USUARIO_MODIFICACION" IS 'Último usuario que modificó   los datos de  los antecedentes de las enfermedades familiares'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ENFER_FAMILIARES"."FECHA_MODIFICACION" IS 'Última fecha en la que se modificaron  los datos de  los antecedentes de las enfermedades familiares'
;
