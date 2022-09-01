CREATE OR REPLACE PACKAGE HOSPITALARIO."PKG_SNH_HISTORIA_CLINICA_CP"
    AUTHID CURRENT_USER
AS
    eSalidaConError EXCEPTION;
    eParametroNull EXCEPTION;
    eParametrosInvalidos EXCEPTION;
    eRegistroExiste EXCEPTION;
    eRegistroNoExiste EXCEPTION;

    TYPE VAR_REFCURSOR IS REF CURSOR;

    KINSERT CONSTANT CHAR (1) := 'I';
    KUPDATE CONSTANT CHAR (1) := 'U';
    KDELETE CONSTANT CHAR (1) := 'D';
    KCONSULTAR CONSTANT CHAR (1) := 'C';
    K_CAT_REG_ACT  CHAR (6) := 'ACTREG';
    K_CAT_REG_PAS  CHAR (6) := 'PASREG';
    K_CAT_REG_DEL  CHAR (6) := 'DELREG';
    K_STATE_REG    CHAR (5) := 'STREG';
    K_TIPO_HIST    VARCHAR (18):= 'HISTORIACLINICA001'; --- COLOCAR AQUI EL CODIGO SUP DEL TIPO DE HISTORIA CLINICA CUANDO ESTE CREADO
    K_HIST_PEDI    VARCHAR2 (20):= 'HISTORIACLINICA00101';---COLOCAR AQUI EL CODIGO DE LA HISTORIA CLINICA PEDIATRICA
    K_HIST_ADUL    VARCHAR2 (20):='HISTORIACLINICA00103'; ---- COLOCAR AQUI EL CODIGO DE LA HISTORIA CLINICA DE ADULTO
    K_HIST_ADOL    VARCHAR2 (20):='HISTORIACLINICA00102' ;---- COLOCAR AQUI EL CODIDO DE LA HISTORIA CLINICA DEL ADOLESCENTE

    FUNCTION FN_R_VALIDA_CATALOGO (pCodigoSup     IN VARCHAR2,
                                   pCodigo        IN VARCHAR2)
        RETURN NUMBER;
     FUNCTION FN_R_HISTORIA_CLINICA( pCodigoExpediente HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE.CODIGO_EXPEDIENTE_ELECTRONICO%TYPE,
                                    pHistoriaId HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
                                    pPersonaId HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.PERSONA_ID%TYPE
                                    )
        RETURN VAR_REFCURSOR;

    PROCEDURE SNH_C_HISTORIA_CLINICA (

        pAdmisionServicioId IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.ADMISION_SERVICIO_ID%TYPE,
        pTipoHistoria       IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.TIPO_HISTORIA%TYPE,
        pExpedienteId       IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.EXPEDIENTE_ID%TYPE,
        pUnidadSalud        IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.UNIDAD_SALUD_ID%TYPE,
        pPersonalSalud      IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.PERSONAL_SALUD_ID%TYPE,
        --pDivisionId         IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.DIVISIONP_ID%TYPE,
		pFechaHistoria      IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_HISTORIA%TYPE,
        pUsuarioRegistro    IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro      IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.FECHA_REGISTRO%TYPE,
        pPersonaId          IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.PERSONA_ID%TYPE,
        pRegistro           OUT VAR_REFCURSOR,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2);

    PROCEDURE SNH_CRUD_HISTORIA_CLINICA (
        pCodigoExpediente    IN     HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE.CODIGO_EXPEDIENTE_ELECTRONICO%TYPE,
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
        pPersonaId           IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.PERSONA_ID%TYPE,
        pTipoOperacion       IN     VARCHAR2,
        pRegistro            OUT   VAR_REFCURSOR,
        pMsgError            OUT VARCHAR2,
        pResultado           OUT VARCHAR2);

    PROCEDURE SNH_R_HISTORIA_CLINICA( 
        pCodigoExpediente   IN     HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE.CODIGO_EXPEDIENTE_ELECTRONICO%TYPE,
        pHistoriaId         IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pPersonaId          IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.PERSONA_ID%TYPE,
        pRegistro           OUT VAR_REFCURSOR,
        pResultado          OUT VARCHAR2,
        pMsgError           OUT VARCHAR2
                                      );

    PROCEDURE SNH_D_HISTORIA_CLINICA (
        pHistoriaId          IN     HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pUsuarioModificacion IN HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.USUARIO_MODIFICACION%TYPE,
        pResultado           OUT VARCHAR2,
        pMsgError            OUT VARCHAR2);

    PROCEDURE SNH_R_DET_HISTORIA_CLINICA( 
        pDetHistoriaId       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DET_HISTORIA_CLINICA_ID%TYPE,
        pHistoriaId          IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pRegistro           OUT VAR_REFCURSOR,
        pResultado        OUT VARCHAR2,
        pMsgError         OUT VARCHAR2
                                        );

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
        pTipoOperacion       VARCHAR2,
        pRegistro            OUT    VAR_REFCURSOR,
        pResultado           OUT VARCHAR2,
        pMsgError            OUT VARCHAR2);

    PROCEDURE SNH_C_DET_HISTORIA_CLINICA (
        pHistoriaId      IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pObservaciones   IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.OBSERVACIONES%TYPE,
        pDiagnostico     IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DIAGNOSTICO%TYPE,
        pInterconsultas  IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.INTERCONSULTAS%TYPE,
        pUsuarioRegistro IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro   IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.FECHA_REGISTRO%TYPE,
        pResultado       OUT VARCHAR2,
        pMsgError        OUT VARCHAR2);

    PROCEDURE SNH_U_DET_HISTORIA_CLINICA (
        pDetHistoriaId       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DET_HISTORIA_CLINICA_ID%TYPE,
        pHistoriaId          IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pObservaciones       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.OBSERVACIONES%TYPE,
        pDiagnostico         IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DIAGNOSTICO%TYPE,
        pInterconsultas      IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.INTERCONSULTAS%TYPE,
        pUsuarioModificacion IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion   IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.FECHA_MODIFICACION%TYPE,
        --pRegistro            OUT VAR_REFCURSOR,
        pResultado           OUT VARCHAR2,
        pMsgError            OUT VARCHAR2);

    PROCEDURE SNH_D_DET_HISTORIA_CLINICA (
        pDetHistoriaId       IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.DET_HISTORIA_CLINICA_ID%TYPE,
        pUsuarioModificacion IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion   IN     HOSPITALARIO.SNH_DET_HISTORIA_CLINICA.FECHA_MODIFICACION%TYPE,
        pResultado           OUT VARCHAR2,
        pMsgError            OUT VARCHAR2);

    PROCEDURE SNH_C_ANTECEDENTES_PARTO (
        pAntecedentesId    IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.ANTE_PARTO_ID%TYPE,
        pHistoriaClinicaId IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.HISTORIA_CLINICA_ID%TYPE,
        pLugarParto        IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.LUGAR_PARTO%TYPE,
        pFechaNacimiento   IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_NACIMIENTO%TYPE,
        pEdadGestacional   IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.EDAD_GESTACIONAL%TYPE,
        pDuracionParto     IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.DURACION_PARTO%TYPE,
        pAtencionParto     IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.ATENCION_PARTO%TYPE,
        pVia               IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.VIA%TYPE,
        pPresentacion      IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.PRESENTACION%TYPE,
        pEventualidades    IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.EVENTUALIDADES%TYPE,
        pUsuarioRegistro   IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.USUARIO_REGISTRO%TYPE,
        pFechaRegistro     IN     HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_REGISTRO%TYPE,
        pMsgError         OUT VARCHAR2,
        pResultado        OUT VARCHAR2);

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
        pMsgError         OUT VARCHAR2,
        pResultado        OUT VARCHAR2);

    PROCEDURE SNH_D_ANTECEDENTES_PARTO (
        pAntecedentesId      IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.ANTE_PARTO_ID%TYPE,
        pUsuarioModificacion IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.USUARIO_MODIFICACION%TYPE,
        pMsgError         OUT VARCHAR2,
        pResultado        OUT VARCHAR2);

    PROCEDURE SNH_CRUD_ANTECEDENTES_PARTO (
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
        pUsuarioRegistro     IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.USUARIO_REGISTRO%TYPE,
        pFechaRegistro       IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_REGISTRO%TYPE,
        pUsuarioModificacion IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion   IN    HOSPITALARIO.SNH_MST_ANTE_PARTO.FECHA_MODIFICACION%TYPE,
        pTipoOperacion       IN     VARCHAR2,
        pMsgError            OUT VARCHAR2,
        pResultado           OUT VARCHAR2);
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
       );
     PROCEDURE  SNH_U_MST_ANTE_POSTNATALES  (
        pAntePostnatalesId       IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ANTE_POSTNATALES_ID%TYPE,
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
        );
     PROCEDURE SNH_D_MST_ANTE_POSTNATALES  (
        pAntePostnatalesId       IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.ANTE_POSTNATALES_ID%TYPE,
        pUsuarioModificacion   IN    HOSPITALARIO.SNH_MST_ANTE_POSTNATALES.USUARIO_MODIFICACION%TYPE,
        pResultado             OUT VARCHAR2,
        pMsgError              OUT VARCHAR2
        );
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
        pMsgError              OUT VARCHAR2);
     PROCEDURE SNH_C_MST_ALIMEN_PEDIATRICA (
        pAlimentPediatricaId     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ALIMEN_PEDIATRICA_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.HISTORIA_CLINICA_ID%TYPE,
        pTipoLactancia           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.TIPO_LACTANCIA%TYPE,
        pDuracionLactancia       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.DURACION_LACTANCIA%TYPE,
        pAblactacion             IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ABLACTACION%TYPE,
        pUsuarioRegistro         IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_REGISTRO%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2);

    PROCEDURE  SNH_U_MST_ALIMEN_PEDIATRICA  (
        pAlimentPediatricaId     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ALIMEN_PEDIATRICA_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.HISTORIA_CLINICA_ID%TYPE,
        pTipoLactancia           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.TIPO_LACTANCIA%TYPE,
        pDuracionLactancia       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.DURACION_LACTANCIA%TYPE,
        pAblactacion             IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ABLACTACION%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2);

    PROCEDURE SNH_D_MST_ALIMEN_PEDIATRICA (
        pAlimentPediatricaId     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ALIMEN_PEDIATRICA_ID%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2);

    PROCEDURE SNH_CRUD_ALIMEN_PEDIATRICA (
        pAlimentPediatricaId     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ALIMEN_PEDIATRICA_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.HISTORIA_CLINICA_ID%TYPE,
        pTipoLactancia           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.TIPO_LACTANCIA%TYPE,
        pDuracionLactancia       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.DURACION_LACTANCIA%TYPE,
        pAblactacion             IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.ABLACTACION%TYPE,
        pUsuarioRegistro         IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_REGISTRO%TYPE,
        pFechaRegistro           IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_REGISTRO%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.USUARIO_MODIFICACION%TYPE,
        pFechaModificacion       IN    HOSPITALARIO.SNH_MST_ALIMEN_PEDIATRICA.FECHA_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2,
        pTipoOperacion         VARCHAR2

        );
    PROCEDURE SNH_C_MST_ANTE_PSICOMOTOR(
        pHistoriaId           IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.HISTORIA_CLINICA_ID%TYPE,
        pTipoDesarrollo       IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.TIPO_DESARROLLO%TYPE,
        pConfirmaDesarrollo   IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.CONFIRMA_DESARROLLO%TYPE,
        pEdad                 IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.EDAD%TYPE,
        pUsuarioRegistro      IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.USUARIO_REGISTRO%TYPE,    
        pMsgError             OUT VARCHAR2,
        pResultado            OUT VARCHAR2);

    PROCEDURE  SNH_U_MST_ANTE_PSICOMOTOR  (
        pAntePsicomotorId     IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.ANTE_PSICOMOTOR_ID%TYPE,
        pHistoriaId           IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.HISTORIA_CLINICA_ID%TYPE,
        pTipoDesarrollo       IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.TIPO_DESARROLLO%TYPE,
        pConfirmaDesarrollo   IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.CONFIRMA_DESARROLLO%TYPE,
        pEdad                 IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.EDAD%TYPE,
        pUsuarioModificacion  IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.USUARIO_MODIFICACION%TYPE,    
        pMsgError             OUT VARCHAR2,
        pResultado            OUT VARCHAR2);

    PROCEDURE SNH_D_MST_ANTE_PSICOMOTOR (
        pAntePsicomotorId     IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.ANTE_PSICOMOTOR_ID%TYPE,
        pUsuarioModificacion  IN    HOSPITALARIO.SNH_MST_ANTE_PSICOMOTOR.USUARIO_MODIFICACION%TYPE,    
        pMsgError             OUT VARCHAR2,
        pResultado            OUT VARCHAR2);

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
        pTipoOperacion         VARCHAR2);

    PROCEDURE SNH_C_ANTE_SOCIOECONOMICO (
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HISTORIA_CLINICA_ID%TYPE,
        pCasa                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.CASA%TYPE,
        pServiciosHigienicos     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.SERVICIOS_HIGIENICOS%TYPE,
        pHabitaciones            IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HABITACIONES%TYPE,
        pLugarAgua               IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_AGUA%TYPE,
        pLugarExcretas           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_EXCRETAS%TYPE,
        pNumeroPersonas          IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.NUMERO_PERSONAS%TYPE,
        pAnimales                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANIMALES%TYPE,
        pTelefono                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.TELEFONO%TYPE,
        pObservaciones           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OBSERVACIONES%TYPE,
        pOtros                   IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OTROS%TYPE,
        pHacimiento              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HACIMIENTO%TYPE,
        pUsuarioRegistro         IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.USUARIO_REGISTRO%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2);

    PROCEDURE  SNH_U_ANTE_SOCIOECONOMICO  (
        pAnteSocioeconomicoId    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANTE_SOCIOECONOMICO_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HISTORIA_CLINICA_ID%TYPE,
        pCasa                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.CASA%TYPE,
        pServiciosHigienicos     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.SERVICIOS_HIGIENICOS%TYPE,
        pHabitaciones            IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HABITACIONES%TYPE,
        pLugarAgua               IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_AGUA%TYPE,
        pLugarExcretas           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_EXCRETAS%TYPE,
        pNumeroPersonas          IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.NUMERO_PERSONAS%TYPE,
        pAnimales                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANIMALES%TYPE,
        pTelefono                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.TELEFONO%TYPE,
        pObservaciones           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OBSERVACIONES%TYPE,
        pOtros                   IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OTROS%TYPE,
        pHacimiento              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HACIMIENTO%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.USUARIO_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2);

    PROCEDURE SNH_D_ANTE_SOCIOECONOMICO (
        pAnteSocioeconomicoId    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANTE_SOCIOECONOMICO_ID%TYPE,
        pUsuarioModificacion     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.USUARIO_MODIFICACION%TYPE,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2);
        
    /*PROCEDURE SNH_C_DET_SOCIOECONOMICO (
        pDetalleId       IN    HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.DET_SOCIOECONOMICO_ID%TYPE,
        pAntecedenteId   IN    HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.ANTE_SOCIOECONOMICO_ID%TYPE,
        pAntecedente     IN    HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.ANTECEDENTE%TYPE,
        pTipoAntecedente IN    HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.TIPO_ANTECEDENTE%TYPE,
        pUsuarioRegistro IN    HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.USUARIO_REGISTRO%TYPE,
        pJsonData               CLOB,
        pMsgError           OUT VARCHAR2,
        pResultado          OUT VARCHAR2);*/

    PROCEDURE SNH_CRUD_ANTE_SOCIOECONOMICO(
        pAnteSocioeconomicoId    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANTE_SOCIOECONOMICO_ID%TYPE,
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HISTORIA_CLINICA_ID%TYPE,
        pCasa                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.CASA%TYPE,
        pServiciosHigienicos     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.SERVICIOS_HIGIENICOS%TYPE,
        pHabitaciones            IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HABITACIONES%TYPE,
        pLugarAgua               IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_AGUA%TYPE,
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
        pTipoOperacion               VARCHAR2);

    PROCEDURE SNH_R_HISTORIA_CLINICA_JSON (
        pHistoriaId             IN HOSPITALARIO.SNH_MST_HISTORIA_CLINICA.HISTORIA_CLINICA_ID%TYPE,
        pCodigoExpediente       IN HOSPITALARIO.SNH_MST_CODIGO_EXPEDIENTE.CODIGO_EXPEDIENTE_ELECTRONICO%TYPE,
        pRegistro               OUT VAR_REFCURSOR,
        pMsgError               OUT VARCHAR2,
        pResultado              OUT VARCHAR2

        ) ;


END PKG_SNH_HISTORIA_CLINICA_CP;
/