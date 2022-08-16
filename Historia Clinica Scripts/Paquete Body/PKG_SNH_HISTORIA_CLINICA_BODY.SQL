create or replace PACKAGE BODY              PKG_SNH_HISTORIA_CLINICA
AS
    /****************************************************************************************************************************************************************************/
    FUNCTION FN_R_VALIDA_CATALOGO (pCodigoSup     IN VARCHAR2,
                                   pCodigo        IN VARCHAR2)
        RETURN NUMBER
    AS
        catId          CATALOGOS.SBC_CAT_CATALOGOS.CATALOGO_ID%TYPE;
    BEGIN
        SELECT C.CATALOGO_ID
        INTO catId
        FROM CATALOGOS.SBC_CAT_CATALOGOS  C
             INNER JOIN CATALOGOS.SBC_CAT_CATALOGOS CS
                 ON C.CATALOGO_SUP = CS.CATALOGO_ID
        WHERE C.CODIGO = pCodigo AND CS.CODIGO = pCodigoSup;

        RETURN catId;
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            RAISE_APPLICATION_ERROR (
                -20999,
                'ORA-' || SQLCODE ||
                ' VALOR DE CATALOGO NO ENCONTRADO pCodigoSup:' || pCodigoSup
                || ', pCodigo:' || pCodigo,
                TRUE);
    END FN_R_VALIDA_CATALOGO;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_C_HISTORIA_CLINICA (
        pAdmisionServicioId IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.ADMISION_SERVICIO_ID%TYPE,
        pTipoHistoria       IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.TIPO_HISTORIA%TYPE,
        pExpedienteId       IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.EXPEDIENTE_ID%TYPE,
        pUnidadSalud        IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.UNIDAD_SALUD_ID%TYPE,
        pPersonalSalud      IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.PERSONAL_SALUD_ID%TYPE,
        pFechaHistoria      IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_HISTORIA%TYPE,
        pUsuarioRegistro    IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro      IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_REGISTRO%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_C_HISTORIA_CLINICA=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        INSERT INTO HOSPITALARIO.SNH_MST_HISTORIA_CLINICA (
                                                ADMISION_SERVICIO_ID,
                                                TIPO_HISTORIA,
                                                EXPEDIENTE_ID,
                                                UNIDAD_SALUD_ID,
                                                PERSONAL_SALUD_ID,
                                                FECHA_HISTORIA,
                                                ESTADO_REGISTRO,
                                                USUARIO_REGISTRO,
                                                FECHA_REGISTRO
                                                )
        VALUES                                  (
                                                pAdmisionServicioId,
                                                pTipoHistoria,
                                                pExpedienteId,
                                                pUnidadSalud,
                                                pPersonalSalud,
                                              	NVL(pFechaHistoria,CURRENT_DATE),
                                                pEstadoRegistro,
                                                pUsuarioRegistro,
                                                CURRENT_DATE
                                                );

        pResultado   := 'RESULTADO CREADO SATISFACTORIAMENTE';
    --EXCEPTION
    --WHEN OTHERS THEN
    --   pResultado := 'ERROR INESPERADO';
    --  pMsgError :=/*vFirma|| */ pResultado || sqlerrm;
    --pMsgError:=pResultado;
    END SNH_C_HISTORIA_CLINICA;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_D_HISTORIA_CLINICA (
        pHistoriaId           IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pUsuarioModificacion  IN HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.USUARIO_MODIFICACION%TYPE,
        pResultado            OUT VARCHAR2,
        pMsgError             OUT VARCHAR2)
    IS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_D_HISTORIA_CLINICA=>';
        pEstado        NUMBER (10);
    BEGIN
        pEstado      := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_PAS);

        UPDATE HOSPITALARIO.SNH_MST_HISTORIA_CLINICA
        SET FECHA_MODIFICACION     = CURRENT_DATE,
            ESTADO_REGISTRO        = pEstado,
            USUARIO_MODIFICACION   = NVL (pUsuarioModificacion, USUARIO_MODIFICACION)
        WHERE HISTORIA_CLINICA_ID  = pHistoriaId;

        pResultado   := 'HISTORIA ELIMINADA SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_D_HISTORIA_CLINICA;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_CRUD_HISTORIA_CLINICA (
        pHistoriaId          IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pAdmisionServicioId  IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.ADMISION_SERVICIO_ID%TYPE,
        pTipoHistoria        IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.TIPO_HISTORIA%TYPE,
        pExpedienteId        IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.EXPEDIENTE_ID%TYPE,
        pUnidadSalud         IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.UNIDAD_SALUD_ID%TYPE,
        pPersonalSalud       IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.PERSONAL_SALUD_ID%TYPE,
        pFechaHistoria       IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_HISTORIA%TYPE,
        pUsuarioRegistro     IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro       IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_REGISTRO%TYPE,
        pUsuarioModificacion IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion   IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_MODIFICACION%TYPE,
        pTipoOperacion       IN     VARCHAR2,
        pMsgError            OUT VARCHAR2,
        pResultado           OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_CRUD_HISTORIA_CLINICA=>';
    BEGIN
        CASE
            WHEN pTipoOperacion IS NULL
            THEN
                pResultado   := 'No se ha indicado el tipo de operacion';
                RAISE eParametroNull;
            WHEN pTipoOperacion = KINSERT
            THEN
                SNH_C_HISTORIA_CLINICA (
                    pAdmisionServicioId  => pAdmisionServicioId,
                    pTipoHistoria        => pTipoHistoria,
                    pExpedienteId        => pExpedienteId,
                    pUnidadSalud         => pUnidadSalud,
                    pPersonalSalud       => pPersonalSalud,                  
					pFechaHistoria       => pFechaHistoria,
                    pUsuarioRegistro     => pUsuarioRegistro,
                    pFechaRegistro       => pFechaRegistro,                    
                    pMsgError            => pMsgError,
                    pResultado           => pResultado);

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            WHEN pTipoOperacion = KDELETE
            THEN
                SNH_D_HISTORIA_CLINICA (
                    pHistoriaId            => pHistoriaId,
                    pUsuarioModificacion   => pUsuarioModificacion,
                    pResultado             => pResultado,
                    pMsgError              => pMsgError);

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            ELSE
                pResultado   := 'EL PARÁMETRO pTipoOperacion [' ||
                                pTipoOperacion || '] ES INVALIDO';
                RAISE eParametrosInvalidos;
        END CASE;

        CASE
            WHEN pMsgError IS NOT NULL
            THEN
                RAISE eSalidaConError;
            ELSE
                NULL;
        END CASE;
    EXCEPTION
        WHEN eSalidaConError
        THEN
            pResultado   := vFirma || pResultado;
            pMsgError    := pResultado || pMsgError;
        WHEN eParametrosInvalidos
        THEN
            pResultado   := vFirma || pResultado;
            pMsgError    := pResultado;
        WHEN OTHERS
        THEN
            pResultado   := vFirma || 'Error no controlado' || pResultado;
            pMsgError    := pResultado || ' - ' || SQLERRM;
    END SNH_CRUD_HISTORIA_CLINICA;
    /****************************************************************************************************************************************************************************/

    PROCEDURE SNH_R_HISTORIA_CLINICA( 
        pExpedienteId       IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.EXPEDIENTE_ID%TYPE,
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

           SELECT CASE WHEN EXISTS (SELECT HISTORIA_CLINICA_ID FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA
                                      WHERE EXPEDIENTE_ID = pExpedienteId)
            THEN 1
            ELSE 0            
            END INTO existeRegistro FROM dual;

            IF(existeRegistro=0) THEN
                pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES';
            END IF;

            IF(pExpedienteId>0 and pHistoriaId is null) THEN
                OPEN  cursorLectura FOR
                SELECT
                      HISTORIA_CLINICA_ID ,    
                      ADMISION_SERVICIO_ID  ,
                      TIPO_HISTORIA  ,
                      EXPEDIENTE_ID  ,
                      UNIDAD_SALUD_ID ,
                      PERSONAL_SALUD_ID ,
                      ESTADO_REGISTRO,
                      USUARIO_REGISTRO,
                      FECHA_REGISTRO,
                      USUARIO_MODIFICACION,
                      FECHA_MODIFICACION,
                      FECHA_HISTORIA         
                     FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA 
                     WHERE EXPEDIENTE_ID = pExpedienteId;

                SELECT  COUNT(*)    
                             into recCount  
                     FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA 
                     WHERE EXPEDIENTE_ID = pExpedienteId;

                IF recCount = 0 THEN
                  pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES';
               END IF;
             END IF;

             IF (pExpedienteId>0 and pHistoriaId is not null) THEN

                     OPEN  cursorLectura FOR

                    SELECT
                      HISTORIA_CLINICA_ID ,    
                      ADMISION_SERVICIO_ID  ,
                      TIPO_HISTORIA  ,
                      EXPEDIENTE_ID  ,
                      UNIDAD_SALUD_ID ,
                      PERSONAL_SALUD_ID ,
                      ESTADO_REGISTRO,
                      USUARIO_REGISTRO,
                      FECHA_REGISTRO,
                      USUARIO_MODIFICACION,
                      FECHA_MODIFICACION,
                      FECHA_HISTORIA
                    FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA 
                     WHERE EXPEDIENTE_ID = pExpedienteId and
                     HISTORIA_CLINICA_ID  = pHistoriaId;

                 SELECT  COUNT(*)    
                             into recCount  
                     FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA 
                     WHERE EXPEDIENTE_ID = pExpedienteId and
                     HISTORIA_CLINICA_ID  = pHistoriaId;

                IF recCount = 0 THEN
                  pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES';
               END IF;
            END IF;

           pRegistro :=  cursorLectura;            
            END SNH_R_HISTORIA_CLINICA;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_C_DET_HISTORIA_CLINICA (
        pHistoriaId         IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pObservaciones      IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.OBSERVACIONES%TYPE,
        pDiagnostico        IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DIAGNOSTICO%TYPE,
        pInterconsultas     IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.INTERCONSULTAS%TYPE,
        pUsuarioRegistro    IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro      IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.FECHA_REGISTRO%TYPE,
        pResultado          OUT VARCHAR2,
        pMsgError           OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_C_DET_HISTORIA_CLINICA=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        INSERT INTO HOSPITALARIO.SNH_DET_HISTORIA_CLINICA (
                                            HISTORIA_CLINICA_ID,
                                            OBSERVACIONES,
                                            DIAGNOSTICO,
                                            INTERCONSULTAS,
                                            ESTADO_REGISTRO,
                                            USUARIO_REGISTRO,
                                            FECHA_REGISTRO
                                            )
        VALUES (
                                            pHistoriaId,
                                            pObservaciones,
                                            pDiagnostico,
                                            pInterconsultas,
                                            pEstadoRegistro,
                                            pUsuarioRegistro,
                                            CURRENT_DATE
                                            );

        pResultado   := 'DETALLE DE LA HISTORIA AGREGADO CORRECTAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_C_DET_HISTORIA_CLINICA;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_U_DET_HISTORIA_CLINICA (
        pDetHistoriaId       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DET_HISTORIA_CLINICA_ID%TYPE,
        pHistoriaId          IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pObservaciones       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.OBSERVACIONES%TYPE,
        pDiagnostico         IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DIAGNOSTICO%TYPE,
        pInterconsultas      IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.INTERCONSULTAS%TYPE,
        pUsuarioModificacion IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion   IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.FECHA_MODIFICACION%TYPE,
        --pRegistro            OUT    VAR_REFCURSOR,
        pResultado           OUT VARCHAR2,
        pMsgError            OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200) := 'PKG_SNH_HISTORIA_CLINICA.SNH_U_DET_HISTORIA_CLINICA=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        UPDATE HOSPITALARIO.SNH_DET_HISTORIA_CLINICA
        SET HISTORIA_CLINICA_ID    = NVL (pHistoriaId, HISTORIA_CLINICA_ID),
            OBSERVACIONES          = NVL (pObservaciones, OBSERVACIONES),
            DIAGNOSTICO            = NVL (pDiagnostico, DIAGNOSTICO),
            INTERCONSULTAS         = NVL (pInterconsultas, INTERCONSULTAS),
            ESTADO_REGISTRO        = NVL (pEstadoRegistro, ESTADO_REGISTRO),
            USUARIO_MODIFICACION   = NVL (pUsuarioModificacion, USUARIO_MODIFICACION),
            FECHA_MODIFICACION     = CURRENT_DATE
        WHERE DET_HISTORIA_CLINICA_ID = pDetHistoriaId;

        pResultado   :='DETALLE DE HISTORIA CLINICA ACTUALIZADA SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_U_DET_HISTORIA_CLINICA;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_D_DET_HISTORIA_CLINICA (
        pDetHistoriaId        IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DET_HISTORIA_CLINICA_ID%TYPE,
        pUsuarioModificacion  IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion    IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.FECHA_MODIFICACION%TYPE,
        pResultado            OUT VARCHAR2,
        pMsgError             OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200) := 'PKG_SNH_HISTORIA_CLINICA.SNH_D_DET_HISTORIA_CLINICA=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_PAS);

        UPDATE HOSPITALARIO.SNH_DET_HISTORIA_CLINICA
        SET ESTADO_REGISTRO        = NVL (pEstadoRegistro, ESTADO_REGISTRO),
            USUARIO_MODIFICACION   = NVL (pUsuarioModificacion, USUARIO_MODIFICACION),
            FECHA_MODIFICACION     = CURRENT_DATE
        WHERE DET_HISTORIA_CLINICA_ID = pDetHistoriaId;

        pResultado   :='EL DETALLE DE LA HISTORIA CLINICA FUE  ELIMINADA SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_D_DET_HISTORIA_CLINICA;
    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_R_DET_HISTORIA_CLINICA( 
        pDetHistoriaId       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DET_HISTORIA_CLINICA_ID%TYPE,
        pHistoriaId          IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pRegistro           OUT VAR_REFCURSOR,
        pResultado        OUT VARCHAR2,
        pMsgError         OUT VARCHAR2
                                        ) AS
    vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_R_DET_HISTORIA_CLINICA=>';
    cursorLectura VAR_REFCURSOR;
    recCount number;
    existeRegistro NUMBER(1);
    BEGIN   

           SELECT CASE WHEN EXISTS (SELECT HISTORIA_CLINICA_ID FROM HOSPITALARIO.SNH_DET_HISTORIA_CLINICA
                                      WHERE HISTORIA_CLINICA_ID = pHistoriaId)
            THEN 1
            ELSE 0            
            END INTO existeRegistro FROM dual;

            IF(existeRegistro=0) THEN
                pResultado:='NO SE ENCONTRARON DATOS CONCURRENTES';
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


    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_CRUD_DET_HISTORIA_CLINICA (
        pDetHistoriaId       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DET_HISTORIA_CLINICA_ID%TYPE,
        pHistoriaId          IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pObservaciones       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.OBSERVACIONES%TYPE,
        pDiagnostico         IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DIAGNOSTICO%TYPE,
        pInterconsultas      IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.INTERCONSULTAS%TYPE,
        pUsuarioRegistro     IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.FECHA_REGISTRO%TYPE,
        pUsuarioModificacion IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion   IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.FECHA_MODIFICACION%TYPE,
        pTipoOperacion              VARCHAR2,
        --pRegistro            OUT VAR_REFCURSOR,
        pResultado           OUT VARCHAR2,
        pMsgError            OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200) := 'PKG_SNH_HISTORIA_CLINICA.SNH_CRUD_DET_HISTORIA_CLINICA=>';
    BEGIN
        CASE
            WHEN pTipoOperacion IS NULL
            THEN
                pResultado   := 'NO SE HA INDICADO EL TIPO DE OPERACION';
                RAISE eParametroNull;
            WHEN pTipoOperacion = KINSERT
            THEN
                SNH_C_DET_HISTORIA_CLINICA (
                                    pHistoriaId      => pHistoriaId,
                                    pObservaciones   => pObservaciones,
                                    pDiagnostico     => pDiagnostico,
                                    pInterconsultas  => pInterconsultas,
                                    pUsuarioRegistro => pUsuarioRegistro,
                                    pFechaRegistro   => pFechaRegistro,
                                    pResultado       => pResultado,
                                    pMsgError        => pMsgError
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            WHEN pTipoOperacion = KUPDATE
            THEN
                SNH_U_DET_HISTORIA_CLINICA (
                                    pDetHistoriaId       => pDetHistoriaId,
                                    pHistoriaId          => pHistoriaId,
                                    pObservaciones       => pObservaciones,
                                    pDiagnostico         => pDiagnostico,
                                    pInterconsultas      => pInterconsultas,
                                    pUsuarioModificacion => pUsuarioModificacion,
                                    pFechaModificacion   => pFechaModificacion,
                                    --pRegistro            => pRegistro,
                                    pResultado           => pResultado,
                                    pMsgError            => pMsgError
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            WHEN pTipoOperacion = KDELETE
            THEN
                SNH_D_DET_HISTORIA_CLINICA (
                                    pDetHistoriaId       => pDetHistoriaId,
                                    pUsuarioModificacion => pUsuarioModificacion,
                                    pFechaModificacion   => pFechaModificacion,
                                    pResultado           => pResultado,
                                    pMsgError            => pMsgError
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            ELSE
                pResultado   := 'EL TIPO DE OPERACIÓN  ES INVALIDO';
                RAISE eParametrosInvalidos;
        END CASE;
    EXCEPTION
        WHEN eSalidaConError
        THEN
            pResultado   := vFirma || pResultado;
            pMsgError    := pResultado || pMsgError;
        WHEN eParametrosInvalidos
        THEN
            pResultado   := vFirma || pResultado;
            pMsgError    := pResultado;
        WHEN OTHERS
        THEN
            pResultado   := vFirma || 'Error no controlado' || pResultado;
            pMsgError    := pResultado || ' - ' || SQLERRM;
    END SNH_CRUD_DET_HISTORIA_CLINICA;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_C_ANTECEDENTES_PARTO (
        pAntecedentesId     IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.ANTE_PARTO_ID%TYPE,
        pHistoriaClinicaId  IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.HISTORIA_CLINICA_ID%TYPE,
        pLugarParto         IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.LUGAR_PARTO%TYPE,
        pFechaNacimiento    IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_NACIMIENTO%TYPE,
        pEdadGestacional    IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.EDAD_GESTACIONAL%TYPE,
        pDuracionParto      IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.DURACION_PARTO%TYPE,
        pAtencionParto      IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.ATENCION_PARTO%TYPE,
        pVia                IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.VIA%TYPE,
        pPresentacion       IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.PRESENTACION%TYPE,
        pEventualidades     IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.EVENTUALIDADES%TYPE,
        pUsuarioRegistro    IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.USUARIO_REGISTRO%TYPE,
        pFechaRegistro      IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_REGISTRO%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_C_ANTECEDENTES_PARTO=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        INSERT INTO HOSPITALARIO.SNH_MST_ANTE_PARTO (
                                         HISTORIA_CLINICA_ID,
                                         LUGAR_PARTO,
                                         FECHA_NACIMIENTO,
                                         EDAD_GESTACIONAL,
                                         DURACION_PARTO,
                                         ATENCION_PARTO,
                                         VIA,
                                         PRESENTACION,
                                         EVENTUALIDADES,
                                         ESTADO_REGISTRO,
                                         USUARIO_REGISTRO,
                                         FECHA_REGISTRO
                                         )
        VALUES                           (
                                        pHistoriaClinicaId,
                                        pLugarParto,
                                        pFechaNacimiento,
                                        pEdadGestacional,
                                        pDuracionParto,
                                        pAtencionParto,
                                        pVia,
                                        pPresentacion,
                                        pEventualidades,
                                        pEstadoRegistro,
                                        pUsuarioRegistro,
                                        CURRENT_DATE);

        pResultado   := 'ANTECEDENTES DEL PARTO  CREADO SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_C_ANTECEDENTES_PARTO;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_U_ANTECEDENTES_PARTO (
        pAntecedentesId      IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.ANTE_PARTO_ID%TYPE,
        pHistoriaClinicaId   IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.HISTORIA_CLINICA_ID%TYPE,
        pLugarParto          IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.LUGAR_PARTO%TYPE,
        pFechaNacimiento     IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_NACIMIENTO%TYPE,
        pEdadGestacional     IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.EDAD_GESTACIONAL%TYPE,
        pDuracionParto       IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.DURACION_PARTO%TYPE,
        pAtencionParto       IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.ATENCION_PARTO%TYPE,
        pVia                 IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.VIA%TYPE,
        pPresentacion        IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.PRESENTACION%TYPE,
        pEventualidades      IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.EVENTUALIDADES%TYPE,
        pUsuarioModificacion IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.USUARIO_MODIFICACION%TYPE,
        pMsgError            OUT VARCHAR2,
        pResultado           OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_U_ANTECEDENTES_PARTO=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        UPDATE HOSPITALARIO.SNH_MST_ANTE_PARTO
        SET 
            HISTORIA_CLINICA_ID    = NVL (pHistoriaClinicaId, HISTORIA_CLINICA_ID),
            LUGAR_PARTO            = NVL (pLugarParto, LUGAR_PARTO),
            FECHA_NACIMIENTO       = NVL (pFechaNacimiento, FECHA_NACIMIENTO),
            EDAD_GESTACIONAL       = NVL (pEdadGestacional, EDAD_GESTACIONAL),
            DURACION_PARTO         = NVL (pDuracionParto, DURACION_PARTO),
            ATENCION_PARTO         = NVL (pAtencionParto, ATENCION_PARTO),
            VIA                    = NVL (pVia, VIA),
            PRESENTACION           = NVL (pPresentacion, PRESENTACION),
            EVENTUALIDADES         = NVL (pEventualidades, EVENTUALIDADES),
            ESTADO_REGISTRO        = NVL (pEstadoRegistro, ESTADO_REGISTRO),
            USUARIO_MODIFICACION   = NVL (pUsuarioModificacion, USUARIO_MODIFICACION),
            FECHA_MODIFICACION     = CURRENT_DATE
        WHERE ANTE_PARTO_ID = pAntecedentesId;

        pResultado   :='ANTECEDENTES DEL PARTO  ACTUALIZADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_U_ANTECEDENTES_PARTO;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_D_ANTECEDENTES_PARTO (
        pAntecedentesId      IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.ANTE_PARTO_ID%TYPE,
        pUsuarioModificacion IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.USUARIO_MODIFICACION%TYPE,
        pMsgError            OUT VARCHAR2,
        pResultado           OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200) := 'PKG_SNH_HISTORIA_CLINICA.SNH_D_ANTECEDENTES_PARTO=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_PAS);

        UPDATE HOSPITALARIO.SNH_MST_ANTE_PARTO
        SET 
            ESTADO_REGISTRO        = NVL (pEstadoRegistro, ESTADO_REGISTRO),
            USUARIO_MODIFICACION   = NVL (pUsuarioModificacion, USUARIO_MODIFICACION),
            FECHA_MODIFICACION     = CURRENT_DATE
        WHERE ANTE_PARTO_ID = pAntecedentesId;

        pResultado   :='ANTECEDENTES DEL PARTO  ELIMINADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_D_ANTECEDENTES_PARTO;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_CRUD_ANTECEDENTES_PARTO (
        pAntecedentesId      IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.ANTE_PARTO_ID%TYPE,
        pHistoriaClinicaId   IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.HISTORIA_CLINICA_ID%TYPE,
        pLugarParto          IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.LUGAR_PARTO%TYPE,
        pFechaNacimiento     IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_NACIMIENTO%TYPE,
        pEdadGestacional     IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.EDAD_GESTACIONAL%TYPE,
        pDuracionParto       IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.DURACION_PARTO%TYPE,
        pAtencionParto       IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.ATENCION_PARTO%TYPE,
        pVia                 IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.VIA%TYPE,
        pPresentacion        IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.PRESENTACION%TYPE,
        pEventualidades      IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.EVENTUALIDADES%TYPE,
        pUsuarioRegistro     IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.USUARIO_REGISTRO%TYPE,
        pFechaRegistro       IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_REGISTRO%TYPE,
        pUsuarioModificacion IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion   IN   HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_MODIFICACION%TYPE,
        pTipoOperacion       IN     VARCHAR2,
        pMsgError            OUT VARCHAR2,
        pResultado           OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_CRUD_ANTECEDENTES_PARTO=>';
    --  pEstadoRegistro NUMBER(10);
    BEGIN
        CASE
            WHEN pTipoOperacion IS NULL
            THEN
                pResultado   := 'No se ha indicado el tipo de operacion';
                RAISE eParametroNull;
            WHEN pTipoOperacion = KINSERT
            THEN
                SNH_C_ANTECEDENTES_PARTO (
                                    pAntecedentesId    => pAntecedentesId,
                                    pHistoriaClinicaId => pHistoriaClinicaId,
                                    pLugarParto        => pLugarParto,
                                    pFechaNacimiento   => pFechaNacimiento,
                                    pEdadGestacional   => pEdadGestacional,
                                    pDuracionParto     => pDuracionParto,
                                    pAtencionParto     => pAtencionParto,
                                    pVia               => pVia,
                                    pPresentacion      => pPresentacion,
                                    pEventualidades    => pEventualidades,
                                    pUsuarioRegistro   => pUsuarioRegistro,
                                    pFechaRegistro     => pFechaRegistro,
                                    pMsgError          => pMsgError,
                                    pResultado         => pResultado
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            WHEN pTipoOperacion = KUPDATE
            THEN
                SNH_U_ANTECEDENTES_PARTO (
                                    pAntecedentesId      => pAntecedentesId,
                                    pHistoriaClinicaId   => pHistoriaClinicaId,
                                    pLugarParto          => pLugarParto,
                                    pFechaNacimiento     => pFechaNacimiento,
                                    pEdadGestacional     => pEdadGestacional,
                                    pDuracionParto       => pDuracionParto,
                                    pAtencionParto       => pAtencionParto,
                                    pVia                 => pVia,
                                    pPresentacion        => pPresentacion,
                                    pEventualidades      => pEventualidades,
                                    pUsuarioModificacion => pUsuarioModificacion,
                                    pMsgError            => pMsgError,
                                    pResultado           => pResultado
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            WHEN pTipoOperacion = KDELETE
            THEN
                SNH_D_ANTECEDENTES_PARTO (
                                    pAntecedentesId      => pAntecedentesId,
                                    pUsuarioModificacion => pUsuarioModificacion,
                                    pMsgError            => pMsgError,
                                    pResultado           => pResultado
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            ELSE
                --pResultado := 'EL PARÁMETRO pTipoOperacion ['||pTipoOperacion|| '] ES INVALIDO';
                pResultado   := 'EL TIPO DE OPERACIÓN  ES INVALIDO';
                RAISE eParametrosInvalidos;
        END CASE;
    EXCEPTION
        WHEN eParametroNull
        THEN
            pMsgError   := pMsgError || pResultado;
        WHEN eSalidaConError
        THEN
            --pMsgError:= pMsgError||
            pResultado   := 'ERROR';
        WHEN eParametrosInvalidos
        THEN
            pMsgError   := pMsgError || pResultado;
    END SNH_CRUD_ANTECEDENTES_PARTO;
    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_C_MST_ANTE_POSTNATALES  (
       -- pAntePostnatalesId     IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ANTE_POSTNATALES_ID%TYPE,
        pHistoriaClinicaId     IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.HISTORIA_CLINICA_ID%TYPE,
        pApgar1                IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.APGAR1%TYPE,
        pApgar5                IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.APGAR5%TYPE,
        pPeso                  IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.PESO%TYPE,
        pTalla                 IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.TALLA%TYPE,
        pAsfixia               IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ASFIXIA%TYPE,
        pDescripcionAsfixia    IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.DESCRIPCION_ASFIXIA%TYPE,
        pAlojamientoConjunto   IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ALOJAMIENTO_CONJUNTO%TYPE,
        pTiempoMadre           IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.TIEMPO_MADRE%TYPE,
        pHorasMadre            IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.HORAS_MADRE%TYPE,
        pHospitalizacion       IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.HOSPITALIZACION%TYPE,
        pUsuarioRegistro       IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.USUARIO_REGISTRO%TYPE,
        pFechaRegistro         IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.FECHA_REGISTRO%TYPE,
        pResultado             OUT VARCHAR2,
        pMsgError              OUT VARCHAR2
       )
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_C_MST_ANTE_POSTNATALES=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        INSERT INTO HOSPITALARIO.SNH_MST_ANTE_POSTNATALES (
                                         HISTORIA_CLINICA_ID, 
                                         APGAR1, 
                                         APGAR5, 
                                         PESO, 
                                         TALLA, 
                                         ASFIXIA, 
                                         DESCRIPCION_ASFIXIA, 
                                         ALOJAMIENTO_CONJUNTO, 
                                         TIEMPO_MADRE, 
                                         HORAS_MADRE, 
                                         HOSPITALIZACION, 
                                         ESTADO_REGISTRO, 
                                         USUARIO_REGISTRO, 
                                         FECHA_REGISTRO
                                         )
        VALUES                           (
                                        pHistoriaClinicaId,
                                        pApgar1,
                                        pApgar5,
                                        pPeso,
                                        pTalla,
                                        pAsfixia,
                                        pDescripcionAsfixia,
                                        pAlojamientoConjunto,
                                        pTiempoMadre,
                                        pHorasMadre,
                                        pHospitalizacion,
                                        pEstadoRegistro,
                                        pUsuarioRegistro,
                                        CURRENT_DATE
                                        );

        pResultado   := 'ANTECEDENTES POSTNATALES CREADOS SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_C_MST_ANTE_POSTNATALES ;

    /****************************************************************************************************************************************************************************/
    PROCEDURE  SNH_U_MST_ANTE_POSTNATALES  (
        pAntePostnatalesId     IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ANTE_POSTNATALES_ID%TYPE,
        pHistoriaClinicaId     IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.HISTORIA_CLINICA_ID%TYPE,
        pApgar1                IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.APGAR1%TYPE,
        pApgar5                IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.APGAR5%TYPE,
        pPeso                  IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.PESO%TYPE,
        pTalla                 IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.TALLA%TYPE,
        pAsfixia               IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ASFIXIA%TYPE,
        pDescripcionAsfixia    IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.DESCRIPCION_ASFIXIA%TYPE,
        pAlojamientoConjunto   IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ALOJAMIENTO_CONJUNTO%TYPE,
        pTiempoMadre           IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.TIEMPO_MADRE%TYPE,
        pHorasMadre            IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.HORAS_MADRE%TYPE,
        pHospitalizacion       IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.HOSPITALIZACION%TYPE,
        pUsuarioModificacion   IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.USUARIO_MODIFICACION%TYPE,
        pResultado             OUT VARCHAR2,
        pMsgError              OUT VARCHAR2
        )
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_U_MST_ANTE_POSTNATALES=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        UPDATE SNH_MST_ANTE_POSTNATALES
        SET 
            HISTORIA_CLINICA_ID    = NVL (pHistoriaClinicaId, HISTORIA_CLINICA_ID),
            APGAR1                 = NVL (pApgar1,APGAR1 ),
            APGAR5                 = NVL (pApgar5,APGAR5),
            PESO                   = NVL (pPeso,PESO),
            TALLA                  = NVL (pTalla,TALLA),
            ASFIXIA                = NVL (pAsfixia,ASFIXIA),
            DESCRIPCION_ASFIXIA    = NVL (pDescripcionAsfixia,DESCRIPCION_ASFIXIA),
            ALOJAMIENTO_CONJUNTO   = NVL (pAlojamientoConjunto,ALOJAMIENTO_CONJUNTO),
            TIEMPO_MADRE           = NVL (pTiempoMadre,TIEMPO_MADRE),
            HORAS_MADRE            = NVL (pHorasMadre,HORAS_MADRE),
            HOSPITALIZACION        = NVL (pHospitalizacion,HOSPITALIZACION),
            ESTADO_REGISTRO        = NVL (pEstadoRegistro, ESTADO_REGISTRO),  
            USUARIO_MODIFICACION   = NVL (pUsuarioModificacion,USUARIO_MODIFICACION),
            FECHA_MODIFICACION     = CURRENT_DATE     
        WHERE ANTE_POSTNATALES_ID = pAntePostnatalesId;

        pResultado   :='ANTECEDENTES POSTNATALES  ACTUALIZADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_U_MST_ANTE_POSTNATALES;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_D_MST_ANTE_POSTNATALES  (
        pAntePostnatalesId       IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ANTE_POSTNATALES_ID%TYPE,
        pUsuarioModificacion   IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.USUARIO_MODIFICACION%TYPE,
        pResultado             OUT VARCHAR2,
        pMsgError              OUT VARCHAR2
        )
    AS
        vFirma         VARCHAR2 (200) := 'PKG_SNH_HISTORIA_CLINICA.SNH_D_ANTECEDENTES_PARTO=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_PAS);

        UPDATE  SNH_MST_ANTE_POSTNATALES
        SET 
            ESTADO_REGISTRO        = NVL (pEstadoRegistro, ESTADO_REGISTRO),
            USUARIO_MODIFICACION   = NVL (pUsuarioModificacion,USUARIO_MODIFICACION),
            FECHA_MODIFICACION     = CURRENT_DATE
        WHERE  ANTE_POSTNATALES_ID = pAntePostnatalesId;

        pResultado   :='ANTECEDENTES POSTNATALES   ELIMINADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_D_MST_ANTE_POSTNATALES;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_CRUD_ANTE_POSTNATALES (
        pAntePostnatalesId     IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ANTE_POSTNATALES_ID%TYPE,
        pHistoriaClinicaId     IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.HISTORIA_CLINICA_ID%TYPE,
        pApgar1                IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.APGAR1%TYPE,
        pApgar5                IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.APGAR5%TYPE,
        pPeso                  IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.PESO%TYPE,
        pTalla                 IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.TALLA%TYPE,
        pAsfixia               IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ASFIXIA%TYPE,
        pDescripcionAsfixia    IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.DESCRIPCION_ASFIXIA%TYPE,
        pAlojamientoConjunto   IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ALOJAMIENTO_CONJUNTO%TYPE,
        pTiempoMadre           IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.TIEMPO_MADRE%TYPE,
        pHorasMadre            IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.HORAS_MADRE%TYPE,
        pHospitalizacion       IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.HOSPITALIZACION%TYPE,
        pUsuarioRegistro       IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.USUARIO_REGISTRO%TYPE,
        pFechaRegistro         IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.FECHA_REGISTRO%TYPE,
        pUsuarioModificacion   IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.USUARIO_MODIFICACION%TYPE,
        pTipoOperacion         VARCHAR2,
        pResultado             OUT VARCHAR2,
        pMsgError              OUT VARCHAR2

        )
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_CRUD_ANTE_POSTNATALES=>';
    --  pEstadoRegistro NUMBER(10);
    BEGIN
        CASE
            WHEN pTipoOperacion IS NULL
            THEN
                pResultado   := 'No se ha indicado el tipo de operacion';
                RAISE eParametroNull;
            WHEN pTipoOperacion = KINSERT
            THEN
                SNH_C_MST_ANTE_POSTNATALES (

                                    pHistoriaClinicaId     => pHistoriaClinicaId,
                                    pApgar1                => pApgar1,
                                    pApgar5                => pApgar5,
                                    pPeso                  => pPeso,
                                    pTalla                 => pTalla,
                                    pAsfixia               => pAsfixia,
                                    pDescripcionAsfixia    => pDescripcionAsfixia,
                                    pAlojamientoConjunto   => pAlojamientoConjunto,
                                    pTiempoMadre           => pTiempoMadre,
                                    pHorasMadre            => pHorasMadre,
                                    pHospitalizacion       => pHospitalizacion,
                                    pUsuarioRegistro       => pUsuarioRegistro,
                                    pFechaRegistro         => pFechaRegistro,
                                    pResultado             => pResultado,
                                    pMsgError              => pMsgError

                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;

            WHEN pTipoOperacion = KUPDATE
            THEN
                SNH_U_MST_ANTE_POSTNATALES  (
                                    pAntePostnatalesId     => pAntePostnatalesId,
                                    pHistoriaClinicaId     => pHistoriaClinicaId,
                                    pApgar1                => pApgar1,
                                    pApgar5                => pApgar5,
                                    pPeso                  => pPeso,
                                    pTalla                 => pTalla,
                                    pAsfixia               => pAsfixia,
                                    pDescripcionAsfixia    => pDescripcionAsfixia,
                                    pAlojamientoConjunto   => pAlojamientoConjunto,
                                    pTiempoMadre           => pTiempoMadre,
                                    pHorasMadre            => pHorasMadre,
                                    pHospitalizacion       => pHospitalizacion,
                                    pUsuarioModificacion   => pUsuarioModificacion,
                                    pResultado             => pResultado,
                                    pMsgError              => pMsgError

                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            WHEN pTipoOperacion = KDELETE
            THEN
                SNH_D_MST_ANTE_POSTNATALES  (
                                    pAntePostnatalesId     => pAntePostnatalesId,
                                    pUsuarioModificacion   => pUsuarioModificacion,
                                    pResultado             => pResultado,
                                    pMsgError              => pMsgError                                                                       
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            ELSE
                --pResultado := 'EL PARÁMETRO pTipoOperacion ['||pTipoOperacion|| '] ES INVALIDO';
                pResultado   := 'EL TIPO DE OPERACIÓN  ES INVALIDO';
                RAISE eParametrosInvalidos;
        END CASE;
    EXCEPTION
        WHEN eParametroNull
        THEN
            pMsgError   := pMsgError || pResultado;
        WHEN eSalidaConError
        THEN
            --pMsgError:= pMsgError||
            pResultado   := 'ERROR';
        WHEN eParametrosInvalidos
        THEN
            pMsgError   := pMsgError || pResultado;
    END SNH_CRUD_ANTE_POSTNATALES;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_C_MST_ALIMEN_PEDIATRICA (
        pAlimentPediatricaId     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ALIMEN_PEDIATRICA_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.HISTORIA_CLINICA_ID%TYPE,
        pLactanciaExclusiva      IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.LACTANCIA_EXCLUSIVA%TYPE,
        pLactanciaMixta          IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.LACTANCIA_MIXTA%TYPE,
        pDuracionMixta           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.DURACION_LACT_MIXTA%TYPE,
        pDuracionExclusiva       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.DURACION_LACT_EXCLUSIVA%TYPE,
        pAblactacion             IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ABLACTACION%TYPE,
        pUsuarioRegistro         IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_REGISTRO%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_C_MST_ALIMEN_PEDIATRICA=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        INSERT INTO HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA (
                                         HISTORIA_CLINICA_ID,
                                         LACTANCIA_EXCLUSIVA,
                                         LACTANCIA_MIXTA,
                                         DURACION_LACT_MIXTA,
                                         DURACION_LACT_EXCLUSIVA,
                                         ABLACTACION,
                                         ESTADO_REGISTRO,
                                         USUARIO_REGISTRO,
                                         FECHA_REGISTRO
                                         )
        VALUES                           (
                                        pHistoriaId,
                                        pLactanciaExclusiva,
                                        pLactanciaMixta,
                                        pDuracionMixta,
                                        pDuracionExclusiva,
                                        pAblactacion,
                                        pEstadoRegistro,
                                        pUsuarioRegistro,
                                        CURRENT_DATE);

        pResultado   := 'DATOS DE ALIMENTACION PEDIATRICA CREADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_C_MST_ALIMEN_PEDIATRICA;
    /****************************************************************************************************************************************************************************/
    PROCEDURE  SNH_U_MST_ALIMEN_PEDIATRICA  (
        pAlimentPediatricaId     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ALIMEN_PEDIATRICA_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.HISTORIA_CLINICA_ID%TYPE,
        pLactanciaExclusiva      IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.LACTANCIA_EXCLUSIVA%TYPE,
        pLactanciaMixta          IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.LACTANCIA_MIXTA%TYPE,
        pDuracionMixta           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.DURACION_LACT_MIXTA%TYPE,
        pDuracionExclusiva       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.DURACION_LACT_EXCLUSIVA%TYPE,
        pAblactacion             IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ABLACTACION%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_U_MST_ALIMEN_PEDIATRICA=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        UPDATE SNH_MST_ALIMEN_PEDIATRICA
        SET 
            HISTORIA_CLINICA_ID    = NVL (pHistoriaId, HISTORIA_CLINICA_ID),
            LACTANCIA_EXCLUSIVA    = NVL (pLactanciaExclusiva,LACTANCIA_EXCLUSIVA ),
            LACTANCIA_MIXTA        = NVL (pLactanciaMixta,LACTANCIA_MIXTA),
            DURACION_LACT_MIXTA    = NVL (pDuracionMixta,DURACION_LACT_MIXTA),
            DURACION_LACT_EXCLUSIVA= NVL (pDuracionExclusiva,DURACION_LACT_EXCLUSIVA),
            ABLACTACION            = NVL (pAblactacion,ABLACTACION),
            ESTADO_REGISTRO        = NVL (pEstadoRegistro, ESTADO_REGISTRO),  
            USUARIO_MODIFICACION   = NVL (pUsuarioModificacion,USUARIO_MODIFICACION),
            FECHA_MODIFICACION     = CURRENT_DATE     
        WHERE ALIMEN_PEDIATRICA_ID = pAlimentPediatricaId;

        pResultado   :='DATOS DE ALIMENTACION PEDIATRICA   ACTUALIZADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_U_MST_ALIMEN_PEDIATRICA;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_D_MST_ALIMEN_PEDIATRICA (
        pAlimentPediatricaId     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ALIMEN_PEDIATRICA_ID%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2)

    AS
        vFirma         VARCHAR2 (200) := 'PKG_SNH_HISTORIA_CLINICA.SNH_D_MST_ALIMEN_PEDIATRICA=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_PAS);

        UPDATE  SNH_MST_ALIMEN_PEDIATRICA
        SET 
            ESTADO_REGISTRO         = NVL (pEstadoRegistro, ESTADO_REGISTRO),
            USUARIO_MODIFICACION    = NVL (pUsuarioModificacion,USUARIO_MODIFICACION),
            FECHA_MODIFICACION      = CURRENT_DATE
        WHERE  ALIMEN_PEDIATRICA_ID = pAlimentPediatricaId;

        pResultado   :='DATOS DE ALIMENTACION PEDIATRICA ELIMINADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_D_MST_ALIMEN_PEDIATRICA;

     PROCEDURE SNH_CRUD_ALIMEN_PEDIATRICA (
        pAlimentPediatricaId     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ALIMEN_PEDIATRICA_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.HISTORIA_CLINICA_ID%TYPE,
        pLactanciaExclusiva      IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.LACTANCIA_EXCLUSIVA%TYPE,
        pLactanciaMixta          IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.LACTANCIA_MIXTA%TYPE,
        pDuracionMixta           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.DURACION_LACT_MIXTA%TYPE,
        pDuracionExclusiva       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.DURACION_LACT_EXCLUSIVA%TYPE,
        pAblactacion             IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ABLACTACION%TYPE,
        pUsuarioRegistro         IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_REGISTRO%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2,
        pTipoOperacion         VARCHAR2

        )
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_CRUD_ALIMEN_PEDIATRICA=>';
    --  pEstadoRegistro NUMBER(10);
    BEGIN
        CASE
            WHEN pTipoOperacion IS NULL
            THEN
                pResultado   := 'No se ha indicado el tipo de operacion';
                RAISE eParametroNull;
            WHEN pTipoOperacion = KINSERT
            THEN
                SNH_C_MST_ALIMEN_PEDIATRICA (
                                    pAlimentPediatricaId     =>    pAlimentPediatricaId,
                                    pHistoriaId              =>    pHistoriaId,
                                    pLactanciaExclusiva      =>    pLactanciaExclusiva,
                                    pLactanciaMixta          =>    pLactanciaMixta,
                                    pDuracionMixta           =>    pDuracionMixta,
                                    pDuracionExclusiva       =>    pDuracionExclusiva,
                                    pAblactacion             =>    pAblactacion,
                                    pUsuarioRegistro         =>    pUsuarioRegistro,
                                    pFechaRegistro           =>    pFechaRegistro,
                                    pMsgError                =>    pMsgError,
                                    pResultado               =>    pResultado                                    
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;

            WHEN pTipoOperacion = KUPDATE
            THEN
                SNH_U_MST_ALIMEN_PEDIATRICA  (
                                    pAlimentPediatricaId     =>   pAlimentPediatricaId,   
                                    pHistoriaId              =>   pHistoriaId,
                                    pLactanciaExclusiva      =>   pLactanciaExclusiva,
                                    pLactanciaMixta          =>   pLactanciaMixta,
                                    pDuracionMixta           =>   pDuracionMixta,
                                    pDuracionExclusiva       =>   pDuracionExclusiva,
                                    pAblactacion             =>   pAblactacion,
                                    pUsuarioModificacion     =>   pUsuarioModificacion,
                                    pFechaModificacion       =>   pFechaModificacion,
                                    pMsgError                =>   pMsgError,
                                    pResultado               =>   pResultado

                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            WHEN pTipoOperacion = KDELETE
            THEN
                SNH_D_MST_ALIMEN_PEDIATRICA (
                                    pAlimentPediatricaId     =>   pAlimentPediatricaId,
                                    pUsuarioModificacion     =>   pUsuarioModificacion,
                                    pFechaModificacion       =>   pFechaModificacion,
                                    pMsgError                =>   pMsgError,
                                    pResultado               =>   pResultado                                                                     
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            ELSE
                --pResultado := 'EL PARÁMETRO pTipoOperacion ['||pTipoOperacion|| '] ES INVALIDO';
                pResultado   := 'EL TIPO DE OPERACIÓN  ES INVALIDO';
                RAISE eParametrosInvalidos;
        END CASE;
    EXCEPTION
        WHEN eParametroNull
        THEN
            pMsgError   := pMsgError || pResultado;
        WHEN eSalidaConError
        THEN
            --pMsgError:= pMsgError||
            pResultado   := 'ERROR';
        WHEN eParametrosInvalidos
        THEN
            pMsgError   := pMsgError || pResultado;
    END SNH_CRUD_ALIMEN_PEDIATRICA;



    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_C_MST_ANTE_PSICOMOTOR(
        pHistoriaId           IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.HISTORIA_CLINICA_ID%TYPE,
        pTipoDesarrollo       IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.TIPO_DESARROLLO%TYPE,
        pConfirmaDesarrollo   IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.CONFIRMA_DESARROLLO%TYPE,
        pEdad                 IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.EDAD%TYPE,
        pUsuarioRegistro      IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.USUARIO_REGISTRO%TYPE,    
        pMsgError             OUT VARCHAR2,
        pResultado            OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_C_MST_ANTE_PSICOMOTOR=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        INSERT INTO HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR (
                                         HISTORIA_CLINICA_ID, 
                                         TIPO_DESARROLLO, 
                                         CONFIRMA_DESARROLLO, 
                                         EDAD, 
                                         ESTADO_REGISTRO, 
                                         USUARIO_REGISTRO, 
                                         FECHA_REGISTRO
                                         )
        VALUES                           (
                                        pHistoriaId,
                                        pTipoDesarrollo,
                                        pConfirmaDesarrollo,
                                        pEdad,
                                        pEstadoRegistro,
                                        pUsuarioRegistro,
                                        CURRENT_DATE);

        pResultado   := 'DATOS DE ANTECEDENTES PSICOMOTOR CREADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_C_MST_ANTE_PSICOMOTOR;

    /****************************************************************************************************************************************************************************/
    PROCEDURE  SNH_U_MST_ANTE_PSICOMOTOR  (
        pAntePsicomotorId     IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.ANTE_PSICOMOTOR_ID%TYPE,
        pHistoriaId           IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.HISTORIA_CLINICA_ID%TYPE,
        pTipoDesarrollo       IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.TIPO_DESARROLLO%TYPE,
        pConfirmaDesarrollo   IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.CONFIRMA_DESARROLLO%TYPE,
        pEdad                 IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.EDAD%TYPE,
        pUsuarioModificacion  IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.USUARIO_MODIFICACION%TYPE,    
        pMsgError             OUT VARCHAR2,
        pResultado            OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_U_MST_ANTE_PSICOMOTOR=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        UPDATE SNH_MST_ANTE_PSICOMOTOR
        SET 
            HISTORIA_CLINICA_ID    = NVL (pHistoriaId, HISTORIA_CLINICA_ID),
            TIPO_DESARROLLO        = NVL (pTipoDesarrollo, TIPO_DESARROLLO), 
            CONFIRMA_DESARROLLO    = NVL (pConfirmaDesarrollo, CONFIRMA_DESARROLLO), 
            EDAD                   = NVL (pEdad,EDAD),
            ESTADO_REGISTRO        = NVL (pEstadoRegistro, ESTADO_REGISTRO),  
            USUARIO_MODIFICACION   = NVL (pUsuarioModificacion,USUARIO_MODIFICACION),
            FECHA_MODIFICACION     = CURRENT_DATE     
        WHERE ANTE_PSICOMOTOR_ID   = pAntePsicomotorId;

        pResultado   :='DATOS DE ANTECEDENTES PSICOMOTOR   ACTUALIZADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_U_MST_ANTE_PSICOMOTOR;
    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_D_MST_ANTE_PSICOMOTOR (
        pAntePsicomotorId     IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.ANTE_PSICOMOTOR_ID%TYPE,
        pUsuarioModificacion  IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.USUARIO_MODIFICACION%TYPE,    
        pMsgError             OUT VARCHAR2,
        pResultado            OUT VARCHAR2)

    AS
        vFirma         VARCHAR2 (200) := 'PKG_SNH_HISTORIA_CLINICA.SNH_D_MST_ANTE_PSICOMOTOR=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_PAS);

        UPDATE  SNH_MST_ANTE_PSICOMOTOR
        SET 
            ESTADO_REGISTRO         = NVL (pEstadoRegistro, ESTADO_REGISTRO),
            USUARIO_MODIFICACION    = NVL (pUsuarioModificacion,USUARIO_MODIFICACION),
            FECHA_MODIFICACION      = CURRENT_DATE
        WHERE  ANTE_PSICOMOTOR_ID   = pAntePsicomotorId;

        pResultado   :='DATOS DE ANTECEDENTES PSICOMOTOR ELIMINADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_D_MST_ANTE_PSICOMOTOR ;
      /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_CRUD_ANTE_PSICOMOTOR (
        pAntePsicomotorId     IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.ANTE_PSICOMOTOR_ID%TYPE,
        pHistoriaId           IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.HISTORIA_CLINICA_ID%TYPE,
        pTipoDesarrollo       IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.TIPO_DESARROLLO%TYPE,
        pConfirmaDesarrollo   IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.CONFIRMA_DESARROLLO%TYPE,
        pEdad                 IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.EDAD%TYPE,
        pUsuarioRegistro      IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.USUARIO_REGISTRO%TYPE,  
        pUsuarioModificacion  IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.USUARIO_MODIFICACION%TYPE,    
        pMsgError             OUT VARCHAR2,
        pResultado            OUT VARCHAR2,
        pTipoOperacion         VARCHAR2

        )
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_CRUD_ANTE_PSICOMOTOR=>';
    --  pEstadoRegistro NUMBER(10);
    BEGIN
        CASE
            WHEN pTipoOperacion IS NULL
            THEN
                pResultado   := 'No se ha indicado el tipo de operacion';
                RAISE eParametroNull;
            WHEN pTipoOperacion = KINSERT
            THEN

                SNH_C_MST_ANTE_PSICOMOTOR( 
                                    pHistoriaId           =>    pHistoriaId,
                                    pTipoDesarrollo       =>    pTipoDesarrollo,
                                    pConfirmaDesarrollo   =>    pConfirmaDesarrollo,
                                    pEdad                 =>    pEdad,
                                    pUsuarioRegistro      =>    pUsuarioRegistro,
                                    pMsgError             =>    pMsgError,
                                    pResultado            =>    pResultado);

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;

            WHEN pTipoOperacion = KUPDATE
            THEN


                SNH_U_MST_ANTE_PSICOMOTOR  (
                                    pAntePsicomotorId     =>    pAntePsicomotorId,
                                    pHistoriaId           =>    pHistoriaId,
                                    pTipoDesarrollo       =>    pTipoDesarrollo,
                                    pConfirmaDesarrollo   =>    pConfirmaDesarrollo,
                                    pEdad                 =>    pEdad,
                                    pUsuarioModificacion  =>    pUsuarioModificacion,   
                                    pMsgError             =>    pMsgError,
                                    pResultado            =>    pResultado
                                    );


                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            WHEN pTipoOperacion = KDELETE
            THEN
                SNH_D_MST_ANTE_PSICOMOTOR (
                                    pAntePsicomotorId     =>    pAntePsicomotorId,
                                    pUsuarioModificacion  =>    pUsuarioModificacion,  
                                    pMsgError             =>    pMsgError,
                                    pResultado            =>    pResultado
                                    );


                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            ELSE
                --pResultado := 'EL PARÁMETRO pTipoOperacion ['||pTipoOperacion|| '] ES INVALIDO';
                pResultado   := 'EL TIPO DE OPERACIÓN  ES INVALIDO';
                RAISE eParametrosInvalidos;
        END CASE;
    EXCEPTION
        WHEN eParametroNull
        THEN
            pMsgError   := pMsgError || pResultado;
        WHEN eSalidaConError
        THEN
            --pMsgError:= pMsgError||
            pResultado   := 'ERROR';
        WHEN eParametrosInvalidos
        THEN
            pMsgError   := pMsgError || pResultado;
    END SNH_CRUD_ANTE_PSICOMOTOR;

    PROCEDURE SNH_C_ANTE_SOCIOECONOMICO (
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HISTORIA_CLINICA_ID%TYPE,
        pCasa                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.CASA%TYPE,
        pParedes                 IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.PAREDES%TYPE,
        pPiso                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.PISO%TYPE,
        pTecho                   IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.TECHO%TYPE,
        pServiciosHigienicos     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.SERVICIOS_HIGIENICOS%TYPE,
        pHabitaciones            IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HABITACIONES%TYPE,
        pAgua                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.AGUA%TYPE,
        pLugarAgua               IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_AGUA%TYPE,
        pLuz                     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUZ%TYPE,
        pLugarExcretas           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_EXCRETAS%TYPE,
        pNumeroPersonas          IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.NUMERO_PERSONAS%TYPE,
        pAnimales                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANIMALES%TYPE,
        pTelefono                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.TELEFONO%TYPE,
        pObservaciones           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OBSERVACIONES%TYPE,
        pOtros                   IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OTROS%TYPE,
        pHacimiento              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HACIMIENTO%TYPE,
        pUsuarioRegistro         IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.USUARIO_REGISTRO%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_C_ANTE_SOCIOECONOMICO=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        INSERT INTO HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO (
                                         HISTORIA_CLINICA_ID, 
                                         CASA, 
                                         PAREDES, 
                                         PISO, 
                                         TECHO, 
                                         SERVICIOS_HIGIENICOS, 
                                         HABITACIONES, 
                                         AGUA, 
                                         LUGAR_AGUA, 
                                         LUZ, 
                                         LUGAR_EXCRETAS, 
                                         NUMERO_PERSONAS, 
                                         ANIMALES, 
                                         TELEFONO, 
                                         OBSERVACIONES, 
                                         OTROS, 
                                         HACIMIENTO, 
                                         ESTADO_REGISTRO, 
                                         USUARIO_REGISTRO, 
                                         FECHA_REGISTRO
                                         )
        VALUES                           (
                                        pHistoriaId,
                                        pCasa,
                                        pParedes,
                                        pPiso,
                                        pTecho,
                                        pServiciosHigienicos,
                                        pHabitaciones,
                                        pAgua,
                                        pLugarAgua,
                                        pLuz,
                                        pLugarExcretas,
                                        pNumeroPersonas,
                                        pAnimales,
                                        pTelefono,
                                        pObservaciones,
                                        pOtros,
                                        pHacimiento,
                                        pEstadoRegistro,
                                        pUsuarioRegistro,
                                        CURRENT_DATE);

        pResultado   := 'DATOS DE ANTECEDENTES SOCIOECONOMICOS CREADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_C_ANTE_SOCIOECONOMICO;
    /****************************************************************************************************************************************************************************/
    PROCEDURE  SNH_U_ANTE_SOCIOECONOMICO  (
        pAnteSocioeconomicoId    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANTE_SOCIOECONOMICO_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HISTORIA_CLINICA_ID%TYPE,
        pCasa                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.CASA%TYPE,
        pParedes                 IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.PAREDES%TYPE,
        pPiso                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.PISO%TYPE,
        pTecho                   IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.TECHO%TYPE,
        pServiciosHigienicos     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.SERVICIOS_HIGIENICOS%TYPE,
        pHabitaciones            IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HABITACIONES%TYPE,
        pAgua                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.AGUA%TYPE,
        pLugarAgua               IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_AGUA%TYPE,
        pLuz                     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUZ%TYPE,
        pLugarExcretas           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_EXCRETAS%TYPE,
        pNumeroPersonas          IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.NUMERO_PERSONAS%TYPE,
        pAnimales                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANIMALES%TYPE,
        pTelefono                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.TELEFONO%TYPE,
        pObservaciones           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OBSERVACIONES%TYPE,
        pOtros                   IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OTROS%TYPE,
        pHacimiento              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HACIMIENTO%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.USUARIO_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2)
    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_U_ANTE_SOCIOECONOMICO=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);

        UPDATE SNH_MST_ANTE_SOCIOECONOMICO
        SET 
            HISTORIA_CLINICA_ID     = NVL    (pHistoriaId,HISTORIA_CLINICA_ID),
            CASA                    = NVL    (pCasa, CASA),                       
            PAREDES                 = NVL    (pParedes,PAREDES), 
            PISO                    = NVL    (pPiso,PISO), 
            TECHO                   = NVL    (pTecho,TECHO), 
            SERVICIOS_HIGIENICOS    = NVL    (pServiciosHigienicos, SERVICIOS_HIGIENICOS), 
            HABITACIONES            = NVL    (pHabitaciones,HABITACIONES), 
            AGUA                    = NVL    (pAgua,AGUA), 
            LUGAR_AGUA              = NVL    (pLugarAgua,LUGAR_AGUA), 
            LUZ                     = NVL    (pLuz,LUZ), 
            LUGAR_EXCRETAS          = NVL    (pLugarExcretas,LUGAR_EXCRETAS ), 
            NUMERO_PERSONAS         = NVL    (pNumeroPersonas, NUMERO_PERSONAS), 
            ANIMALES                = NVL    (pAnimales,ANIMALES ), 
            TELEFONO                = NVL    (pTelefono,TELEFONO), 
            OBSERVACIONES           = NVL    (pObservaciones, OBSERVACIONES), 
            OTROS                   = NVL    (pOtros,OTROS ), 
            ESTADO_REGISTRO         = NVL    (pEstadoRegistro, ESTADO_REGISTRO),          
            USUARIO_MODIFICACION    = NVL    (pUsuarioModificacion, USUARIO_MODIFICACION), 
            FECHA_MODIFICACION      = CURRENT_DATE
        WHERE ANTE_SOCIOECONOMICO_ID = pAnteSocioeconomicoId;

        pResultado   :='DATOS DE ANTECEDENTES SOCIO ECONOMICOS ACTUALIZADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_U_ANTE_SOCIOECONOMICO;

    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_D_ANTE_SOCIOECONOMICO (
        pAnteSocioeconomicoId    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANTE_SOCIOECONOMICO_ID%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.USUARIO_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2)

    AS
        vFirma         VARCHAR2 (200) := 'PKG_SNH_HISTORIA_CLINICA.SNH_D_ANTE_SOCIOECONOMICO=>';
        pEstadoRegistro NUMBER (10);
    BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_PAS);

        UPDATE  SNH_MST_ANTE_SOCIOECONOMICO
        SET 
            ESTADO_REGISTRO          = NVL (pEstadoRegistro, ESTADO_REGISTRO),
            USUARIO_MODIFICACION     = NVL (pUsuarioModificacion,USUARIO_MODIFICACION),
            FECHA_MODIFICACION       = CURRENT_DATE
        WHERE ANTE_SOCIOECONOMICO_ID = pAnteSocioeconomicoId;

        pResultado   :='DATOS DE ANTECEDENTES SOCIOECONOMICOS ELIMINADOS  SATISFACTORIAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_D_ANTE_SOCIOECONOMICO;

      /****************************************************************************************************************************************************************************/

     PROCEDURE SNH_CRUD_ANTE_SOCIOECONOMICO(
        pAnteSocioeconomicoId    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANTE_SOCIOECONOMICO_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HISTORIA_CLINICA_ID%TYPE,
        pCasa                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.CASA%TYPE,
        pParedes                 IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.PAREDES%TYPE,
        pPiso                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.PISO%TYPE,
        pTecho                   IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.TECHO%TYPE,
        pServiciosHigienicos     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.SERVICIOS_HIGIENICOS%TYPE,
        pHabitaciones            IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HABITACIONES%TYPE,
        pAgua                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.AGUA%TYPE,
        pLugarAgua               IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_AGUA%TYPE,
        pLuz                     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUZ%TYPE,
        pLugarExcretas           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_EXCRETAS%TYPE,
        pNumeroPersonas          IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.NUMERO_PERSONAS%TYPE,
        pAnimales                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANIMALES%TYPE,
        pTelefono                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.TELEFONO%TYPE,
        pObservaciones           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OBSERVACIONES%TYPE,
        pOtros                   IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OTROS%TYPE,
        pHacimiento              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HACIMIENTO%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.USUARIO_MODIFICACION%TYPE,
        pUsuarioRegistro         IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.USUARIO_REGISTRO%TYPE,
        pMsgError                OUT VARCHAR2,
        pResultado               OUT VARCHAR2,
        pTipoOperacion               VARCHAR2)

    AS
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_CRUD_ANTE_SOCIOECONOMICO=>';
    --  pEstadoRegistro NUMBER(10);
    BEGIN
        CASE
            WHEN pTipoOperacion IS NULL
            THEN
                pResultado   := 'No se ha indicado el tipo de operacion';
                RAISE eParametroNull;
            WHEN pTipoOperacion = KINSERT
            THEN
                SNH_C_ANTE_SOCIOECONOMICO (
                                    pHistoriaId              =>     pHistoriaId,
                                    pCasa                    =>     pCasa,
                                    pParedes                 =>     pParedes,
                                    pPiso                    =>     pPiso,
                                    pTecho                   =>     pTecho,
                                    pServiciosHigienicos     =>     pServiciosHigienicos,
                                    pHabitaciones            =>     pHabitaciones,
                                    pAgua                    =>     pAgua,
                                    pLugarAgua               =>     pLugarAgua,
                                    pLuz                     =>     pLuz,
                                    pLugarExcretas           =>     pLugarExcretas,
                                    pNumeroPersonas          =>     pNumeroPersonas,
                                    pAnimales                =>     pAnimales,
                                    pTelefono                =>     pTelefono,
                                    pObservaciones           =>     pObservaciones,
                                    pOtros                   =>     pOtros,
                                    pHacimiento              =>     pHacimiento,
                                    pUsuarioRegistro         =>     pUsuarioRegistro,
                                    pMsgError                =>     pMsgError,
                                    pResultado               =>     pResultado
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;

            WHEN pTipoOperacion = KUPDATE
            THEN
                SNH_U_ANTE_SOCIOECONOMICO  (
                                    pAnteSocioeconomicoId    =>     pAnteSocioeconomicoId,
                                    pHistoriaId              =>     pHistoriaId,
                                    pCasa                    =>     pCasa,
                                    pParedes                 =>     pParedes,
                                    pPiso                    =>     pPiso,
                                    pTecho                   =>     pTecho,
                                    pServiciosHigienicos     =>     pServiciosHigienicos,
                                    pHabitaciones            =>     pHabitaciones,
                                    pAgua                    =>     pAgua,
                                    pLugarAgua               =>     pLugarAgua,
                                    pLuz                     =>     pLuz,
                                    pLugarExcretas           =>     pLugarExcretas,
                                    pNumeroPersonas          =>     pNumeroPersonas,
                                    pAnimales                =>     pAnimales,
                                    pTelefono                =>     pTelefono,
                                    pObservaciones           =>     pObservaciones,
                                    pOtros                   =>     pOtros,
                                    pHacimiento              =>     pHacimiento,
                                    pUsuarioModificacion     =>     pUsuarioModificacion,
                                    pMsgError                =>     pMsgError,
                                    pResultado               =>     pResultado

                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            WHEN pTipoOperacion = KDELETE
            THEN

                SNH_D_ANTE_SOCIOECONOMICO (
                                    pAnteSocioeconomicoId    =>     pAnteSocioeconomicoId,
                                    pUsuarioModificacion     =>     pUsuarioModificacion,
                                    pMsgError                =>     pMsgError,
                                    pResultado               =>     pResultado                                                              
                                    );

                CASE
                    WHEN pMsgError IS NOT NULL
                    THEN
                        RAISE eSalidaConError;
                    ELSE
                        NULL;
                END CASE;
            ELSE
                --pResultado := 'EL PARÁMETRO pTipoOperacion ['||pTipoOperacion|| '] ES INVALIDO';
                pResultado   := 'EL TIPO DE OPERACIÓN  ES INVALIDO';
                RAISE eParametrosInvalidos;
        END CASE;
    EXCEPTION
        WHEN eParametroNull
        THEN
            pMsgError   := pMsgError || pResultado;
        WHEN eSalidaConError
        THEN
            --pMsgError:= pMsgError||
            pResultado   := 'ERROR';
        WHEN eParametrosInvalidos
        THEN
            pMsgError   := pMsgError || pResultado;
    END SNH_CRUD_ANTE_SOCIOECONOMICO;
    /****************************************************************************************************************************************************************************/
    PROCEDURE SNH_R_HISTORIA_CLINICA_JSON (
        pHistoriaId             IN HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pCodigoExpediente       IN HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE.CODIGO_EXPEDIENTE_ELECTRONICO%TYPE,
        pRegistro               OUT VAR_REFCURSOR,
        pMsgError               OUT VARCHAR2,
        pResultado              OUT VARCHAR2


        ) AS 
      vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_R_HISTORIA_CLINICA_JSON=>';
      pEstadoRegistro NUMBER (10);
      pTipoHistoriaClinica NUMBER (10);
      pTipo NUMBER (10);
      pExisteRegistro NUMBER (10);
      var_cursor var_refcursor;

    BEGIN
        pEstadoRegistro   :=  FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);
       pTipo             :=  FN_R_VALIDA_CATALOGO (K_TIPO_HIST, K_HIST_PEDI);
       -- pResultado:=pTipo;
       SELECT CASE WHEN EXISTS (SELECT HC.TIPO_HISTORIA FROM 
                                                            HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE CEX
                                                            INNER JOIN HOSPITALARIO.SNH_MST_HISTORIA_CLINICA HC
                                                            ON HC.EXPEDIENTE_ID=CEX.EXPEDIENTE_ID
                                                            WHERE CEX.CODIGO_EXPEDIENTE_ELECTRONICO=pCodigoExpediente)
        THEN 1
        ELSE 0            
        END INTO pExisteRegistro FROM dual;

        IF(pExisteRegistro=0) THEN
            pResultado:='NO EXISTEN DATOS PARA EL EXPEDIENTE No' || pCodigoExpediente;
        ELSE

      SELECT HC.TIPO_HISTORIA INTO pTipoHistoriaClinica FROM 
                                                            HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE CEX
                                                            INNER JOIN HOSPITALARIO.SNH_MST_HISTORIA_CLINICA HC
                                                            ON HC.EXPEDIENTE_ID=CEX.EXPEDIENTE_ID
                                                            WHERE CEX.CODIGO_EXPEDIENTE_ELECTRONICO=pCodigoExpediente;


END IF;





    IF pTipoHistoriaClinica= pTipo --(SELECT CAT.CATALOGO_ID FROM CATALOGOS.SBC_CAT_CATALOGOS CAT  WHERE CAT.CODIGO=K_HIST_PEDI)
      THEN 
      OPEN  var_cursor FOR
      SELECT DISTINCT
       JSON_OBJECT (
           'HistoriaClinica' VALUE
               JSON_OBJECT (
                   'Id'             VALUE HC.HISTORIA_CLINICA_ID,
                   'TipoHistoria'   VALUE TH.VALOR,
                   'FechaHistoria'  VALUE HC.FECHA_HISTORIA,
                   'UnidadSalud'    VALUE USAD.NOMBRE,
                   'Observaciones'  VALUE NVL (DHC.OBSERVACIONES, 'Sin Observaciones'),
                   'Diagnostico'    VALUE NVL (DHC.DIAGNOSTICO, 'N/D'),
                   'Interconsultas' VALUE NVL (DHC.INTERCONSULTAS, 'N/D'),
                   'DatosPaciente'  VALUE
                       JSON_OBJECT (
                           'CodigoExpediente'       VALUE PERNOM.CODIGO_EXPEDIENTE_ELECTRONICO,
                           'NombreCompleto'         VALUE PERNOM.NOMBRE_COMPLETO,
                           'Edad'                   VALUE HOSPITALARIO.PKG_SNH_EMERGENCIA.FN_OBT_EDAD_PERSONA_HST (PERNOM.FECHA_NACIMIENTO,SYSDATE,'F'),
                           'FechaNacimiento'        VALUE PERNOM.FECHA_NACIMIENTO,
                           'Sexo'                   VALUE NVL (PERNOM.SEXO_VALOR, 0),
                           'Telefono'               VALUE NVL (PERNOM.TELEFONO, 'N/D'),
                           'DepartamentoNacimiento' VALUE NVL (PERNOM.DEPARTAMENTO_NACIMIENTO_NOMBRE,'N/D'),
                           'MunicipioNacimiento'    VALUE NVL (PERNOM.MUNICIPIO_NACIMIENTO_NOMBRE,'N/D'),
                           'ComunidadResidencia'    VALUE NVL (PERNOM.COMUNIDAD_RESIDENCIA_NOMBRE,'N/D'),
                           'DireccionResidencia'    VALUE NVL (PERNOM.DIRECCION_RESIDENCIA, 'N/D'),
                           'SectorReside'           VALUE NVL (PERNOM.SECTOR_RESIDENCIA_NOMBRE, 'N/D'),
                           'UnidadReside'           VALUE NVL (PERNOM.UNIDAD_SALUD_RSD_NOMBRE, 'N/D'),
                           'Pais'                   VALUE NVL (PERNOM.PAIS_ORIGEN_NOMBRE, 'N/D')
                           ),

                   'AntecedentesParto' VALUE
                       JSON_OBJECT (
                           'LugarParto'             VALUE NVL (TPAR.VALOR, 'N/D'),
                           'FechaNacimiento'        VALUE APAR.FECHA_NACIMIENTO,
                           'EdadGestacional'        VALUE APAR.EDAD_GESTACIONAL,
                           'DuracionParto'          VALUE NVL (APAR.DURACION_PARTO, 0) || ' Horas',
                           'AtencionParto'          VALUE NVL (APAR.VALOR, 'N/D'),
                           'Vía'                    VALUE NVL (VIA.VALOR, 'N/D'),
                           'Presentacion'           VALUE NVL (APAR.PRESENTACION, 'N/D'),
                           'Eventualidades'         VALUE NVL (APAR.EVENTUALIDADES, 'N/D')
                           ),

                    'AntecedentesPostnatales' VALUE
                       JSON_OBJECT (
                           'Apgar1'                 VALUE NVL (APOS.APGAR1, 0),
                           'Apgar2'                 VALUE NVL (APOS.APGAR5,0),
                           'Peso'                   VALUE NVL (APOS.PESO, 0)|| ' Gramos',
                           'Talla'                  VALUE NVL (APOS.TALLA,0) || ' Centimetros',
                           'Asfixia'                VALUE NVL (ASF.VALOR, 'N/D'),
                           'DescripcionAsfixia'     VALUE NVL (APOS.DESCRIPCION_ASFIXIA, 'N/D'),
                           'AlojamientoConjunto'    VALUE NVL (ALOJA.VALOR, 'N/D'),
                           'TiempoMadre'            VALUE NVL (TMAD.VALOR, 'N/D'),
                           'HorasMadre'             VALUE NVL (APOS.HORAS_MADRE, 0) || ' Horas',
                           'Hospitalizacion'        VALUE NVL (APOS.HOSPITALIZACION, 'N/D')
                           ),
                   'Alimentacion' VALUE
                       JSON_OBJECT (
                           'LactanciaExclusiva'         VALUE NVL (AL.LACTANCIA_EXCLUSIVA, 0),
                           'LactanciaMixta'             VALUE NVL (AL.LACTANCIA_MIXTA, 0),
                           'DuracionLactanciaMixta'     VALUE NVL (AL.DURACION_LACT_MIXTA, 0) || ' Meses ',
                           'DuracionLactanciaExclusiva' VALUE NVL (AL.DURACION_LACT_EXCLUSIVA, 0) ||' Meses ',
                           'Ablactacion'                VALUE NVL (AL.ABLACTACION, 'N/D')
                           ),
                   'DesarrolloPsicomotor' VALUE
                       (SELECT JSON_ARRAYAGG (
                                   JSON_OBJECT (
                                       'TipoDesarrollo'      VALUE TDES.VALOR,
                                       'ConfirmaDesarrollo'  VALUE CDES.VALOR,
                                       'Edad'                VALUE PS.EDAD))
                                                    FROM HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR  PS
                                                    INNER JOIN CATALOGOS.SBC_CAT_CATALOGOS TDES
                                                    ON TDES.CATALOGO_ID = PS.TIPO_DESARROLLO
                                                    INNER JOIN CATALOGOS.SBC_CAT_CATALOGOS CDES
                                                    ON CDES.CATALOGO_ID = PS.CONFIRMA_DESARROLLO

                                 ),
                   'AntecedentesSocioeconomico' VALUE
                       JSON_OBJECT (
                           'Casa'               VALUE NVL (CASA.VALOR, 'N/D'),  --ASEC.CASA,
                           'Paredes'            VALUE NVL (PARE.VALOR, 'N/D'),
                           'Piso'               VALUE NVL (PISO.VALOR, 'N/D'),
                           'Techo'              VALUE NVL (TECHO.VALOR, 'N/D'),
                           'Servicios'          VALUE NVL (ASEC.SERVICIOS_HIGIENICOS, 0),
                           'Habitaciones'       VALUE NVL (ASEC.HABITACIONES, 0),
                           'Agua'               VALUE NVL (AGUA.VALOR, 'N/D'),
                           'LugarAgua'          VALUE NVL (LAGUA.VALOR, 'N/D'),
                           'Luz'                VALUE NVL (LUZ.VALOR, 'N/D'),
                           'LugarExcretas'      VALUE NVL (LUEX.VALOR, 'N/D'),
                           'NumeroPersonas'     VALUE NVL (ASEC.NUMERO_PERSONAS, 0),
                           'Animales'           VALUE NVL (ASEC.ANIMALES, 0),
                           'Observaciones'      VALUE NVL (ASEC.OBSERVACIONES, 'N/D'),
                           'Otros'              VALUE NVL (ASEC.OTROS, 'N/D'),
                           'Hacimiento'         VALUE NVL (HAC.VALOR, 'N/D')
                           )
                           )
                           ) 
FROM HOSPITALARIO.SNH_MST_HISTORIA_CLINICA  HC
     INNER JOIN HOSPITALARIO.SNH_MST_ADMISION_SERVICIOS ADSE
         ON HC.ADMISION_SERVICIO_ID = ADSE.ADMISION_SERVICIO_ID
     INNER JOIN CATALOGOS.SBC_MST_PERSONAS P
         ON P.EXPEDIENTE_ID = HC.EXPEDIENTE_ID
     INNER JOIN CATALOGOS.SBC_MST_PERSONAS_NOMINAL PERNOM
         ON P.PERSONA_ID = PERNOM.PERSONA_ID
     INNER JOIN CATALOGOS.SBC_CAT_CATALOGOS TH
         ON TH.CATALOGO_ID = HC.TIPO_HISTORIA
     INNER JOIN CATALOGOS.SBC_CAT_UNIDADES_SALUD USAD
         ON USAD.UNIDAD_SALUD_ID = HC.UNIDAD_SALUD_ID
     LEFT JOIN HOSPITALARIO.SNH_DET_HISTORIA_CLINICA DHC
         ON DHC.HISTORIA_CLINICA_ID = HC.HISTORIA_CLINICA_ID AND DHC.ESTADO_REGISTRO=pEstadoRegistro
     LEFT JOIN HOSPITALARIO.SNH_MST_ANTE_PARTO APAR 
         ON APAR.HISTORIA_CLINICA_ID = HC.HISTORIA_CLINICA_ID AND APAR.ESTADO_REGISTRO=pEstadoRegistro
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS TPAR
         ON TPAR.CATALOGO_ID = APAR.LUGAR_PARTO
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS APAR
         ON APAR.CATALOGO_ID = APAR.ATENCION_PARTO
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS VIA ON VIA.CATALOGO_ID = APAR.VIA
     LEFT JOIN HOSPITALARIO.SNH_MST_ANTE_POSTNATALES APOS 
          ON APOS.HISTORIA_CLINICA_ID=HC.HISTORIA_CLINICA_ID
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS ASF 
           ON ASF.CATALOGO_ID=APOS.ASFIXIA
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS ALOJA
           ON ALOJA.CATALOGO_ID=APOS.ALOJAMIENTO_CONJUNTO
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS TMAD
           ON TMAD.CATALOGO_ID=APOS.TIEMPO_MADRE
     LEFT JOIN HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA AL
         ON AL.HISTORIA_CLINICA_ID = HC.HISTORIA_CLINICA_ID AND AL.ESTADO_REGISTRO=pEstadoRegistro
     LEFT JOIN HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO ASEC
         ON ASEC.HISTORIA_CLINICA_ID = HC.HISTORIA_CLINICA_ID AND ASEC.ESTADO_REGISTRO=pEstadoRegistro
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS CASA
         ON CASA.CATALOGO_ID = ASEC.CASA
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS PARE
         ON PARE.CATALOGO_ID = ASEC.PAREDES
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS PISO
         ON PISO.CATALOGO_ID = ASEC.PISO
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS TECHO
         ON TECHO.CATALOGO_ID = ASEC.TECHO
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS AGUA
         ON AGUA.CATALOGO_ID = ASEC.AGUA
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS LAGUA
         ON LAGUA.CATALOGO_ID = ASEC.LUGAR_AGUA
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS LUZ ON LUZ.CATALOGO_ID = ASEC.LUZ
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS LUEX
         ON LUEX.CATALOGO_ID = ASEC.LUGAR_EXCRETAS
     LEFT JOIN CATALOGOS.SBC_CAT_CATALOGOS HAC
         ON HAC.CATALOGO_ID = ASEC.HACIMIENTO
WHERE  PERNOM.CODIGO_EXPEDIENTE_ELECTRONICO=pCodigoExpediente
      AND HC.ESTADO_REGISTRO=pEstadoRegistro;


      /*IF  pTipoHistoriaClinica= FN_R_VALIDA_CATALOGO (K_TIPO_HIST, K_HIST_ADOL)
      THEN 
      pResultado:='AQUI VA LA CONSULTA SI LA HISTORIA CLINICA ES ADOLESCENTE';

      IF  pTipoHistoriaClinica= FN_R_VALIDA_CATALOGO (K_TIPO_HIST, K_HIST_ADUL)
      THEN 
      pResultado:='AQUI VA LA CONSULTA SI LA HISTORIA CLINICA ES DEL ADULTO';
      */
      ELSE
      pResultado:='HAY UN INCONVENIENTE CON LA HISTORIA CLINICA';

     -- END IF;
      --END IF;

      END IF;
     pRegistro:=var_cursor;

     -- pResultado:=var_cursor;
     --dbms_sql.return_result(pRegistro);
    EXCEPTION
        WHEN OTHERS
        THEN

           pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM; 

    END SNH_R_HISTORIA_CLINICA_JSON;

END PKG_SNH_HISTORIA_CLINICA;
