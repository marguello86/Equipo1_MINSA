
-- Create foreign keys (relationships) section ------------------------------------------------- 

--ALTER TABLE "SNH_DET_ANTE_ENFERMEDADES" ADD CONSTRAINT "FRK_MST_ANTE_ENFER_DETENFERM" FOREIGN KEY ("ANTE_ENFERMEDADES_ID") REFERENCES "SNH_MST_ANTE_ENFERMEDADES" ("ANTE_ENFERMEDADES_ID")
--;



ALTER TABLE "HOSPITALARIO"."SNH_DET_HIST_LABORAL" ADD CONSTRAINT "FRK_REL_HIST_LABORAL_DETHLAB" FOREIGN KEY ("HIST_LABORAL_ID") REFERENCES "HOSPITALARIO"."SNH_REL_HIST_LABORAL" ("HIST_LABORAL_ID")
;



ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_POSTNATALES" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_POST" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PARTO" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_PAR" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_REL_HIST_LABORAL" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_HLAB" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_ANTE_ENFERMEDADES" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_ENF" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_PSIC" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_ALIM" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_SOCE" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "HOSPITALARIO"."SNH_DET_HISTORIA_CLINICA" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_DETHC" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_HIST_SERVICIOS" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_SER" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_ANT_PERSONALES" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_APER" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_DET_FAMILIA" ADD CONSTRAINT "FRK_FAMILIAID_DET_FAMILIA" FOREIGN KEY ("ANT_FAMILIAR_ID") REFERENCES "SNH_MST_FAMILIA" ("ANT_FAMILIAR_ID")
;



ALTER TABLE "SNH_MST_FAMILIA" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_FAM" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_EDUCACION" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_EDU" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_ENFER_FAMILIARES" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_EFAM" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_EXAMEN_FISICO" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_EF" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_EXAMEN_ADOLES" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_EXAD" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_DET_FAMILIA_CONVIVE" ADD CONSTRAINT "FRK_FAMILIAID_FAMILIACONVIVE" FOREIGN KEY ("ANT_FAMILIAR_ID") REFERENCES "SNH_MST_FAMILIA" ("ANT_FAMILIAR_ID")
;



ALTER TABLE "SNH_MST_ANT_GINECOOBSTETRICO" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_GINE" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_ANT_UROLOGICO" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_URO" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_SEXUALIDAD" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_SEX" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_HABITOS" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_HAB" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_CONSUMOS" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_CONS" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_VIDA_SOCIAL" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_VISOC" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "SNH_MST_PSICOEMOCIONAL" ADD CONSTRAINT "FRK_MST_HISTORIA_CLINICA_PSEM" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;



ALTER TABLE "HOSPITALARIO"."SNH_MST_VACUNAS" ADD CONSTRAINT "FK_MST_HISTORIA_CLINICA_VACUN" FOREIGN KEY ("HISTORIA_CLINICA_ID") REFERENCES "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ("HISTORIA_CLINICA_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ADD CONSTRAINT "FRK_CODIGO_EXPEDIENTE_HIST" FOREIGN KEY ("EXPEDIENTE_ID") REFERENCES "HOSPITALARIO"."SNH_MST_CODIGO_EXPEDIENTE" ("EXPEDIENTE_ID")
;
ALTER TABLE "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ADD CONSTRAINT "FRK_ADMISION_SERVICIO_HIST" FOREIGN KEY ("ADMISION_SERVICIO_ID") REFERENCES "HOSPITALARIO"."SNH_MST_ADMISION_SERVICIOS" ("ADMISION_SERVICIO_ID")
;
ALTER TABLE "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ADD CONSTRAINT "FRK_CAT_UNIDADES_SALUD_HIST" FOREIGN KEY ("UNIDAD_SALUD_ID") REFERENCES "CATALOGOS"."SBC_CAT_UNIDADES_SALUD" ("UNIDAD_SALUD_ID")
;
ALTER TABLE "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ADD CONSTRAINT "FRK_MINSA_PERSONALES_HIST" FOREIGN KEY ("PERSONAL_SALUD_ID") REFERENCES "CATALOGOS"."SBC_MST_MINSA_PERSONALES" ("MINSA_PERSONAL_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_HISTORIA_CLINICA" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_HIST" FOREIGN KEY ("TIPO_HISTORIA") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PARTO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_LUGAR" FOREIGN KEY ("LUGAR_PARTO") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PARTO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_VIA" FOREIGN KEY ("VIA") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PARTO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_ATENCION" FOREIGN KEY ("ATENCION_PARTO") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_CASA" FOREIGN KEY ("CASA") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_PARED" FOREIGN KEY ("PAREDES") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;
ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_PISO" FOREIGN KEY ("PISO") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_TECHO" FOREIGN KEY ("TECHO") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_AGUA" FOREIGN KEY ("AGUA") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_LAGUA" FOREIGN KEY ("LUGAR_AGUA") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_LUZ" FOREIGN KEY ("LUZ") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_LEXCRE" FOREIGN KEY ("LUGAR_EXCRETAS") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;


ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_SOCIOECONOMICO" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_ANIM" FOREIGN KEY ("ANIMALES") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_LACEXCL" FOREIGN KEY ("LACTANCIA_EXCLUSIVA") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;
ALTER TABLE "HOSPITALARIO"."SNH_MST_ALIMEN_PEDIATRICA" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_LACMIX" FOREIGN KEY ("LACTANCIA_MIXTA") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_DESARR" FOREIGN KEY ("TIPO_DESARROLLO") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;

ALTER TABLE "HOSPITALARIO"."SNH_MST_ANTE_PSICOMOTOR" ADD CONSTRAINT "FRK_SBC_CAT_CATALOGOS_CONFDES" FOREIGN KEY ("CONFIRMA_DESARROLLO") REFERENCES "CATALOGOS"."SBC_CAT_CATALOGOS" ("CATALOGO_ID")
;
