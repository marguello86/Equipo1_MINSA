PROCEDURE SNH_R_DET_HISTORIA_CLINICA( 
        pDetHistoriaId       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DET_HISTORIA_CLINICA_ID%TYPE,
        pHistoriaId          IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pRegistro            OUT VAR_REFCURSOR,
        pResultado           OUT VARCHAR2,
        pMsgError            OUT VARCHAR2
                                        ) AS
    vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_R_DET_HISTORIA_CLINICA=>';
    cursorLectura VAR_REFCURSOR;
    recCount number;
    existeRegistro NUMBER(1);
    BEGIN   

           SELECT CASE WHEN EXISTS (SELECT HISTORIA_CLINICA_ID FROM HOSPITALARIO.SNH_DET_HISTORIA_CLINICA
                                       WHERE DET_HISTORIA_CLINICA_ID  =pDetHistoriaId)
             THEN 1
             ELSE 0
             END INTO existeRegistro FROM dual;

             IF(existeRegistro=0 and pHistoriaId is null and pDetHistoriaId is not null) THEN
                 pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES CON ID_DET_HISTORIA INGRESADO';
             END IF;


            IF(pHistoriaId>0 and pDetHistoriaId is null) THEN
                OPEN  cursorLectura FOR
                SELECT DET_HISTORIA_CLINICA_ID ,    
                      HISTORIA_CLINICA_ID  ,
                      OBSERVACIONES  ,
                      DIAGNOSTICO  ,
                      INTERCONSULTAS ,
                      ESTADO_REGISTRO,
                      USUARIO_REGISTRO,
                      FECHA_REGISTRO,
                      USUARIO_MODIFICACION,
                      FECHA_MODIFICACION    
                     FROM HOSPITALARIO.SNH_DET_HISTORIA_CLINICA
                     WHERE HISTORIA_CLINICA_ID = pHistoriaId;

                SELECT  COUNT(*)    
                             into recCount  
                     FROM HOSPITALARIO.SNH_DET_HISTORIA_CLINICA
                     WHERE HISTORIA_CLINICA_ID = pHistoriaId;

                IF recCount = 0 THEN
                  pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES';
               END IF;
             END IF;

             SELECT CASE WHEN EXISTS (SELECT HISTORIA_CLINICA_ID FROM HOSPITALARIO.SNH_DET_HISTORIA_CLINICA
                                       WHERE HISTORIA_CLINICA_ID  =pHistoriaId)
             THEN 1
             ELSE 0
             END INTO existeRegistro FROM dual;

             IF(existeRegistro=0 and pDetHistoriaId is null and pHistoriaId is not null ) THEN
                 pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES CON ID_HISTORIA INGRESADO';
             END IF;

             IF (pHistoriaId>0 and pDetHistoriaId is not null) THEN
                     OPEN  cursorLectura FOR
                    SELECT DET_HISTORIA_CLINICA_ID ,    
                      HISTORIA_CLINICA_ID  ,
                      OBSERVACIONES  ,
                      DIAGNOSTICO  ,
                      INTERCONSULTAS ,
                      ESTADO_REGISTRO,
                      USUARIO_REGISTRO,
                      FECHA_REGISTRO,
                      USUARIO_MODIFICACION,
                      FECHA_MODIFICACION  
                    FROM HOSPITALARIO.SNH_DET_HISTORIA_CLINICA
                     WHERE HISTORIA_CLINICA_ID = pHistoriaId and
                     DET_HISTORIA_CLINICA_ID  = pDetHistoriaId;

                 SELECT  COUNT(*)    
                             into recCount  
                     FROM HOSPITALARIO.SNH_DET_HISTORIA_CLINICA
                     WHERE HISTORIA_CLINICA_ID = pHistoriaId and
                     DET_HISTORIA_CLINICA_ID  = pDetHistoriaId;

                IF recCount = 0 THEN
                  pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES';
               END IF;
            END IF;

           pRegistro :=  cursorLectura;            
    END SNH_R_DET_HISTORIA_CLINICA;