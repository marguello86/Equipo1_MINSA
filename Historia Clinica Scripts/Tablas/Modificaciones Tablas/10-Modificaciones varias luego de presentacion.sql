ALTER TABLE HOSPITALARIO.SNH_MST_ANTE_PARTO ADD UNIDAD_TIEMPO NUMBER(10,0) NULL;
ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PARTO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_UNIDAD" FOREIGN KEY ("UNIDAD_TIEMPO") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID");
---- SE ELIMINA LA COLUMNA DE OBSERVACIONES CON EL PROPOSITO DE CAMBIARLO DE TIPO DE DATOS A TIPO DE DATOS CLOB 
ALTER TABLE HOSPITALARIO.SNH_DET_HISTORIA_CLINICA DROP COLUMN OBSERVACIONES;
ALTER TABLE  HOSPITALARIO.SNH_DET_HISTORIA_CLINICA ADD OBSERVACIONES CLOB;




----- SE ELIMINAN LAS COLUMNAS SERVICIOS_HIGIENICOS Y ANIMALES, LAS CUALES PASAN A LA TABLA DE DETALLE POR SER CATALOGOS Y PORQUE PUEDEN HABER MAS DE UN TIPO POR HISTORIA SOCIOECONÓMICA

ALTER TABLE SNH_MST_ANTE_SOCIOECONOMICO DROP COLUMN SERVICIOS_HIGIENICOS;
ALTER TABLE SNH_MST_ANTE_SOCIOECONOMICO DROP COLUMN ANIMALES;