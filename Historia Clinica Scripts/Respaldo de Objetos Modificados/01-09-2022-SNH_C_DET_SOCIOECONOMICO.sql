 PROCEDURE SNH_C_DET_SOCIOECONOMICO (
        pDetalleId             IN    HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.DET_SOCIOECONOMICO_ID%TYPE,
       
        pTipoAntecedentepadre  IN    HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.ANTECEDENTE%TYPE,
        pTipoAntecedente       IN    HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.TIPO_ANTECEDENTE%TYPE,
        pUsuarioRegistro       IN    HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.USUARIO_REGISTRO%TYPE,
        pJsonData              CLOB,
        pRegistro              OUT  VAR_REFCURSOR,
        pMsgError              OUT VARCHAR2,
        pResultado             OUT VARCHAR2)
                                       
    
    AS
         type r_antecedentes is RECORD ( tipoantecedente NUMBER(19));
        rowa r_antecedentes;
        vFirma         VARCHAR2 (200):= 'PKG_SNH_HISTORIA_CLINICA.SNH_C_DET_SOCIOECONOMICO=>';
        pEstadoRegistro NUMBER(10,0);
        var_cursor VAR_REFCURSOR;
        pRegistroCursor var_refcursor;
        vExisteRegistro NUMBER (1);
        vAntecedenteId  HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.ANTE_SOCIOECONOMICO_ID%TYPE;
        vHistoriaClinicaId HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HISTORIA_CLINICA_ID%TYPE;
        vCasa HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.CASA%TYPE;
        vhabitaciones HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HABITACIONES%TYPE;
        vLugarAgua HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_AGUA%TYPE;
        vLugarExcretas HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.LUGAR_EXCRETAS%TYPE;
        vNumeroPersonas HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.NUMERO_PERSONAS%TYPE;
        vTelefono HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.TELEFONO%TYPE;
        vObservaciones HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OBSERVACIONES%TYPE;
        vOtros HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.OTROS%TYPE;
        vHacimiento HOSPITALARIO.SNH_MST_ANTE_SOCIOECONOMICO.HACIMIENTO%TYPE;
        vTipoAntecedente HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO.TIPO_ANTECEDENTE%TYPE;
         
        BEGIN
        pEstadoRegistro   :=FN_R_VALIDA_CATALOGO (K_STATE_REG, K_CAT_REG_ACT);
        
         IF LENGTH (pJsonData)=0  THEN 
         pResultado:='EL PARAMETRO pJsonData NO PUEDE VENIR VACIO';
         ELSE 
         
        vHistoriaClinicaId       :=JSON_VALUE(pJsonData,'$.historiaclinicaid'  NULL ON EMPTY); 
        
        END IF; 
        
        SELECT CASE WHEN EXISTS (SELECT  ANTE_SOCIOECONOMICO_ID FROM SNH_MST_ANTE_SOCIOECONOMICO
                                  WHERE HISTORIA_CLINICA_ID = vHistoriaClinicaId AND ESTADO_REGISTRO=pEstadoRegistro )
        THEN 1
        ELSE 0
        END INTO vExisteRegistro FROM DUAL;
                       
        IF vExisteRegistro=1 THEN 
            pResultado:='YA EXISTE ANTECEDENTES SOCIOECONOMICOS PARA ESTA HISTORIA CLINICA';
            ELSE
        vHistoriaClinicaId:=JSON_VALUE(pJsonData,'$.historiaclinicaid'  NULL ON EMPTY);
        vCasa :=JSON_VALUE(pJsonData,'$.casa'  NULL ON EMPTY);
        vhabitaciones:=JSON_VALUE(pJsonData,'$.habitaciones'  NULL ON EMPTY);
        vLugarAgua :=JSON_VALUE(pJsonData,'$.lugaragua'  NULL ON EMPTY);
        vLugarExcretas :=JSON_VALUE(pJsonData,'$.lugarexcretas'  NULL ON EMPTY);
        vNumeroPersonas :=JSON_VALUE(pJsonData,'$.numeropersonas'  NULL ON EMPTY);
        vTelefono :=JSON_VALUE(pJsonData,'$.telefono'  NULL ON EMPTY);
        vObservaciones :=JSON_VALUE(pJsonData,'$.observaciones'  NULL ON EMPTY);
        vOtros:=JSON_VALUE(pJsonData,'$.otros'  NULL ON EMPTY);
        vHacimiento:=JSON_VALUE(pJsonData,'$.hacimiento'  NULL ON EMPTY);
                  
        
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
          VALUES (
          vHistoriaClinicaId,
          vCasa,
          vhabitaciones,
          vLugarAgua,
          vLugarExcretas,
          vNumeroPersonas,
          vTelefono,
          vObservaciones,
          vOtros,
          vHacimiento,
          pEstadoRegistro,
          pUsuarioRegistro,
          CURRENT_DATE
          )
          RETURNING ANTE_SOCIOECONOMICO_ID INTO vAntecedenteId;
         
       
        open pRegistroCursor  for

             select    
               tipoantecedente
               FROM DUAL,
               JSON_TABLE(pJsonData,'$' COLUMNS(
                   
                    NESTED PATH '$.paredes[*]' COLUMNS (tipoantecedente NUMBER (10) PATH '$.id')
                         ))
                UNION ALL 
                
                 select    
               tipoantecedente
               FROM DUAL,
               JSON_TABLE(pJsonData,'$' COLUMNS(
                   
                    NESTED PATH '$.piso[*]' COLUMNS (tipoantecedente NUMBER (10) PATH '$.id')
                         ))
                UNION ALL
                
                  select    
               tipoantecedente
               FROM DUAL,
               JSON_TABLE(pJsonData,'$' COLUMNS(
                   
                    NESTED PATH '$.techo[*]' COLUMNS (tipoantecedente NUMBER (10) PATH '$.id')
                         ))
                UNION ALL
                
                   select    
               tipoantecedente
               FROM DUAL,
               JSON_TABLE(pJsonData,'$' COLUMNS(
                   
                    NESTED PATH '$.servicios[*]' COLUMNS (tipoantecedente NUMBER (10) PATH '$.id')
                         ))
                    
                    ;
       
        LOOP
         FETCH pRegistroCursor INTO rowa;
         EXIT WHEN pRegistroCursor%NOTFOUND;
                 
           
         
         INSERT INTO HOSPITALARIO.SNH_DET_ANTE_SOCIOECONOMICO ( 
                                                            ANTE_SOCIOECONOMICO_ID,
                                                            ANTECEDENTE,
                                                            TIPO_ANTECEDENTE,
                                                            ESTADO_REGISTRO,
                                                            USUARIO_REGISTRO,
                                                            FECHA_REGISTRO
        
         )
         
         VALUES 
         (
         vAntecedenteId,
         (SELECT CATALOGO_SUP FROM CATALOGOS.SBC_CAT_CATALOGOS WHERE CATALOGO_ID=rowa.tipoantecedente) ,
         rowa.tipoantecedente,
         pEstadoRegistro,
         pUsuarioRegistro,
         CURRENT_DATE    
         
         );
        END LOOP;
        CLOSE pRegistroCursor;
       END IF;
        EXCEPTION
        WHEN OTHERS
        THEN
            pResultado   := 'ERROR INESPERADO';
            pMsgError    := vFirma || pResultado || SQLERRM;
    END SNH_C_DET_SOCIOECONOMICO;