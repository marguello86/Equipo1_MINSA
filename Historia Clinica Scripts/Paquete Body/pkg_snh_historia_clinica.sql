CREATE OR REPLACE PACKAGE BODY PKG_SNH_HISTORIA_CLINICA AS
/****************************************************************************************************************************************************************************/
FUNCTION FN_R_VALIDA_CATALOGO (pCodigoSup IN varchar2,pCodigo IN varchar2 ) RETURN NUMBER AS
   catId  CATALOGOS.SBC_CAT_CATALOGOS.CATALOGO_ID%TYPE;
   BEGIN
      select C.CATALOGO_ID INTO catId from CATALOGOS.SBC_CAT_CATALOGOS C
      inner join CATALOGOS.SBC_CAT_CATALOGOS CS on C.CATALOGO_SUP=CS.CATALOGO_ID
      WHERE C.CODIGO=pCodigo and CS.CODIGO=pCodigoSup;
     RETURN catId;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR ( -20999 , 'ORA-'||SQLCODE||' VALOR DE CATALOGO NO ENCONTRADO pCodigoSup:'||pCodigoSup||', pCodigo:'||pCodigo , TRUE );
   END  FN_R_VALIDA_CATALOGO;

/****************************************************************************************************************************************************************************/
PROCEDURE SNH_C_HISTORIA_CLINICA    (
                                                                         -- pHistoriaId IN OUT HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
                                                                          pAdmisionServicioId IN HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.ADMISION_SERVICIO_ID%TYPE,
                                                                          pTipoHistoria in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.TIPO_HISTORIA%TYPE,
                                                                          pExpedienteId in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.EXPEDIENTE_ID%TYPE,
                                                                          pUnidadSalud in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.UNIDAD_SALUD_ID%TYPE,
                                                                          pPersonalSalud in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.PERSONAL_SALUD_ID%TYPE,
                                                                          pDivisionId in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.DIVISIONP_ID%TYPE,
                                                                          pEstadoRegistro in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.ESTADO_REGISTRO%TYPE,
                                                                          pUsuarioRegistro in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.USUARIO_REGISTRO%TYPE,
                                                                          pFechaRegistro in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_REGISTRO%TYPE,
                                                                          --pTipoOperacion     IN VARCHAR2,
                                                                         pRegistro          OUT var_refcursor,     
                                                                          pMsgError          OUT  VARCHAR2,
                                                                          pResultado         OUT VARCHAR2
                                                                        ) AS
    BEGIN
            
        ---    pEstado:=FN_R_ID_CATALOGO (K_STATE_REG,K_CAT_REG_ACT);---Pendiente consulta los valores de donde se extraen

INSERT  INTO HOSPITALARIO.SNH_MST_HISTORIA_CLINICA   (
                                                                                                ADMISION_SERVICIO_ID,
                                                                                                TIPO_HISTORIA,
                                                                                                EXPEDIENTE_ID,
                                                                                                UNIDAD_SALUD_ID,
                                                                                                PERSONAL_SALUD_ID,
                                                                                                DIVISIONP_ID,
                                                                                                ESTADO_REGISTRO,
                                                                                                USUARIO_REGISTRO,
                                                                                                FECHA_REGISTRO                                                                                         
                                                                                                  )
VALUES                                                                                    (
                                                                                                pAdmisionServicioId,
                                                                                                pTipoHistoria,
                                                                                                pExpedienteId,
                                                                                                pUnidadSalud,
                                                                                                pPersonalSalud,
                                                                                                pDivisionId,
                                                                                                pEstadoRegistro,
                                                                                                pUsuarioRegistro,
                                                                                                pFechaRegistro
                                                                                                );
    pResultado:='RESULTADO CREADO SATISFACTORIAMENTE';
            
            EXCEPTION
        WHEN OTHERS THEN
        pResultado:='ERROR INESPERADO';
        pMsgError:=/*vFirma|| */pResultado|| SQLERRM; 
        --pMsgError:=pResultado; 
        END SNH_C_HISTORIA_CLINICA;

/****************************************************************************************************************************************************************************/
    PROCEDURE SNH_CRUD_HISTORIA_CLINICA   (
                                                                          --pHistoriaId IN OUT HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
                                                                          pAdmisionServicioId IN HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.ADMISION_SERVICIO_ID%TYPE,
                                                                          pTipoHistoria in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.TIPO_HISTORIA%TYPE,
                                                                          pExpedienteId in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.EXPEDIENTE_ID%TYPE,
                                                                          pUnidadSalud in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.UNIDAD_SALUD_ID%TYPE,
                                                                          pPersonalSalud in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.PERSONAL_SALUD_ID%TYPE,
                                                                          pDivisionId in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.DIVISIONP_ID%TYPE,
                                                                          pEstadoRegistro in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.ESTADO_REGISTRO%TYPE,
                                                                          pUsuarioRegistro in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.USUARIO_REGISTRO%TYPE,
                                                                          pFechaRegistro in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_REGISTRO%TYPE,
                                                                          pUsuarioModificacion in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.USUARIO_MODIFICACION%TYPE,
                                                                          pFechaModificacion in  HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_MODIFICACION%TYPE,
                                                                          pTipoOperacion     IN VARCHAR2,
                                                                          pRegistro          OUT var_refcursor,     
                                                                          pMsgError          OUT  VARCHAR2,
                                                                          pResultado         OUT VARCHAR2
                                                                  

                                                                        ) AS
    BEGIN
        CASE 
                WHEN pTipoOperacion IS NULL THEN  
                pResultado:='No se ha indicado el tipo de operacion';   
                RAISE eParametroNull;
            
                WHEN pTipoOperacion=kINSERT THEN 
                            SNH_C_HISTORIA_CLINICA  ( 
                                                                       --pHistoriaId =>pHistoriaId,
                                                                       pAdmisionServicioId=>pAdmisionServicioId,
                                                                       pTipoHistoria=>pTipoHistoria,
                                                                       pExpedienteId=>pExpedienteId,
                                                                       pUnidadSalud=>pUnidadSalud,
                                                                       pPersonalSalud=>pPersonalSalud,
                                                                       pDivisionId=>pDivisionId,
                                                                       pEstadoRegistro=>pEstadoRegistro,
                                                                       pUsuarioRegistro=>pUsuarioRegistro,
                                                                       pFechaRegistro=>pFechaRegistro,
                                                                       pRegistro        =>pRegistro,
                                                                       pMsgError=>pMsgError,
                                                                       pResultado=>pResultado
                                                                        );
                CASE WHEN   pMsgError IS NOT NULL THEN
                    RAISE  eSalidaConError; 
                    ELSE NULL;                        
                    END CASE;  
                    
               ELSE
                            pResultado := 'EL PARÁMETRO pTipoOperacion ['||pTipoOperacion|| '] ES INVALIDO';
                            RAISE eParametrosInvalidos;
                            END CASE;

             CASE WHEN  pMsgError IS NOT NULL THEN
                RAISE eSalidaConError;
             ELSE NULL;
             END CASE;
        EXCEPTION        
     WHEN eSalidaConError THEN            
           pResultado := /* vFirma  ||*/ pResultado;
           pMsgError  := pResultado || pMsgError;
     WHEN eParametrosInvalidos THEN
           pResultado := /* vFirma  || */pResultado;
           pMsgError  := pResultado;
     WHEN OTHERS THEN
           pResultado := /* vFirma  ||*/ 'Error no controlado' || pResultado;
           pMsgError  := pResultado||' - '||SQLERRM;
                                                                    
END SNH_CRUD_HISTORIA_CLINICA;
END  PKG_SNH_HISTORIA_CLINICA;



