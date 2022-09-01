 PROCEDURE SNH_C_ANTE_SOCIOECONOMICO (
        pHistoriaId              IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HISTORIA_CLINICA_ID%TYPE,
        pCasa                    IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.CASA%TYPE,
       -- pServiciosHigienicos     IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.SERVICIOS_HIGIENICOS%TYPE,
        pHabitaciones            IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HABITACIONES%TYPE,
        pLugarAgua               IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_AGUA%TYPE,
        pLugarExcretas           IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_EXCRETAS%TYPE,
        pNumeroPersonas          IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.NUMERO_PERSONAS%TYPE,
       -- pAnimales                IN    HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.ANIMALES%TYPE,
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
        vExisteRegistro NUMBER (1);
    BEGIN
        pEstadoRegistro   := FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);



      SELECT CASE WHEN EXISTS (SELECT  ANTE_SOCIOECONOMICO_ID FROM SNH_MST_ANTE_SOCIOECONOMICO
                                  WHERE HISTORIA_CLINICA_ID = pHistoriaId AND ESTADO_REGISTRO=pEstadoRegistro )
        THEN 1
        ELSE 0
        END INTO vExisteRegistro FROM DUAL; 

        IF vExisteRegistro=1 THEN 
            pResultado:='LA HISTORIA CLINICA YA TIENE ANTECEDENTES SOCIOECONOMICOS';

            ELSE

        INSERT INTO HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO (
                                         HISTORIA_CLINICA_ID, 
                                         CASA, 
                                        -- SERVICIOS_HIGIENICOS, 
                                         HABITACIONES, 
                                         LUGAR_AGUA, 
                                         LUGAR_EXCRETAS, 
                                         NUMERO_PERSONAS, 
                                         --ANIMALES, 
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
                                       -- pServiciosHigienicos,
                                        pHabitaciones,
                                        pLugarAgua,
                                        pLugarExcretas,
                                        pNumeroPersonas,
                                       -- pAnimales,
                                        pTelefono,
                                        pObservaciones,
                                        pOtros,
                                        pHacimiento,
                                        pEstadoRegistro,
                                        pUsuarioRegistro,
                                        CURRENT_DATE);

        pResultado   := 'DATOS DE ANTECEDENTES SOCIOECONOMICOS CREADOS  SATISFACTORIAMENTE';
        END IF ;
    EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_C_ANTE_SOCIOECONOMICO;