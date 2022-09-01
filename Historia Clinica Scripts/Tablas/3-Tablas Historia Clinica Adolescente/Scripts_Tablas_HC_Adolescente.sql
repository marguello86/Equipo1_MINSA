-- Table HOSPITALARIO.SNH_MST_ANT_PERSONALES

CREATE TABLE "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"(
  "ANT_PERSONALES_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0) NOT NULL,
  "PERINATAL_NORMAL" Number(10,0),
  "CRECIMIENTO_NORMAL" Number(10,0),
  "DESARROLLO_NORMAL" Number(10,0),
  "PROBLEMAS_PSICOLOGICOS" Number(10,0),
  "USO_MEDICAMENTOS" Number(10,0),
  "JUDICIALES" Number(10,0),
  "OBSERVACIONES" Varchar2(250 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ANT_PERSONALES

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANT_PERSONALES" ADD CONSTRAINT "PK_SNH_MST_ANT_PERSONALES" PRIMARY KEY ("ANT_PERSONALES_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_ANT_PERSONALES" IS 'Esta tabla almacena los antecedentes personales correspondientes a la historia clínica del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."ANT_PERSONALES_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."PERINATAL_NORMAL" IS 'Catalogo Predefinido que indica perinatal normal, siendo los valores si/no;sin definir'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."CRECIMIENTO_NORMAL" IS 'Catalogo Predefinido que indica crecimiento normal, siendo los valores si/no;sin definirID EXTRAIDO POR CATALOGO, LOS POSIBLES VALORES SON:
'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."DESARROLLO_NORMAL" IS 'Catalogo Predefinido que indicaDesarrollo normal, siendo los valores si/no;sin definir'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."PROBLEMAS_PSICOLOGICOS" IS 'Catalogo Predefinido que indica problemas psicológicos, siendo los valores si/no;sin definir'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."USO_MEDICAMENTOS" IS 'Catalogo Predefinido que indica uso de medicamentos, siendo los valores si/no;sin definir'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."JUDICIALES" IS 'Catalogo Predefinido que indica problemas judiciales, siendo los valores si/no;sin definir'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."OBSERVACIONES" IS 'Observaciones'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del registro de antecedentes personales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."USUARIO_REGISTRO" IS 'Usuario que registró los antecedentes personales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."FECHA_REGISTRO" IS 'Fecha en la que se registraron los antecedentes personales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."USUARIO_MODIFICACION" IS 'Último Usuario que modificó los antecedentes personales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_PERSONALES"."FECHA_MODIFICACION" IS 'Última Fecha de modificación de los antecedentes personales'
;

-- Table HOSPITALARIO.SNH_DET_FAMILIA

CREATE TABLE "HOSPITALARIO"."SNH_DET_FAMILIA"(
  "DET_FAMILIAR_ID" Number(10,0) NOT NULL,
  "ANT_FAMILIAR_ID" Number(10,0),
  "PARENTESCO" Number(10,0),
  "NIVEL_EDUCACION" Number(10,0),
  "ANIOS_MAYOR_NIVEL" Number(10,0),
  "TIPO_TRABAJO" Number(10,0),
  "OCUPACION" Varchar2(30 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_DET_FAMILIA

ALTER TABLE "HOSPITALARIO"."SNH_DET_FAMILIA" ADD CONSTRAINT "PK_SNH_DET_FAMILIA" PRIMARY KEY ("DET_FAMILIAR_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_DET_FAMILIA" IS 'Esta tabla almacena los datos del detalle de los antecedentes Familiares correspondiente a la historia clínica para adolescentes '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."DET_FAMILIAR_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."ANT_FAMILIAR_ID" IS 'Llave Foránea de la tabla SNH_MST_FAMILIA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."PARENTESCO" IS 'Catalogo Predefinido que indica el parentezco del familiar que se esta detallando'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."NIVEL_EDUCACION" IS 'Catalogo Predefinido que indica el nivel de educación del familiar, siendo los posibles valores, ninguno, primaria, secundaria,universidad'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."ANIOS_MAYOR_NIVEL" IS 'Años en el mayor nivel de instrucción del familiar'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."TIPO_TRABAJO" IS 'Catalogo Predefinido que indica el tipo de trabajo del familiar que se está detallando'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."OCUPACION" IS 'Catalogo Predefinido que indica la ocupación del familiar'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del registro del detalle de familia'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."USUARIO_REGISTRO" IS 'Usuario que registró el detalle de familia'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."FECHA_REGISTRO" IS 'Fecha de registro del detalle de familia'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."USUARIO_MODIFICACION" IS 'Último usuario que modificó el registro del detalle de familia'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA"."FECHA_MODIFICACION" IS 'Última fecha de modificación del registro de detalle de familia'
;

-- Table HOSPITALARIO.SNH_MST_EDUCACION

CREATE TABLE "HOSPITALARIO"."SNH_MST_EDUCACION"(
  "EDUCACION_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "ESTUDIA" Number(10,0),
  "GRADO_ACTUAL" Varchar2(30 ),
  "NIVEL_ESCOLARIDAD" Number(10,0),
  "NOMBRE_CENTRO" Varchar2(100 ),
  "ANNIOS_APROBADOS" Number(10,0),
  "PROBLEMAS_ESCUELA" Number(10,0),
  "ANNIOS_REPETIDOS" Number(10,0),
  "VIOLENCIA_ESCOLAR" Number(10,0),
  "EXCLUSION" Number(10,0),
  "EXCLUSION_CAUSA" Varchar2(1000 ),
  "EDUCACION_NO_FORMAL" Number(10,0),
  "DESCRIPCION_EDU_NOFORMAL" Varchar2(250 ),
  "OBSERVACIONES" Varchar2(250 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_EDUCACION

ALTER TABLE "HOSPITALARIO"."SNH_MST_EDUCACION" ADD CONSTRAINT "PK_SNH_MST_EDUCACION" PRIMARY KEY ("EDUCACION_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_EDUCACION" IS 'Esta tabla almacena los datos correspondientes a la sección de educación de la historia clínica del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."EDUCACION_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la Tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."ESTUDIA" IS 'Catalogo Predefinido que indica si estudia o no, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."GRADO_ACTUAL" IS 'Descripción del grado actual '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."NIVEL_ESCOLARIDAD" IS 'Catalogo Predefinido que indica ell nivel de escolaridad '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."NOMBRE_CENTRO" IS 'Nombre del Centro en el que actualmente estudia'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."ANNIOS_APROBADOS" IS 'Cantidad de años aprobados'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."PROBLEMAS_ESCUELA" IS 'Catalogo Predefinido que indica si tiene problemas en la escuela, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."ANNIOS_REPETIDOS" IS 'Cantidad de años repetidos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."VIOLENCIA_ESCOLAR" IS 'Catalogo Predefinido que indica si sufre violencia escolar, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."EXCLUSION" IS 'Catalogo Predefinido que indica si sufre exclusion o desercion, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."EXCLUSION_CAUSA" IS 'Descripción de la causa de la exlusión'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."EDUCACION_NO_FORMAL" IS 'Catalogo Predefinido que indica si la educacion es no formal, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."DESCRIPCION_EDU_NOFORMAL" IS 'Descripción de la educacion no formal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."OBSERVACIONES" IS 'Observaciones'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."ESTADO_REGISTRO" IS 'Catalogo Predefinido del Estado del Registro de la educación '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."USUARIO_REGISTRO" IS 'Usuario que registro los datos de Educación '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."FECHA_REGISTRO" IS 'Fecha en la que se registraron los datos de Educación '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."USUARIO_MODIFICACION" IS 'Último usuario de modificación de los datos de Educación '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EDUCACION"."FECHA_MODIFICACION" IS 'Fecha de la última modificación de los datos de Educación '
;




-- Table HOSPITALARIO.SNH_MST_ANT_UROLOGICO

CREATE TABLE "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"(
  "ANT_UROLOGICO_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "ESPERMARCA_ANNIOS" Number(10,0),
  "ESPERMARCA_MESES" Number(10,0),
  "SECRECION_PENEANA" Number(10,0),
  "ITS" Number(10,0),
  "ITS_DESCRIPCION" Varchar2(1000 ),
  "ITS_TRATAMIENTO" Number(10,0),
  "BUSQUEDA_CONTACTO" Number(10,0),
  "TRATAMIENTO_CONTACTO" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_ANT_UROLOGICO

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO" ADD CONSTRAINT "PK_SNH_MST_ANT_UROLOGICO" PRIMARY KEY ("ANT_UROLOGICO_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO" IS 'Esta tabla almacena los antecedentes urológicos y aplican solo para la historia clínica de adolescente la sección gineco-urologico correspondiente cuando el paciente es hombre'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."ANT_UROLOGICO_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."HISTORIA_CLINICA_ID" IS 'Llave Foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."ESPERMARCA_ANNIOS" IS 'Edad de espermarca en años'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."ESPERMARCA_MESES" IS 'Edad de espermarca en meses'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."SECRECION_PENEANA" IS 'Catalogo predefinido que indica la secreción peneana, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."ITS" IS 'Catalogo Predefinido que indica si tiene enfermedades ITS, siendo los valores si/no.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."ITS_DESCRIPCION" IS 'Descripción de enfermedades ITS'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."ITS_TRATAMIENTO" IS 'Catalogo predefinido que indica si esta en tratamiento, siendo los posibles valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."BUSQUEDA_CONTACTO" IS 'Catalogo predefinido que indica si busco al contacto, siendo los posibles valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."TRATAMIENTO_CONTACTO" IS 'Catalogo predefinido que indica si el contacto esta en tratamiento, siendo los posibles valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."ESTADO_REGISTRO" IS 'Catalogo predefinido que indica el estados de los antecedentes urologicos, registro activo , inactivo etc'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."USUARIO_REGISTRO" IS 'Usuario con el cual se crearon los antecedentes urológicos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."FECHA_REGISTRO" IS 'Fecha en la que se guardaron los antecedentes urológicos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."USUARIO_MODIFICACION" IS 'Último usuario que modificó los antecedentes urológicos'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANT_UROLOGICO"."FECHA_MODIFICACION" IS 'Última fecha en la que se modificaron los antecedentes urológicos '
;

-- Table HOSPITALARIO.SNH_MST_EXAMEN_ADOLES

CREATE TABLE "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"(
  "EXAMEN_ADOLES_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "ASPECTO_GENERAL" Number(10,0),
  "PESO" Number(10,2),
  "TALLA" Number(10,2),
  "PESO_EDAD" Number(10,2),
  "TALLA_EDAD" Number(10,2),
  "IMC" Number(10,2),
  "DZ_IMC" Number(10,2),
  "PIEL_MUCOSAS" Number(10,0),
  "CABEZA" Number(10,0),
  "AGUDEZA_VISUAL" Number(10,0),
  "AGUDEZA_AUDITIVA" Number(10,0),
  "SALUD_BUCAL" Number(10,0),
  "CUELLO" Number(10,0),
  "TORAX_MAMAS" Number(10,0),
  "CARDIO" Number(10,0),
  "PRESION" Varchar2(10 ),
  "FRECUENCIA_CAR" Number(10,2),
  "FRECUENCIA_RESP" Number(10,2),
  "TEMPERATURA" Number(10,2),
  "ABDOMEN" Number(10,0),
  "GENITO_URINARIO" Number(10,0),
  "TANNER" Number(10,0),
  "COLUMNA" Number(10,0),
  "EXTREMIDADES" Number(10,0),
  "NEUROLOGICO" Number(10,0),
  "OBSERVACIONES" Varchar2(1000 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_EXAMEN_ADOLES

ALTER TABLE "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES" ADD CONSTRAINT "PK_SNH_MST_EXAMEN_ADOLES" PRIMARY KEY ("EXAMEN_ADOLES_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES" IS 'Esta tabla almacena los datos del examen fisico de la historia clinica del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."EXAMEN_ADOLES_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."ASPECTO_GENERAL" IS 'Catalogo Predefinido que indica el aspecto general, siendo los valores normal;anormal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."PESO" IS 'Peso en Kg'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."TALLA" IS 'Talla en cm'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."PESO_EDAD" IS 'Relación Peso Edad'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."TALLA_EDAD" IS 'Relación Talla Edad'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."IMC" IS 'Indice de Masa Corporal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."PIEL_MUCOSAS" IS 'Catalogo predefinido que indica el estado de su piel y mucosas, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."CABEZA" IS 'Catalogo predefinido que indica el estado  de su cabeza, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."AGUDEZA_VISUAL" IS 'Catalogo predefinido que indica el estado  visual, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."AGUDEZA_AUDITIVA" IS 'Catalogo predefinido que indica el estado auditivo, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."SALUD_BUCAL" IS 'Catalogo predefinido que indica el estado  de su salud bucal, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."CUELLO" IS 'Catalogo predefinido que indica el estado  de su cuello, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."TORAX_MAMAS" IS 'Catalogo predefinido que indica el estado  de su torax y mamas, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."CARDIO" IS 'Catalogo predefinido que indica el estado  cardio pulmonar, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."PRESION" IS 'Medida de la presion arterial'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."FRECUENCIA_CAR" IS 'Medida Frecuencia cardíaca'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."FRECUENCIA_RESP" IS 'Medida Frecuencia Respiratoria'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."TEMPERATURA" IS 'Medida Temperatura'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."ABDOMEN" IS 'Catalogo predefinido que indica el estado de su abdomen, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."GENITO_URINARIO" IS 'Catalogo predefinido que indica el estado genitourinario, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."TANNER" IS 'Catalogo predefinido que indica los cambios fisicos , siendo los valores mamas, vello pubico, genitales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."COLUMNA" IS 'Catalogo predefinido que indica el estado  de su columna, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."EXTREMIDADES" IS 'Catalogo predefinido que indica el estado  de sus extremidades, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."NEUROLOGICO" IS 'Catalogo predefinido que indica el estado neurologico, siendo los valores normal y anormal '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."OBSERVACIONES" IS 'Observaciones'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado de los datos del examen fisico del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."USUARIO_REGISTRO" IS 'Catalogo Predefinido que indica el usuario que registró los datos del examen fisico del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."FECHA_REGISTRO" IS 'Catalogo Predefinido que indica la fecha en que se registró los datos del examen fisico del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."USUARIO_MODIFICACION" IS 'Último usuario que modificó los datos del examen fisico del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_EXAMEN_ADOLES"."FECHA_MODIFICACION" IS 'Última fecha de modificación de los datos del examen fisico'
;

-- Table HOSPITALARIO.SNH_DET_FAMILIA_CONVIVE

CREATE TABLE "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"(
  "FAMILIA_CONVIVE_ID" Number(10,0) NOT NULL,
  "ANT_FAMILIAR_ID" Number(10,0) NOT NULL,
  "PARENTEZCO" Number(10,0) NOT NULL,
  "CONVIVE" Number(10,0),
  "EN_CASA" Number(10,0),
  "COMPARTE_CUARTO" Number(10,0),
  "COMPARTE_CAMA" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_DET_FAMILIA_CONVIVE

ALTER TABLE "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE" ADD CONSTRAINT "PK_SNH_DET_FAMILIA_CONVIVE" PRIMARY KEY ("FAMILIA_CONVIVE_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE" IS 'Esta tabla almacena los datos de la convivencia que son parte de los antecedentes familiares de la historia clínica del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."FAMILIA_CONVIVE_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."ANT_FAMILIAR_ID" IS 'Llave Foránea a la tabla SNH_MST_FAMILIA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."PARENTEZCO" IS 'Catalogo predefinido que indica el parentezco de la persona con la que convive, siendo los posibles valores, madre, padre, madrastra, hermanod etc'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."CONVIVE" IS 'Catalogo predefinido que indica si convive  con el familiar, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."EN_CASA" IS 'Catalogo predefinido que indica si convive en la casa  con el familiar, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."COMPARTE_CUARTO" IS 'Catalogo predefinido que indica si comparte cuarto con el familiar, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."COMPARTE_CAMA" IS 'Catalogo predefinido que indica si comparte cama con el familiar, siendo los valores si;no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del registro la convivencia familiar'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."USUARIO_REGISTRO" IS 'Usuario que agregó los datos de  la convivencia familiar'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."FECHA_REGISTRO" IS 'Fecha en la que se registró la convivencia familiar'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."USUARIO_MODIFICACION" IS 'Último usuario que modificó el registro de convivencia familiar'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_FAMILIA_CONVIVE"."FECHA_MODIFICACION" IS 'última Fecha en la que se modificó la convicencia familiar'
;

-- Table HOSPITALARIO.SNH_MST_VIDA_SOCIAL

CREATE TABLE "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"(
  "VIDA_SOCIAL_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "ACEPTACION" Number(10,0),
  "PAREJA" Number(10,0),
  "EDAD_PAREJA_ANNIOS" Number(10,0),
  "EDAD_PAREJA_MESES" Number(10,0),
  "VIOLENCIA_PAREJA" Number(10,0),
  "AMIGOS" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_VIDA_SOCIAL

ALTER TABLE "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL" ADD CONSTRAINT "PK_SNH_MST_VIDA_SOCIAL" PRIMARY KEY ("VIDA_SOCIAL_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL" IS 'Esta tabla almacena los datos de la vida social correspondiente a la historia clinica del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."VIDA_SOCIAL_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."ACEPTACION" IS 'Catalogo Predefinido que indica el nivel de aceptación.'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."PAREJA" IS 'Catalogo Predefinido que indica si tiene pareja, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."EDAD_PAREJA_ANNIOS" IS 'Edad en años con la pareja'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."EDAD_PAREJA_MESES" IS 'Edad en meses con la pareja'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."VIOLENCIA_PAREJA" IS 'Catalogo Predefinido que indica si recibe violencia de la pareja, siendo los valores si ; no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."AMIGOS" IS 'Catalogo Predefinido que indica si tiene amigos, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del registro '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."USUARIO_REGISTRO" IS 'Usuario que registró los datos de vida social'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."FECHA_REGISTRO" IS 'Fecha en la que se registró los datos de la vida social'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."USUARIO_MODIFICACION" IS 'Último Usuario que modificó el registro de vida social'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_VIDA_SOCIAL"."FECHA_MODIFICACION" IS 'Última Fecha de Modificación del registro de vidad social'
;


-- Table HOSPITALARIO.SNH_MST_PSICOEMOCIONAL

CREATE TABLE "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"(
  "PSICOEMOCIONAL_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "IMAGEN_CORPORAL" Number(10,0),
  "ESTADO_ANIMO" Number(10,0),
  "REFERENTE_ADULTO" Number(10,0),
  "PROYECTO_VIDA" Number(10,0),
  "APOYO_REDES" Number(10,0),
  "TELEFONO_ADULTO" Number(10,0),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_PSICOEMOCIONAL

ALTER TABLE "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL" ADD CONSTRAINT "PK_SNH_MST_PSICOEMOCIONAL" PRIMARY KEY ("PSICOEMOCIONAL_ID")
;

-- Table and Columns comments section

COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."PSICOEMOCIONAL_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."IMAGEN_CORPORAL" IS 'Catalogo Predefinido que indica la imagen corporal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."ESTADO_ANIMO" IS 'Catalogo Predefinido que indica el estado de ánimo'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."REFERENTE_ADULTO" IS 'Catalogo Predefinido que indica la referencia del adulto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."PROYECTO_VIDA" IS 'Catalogo Predefinido que indica si tiene un proyecto de vida'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."APOYO_REDES" IS 'Catalogo predefinido que indica si tiene apoyo en redes, siendo los valores si/no'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."TELEFONO_ADULTO" IS 'Numero de Telefono del adulto'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del registro del antecedentes psicoemocional'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."USUARIO_REGISTRO" IS 'Usuario que registró el antecedente psicoemocional'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."FECHA_REGISTRO" IS 'Fecha en la que se registraron los antecedentes psicoemocionales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."USUARIO_MODIFICACION" IS 'Último Usuario que modificó los antecedentes psicoemocionales'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_PSICOEMOCIONAL"."FECHA_MODIFICACION" IS 'Última Fecha de modificación de los antecedentes psicoemocionales'
;


-- Table HOSPITALARIO.SNH_MST_FAMILIA

CREATE TABLE "HOSPITALARIO"."SNH_MST_FAMILIA"(
  "ANT_FAMILIAR_ID" Number(10,0) NOT NULL,
  "HISTORIA_CLINICA_ID" Number(10,0),
  "VIVE" Number(10,0),
  "PERCEPCION_FAMILIAR" Number(10,0),
  "OBSERVACIONES" Varchar2(250 ),
  "ESTADO_REGISTRO" Number(10,0) NOT NULL,
  "USUARIO_REGISTRO" Number(10,0) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Number(10,0),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_MST_FAMILIA

ALTER TABLE "HOSPITALARIO"."SNH_MST_FAMILIA" ADD CONSTRAINT "PK_SNH_MST_FAMILIA" PRIMARY KEY ("ANT_FAMILIAR_ID")
;

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_MST_FAMILIA" IS 'Esta Tabla almacena los antecedentes familiares correspondientes a la historia clínica del adolescente'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."ANT_FAMILIAR_ID" IS 'Llave Principal'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."HISTORIA_CLINICA_ID" IS 'Llave foránea de la tabla SNH_MST_HISTORIA_CLINICA'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."VIVE" IS 'Catalogo Predefinido que indica la forma en donde vive el paciente, siendo los valores : solo, en casa, en la calle, institución protectora, privado de libertad
'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."PERCEPCION_FAMILIAR" IS 'Catalogo Predefinido que indica la percepción familiar, siendo los valores, bueno, regular, mala, no hay relación '
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."OBSERVACIONES" IS 'Observaciones'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del registro de los antecedentes familiares'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."USUARIO_REGISTRO" IS 'Usuario que agregó los datos de los antecedentes familiares'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."FECHA_REGISTRO" IS 'Fecha en que se registraron los antecedentes familiares'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."USUARIO_MODIFICACION" IS 'Último usuario que modificó los antecedentes familiares'
;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_FAMILIA"."FECHA_MODIFICACION" IS 'Última fecha en que se modificó los antecedentes familiares'
;
