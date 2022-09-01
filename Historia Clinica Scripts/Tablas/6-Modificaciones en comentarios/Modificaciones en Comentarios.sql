--- Se Comentan las Tablas que tengan columnas que representen valores de si y NOARCHIVELOG
--1
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."ALOJAMIENTO_CONJUNTO" IS 'Valor 1 Significa que hubo alojamiento en conjunto. Valor 0 No Hubo Alojamiento';
--2
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del registro';
--3

COMMENT ON COLUMN "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA"."ESTADO_REGISTRO" IS 'Catalogo Predefinido que indica el estado del registro';
--4
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES"."ASFIXIA" IS 'Valor 1 Indica Si tienes datos de Asfixia, Valor 0 No tiene Datos de Asfixia';
--5
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR"."CONFIRMA_DESARROLLO" IS 'Valor 1 Confirma el tipo de desarrollo ingresado, Valor 0 no se confirma';
--6
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."AGUA" IS 'Valor 1 Confirma que tiene servicio de Agua, Valor 0 no tiene servicio de agua';
--7
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."LUZ" IS 'Valor 1 Confirma que tiene servicio de Luz, Valor 0 no tiene servicio de Luz';
--8
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."ANIMALES" IS 'Valor 1 Confirma que tiene animales, Valor 0 no tiene animales';
--9
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO"."HACIMIENTO" IS 'Valor 1 Confirma que está en hacimiento, Valor 0 no está en hacimiento';
--10

COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."LACTANCIA_EXCLUSIVA" IS 'Valor 1 Confirma la Lactancia Exclusiva, Valor 0 no confirma';
--11
COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA"."LACTANCIA_MIXTA" IS 'Valor 1 Confirma la Lactancia Mixta, Valor 0 no confirma';
