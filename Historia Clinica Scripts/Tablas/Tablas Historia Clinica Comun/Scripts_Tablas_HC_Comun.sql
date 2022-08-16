-- Table HOSPITALARIO.SNH_MST_ANTE_ENFERMEDADES

CREATE TABLE "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"(
  "ANTE_PATOLOGICOS_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "TIPO_ANTECEDENTE" Number(10,0) NOT NULL,
  "VALOR_ANTECEDENTE" Varchar2(1000 ) NOT NULL,
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ANTE_ENFERMEDADES

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS" ADD CONSTRAINT "PK_SNH_MST_ANTE_PATOLOGICOS" PRIMARY KEY ("ANTE_PATOLOGICOS_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS" IS 'Esta Tabla almacena los antecedentes personales patológicos los cuales corresponden a las enfermedades padecidas por el paciente ademas de las cirugías u hospitalizaciones que ha tenido. Aplica para la historia clínica pediatrica, adolescente, y de adulto. En la historia clínica la seccion corresponde a los antecedentes personales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"."ANTE_PATOLOGICOS_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la tabla de SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"."TIPO_ANTECEDENTE" IS 'Catalogo predefinido del tipo de antecedente personal patológico: Enfermedades infectocontagiosas, Enfermedades cronicas, cirugias u hospitalizaciones'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"."VALOR_ANTECEDENTE" IS 'Descripción del tipo de Enfermedad. '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"."ESTADO_REGISTRO" IS 'Catalogo Predefinido del estado de los datos de los antecedentes de enfermedades'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"."USUARIO_REGISTRO" IS 'Usuario que agregó los antecedentes de Enfermedades'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"."FECHA_REGISTRO" IS 'Fecha en la que se agregó los antecedentes de Enfermedades'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"."USUARIO_MODIFICACION" IS 'Último usuario que modificó los antecedentes de Enfermedades'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PATOLOGICOS"."FECHA_MODIFICACION" IS 'Última Fecha en la que se modificaron los antecedentes de enfermedades'
;


-- Table HOSPITALARIO.SNH_REL_HIST_LABORAL

CREATE TABLE "HOSPITALARIO"."SNH_REL_HIST_LABORAL"(
  "HIST_LABORAL_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_REL_HIST_LABORAL

ALTER TABLE "HOSPITALARIO"."SNH_REL_HIST_LABORAL" ADD CONSTRAINT "PK_SNH_REL_HIST_LABORAL" PRIMARY KEY ("HIST_LABORAL_ID")
;

-- Table and Columns comments section

COMMENT ON COLUMN "HOSPITALARIO"."SNH_REL_HIST_LABORAL"."HIST_LABORAL_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_REL_HIST_LABORAL"."HISTORIA_CLINICA_ID" IS 'Llave Foranea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_REL_HIST_LABORAL"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del Registro '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_REL_HIST_LABORAL"."USUARIO_REGISTRO" IS 'Usuario que registró la historia Laboral'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_REL_HIST_LABORAL"."FECHA_REGISTRO" IS 'Fecha en la que se registró la historia Laboral'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_REL_HIST_LABORAL"."USUARIO_MODIFICACION" IS 'Ultimo usuario que modificó el registro de historia laboral'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_REL_HIST_LABORAL"."FECHA_MODIFICACION" IS 'Última Fecha en la que se modifico el registo de Historia Laboral'
;

-- Table HOSPITALARIO.SNH_DET_HIST_LABORAL

CREATE TABLE "HOSPITALARIO"."SNH_DET_HIST_LABORAL"(
  "DETALLE_HIST_LABORAL" Number(10,0) NOT NULL,
  "HIST_LABORAL_ID" Number(10,0),
  "ACTIVIDAD_ID" Number(38,0) NOT NULL,
  "LUGAR_TRABAJO" Varchar2(250 ),
  "AREA_TRABAJO" Varchar2(250 ),
  "EDAD_INICIO" Number(10,0),
  "FECHA_INICIO" Date,
  "FECHA_FIN" Date,
  "TIPO_TRABAJO" Varchar2(1000 ),
  "HORAS_SEMANA" Number(10,0),
  "DIAS_LABORAL" Number(10,0),
  "HORAS_DIA" Number(10,0),
  "HORARIO_TRABAJO" Number(10,0),
  "HORAS_EXTRAS" Number(10,0),
  "TRABAJO_ACTUAL" Number(10,0),
  "TRABAJO_INFANTIL" Number(10,0),
  "TRABAJO_JUVENIL" Number(10,0),
  "TRABAJO_LEGALIZADO" Number(10,0),
  "TRABAJO_INSALUBRE" Number(10,0),
  "RAZON_TRABAJO" Number(10,0),
  "FRECUENCIA_TAREA" Varchar2(100 ),
  "EXPOSICION" Number(10,0),
  "EXPOSICION_DESCRIPCION" Varchar2(1000 ),
  "POSICION" Varchar2(100 ),
  "TRABAJO_FUERA" Number(10,0),
  "OBSERVACIONES" Varchar2(250 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_DET_HIST_LABORAL

ALTER TABLE "HOSPITALARIO"."SNH_DET_HIST_LABORAL" ADD CONSTRAINT "PK_SNH_DET_HIST_LABORAL" PRIMARY KEY ("DETALLE_HIST_LABORAL")
;

-- Table and Columns comments section

COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."DETALLE_HIST_LABORAL" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."HIST_LABORAL_ID" IS 'Llave Foránea de la tabla SNH_REL_HIST_LABORAL'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."ACTIVIDAD_ID" IS 'Catalogo Predefinido que indica la ocupacion '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."LUGAR_TRABAJO" IS 'Descripcion del lugar de Trabajo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."AREA_TRABAJO" IS 'Descripción area de Trabajo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."EDAD_INICIO" IS 'Edad en la que inició a trabajar'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."FECHA_INICIO" IS 'Fecha de inicio del Trabajo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."FECHA_FIN" IS 'Fecha Fin del Trabajo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."TIPO_TRABAJO" IS 'Descripción Tipo de Trabajo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."HORAS_SEMANA" IS 'Cantidad de horas trabajadas por semana'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."DIAS_LABORAL" IS 'Cantidad de dias laborados en la semana'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."HORAS_DIA" IS 'Cantidad de horas trabajadas al dia '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."HORARIO_TRABAJO" IS 'Catalogo Predefinido que indica el tipo de horario de trabajo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."HORAS_EXTRAS" IS 'Cantidad de Horas extras Trabajadas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."TRABAJO_ACTUAL" IS 'Catalogo Predefinido que indica si el trabajo registrado corresponde al actual, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."TRABAJO_INFANTIL" IS 'Catalogo Predefinido que indica si el trabajo es infantil, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."TRABAJO_JUVENIL" IS 'Catalogo Predefinido que indica si el trabajo es juvenil, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."TRABAJO_LEGALIZADO" IS 'Catalogo Predefinido que indica si el trabajo es legalizado,  siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."TRABAJO_INSALUBRE" IS 'Catalogo Predefinido que indica si el trabajo es insalubrel, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."RAZON_TRABAJO" IS 'Catalogo Predefinido que indica la razón del trabajo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."FRECUENCIA_TAREA" IS 'Descripcion de la Frecuencia de la tarea'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."EXPOSICION" IS 'Catalogo Predefinido que indica si está expuesto a sustancias materiales u otros productos, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."EXPOSICION_DESCRIPCION" IS 'Descripción de las sustancias, materiales u otros productos a los que está expuesto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."POSICION" IS 'Descripcion de la posición adoptada en su trabajo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."TRABAJO_FUERA" IS 'Catalogo predefinido de  Trabajos fuera del empleo habitual'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."OBSERVACIONES" IS 'Observaciones de la historia laboral'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."ESTADO_REGISTRO" IS 'Catalogo Predefinido del Estado del registro de la historia laboral'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."USUARIO_REGISTRO" IS 'Usuario que registro el detalle de la historia Laboral'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."FECHA_REGISTRO" IS 'Fecha en la que se registró la historia Laboral'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."USUARIO_MODIFICACION" IS 'Último usuario de modificación de la historia laboral'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HIST_LABORAL"."FECHA_MODIFICACION" IS 'Última Fecha de modificacion de la historia laboral'
;


-- Table HOSPITALARIO.SNH_MST_EXAMEN_FISICO

CREATE TABLE "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"(
  "EXAMEN_FISICO_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "FRECUENCIA_CARDIACA" Number(10,0),
  "FRECUENCIA_RESPIRATORIA" Number(10,0),
  "TENSION_ARTERIAL" Number(10,0),
  "TEMPERATURA" Number(10,0),
  "PESO" Number(10,2),
  "TALLA" Number(10,2),
  "IMC" Number(10,0),
  "PERIMETRO_CEFALICO" Number(10,0),
  "PERIMETRO_TORACICO" Number(10,0),
  "PERIMETRO_ABDOMINAL" Number(10,0),
  "SUPERFICIE_CORPORAL" Number(10,0),
  "ASPECTO_GENERAL" Varchar2(250 ),
  "PIEL_MUCOSAS" Varchar2(250 ),
  "CRANEO" Varchar2(250 ),
  "CUERO_CABELLUDO" Varchar2(250 ),
  "OJOS" Varchar2(250 ),
  "OREJAS_OIDOS" Varchar2(250 ),
  "NARIZ" Varchar2(250 ),
  "BOCA" Varchar2(250 ),
  "CUELLO" Varchar2(250 ),
  "CAJA_TORACICA" Varchar2(250 ),
  "MAMAS" Varchar2(250 ),
  "CAMPOS_PULMONARES" Varchar2(250 ),
  "CARDIACO" Varchar2(250 ),
  "ABDOMEN_PELVIS" Varchar2(250 ),
  "ANO_RECTO" Varchar2(250 ),
  "EXT_SUPERIORES" Varchar2(250 ),
  "EXT_INFERIORES" Varchar2(250 ),
  "EXAMEN_GINECOLOGICO" Varchar2(250 ),
  "EXAMEN_NEUROLOGICO" Varchar2(250 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_EXAMEN_FISICO

ALTER TABLE "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO" ADD CONSTRAINT "PK_SNH_MST_EXAMEN_FISICO" PRIMARY KEY ("EXAMEN_FISICO_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO" IS 'Esta tabla almacena los datos de los examenes fisicos realizados al paciente. Aplica para la historia clínica pediátrica y del adulto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."EXAMEN_FISICO_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."FRECUENCIA_CARDIACA" IS 'Frecuencia Cardíaca'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."FRECUENCIA_RESPIRATORIA" IS 'Frecuencia Respiratoria'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."TENSION_ARTERIAL" IS 'Tensión arterial'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."TEMPERATURA" IS 'Temperatura'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."PESO" IS 'Peso en Kilogramos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."TALLA" IS 'Talla Centimetros'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."IMC" IS 'Indice de masa corporal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."PERIMETRO_CEFALICO" IS 'Medición del perímetro de la cabeza del niño'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."PERIMETRO_TORACICO" IS 'Medición torax'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."PERIMETRO_ABDOMINAL" IS 'Medición perímetro abdominal	'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."SUPERFICIE_CORPORAL" IS 'Medición Superficie Corporal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."ASPECTO_GENERAL" IS 'Descripción Aspecto General'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."PIEL_MUCOSAS" IS 'Descripción Piel y Mucosas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."CRANEO" IS 'Descripción  cráneo '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."CUERO_CABELLUDO" IS 'Descripción Cuero Cabelludo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."OJOS" IS 'Descripción Ojos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."OREJAS_OIDOS" IS 'Descripción orejas;oiddos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."NARIZ" IS 'Descripción Nariz'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."BOCA" IS 'Descripción Boca'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."CUELLO" IS 'Descripción Cuello'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."CAJA_TORACICA" IS 'Descripción caja Toracica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."MAMAS" IS 'Descripción mamas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."CAMPOS_PULMONARES" IS 'Descripción Campos pulmonares'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."CARDIACO" IS 'Descripción cardíaco'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."ABDOMEN_PELVIS" IS 'Descripción Abdomen Pelvis'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."ANO_RECTO" IS 'Descripción Ano;Recto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."EXT_SUPERIORES" IS 'Descripción Extremidades Superiores'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."EXT_INFERIORES" IS 'Descripción Extremidades Inferiores'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."EXAMEN_GINECOLOGICO" IS 'Descripción Examen Ginecológico'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."EXAMEN_NEUROLOGICO" IS 'Descripción Examen Neurologico'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."ESTADO_REGISTRO" IS 'Catalogo Prestablecido Estado de los datos de Examen fisico'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."USUARIO_REGISTRO" IS 'Usuario que agregó los datos del examen fisico'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."FECHA_REGISTRO" IS 'Fecha en que se agregaron los datos del examen fisico'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."USUARIO_MODIFICACION" IS 'Ultimo Usuario que modificó los datos de Examen Fisico'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_FISICO"."FECHA_MODIFICACION" IS 'Ultima fecha en la que se modificaron los datos de Examen Físico'
;

-- Table HOSPITALARIO.SNH_MST_HIST_SERVICIOS

CREATE TABLE "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"(
  "HIST_CONSULTA_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "ADMISION_SERVICIO_ID" Number(10,0),
  "FECHA_SERVICIO" Date,
  "MOTIVO_CONSULTA" Varchar2(250 ),
  "OBSERVACIONES" Varchar2(250 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_HIST_SERVICIOS

ALTER TABLE "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS" ADD CONSTRAINT "PK_SNH_MST_HIST_SERVICIOS" PRIMARY KEY ("HIST_CONSULTA_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS" IS 'Esta tabla almacena los datos de los servicios que ha solicitado un paciente y que han sido agregados a la historia clínica debido a su relevancia '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."HIST_CONSULTA_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."ADMISION_SERVICIO_ID" IS 'Llave foránea de la tabla SNH_MST_ADMISION_SERVICIOS'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."FECHA_SERVICIO" IS 'Fecha en la que se le realizó servicio al paciente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."MOTIVO_CONSULTA" IS 'Descripción del motivo de la consulta'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."OBSERVACIONES" IS 'Observaciones relevantes del servicio prestado'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."ESTADO_REGISTRO" IS 'Catalogo prestablecido del estado del historico de servicios'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."USUARIO_REGISTRO" IS 'Usuario que agregó el historico de servicios'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."FECHA_REGISTRO" IS 'Fecha en la que se agregó el historico de servicios'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."USUARIO_MODIFICACION" IS 'Ultimo usuario que modificó el historico de servicios'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HIST_SERVICIOS"."FECHA_MODIFICACION" IS 'Ultima Fecha de modificación del historico de servicios'
;

-- Table HOSPITALARIO.SNH_MST_ANT_GINECOOBSTETRICO

CREATE TABLE "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"(
  "ANT_GINECOOBSTETRICO_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "INICIO_VIDA_SEXUAL" Number(10,0),
  "NUMERO_COMPAÑEROS" Number(10,0),
  "MENARCA_ANNIOS" Number(10,0),
  "MENARCA_MESES" Number(10,0),
  "FUR_CONOCE" Number(10,0),
  "FUR_FECHA" Date,
  "CICLOS_REGULARES" Number(10,0),
  "DISMERROREA" Number(10,0),
  "SEMANA_AMENORREA" Number(10,2),
  "MENOPAUSIA" Number(10,0),
  "FECHA_MENOPAUSIA" Date,
  "ITS_TRATAMIENTO" Number(10,0),
  "TRATAMIENTO_CONTACTO" Number(10,0),
  "SUSTITUCION_HORMONAL" Number(10,0),
  "SITUACION_HORMONAL_DESCR" Varchar2(250 ),
  "PAP" Number(10,0),
  "PAP_RESULTADO" Varchar2(250 ),
  "PAP_ULTIMAFECHA" Date,
  "GESTA" Number(10,0),
  "PARA" Number(10,0),
  "CESAREA" Number(10,0),
  "HIJOS" Number(10,0),
  "ABORTO" Number(10,0),
  "LEGRADO" Number(10,0),
  "ITS" Number(10,0),
  "ITS_DESCRIPCION" Varchar2(1000 ),
  "BUSQUEDA_CONTACTO" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ANT_GINECOOBSTETRICO

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO" ADD CONSTRAINT "PK_SNH_MST_ANT_GINECOOBSTETRICO" PRIMARY KEY ("ANT_GINECOOBSTETRICO_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO" IS 'Esta Tabla almacena los antecedentes ginecoobstétricos y aplica para la historia clinica de adolescente y para la historia clínica del adulto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."ANT_GINECOOBSTETRICO_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."INICIO_VIDA_SEXUAL" IS 'Edad que inició su vida sexual'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."NUMERO_COMPAÑEROS" IS 'Numero de compañeros sexuales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."MENARCA_ANNIOS" IS 'Edad en años del primer periodo menstrual'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."MENARCA_MESES" IS 'Edad en meses del primer periodo menstrual'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."FUR_CONOCE" IS 'Catalogo predefinido que indica si recuerda la ultima fecha de la menstruación o si no la recuerda, siendo los posibles valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."FUR_FECHA" IS 'Fecha de la ultima mestruación '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."CICLOS_REGULARES" IS 'Catalogo predefinido que indica si tiene ciclos regulares o no, siendo los posibles valores si/no
'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."DISMERROREA" IS 'Catalogo predefinido que indica si tiene disminorrea siendo los posibles valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."SEMANA_AMENORREA" IS 'Cantidad de semanas con amenorrea'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."MENOPAUSIA" IS 'Catalogo predefinicio que indica si llego menopausia, siendo los posibles valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."FECHA_MENOPAUSIA" IS 'Fecha en que llegó la menopausia'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."ITS_TRATAMIENTO" IS 'Catalogo predefinido que indica si esta en tratamiento de its, siendo los posibles valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."TRATAMIENTO_CONTACTO" IS 'Catalogo predefinido que indica si el contacto esta en tratamiento, siendo los posibles valores si/no.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."SUSTITUCION_HORMONAL" IS 'Catalogo predefinido que indica si el contacto esta en tratamiento, siendo los posibles valores si/no.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."SITUACION_HORMONAL_DESCR" IS 'Descripción de la situación hormonal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."PAP" IS 'Catalogo predefinido que indica si se hizo pap, siendo los posibles valores si/no.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."PAP_RESULTADO" IS 'Resultado del pap'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."PAP_ULTIMAFECHA" IS 'Fecha del ultimo pap realizado'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."GESTA" IS 'Numero de gesta que ha tenido'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."PARA" IS 'Numero de veces que ha dado a luz'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."CESAREA" IS 'Numero de cesareas realizadas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."HIJOS" IS 'Numero de hijos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."ABORTO" IS 'Numero de abortos que ha tenido'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."LEGRADO" IS 'Numero de legrados que ha tenido'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."ITS" IS 'Catalogo predefinido que indica si tiene enfermedades ITS, siendo los posibles valores si/no.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."ITS_DESCRIPCION" IS 'Descripción de Enfermedades ITS'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."BUSQUEDA_CONTACTO" IS 'Catalogo Predefinido que indica si se buscó al contacto, siendo los posibles valores, si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado de los antecedentes gineco-obstétricos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."USUARIO_REGISTRO" IS 'Usuario que agregó los datos de antecedentes gineco-obstétricos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."FECHA_REGISTRO" IS 'Fecha en la que se guardaron los datos de los antecedentes gineco-obstétricos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."USUARIO_MODIFICACION" IS 'Último usuario que realizó modificación en los antecedentes gineco-obstétricos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_GINECOOBSTETRICO"."FECHA_MODIFICACION" IS 'Última Fecha en la que se modificaron los antecedentes gineco-obstétricos'
;


-- Table HOSPITALARIO.SNH_MST_SEXUALIDAD

CREATE TABLE "HOSPITALARIO"."SNH_MST_SEXUALIDAD"(
  "SEXUALIDAD_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "RELACIONES_SEXUALES" Number(10,0),
  "PAREJA_SEXUAL" Number(10,0),
  "EDAD_INICIO_SEXUAL" Number(10,0),
  "RELACION_COERCION" Number(10,0),
  "DIFICULTAD_RELACION" Number(10,0),
  "USO_ANTICONCEPTIVOS" Number(10,0),
  "USO_CONDON" Number(10,0),
  "TIPO_METODO" Number(10,0),
  "CONSEJERIA" Number(10,0),
  "ACO_EMERGENCIA" Number(10,0),
  "ACO_EMERGENCIA_NO" Number(10,0),
  "PRUEBA_VIH" Number(10,0),
  "CONSEJERIA_VIH" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_SEXUALIDAD

ALTER TABLE "HOSPITALARIO"."SNH_MST_SEXUALIDAD" ADD CONSTRAINT "PK_SNH_MST_SEXUALIDAD" PRIMARY KEY ("SEXUALIDAD_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_SEXUALIDAD" IS 'Esta tabla almacena los datos de sexualidad correspondiente a  la historia clínica del adolescente. '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."SEXUALIDAD_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."RELACIONES_SEXUALES" IS 'Catalogo Predefinido que indica el tipo de relaciones sexuales que tiene , siendo los valores no, hetero, homo, ambas'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."PAREJA_SEXUAL" IS 'Catalogo Predefinido que indica si tiene una pareja única, varias o no descrito.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."EDAD_INICIO_SEXUAL" IS 'Edad en años en que inició su vida sexual'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."RELACION_COERCION" IS 'Catalogo Predefinido que indica si mantiene relaciones bajo coerción, siendo los valores si ; no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."DIFICULTAD_RELACION" IS 'Catalogo Predefinido que indica si tiene dificultad en las relaciones sexuales siendo los valores si;no
'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."USO_ANTICONCEPTIVOS" IS 'Catalogo Predefinido que indica si usa anticonceptivos, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."USO_CONDON" IS 'Catalogo Predefinido que indica si usa condon o no, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."TIPO_METODO" IS 'Catalogo Predefinido que indica el tipo de metodo anticonceptivo que usa.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."CONSEJERIA" IS 'Catalogo Predefinido que indica si recibe consejeria, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."ACO_EMERGENCIA" IS 'Catalogo Predefinido que indica si uso anticonceptivos de emergencias, siendo los posibles valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."ACO_EMERGENCIA_NO" IS 'Numero de anticonceptivos de emergencia'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."PRUEBA_VIH" IS 'Catalogo Predefinido que indica si se realizó una prueba de VIH, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."CONSEJERIA_VIH" IS 'Catalogo Predefinido que indica si recibe consejeria vih siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el  estado de los datos de sexualidad'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."USUARIO_REGISTRO" IS 'Usuario que agregó los datos de sexualidad '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."FECHA_REGISTRO" IS 'Fecha en la que se guardaron los datos de sexualidad'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."USUARIO_MODIFICACION" IS 'Última Usuario que modificó  de los datos de sexualidad'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_SEXUALIDAD"."FECHA_MODIFICACION" IS 'Última Fecha de modificación de los datos de sexualidad'
;

-- Table HOSPITALARIO.SNH_MST_HABITOS

CREATE TABLE "HOSPITALARIO"."SNH_MST_HABITOS"(
  "HABITOS_ID" Number NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "INMUNIZACION_COMPLETA" Number(10,0),
  "SUENO_NORMAL" Number(10,0),
  "HORAS_SUENO" Number(10,0),
  "ALIMENTACION_ADECUADA" Number(10,0),
  "COMIDAS_DIA" Number(10,0),
  "COMIDAS_DIA_FAMILIA" Number(10,0),
  "CONDUCE_VEHICULO" Number(10,0),
  "DESCRIPCION_VEHICULO" Varchar2(250 ),
  "SEGURIDAD_VIAL" Number(10,0),
  "TIPO_ACTIVIDAD_FISICA" Number(10,0),
  "HORAS_ACTIVIDAD" Varchar2(30 ),
  "HORAS_TV" Number(10,0),
  "HORAS_JUEGOS_VIRTUALES" Number(10,0),
  "OTROS_HABITOS" Varchar2(250 ),
  "OTRAS_ACTIVIDADES" Varchar2(1000 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_HABITOS

ALTER TABLE "HOSPITALARIO"."SNH_MST_HABITOS" ADD CONSTRAINT "PK_SNH_MST_HABITOS" PRIMARY KEY ("HABITOS_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_HABITOS" IS 'Esta Tabla almacena los datos de loa habitos correspondientes a la secciones Habitos de la historia clínica de adolescente y antecedentes personales no patológicos de la historia clínica del adulto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."HABITOS_ID" IS 'Llave Primaria'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la Tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."INMUNIZACION_COMPLETA" IS 'Catalogo Predefinido que indica si tiene inmunizaciones completas, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."SUENO_NORMAL" IS 'Catalogo Predefinido que indica si tiene sueño normal, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."HORAS_SUENO" IS 'Cantidad de horas de sueño'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."ALIMENTACION_ADECUADA" IS 'Catalogo Predefinido que indica si tiene una alimentación adecuada siendo los posibles valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."COMIDAS_DIA" IS 'Numero de comidas al día '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."COMIDAS_DIA_FAMILIA" IS 'Numero de comidas al dia con su familia'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."CONDUCE_VEHICULO" IS 'Catalogo Predefinido que indica si conduce vehiculo, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."DESCRIPCION_VEHICULO" IS 'Descripción tipo de vehículo que conduce'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."SEGURIDAD_VIAL" IS 'Catalogo Predefinido que indica la seguridad vial, siendo los posibles valores si ;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."TIPO_ACTIVIDAD_FISICA" IS 'Catalogo Predefinido que indica  el tipo de actividad fisica que practica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."HORAS_ACTIVIDAD" IS 'Numero de horas que dedica a la actividad fisica'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."HORAS_TV" IS 'Numero de horas que dedica a ver televisión'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."HORAS_JUEGOS_VIRTUALES" IS 'Numero de horas que dedica a juegos virtuales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."OTROS_HABITOS" IS 'Descripción de otros habitos relevantes '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."OTRAS_ACTIVIDADES" IS 'Descripción de otras actividades relevantes'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del registro de los habitos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."USUARIO_REGISTRO" IS 'Usuario que agregó los datos de los hábitos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."FECHA_REGISTRO" IS 'Fecha en la que se agregaron los datos de los hábitos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."USUARIO_MODIFICACION" IS 'Último usuario que modicó los datos de los hábitos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HABITOS"."FECHA_MODIFICACION" IS 'Fecha de Última modificación de los datos de los hábitos'
;

-- Table HOSPITALARIO.SNH_MST_CONSUMOS

CREATE TABLE "HOSPITALARIO"."SNH_MST_CONSUMOS"(
  "CONSUMOS_ID" Char(20 ) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "TIPO_CONSUMO" Number(10,0) NOT NULL,
  "SUBTIPO_CONSUMO" Varchar2(100 ),
  "CANTIDAD" Number(10,0),
  "FRECUENCIA" Number(10,0),
  "EDAD_INICIO_ANNIOS" Char(20 ),
  "EDAD_INICIO_MESES" Number(10,0),
  "EDAD_ABANDONO" Number(10,0),
  "REPERCUSIONES" Number(10,0),
  "DURACION" Number(10,0),
  "EPISODIOS_ABUSO" Number(10,0),
  "OBSERVACIONES" Varchar2(250 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_CONSUMOS

ALTER TABLE "HOSPITALARIO"."SNH_MST_CONSUMOS" ADD CONSTRAINT "PK_SNH_MST_CONSUMOS" PRIMARY KEY ("CONSUMOS_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_CONSUMOS" IS 'Esta tabla almacena los datos de  consumo correspondientes a la seccion de habitos;consumos de la historia clínica de adolescente y a los antecedentes personales no patológicos de la historia clínica del adulto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."CONSUMOS_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."TIPO_CONSUMO" IS 'Catalogo Predefinido que indica el tipo de consumo, siendo los posibles valores, tabaco alcohol, otras sustancias'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."SUBTIPO_CONSUMO" IS 'Catalogo Predefinido del subtipo de consumo, tipo de tabaco, tipo de alcohol , tipo de droga ilegal etc'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."CANTIDAD" IS 'Cantidad de consumo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."FRECUENCIA" IS 'Frecuencia de la cantidad de consumo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."EDAD_INICIO_ANNIOS" IS 'Edad en que inició el consumo en años'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."EDAD_INICIO_MESES" IS 'Edad en que inició el consumo en meses'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."EDAD_ABANDONO" IS 'Edad en que abandonó el consumo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."REPERCUSIONES" IS 'Catalogo Predefinido que indica si tiene repercusiones, siendo los valores si ; no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."DURACION" IS 'Duración del hábito en años'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."EPISODIOS_ABUSO" IS 'Catalogo Predefinido que indica si ha tenido episodios de abuso, siendo los valores si ; no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."OBSERVACIONES" IS 'Descripción de observaciones relevantes'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."ESTADO_REGISTRO" IS 'Catalogo Predefinido del estado de los datos de consumo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."USUARIO_REGISTRO" IS 'Usuario que agregó los datos de consumo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."FECHA_REGISTRO" IS 'Fecha en la que se agregaron los datos de consumo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."USUARIO_MODIFICACION" IS 'Último usuario que modificó los datos de consumo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_CONSUMOS"."FECHA_MODIFICACION" IS 'Última fecha en la que se modificaron los datos de consumo'
;

