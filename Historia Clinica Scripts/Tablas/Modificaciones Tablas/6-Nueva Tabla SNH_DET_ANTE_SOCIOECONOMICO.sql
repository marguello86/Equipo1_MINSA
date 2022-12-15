CREATE TABLE "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"(
  "DET_SOCIOECONOMICO_ID" Number(10,0) NOT NULL,
  "ANTE_SOCIOECONOMICO_ID" Number(10,0) NOT NULL,
  "TIPO_ANTECEDENTE" Number(10,0) NOT NULL,
  "ESTADO_REGISTRO" Number NOT NULL,
  "USUARIO_REGISTRO" Varchar2(50 ) NOT NULL,
  "FECHA_REGISTRO" Date NOT NULL,
  "USUARIO_MODIFICACION" Varchar2(50 ),
  "FECHA_MODIFICACION" Date
)
;

-- Add keys for table HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO

ALTER TABLE "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "PK_SNH_DET_ANTE_SOCIOECONOMICO" PRIMARY KEY ("DET_SOCIOECONOMICO_ID");

-- Table and Columns comments section

COMMENT ON TABLE "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO" IS 'Esta tabla almacena el detalle de los antecedentes socioeconomicos como por ejemplo el tipo de pared, el tipo de piso, el tipo de techo etc. ';
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"."DET_SOCIOECONOMICO_ID" IS 'Llave Principal';
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"."ANTE_SOCIOECONOMICO_ID" IS 'Llave foránea de la tabla SNH_MST_ANTE_SOCIOECONOMICO';
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"."TIPO_ANTECEDENTE" IS 'Catalogo Predefinido para los tipos de paredes, piso, techo, servicios básicos';
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"."ESTADO_REGISTRO" IS 'Estado del registro, el valor 1 indica que esta activo, el valor 0 indica que está inactivo';
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"."USUARIO_REGISTRO" IS 'Usuario con el que se agregaron los antecedentes del Parto';
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"."FECHA_REGISTRO" IS 'Fecha en la que se guardaron los antecedentes del Parto';
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"."USUARIO_MODIFICACION" IS 'Ultimo Usuario que modificó los antecedentes del Parto';
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"."FECHA_MODIFICACION" IS 'Última Fecha  en la que se modificó los antecedentes del Parto';


	
-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_ANTE_SOCIOECONOMICO_DET" FOREIGN KEY ("ANTE_SOCIOECONOMICO_ID") REFERENCES "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ("ANTE_SOCIOECONOMICO_ID");
ALTER TABLE "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_TIPO" FOREIGN KEY ("TIPO_ANTECEDENTE") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID");

---- Se añade el campo antecedente que guarda el padre del tipo de antecedentes es decir indica si es la pared el piso o el techo
ALTER TABLE SNH_DET_ANTE_SOCIOECONOMICO ADD ANTECEDENTE NUMBER (10,0) NOT NULL;
COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO"."ANTECEDENTE" IS 'Catalogo Predefinido que indica que el antecedente descrito es el techo, piso, pared o los servicios básicos';

ALTER TABLE "HOSPITALARIO"."SNH_DET_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_ANTEC" FOREIGN KEY ("ANTECEDENTE") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID");