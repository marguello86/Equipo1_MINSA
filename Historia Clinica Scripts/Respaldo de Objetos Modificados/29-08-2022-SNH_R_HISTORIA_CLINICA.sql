    PROCEDURE SNH_R_HISTORIA_CLINICA( 
        pCodigoExpediente   IN     HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE.CODIGO_EXPEDIENTE_ELECTRONICO%TYPE,
        pHistoriaId         IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pRegistro           OUT VAR_REFCURSOR,
        pResultado          OUT VARCHAR2,
        pMsgError           OUT VARCHAR2
                                      ) AS

    vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_R_HISTORIA_CLINICA=>';

    cursorLectura VAR_REFCURSOR;
    recCount number;
    existeRegistro NUMBER(1);

        BEGIN   

           SELECT CASE WHEN EXISTS (SELECT HISTORIA_CLINICA_ID FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA MHC
                                                                    INNER JOIN HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE CEX 
                                                                    ON CEX.EXPEDIENTE_ID=MHC.EXPEDIENTE_ID
                                                                    WHERE CEX.CODIGO_EXPEDIENTE_ELECTRONICO=pCodigoExpediente
                                  )
            THEN 1
            ELSE 0            
            END INTO existeRegistro FROM dual;

            IF(existeRegistro=0) THEN
                pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES';
            END IF;

            IF(pCodigoExpediente is not null and pHistoriaId is null) THEN
                OPEN  cursorLectura FOR
                SELECT
                      DISTINCT
                      HC.HISTORIA_CLINICA_ID ,    
                      HC.ADMISION_SERVICIO_ID  ,
                      SER.NOMBRE AS ADMISION_SERVICIO_NOMBRE,
                      HC.TIPO_HISTORIA  ,
                      TIPOHIS.VALOR AS TIPO_HISTORIA_NOMBRE,
                      HC.EXPEDIENTE_ID  ,
                      CEX.CODIGO_EXPEDIENTE_ELECTRONICO,
                      HC.UNIDAD_SALUD_ID ,
                      USAD.NOMBRE AS UNIDAD_SALUD_NOMBRE,
                      ENTSAL.ENTIDAD_ADTVA_ID,
                      ENTSAL.NOMBRE AS ENTIDAD_UNIDAD_SALUD,
                      PERNOM.TIPO_IDENTIFICACION_ID,
                      PERNOM.IDENTIFICACION_NUMERO AS IDENTIFICACION,
                      PERNOM.TIPO_EXPEDIENTE_CODIGO,
                      PERNOM.IDENTIFICACION_CODIGO,
                      PERNOM.IDENTIFICACION_NOMBRE,
                      PERNOM.PRIMER_NOMBRE,
                      PERNOM.SEGUNDO_NOMBRE,
                      PERNOM.PRIMER_APELLIDO,
                      PERNOM.SEGUNDO_APELLIDO,
                      PERNOM.NOMBRE_COMPLETO,
                      PERNOM.SEXO_ID,
                      PERNOM.SEXO_VALOR AS SEXO,
                      HOSPITALARIO.PKG_SNH_EMERGENCIA.FN_OBT_EDAD_PERSONA_HST (PERNOM.FECHA_NACIMIENTO,HC.FECHA_REGISTRO,'F') AS EDAD,
                      PERNOM.FECHA_NACIMIENTO,
                      PERNOM.PAIS_NACIMIENTO_ID,
                      PERNOM.PAIS_ORIGEN_NOMBRE,
                      PERNOM.MUNICIPIO_NACIMIENTO_NOMBRE,
                      PERNOM.MUNICIPIO_NACIMIENTO_ID,
                      HC.PERSONAL_SALUD_ID ,
                      HC.ESTADO_REGISTRO,
                      CODEST.valor as ESTADO_NOMBRE,
                      HC.USUARIO_REGISTRO,
                      HC.FECHA_REGISTRO,
                      HC.USUARIO_MODIFICACION,
                      HC.FECHA_MODIFICACION,
                      HC.FECHA_HISTORIA         
                     FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA HC
                     INNER JOIN HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE CEX
                     ON HC.EXPEDIENTE_ID=CEX.EXPEDIENTE_ID
                     INNER JOIN CATALOGOS.SBC_CAT_UNIDADES_SALUD USAD
                     ON USAD.UNIDAD_SALUD_ID=HC.UNIDAD_SALUD_ID
                     INNER JOIN CATALOGOS.SBC_CAT_ENTIDADES_ADTVAS ENTSAL
                     ON ENTSAL.ENTIDAD_ADTVA_ID=USAD.ENTIDAD_ADTVA_ID
                     INNER JOIN CATALOGOS.SBC_MST_PERSONAS P
                     ON P.EXPEDIENTE_ID = HC.EXPEDIENTE_ID
                     INNER JOIN CATALOGOS.SBC_MST_PERSONAS_NOMINAL PERNOM
                     ON P.PERSONA_ID = PERNOM.PERSONA_ID AND PERNOM.EXPEDIENTE_ID=HC.EXPEDIENTE_ID
                     INNER JOIN  CATALOGOS.SBC_CAT_CATALOGOS CODEST
                     ON CODEST.CATALOGO_ID=HC.ESTADO_REGISTRO
                     INNER JOIN  CATALOGOS.SBC_CAT_CATALOGOS TIPOHIS 
                     ON TIPOHIS.CATALOGO_ID=HC.TIPO_HISTORIA 
                     LEFT JOIN HOSPITALARIO.SNH_MST_ADMISION_SERVICIOS ADSER 
                     ON HC.ADMISION_SERVICIO_ID=ADSER.ADMISION_SERVICIO_ID
                     LEFT JOIN SNH_CAT_SERVICIOS SER 
                     ON ADSER.SERVICIO_ID=SER.SERVICIO_ID 
                     --WHERE HC.EXPEDIENTE_ID = pExpedienteId;
                     WHERE CEX.CODIGO_EXPEDIENTE_ELECTRONICO=pCodigoExpediente;

                SELECT  COUNT(*)
                              into recCount
                      FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA HCL
                      INNER JOIN HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE CE
                      ON HCL.EXPEDIENTE_ID=CE.EXPEDIENTE_ID
                      WHERE CE.CODIGO_EXPEDIENTE_ELECTRONICO=pCodigoExpediente;

                IF recCount = 0 THEN
                  pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES';
               END IF;
             END IF;

             IF (pCodigoExpediente is not null and pHistoriaId is not null) THEN

                     OPEN  cursorLectura FOR

                    SELECT
                      DISTINCT
                      HC.HISTORIA_CLINICA_ID ,    
                      HC.ADMISION_SERVICIO_ID  ,
                      SER.NOMBRE AS ADMISION_SERVICIO_NOMBRE,
                      HC.TIPO_HISTORIA  ,
                      TIPOHIS.VALOR AS TIPO_HISTORIA_NOMBRE,
                      HC.EXPEDIENTE_ID  ,
                      CEX.CODIGO_EXPEDIENTE_ELECTRONICO,
                      HC.UNIDAD_SALUD_ID ,
                      USAD.NOMBRE AS UNIDAD_SALUD_NOMBRE,
                      ENTSAL.ENTIDAD_ADTVA_ID,
                      ENTSAL.NOMBRE AS ENTIDAD_UNIDAD_SALUD,
                      PERNOM.TIPO_IDENTIFICACION_ID,
                      PERNOM.IDENTIFICACION_NUMERO AS IDENTIFICACION,
                      PERNOM.TIPO_EXPEDIENTE_CODIGO,
                      PERNOM.IDENTIFICACION_CODIGO,
                      PERNOM.IDENTIFICACION_NOMBRE,
                      PERNOM.PRIMER_NOMBRE,
                      PERNOM.SEGUNDO_NOMBRE,
                      PERNOM.PRIMER_APELLIDO,
                      PERNOM.SEGUNDO_APELLIDO,
                      PERNOM.NOMBRE_COMPLETO,
                      PERNOM.SEXO_ID,
                      PERNOM.SEXO_VALOR AS SEXO,
                      HOSPITALARIO.PKG_SNH_EMERGENCIA.FN_OBT_EDAD_PERSONA_HST (PERNOM.FECHA_NACIMIENTO,HC.FECHA_REGISTRO,'F') AS EDAD,
                      PERNOM.FECHA_NACIMIENTO,
                      PERNOM.PAIS_NACIMIENTO_ID,
                      PERNOM.PAIS_ORIGEN_NOMBRE,
                      PERNOM.MUNICIPIO_NACIMIENTO_NOMBRE,
                      PERNOM.MUNICIPIO_NACIMIENTO_ID,
                      HC.PERSONAL_SALUD_ID ,
                      HC.ESTADO_REGISTRO,
                      CODEST.valor as ESTADO_NOMBRE,
                      HC.USUARIO_REGISTRO,
                      HC.FECHA_REGISTRO,
                      HC.USUARIO_MODIFICACION,
                      HC.FECHA_MODIFICACION,
                      HC.FECHA_HISTORIA         
                     FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA HC
                     INNER JOIN HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE CEX
                     ON HC.EXPEDIENTE_ID=CEX.EXPEDIENTE_ID
                     INNER JOIN CATALOGOS.SBC_CAT_UNIDADES_SALUD USAD
                     ON USAD.UNIDAD_SALUD_ID=HC.UNIDAD_SALUD_ID
                     INNER JOIN CATALOGOS.SBC_CAT_ENTIDADES_ADTVAS ENTSAL
                     ON ENTSAL.ENTIDAD_ADTVA_ID=USAD.ENTIDAD_ADTVA_ID
                     INNER JOIN CATALOGOS.SBC_MST_PERSONAS P
                     ON P.EXPEDIENTE_ID = HC.EXPEDIENTE_ID
                     INNER JOIN CATALOGOS.SBC_MST_PERSONAS_NOMINAL PERNOM
                     ON P.PERSONA_ID = PERNOM.PERSONA_ID AND PERNOM.EXPEDIENTE_ID=HC.EXPEDIENTE_ID
                     INNER JOIN  CATALOGOS.SBC_CAT_CATALOGOS CODEST
                     ON CODEST.CATALOGO_ID=HC.ESTADO_REGISTRO
                     INNER JOIN  CATALOGOS.SBC_CAT_CATALOGOS TIPOHIS 
                     ON TIPOHIS.CATALOGO_ID=HC.TIPO_HISTORIA
                     LEFT JOIN HOSPITALARIO.SNH_MST_ADMISION_SERVICIOS ADSER 
                     ON HC.ADMISION_SERVICIO_ID=ADSER.ADMISION_SERVICIO_ID
                     LEFT JOIN SNH_CAT_SERVICIOS SER 
                     ON ADSER.SERVICIO_ID=SER.SERVICIO_ID  
                     --WHERE HC.EXPEDIENTE_ID = pExpedienteId;
                      WHERE CEX.CODIGO_EXPEDIENTE_ELECTRONICO=pCodigoExpediente
                      and HC.HISTORIA_CLINICA_ID=pHistoriaId;

                 SELECT  COUNT(*)    
                             into recCount  
                     FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA HCL
                          INNER JOIN HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE CE
                          ON HCL.EXPEDIENTE_ID=CE.EXPEDIENTE_ID
                     WHERE CE.CODIGO_EXPEDIENTE_ELECTRONICO=pCodigoExpediente and
                     HISTORIA_CLINICA_ID  = pHistoriaId;

                IF recCount = 0 THEN
                  pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES';
               END IF;
            END IF;

           pRegistro :=  cursorLectura;            

            END SNH_R_HISTORIA_CLINICA;