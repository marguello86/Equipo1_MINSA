ALTER TABLE HOSPITALARIO.SNH_MST_HISTORIA_CLINICA ADD   FECHA_HISTORIA   DATE    NULL ;  


COMMENT ON COLUMN "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA"."FECHA_HISTORIA" IS 'La Fecha en la que se creó historia clínica en caso de agregar una historia en fisico al sistema';