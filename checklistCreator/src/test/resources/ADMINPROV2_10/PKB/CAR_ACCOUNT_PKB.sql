/*$Id: CAR_ACCOUNT_PKB.sql 39221 2017-01-02 12:35:43Z edson.f.barbosa $*/

CREATE OR REPLACE PACKAGE BODY /* $Id: CAR_ACCOUNT_PKB.sql 39221 2017-01-02 12:35:43Z edson.f.barbosa $ */ 
                                              ADMINPROV2_10.Car_Account_Pck IS

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_PROFILE_LIST                                              **
*****************************************************************************/
PROCEDURE GET_PROFILE_LIST(
   user_in                   IN VARCHAR2,
   plan_list_out             OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   -- chama a api do account para obter a lista de planos existentes --
   ACC_CRM_PCK.ACC_PRV_GET_PLAN_LIST(
      plan_list_out => plan_list_out,
      error_out     => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PROFILE_LIST',
      storedProc_param    => 'user_in = ' || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PROFILE_LIST',
      storedProc_param    => 'user_in = ' || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_PROFILE_LIST;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_PROFILES_BY_PRODUCT_TYPE                                  **
*****************************************************************************/
/* Desc: retorna a lista de planos para um determinado product_type*/
PROCEDURE GET_PROFILES_BY_PRODUCT_TYPE(
   product_type_in           IN VARCHAR2,
   user_in                   IN VARCHAR2,
   area_code_in              IN VARCHAR2,
   plan_list_out             OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   -- chama a api do account para obter a lista de planos existentes de um determinado product_type --
   ACC_CRM_PCK.ACC_PRV_GET_PLAN_BY_PROD_TYPE(
      product_type_in => TO_NUMBER(product_type_in),
      area_code_in    => TO_NUMBER(area_code_in),
      plan_list_out   => plan_list_out,
      error_out       => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PROFILES_BY_PRODUCT_TYPE',
      storedProc_param    => 'product_type_in = ' || product_type_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '         || user_in         || LOG_LOGGER_PCK.F_SEP ||
                             'area_code_in = '    || area_code_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PROFILES_BY_PRODUCT_TYPE',
      storedProc_param    => 'product_type_in = ' || product_type_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '         || user_in         || LOG_LOGGER_PCK.F_SEP ||
                             'area_code_in = '    || area_code_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_PROFILES_BY_PRODUCT_TYPE;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_ALLOWED_CELLULAR_EVENTS                                   **
*****************************************************************************/
PROCEDURE GET_ALLOWED_CELLULAR_EVENTS(
   account_in                IN VARCHAR2,
   user_in                   IN VARCHAR2,
   out_states                OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.LST_EVENT_TYPES(
      in_account     => TO_NUMBER(account_in),
      out_event_list => out_states,
      out_error      => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ALLOWED_CELLULAR_EVENTS',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ALLOWED_CELLULAR_EVENTS',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_ALLOWED_CELLULAR_EVENTS;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: CHANGE_CELLULAR_STATE                                         **
*****************************************************************************/
PROCEDURE CHANGE_CELLULAR_STATE(
   account_in                IN VARCHAR2,
   operation_in              IN VARCHAR2,
   cost_in                   IN VARCHAR2,
   cost_flag_in              IN VARCHAR2,
   reason_in                 IN VARCHAR2,
   observation_in            IN VARCHAR2,
   police_report_no_in       IN VARCHAR2,
   police_report_date_in     IN VARCHAR2,
   police_station_in         IN VARCHAR2,
   city_name_in              IN VARCHAR2,
   num_days_in               IN VARCHAR2,
   service_cost_in           IN VARCHAR2,
   service_cost_flag_in      IN VARCHAR2,
   call_intercept_flag_in    IN VARCHAR2,
   call_intercept_num_in     IN VARCHAR2,
   user_in                   IN VARCHAR2,
   police_report_uf_in       IN VARCHAR2,
   documents_lost_fg_in      IN VARCHAR2,
   equipment_lost_fg_in      IN VARCHAR2,
   dealer_in                 IN VARCHAR2,
   ip_address_in             IN VARCHAR2,
   error_out                 OUT NUMBER
) IS
   trans_id_code             VARCHAR2(3);
   trans_id_nr               NUMBER;
   error_out_dblink          NUMBER;
   procedure_error           EXCEPTION;

BEGIN

   trans_id_code := CAR_GENERIC_PCK.TRANS_ID_CODE;
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;

   ACC_CRM_PCK.CHANGE_STATE(
      in_trans_id_code       => trans_id_code,
      in_trans_id_nr         => trans_id_nr,
      in_operation           => TO_NUMBER(operation_in),
      in_account             => TO_NUMBER(account_in),
      in_cost_value1         => TO_NUMBER(cost_in, NGIN_GER_BD.CURRENCY_MASK, NGIN_GER_BD.CURRENCY_MASK_OPTIONS),
      in_cost_value2         => cost_flag_in,
      in_reason_code         => TO_NUMBER(reason_in),
      in_observation         => observation_in,
      in_police_report_no    => police_report_no_in,
      in_police_report_date  => TO_DATE(police_report_date_in, NGIN_GER_BD.DATE_MASK),
      in_police_station      => police_station_in,
      in_city_name           => city_name_in,
      in_num_days            => TO_NUMBER(num_days_in),
      in_service_cost_value1 => TO_NUMBER(service_cost_in, NGIN_GER_BD.CURRENCY_MASK, NGIN_GER_BD.CURRENCY_MASK_OPTIONS),
      in_service_cost_value2 => service_cost_flag_in,
      in_call_intercept_flag => TO_NUMBER(call_intercept_flag_in),
      in_call_intercept_num  => call_intercept_num_in,
      in_user                => user_in,
      in_police_report_uf    => police_report_uf_in,
      in_ip_address          => ip_address_in,
      in_documents_lost_fg   => TO_NUMBER(documents_lost_fg_in),
      in_lost_equipment      => TO_NUMBER(equipment_lost_fg_in),
      in_dealer              => dealer_in,
      out_error              => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) = 0 THEN
      COMMIT;
      NGIN_GER_BD1.CLOSE_DBLINK_ATOB(
         in_multi_operation_code => TO_NUMBER(operation_in),
         in_dblink               => NULL,
         out_error               => error_out_dblink
      );
   ELSE
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;

   NGIN_GER_BD1.CLOSE_DBLINK_ATOB(
      in_multi_operation_code => TO_NUMBER(operation_in),
      in_dblink               => NULL,
      out_error               => error_out_dblink
   );

   IF error_out_dblink <> 0 THEN
      error_out := error_out_dblink;
   END IF;

   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_CELLULAR_STATE',
      storedProc_param    => 'account_in = '             || account_in             || LOG_LOGGER_PCK.F_SEP ||
                             'operation_in = '           || operation_in           || LOG_LOGGER_PCK.F_SEP ||
                             'cost_in = '                || cost_in                || LOG_LOGGER_PCK.F_SEP ||
                             'cost_flag_in = '           || cost_flag_in           || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '              || reason_in              || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = '         || observation_in         || LOG_LOGGER_PCK.F_SEP ||
                             'police_report_no_in = '    || police_report_no_in    || LOG_LOGGER_PCK.F_SEP ||
                             'police_report_date_in = '  || police_report_date_in  || LOG_LOGGER_PCK.F_SEP ||
                             'police_station_in = '      || police_station_in      || LOG_LOGGER_PCK.F_SEP ||
                             'city_name_in = '           || city_name_in           || LOG_LOGGER_PCK.F_SEP ||
                             'num_days_in = '            || num_days_in            || LOG_LOGGER_PCK.F_SEP ||
                             'service_cost_in = '        || service_cost_in        || LOG_LOGGER_PCK.F_SEP ||
                             'service_cost_flag_in = '   || service_cost_flag_in   || LOG_LOGGER_PCK.F_SEP ||
                             'call_intercept_flag_in = ' || call_intercept_flag_in || LOG_LOGGER_PCK.F_SEP ||
                             'call_intercept_num_in = '  || call_intercept_num_in  || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '                || user_in                || LOG_LOGGER_PCK.F_SEP ||
                             'police_report_uf_in = '    || police_report_uf_in    || LOG_LOGGER_PCK.F_SEP ||
                             'documents_lost_fg_in = '   || documents_lost_fg_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   ROLLBACK;
   error_out := SQLCODE;

   NGIN_GER_BD1.CLOSE_DBLINK_ATOB(
      in_multi_operation_code => TO_NUMBER(operation_in),
      in_dblink               => NULL,
      out_error               => error_out_dblink
   );

   IF error_out_dblink <> 0 THEN
      error_out := error_out_dblink;
   END IF;

   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_CELLULAR_STATE',
      storedProc_param    => 'account_in = '             || account_in             || LOG_LOGGER_PCK.F_SEP ||
                             'operation_in = '           || operation_in           || LOG_LOGGER_PCK.F_SEP ||
                             'cost_in = '                || cost_in                || LOG_LOGGER_PCK.F_SEP ||
                             'cost_flag_in = '           || cost_flag_in           || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '              || reason_in              || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = '         || observation_in         || LOG_LOGGER_PCK.F_SEP ||
                             'police_report_no_in = '    || police_report_no_in    || LOG_LOGGER_PCK.F_SEP ||
                             'police_report_date_in = '  || police_report_date_in  || LOG_LOGGER_PCK.F_SEP ||
                             'police_station_in = '      || police_station_in      || LOG_LOGGER_PCK.F_SEP ||
                             'city_name_in = '           || city_name_in           || LOG_LOGGER_PCK.F_SEP ||
                             'num_days_in = '            || num_days_in            || LOG_LOGGER_PCK.F_SEP ||
                             'service_cost_in = '        || service_cost_in        || LOG_LOGGER_PCK.F_SEP ||
                             'service_cost_flag_in = '   || service_cost_flag_in   || LOG_LOGGER_PCK.F_SEP ||
                             'call_intercept_flag_in = ' || call_intercept_flag_in || LOG_LOGGER_PCK.F_SEP ||
                             'call_intercept_num_in = '  || call_intercept_num_in  || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '                || user_in                || LOG_LOGGER_PCK.F_SEP ||
                             'police_report_uf_in = '    || police_report_uf_in    || LOG_LOGGER_PCK.F_SEP ||
                             'documents_lost_fg_in = '   || documents_lost_fg_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END CHANGE_CELLULAR_STATE;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_REASONS                                                   **
*****************************************************************************/
PROCEDURE GET_REASONS(
   operation_in              IN VARCHAR2,
   user_in                   IN VARCHAR2,
   out_reasons               OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   NGIN_GER_BD.GER_GET_REASONS(
      operation_in => TO_NUMBER(operation_in),
      reasons_out  => out_reasons,
      error_out    => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_REASONS',
      storedProc_param    => 'operation_in = ' || operation_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '      || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_REASONS',
      storedProc_param    => 'operation_in = ' || operation_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '      || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_REASONS;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_REASONS_WITH_COST                                         **
*****************************************************************************/
PROCEDURE GET_REASONS_WITH_COST(
   account_in                IN VARCHAR2,
   operation_in              IN VARCHAR2,
   user_in                   IN VARCHAR2,
   out_reasons               OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.GET_LST_COST_OPERATION(
      in_account         => TO_NUMBER(account_in),
      in_operation       => TO_NUMBER(operation_in),
      out_cost_operation => out_reasons,
      out_error          => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_REASONS_WITH_COST',
      storedProc_param    => 'account_in = '   || account_in   || LOG_LOGGER_PCK.F_SEP ||
                             'operation_in = ' || operation_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '      || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_REASONS_WITH_COST',
      storedProc_param    => 'account_in = '   || account_in   || LOG_LOGGER_PCK.F_SEP ||
                             'operation_in = ' || operation_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '      || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_REASONS_WITH_COST;


/****************************************************************************
** Procedure:   GET_CELLULAR_LIST                                          **
**                                                                         **
** Description: Busca uma lista de celulares dado um crit�rio de busca.    **
**                                                                         **
** Parameters:  search_type_in - Tipo de Busca:                            **
**                      MSISDN - Busca por msisdn.                         **
**                      ESN    - Busca por esn decimal.                    **
**                      ESN_HEX- Busca por esn hexadecimal.                **
**                      CNPJ   - Busca por cnpj.                           **
**                      RG     - Busca por rg.                             **
**                      NAME   - Busca por nome da entidade.               **
**                      MSISDN_REUT - Busca por reutilizacoes MSISDN.      **
**                      ESN_REUT - Busca por ESN reutilizacoes.            **
**              value_in - Valor da busca                                  **
**              client_type_in - Tipo de conta a ser consultada.           **
**              query_out - Query de saida a ser executada.                **
**              error_out - C�digo do erro                                 **
** Throws:                                                                 **
**                                                                         **
** Version  Date       Author     Description                              **
** -------- ---------- ---------- ---------------------------------------- **
** 01.00.00 17/05/2006 Renato H.  1. Implementacao busca por reutilizacoes **
****************************************************************************/
PROCEDURE GET_CELLULAR_LIST(
   search_type_in            IN VARCHAR2,
   value_in                  IN VARCHAR2,
   client_type_in            IN VARCHAR2,
   query_out                 OUT VARCHAR2,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;
   v_search_type_in          VARCHAR2(15);
   v_value_in                VARCHAR2(255);
BEGIN

   v_search_type_in := search_type_in;
   v_value_in := value_in;

   IF(v_search_type_in = 'ESN_HEX') THEN
      v_value_in := CAR_INVENTORY_PCK.VALIDATE_AND_CONVERT_ESN(v_value_in, 'HEX');
      v_search_type_in := 'ESN';
   END IF;

   IF(v_search_type_in = 'ESN' OR v_search_type_in = 'ESN_REUT') AND(LENGTH(v_value_in) != 11) THEN
      error_out := 934;
   ELSIF((v_search_type_in = 'MSISDN' OR v_search_type_in = 'MSISDN_REUT') AND(LENGTH(v_value_in) = 0)) THEN
      error_out := 934;
   ELSE
      ACC_CRM_PCK.ACC_GET_CELLULAR_LIST(
         search_type_in => v_search_type_in,
         value_in => v_value_in,
         client_type_in => client_type_in,
         query_out => query_out,
         error_out => error_out
      );
   END IF;

   IF(error_out <> 0) THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity         => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code    => NULL,
      trans_id_nr      => NULL,
      operation        => NULL,
      storedProc_name  => 'CAR_ACCOUNT_PCK.GET_CELLULAR_LIST',
      storedProc_param => 'search_type_in = ' || v_search_type_in || Log_Logger_Pck.F_SEP ||
                          'value_in = '       || v_value_in,
      storedProc_type  => Log_Logger_Pck.INITIAL_PROC_TYPE,
      error_code       => error_out,
      sql_error        => NULL,
      account_id       => NULL,
      line_code        => NULL,
      additional_text  => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity         => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code    => NULL,
      trans_id_nr      => NULL,
      operation        => NULL,
      storedProc_name  => 'CAR_ACCOUNT_PCK.GET_CELLULAR_LIST',
      storedProc_param => 'search_type_in = ' || v_search_type_in || Log_Logger_Pck.F_SEP ||
                          'value_in = '       || v_value_in,
      storedProc_type  => Log_Logger_Pck.INITIAL_PROC_TYPE,
      error_code       => SQLCODE,
      sql_error        => SQLERRM,
      account_id       => NULL,
      line_code        => NULL,
      additional_text  => NULL
   );

END GET_CELLULAR_LIST;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_CELLULAR                                                  **
*****************************************************************************/
PROCEDURE GET_CELLULAR(
   account_in                IN VARCHAR2,
   user_in                   IN VARCHAR2,
   cellular_out              OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_GET_CELLULAR(
      account_in   => TO_NUMBER(account_in),
      cellular_out => cellular_out,
      error_out    => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CELLULAR',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CELLULAR',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_CELLULAR;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_ACCOUNT_INFO                                              **
*****************************************************************************/
PROCEDURE GET_ACCOUNT_INFO (
   account_in   IN  VARCHAR2,
   info_out     OUT REF_CURSOR,
   error_out    OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_GET_ACCOUNT_INFO(
      account_in   => TO_NUMBER(account_in),
      info_out     => info_out,
      error_out    => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ACCOUNT_INFO',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ACCOUNT_INFO',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_ACCOUNT_INFO;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: CHECK_CHANGE_CELLULAR                                         **
*****************************************************************************/
PROCEDURE CHECK_CHANGE_CELLULAR(
   account_destiny_in        IN VARCHAR2,
   area_code_origin_in       IN VARCHAR2,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_CHECK_CHANGE_CELLULAR(
      account_destiny_in  => TO_NUMBER(account_destiny_in),
      area_code_origin_in => TO_NUMBER(area_code_origin_in),
      error_out           => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_CHANGE_CELLULAR',
      storedProc_param    => 'account_destiny_in = '  || account_destiny_in  || LOG_LOGGER_PCK.F_SEP ||
                             'area_code_origin_in = ' || area_code_origin_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_CHANGE_CELLULAR',
      storedProc_param    => 'account_destiny_in = '  || account_destiny_in  || LOG_LOGGER_PCK.F_SEP ||
                             'area_code_origin_in = ' || area_code_origin_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END CHECK_CHANGE_CELLULAR;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_ACCOUNT                                                   **
*****************************************************************************/
-- Desc: Calls API from Account to generate new account number
PROCEDURE GET_ACCOUNT(
   account_code_out          OUT NUMBER,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   NGIN_ACC_BD1.GET_ACCOUNT(
      account_code_out => account_code_out,
      error_out        => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ACCOUNT',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ACCOUNT',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_ACCOUNT;






/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_CLIENT                                                    **
*****************************************************************************/
PROCEDURE GET_CLIENT(
   account_in                IN VARCHAR2,
   client_type_in            IN VARCHAR2,
   user_in                   IN VARCHAR2,
   address_category_in       IN VARCHAR2,
   client_out                OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;


BEGIN

   ACC_CRM_PCK.ACC_GET_CLIENT(
      account_in => TO_NUMBER(account_in),
      client_type_in => TO_NUMBER(client_type_in),
      address_category_in => TO_NUMBER(address_category_in),
      client_out => client_out,
      error_out  => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CLIENT',
      storedProc_param    => 'account_in = '            || account_in     || LOG_LOGGER_PCK.F_SEP ||
                             'client_type_in = '        || client_type_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '               || user_in        || LOG_LOGGER_PCK.F_SEP ||
                             'address_category_in = '   || address_category_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CLIENT',
      storedProc_param    => 'account_in = '            || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '               || user_in        || LOG_LOGGER_PCK.F_SEP ||
                             'address_category_in = '   || address_category_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_CLIENT;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: EXPRESS_REGISTRATION                                          **
*****************************************************************************/
PROCEDURE EXPRESS_REGISTRATION(
   trans_id_code             IN VARCHAR2,
   operation_in              IN VARCHAR2,
   account_in                IN VARCHAR2,
   event_date_in             IN VARCHAR2,
   entity_type_in            IN VARCHAR2,
   short_name_in             IN VARCHAR2,
   confidential_in           IN VARCHAR2,
   name_in                   IN VARCHAR2,
   birth_date_in             IN VARCHAR2,
   sex_in                    IN VARCHAR2,
   civil_state_in            IN VARCHAR2,
   rg_in                     IN VARCHAR2,
   rg_type_in                IN VARCHAR2,
   rg_emission_date_in       IN VARCHAR2,
   rg_state_in               IN VARCHAR2,
   rg_org_exp_in             IN VARCHAR2,
   nif_in                    IN VARCHAR2,
   nif_type_in               IN VARCHAR2,
   passport_in               IN VARCHAR2,
   passport_type_in          IN VARCHAR2,
   driving_license_in        IN VARCHAR2,
   driving_license_type_in   IN VARCHAR2,
   to_the_care_of_in         IN VARCHAR2,
   phone_in                  IN VARCHAR2,
   fax_in                    IN VARCHAR2,
   e_mail_in                 IN VARCHAR2,
   family_unit_in            IN VARCHAR2,
   com_regist_conserv_in     IN VARCHAR2,
   com_regist_in             IN VARCHAR2,
   profession_code_in        IN VARCHAR2,
   academic_qualif_in        IN VARCHAR2,
   mobile_phone_in           IN VARCHAR2,
   segment_type_in           IN VARCHAR2,
   segment_sub_type_in       IN VARCHAR2,
   month_salary_in           IN VARCHAR2,
   cc_in                     IN VARCHAR2,
   bank_in                   IN VARCHAR2,
   iepj_in                   IN VARCHAR2,
   name_suffix_in            IN VARCHAR2,
   first_name_in             IN VARCHAR2,
   last_name_in              IN VARCHAR2,
   contact_name_in           IN VARCHAR2,
   employee_letter_in        IN VARCHAR2,
   address_type_in           IN VARCHAR2,
   address_in                IN VARCHAR2,
   address_number_in         IN VARCHAR2,
   complement_in             IN VARCHAR2,
   postal_code1_in           IN VARCHAR2,
   postal_code2_in           IN VARCHAR2,
   quarter_in                IN VARCHAR2,
   city_in                   IN VARCHAR2,
   country_prefix_in         IN VARCHAR2,
   geographical_state_in     IN VARCHAR2,
   cost_value1_in            IN VARCHAR2,
   cost_value2_in            IN VARCHAR2,
   reason_in                 IN VARCHAR2,
   obs_in                    IN VARCHAR2,
   user_in                   IN VARCHAR2,
   ip_address_in             IN VARCHAR2,
   category_in               IN VARCHAR2,
   reference_point_in        IN VARCHAR2,
   cnl_code_in               IN VARCHAR2,
   ibge_code_in              IN VARCHAR2,
   error_out                 OUT NUMBER
) IS
--   trans_id_code             VARCHAR2(3);
   trans_id_nr               NUMBER;
   procedure_error           EXCEPTION;

BEGIN

   --trans_id_code := CAR_GENERIC_PCK.TRANS_ID_CODE;
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
   
   LOG_LOGGER_CONTEXT.SET_CONTEXT (
               in_account_id     => account_in, 
               in_trans_id_code  => trans_id_code, 
               in_trans_id_nr    => trans_id_nr, 
               in_operation      => operation_in
   );

   VIVO_PRE_BRL_BD1.ACC_EXPRESS_REGISTRY(
      in_trans_id_code        => trans_id_code,
      in_trans_id_nr          => trans_id_nr,
      in_operation            => operation_in,
      in_account              => account_in,
      in_event_date           => to_date(event_date_in,'YYYYMMDDHH24MISS'),
      in_entity_type          => entity_type_in,
      in_short_name           => short_name_in,
      in_confidential         => confidential_in,
      in_name                 => name_in,
      in_birth_date           => to_date(birth_date_in,NGIN_GER_BD.DATE_MASK),
      in_sex                  => sex_in,
      in_civil_state          => civil_state_in,
      in_rg                   => rg_in,
      in_rg_type              => rg_type_in,
      in_rg_emission_date     => to_date(rg_emission_date_in,NGIN_GER_BD.DATE_MASK),
      in_rg_state             => rg_state_in,
      in_rg_org_exp           => rg_org_exp_in,
      in_nif                  => nif_in,
      in_nif_type             => nif_type_in,
      in_passport             => passport_in,
      in_passport_type        => passport_type_in,
      in_driving_license      => driving_license_in,
      in_driving_license_type => driving_license_type_in,
      in_to_the_care_of       => to_the_care_of_in,
      in_phone                => phone_in,
      in_fax                  => fax_in,
      in_e_mail               => e_mail_in,
      in_family_unit          => TO_NUMBER(family_unit_in),
      in_com_regist_conserv   => com_regist_conserv_in,
      in_com_regist           => com_regist_in,
      in_profession_code      => TO_NUMBER(profession_code_in),
      in_academic_qualif      => TO_NUMBER(academic_qualif_in),
      in_mobile_phone         => mobile_phone_in,
      in_segment_type         => segment_type_in,
      in_segment_sub_type     => segment_sub_type_in,
      in_month_salary         => TO_NUMBER(month_salary_in),
      in_cc                   => cc_in,
      in_bank                 => TO_NUMBER(bank_in),
      in_iepj                 => iepj_in,
      in_name_suffix          => name_suffix_in,
      in_first_name           => first_name_in,
      in_last_name            => last_name_in,
      in_contact_name         => contact_name_in,
      in_employee_letter      => employee_letter_in,
      in_address_type         => address_type_in,
      in_address              => address_in,
      in_address_number       => address_number_in,
      in_complement           => complement_in,
      in_postal_code1         => postal_code1_in,
      in_postal_code2         => postal_code2_in,
      in_quarter              => quarter_in,
      in_city                 => city_in,
      in_country              => country_prefix_in,
      in_geographical_state   => geographical_state_in,
      in_cost_value1          => TO_NUMBER(cost_value1_in, NGIN_GER_BD.CURRENCY_MASK, NGIN_GER_BD.CURRENCY_MASK_OPTIONS),
      in_cost_value2          => cost_value2_in,
      in_reason               => TO_NUMBER(reason_in),
      in_obs                  => obs_in,
      in_user                 => user_in,
      in_ip_address           => ip_address_in,
      in_category             => category_in,
      in_reference_point      => reference_point_in,
      in_cnl_code             => cnl_code_in,
      in_ibge_code            => ibge_code_in,
      out_error               => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) <> 0 THEN
      RAISE procedure_error;
   END IF;
   
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.EXPRESS_REGISTRATION',
      storedProc_param    => 'operation_in = '            || operation_in            || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '              || account_in              || LOG_LOGGER_PCK.F_SEP ||
                             'entity_type_in = '          || entity_type_in          || LOG_LOGGER_PCK.F_SEP ||
                             'short_name_in = '           || short_name_in           || LOG_LOGGER_PCK.F_SEP ||
                             'confidential_in = '         || confidential_in         || LOG_LOGGER_PCK.F_SEP ||
                             'name_in = '                 || name_in                 || LOG_LOGGER_PCK.F_SEP ||
                             'birth_date_in = '           || birth_date_in           || LOG_LOGGER_PCK.F_SEP ||
                             'sex_in = '                  || sex_in                  || LOG_LOGGER_PCK.F_SEP ||
                             'civil_state_in = '          || civil_state_in          || LOG_LOGGER_PCK.F_SEP ||
                             'rg_in = '                   || rg_in                   || LOG_LOGGER_PCK.F_SEP ||
                             'rg_type_in = '              || rg_type_in              || LOG_LOGGER_PCK.F_SEP ||
                             'rg_emission_date_in = '     || rg_emission_date_in     || LOG_LOGGER_PCK.F_SEP ||
                             'rg_state_in = '             || rg_state_in             || LOG_LOGGER_PCK.F_SEP ||
                             'rg_org_exp_in = '           || rg_org_exp_in           || LOG_LOGGER_PCK.F_SEP ||
                             'nif_in = '                  || nif_in                  || LOG_LOGGER_PCK.F_SEP ||
                             'nif_type_in = '             || nif_type_in             || LOG_LOGGER_PCK.F_SEP ||
                             'passport_in = '             || passport_in             || LOG_LOGGER_PCK.F_SEP ||
                             'passport_type_in = '        || passport_type_in        || LOG_LOGGER_PCK.F_SEP ||
                             'driving_license_in = '      || driving_license_in      || LOG_LOGGER_PCK.F_SEP ||
                             'driving_license_type_in = ' || driving_license_type_in || LOG_LOGGER_PCK.F_SEP ||
                             'to_the_care_of_in = '       || to_the_care_of_in       || LOG_LOGGER_PCK.F_SEP ||
                             'phone_in = '                || phone_in                || LOG_LOGGER_PCK.F_SEP ||
                             'fax_in = '                  || fax_in                  || LOG_LOGGER_PCK.F_SEP ||
                             'e_mail_in = '               || e_mail_in               || LOG_LOGGER_PCK.F_SEP ||
                             'family_unit_in = '          || family_unit_in          || LOG_LOGGER_PCK.F_SEP ||
                             'com_regist_conserv_in = '   || com_regist_conserv_in   || LOG_LOGGER_PCK.F_SEP ||
                             'com_regist_in = '           || com_regist_in           || LOG_LOGGER_PCK.F_SEP ||
                             'profession_code_in = '      || profession_code_in      || LOG_LOGGER_PCK.F_SEP ||
                             'academic_qualif_in = '      || academic_qualif_in      || LOG_LOGGER_PCK.F_SEP ||
                             'mobile_phone_in = '         || mobile_phone_in         || LOG_LOGGER_PCK.F_SEP ||
                             'segment_type_in = '         || segment_type_in         || LOG_LOGGER_PCK.F_SEP ||
                             'segment_sub_type_in = '     || segment_sub_type_in     || LOG_LOGGER_PCK.F_SEP ||
                             'month_salary_in = '         || month_salary_in         || LOG_LOGGER_PCK.F_SEP ||
                             'cc_in = '                   || cc_in                   || LOG_LOGGER_PCK.F_SEP ||
                             'bank_in = '                 || bank_in                 || LOG_LOGGER_PCK.F_SEP ||
                             'iepj_in = '                 || iepj_in                 || LOG_LOGGER_PCK.F_SEP ||
                             'name_suffix_in = '          || name_suffix_in          || LOG_LOGGER_PCK.F_SEP ||
                             'first_name_in = '           || first_name_in           || LOG_LOGGER_PCK.F_SEP ||
                             'last_name_in = '            || last_name_in            || LOG_LOGGER_PCK.F_SEP ||
                             'contact_name_in = '         || contact_name_in         || LOG_LOGGER_PCK.F_SEP ||
                             'employee_letter_in = '      || employee_letter_in      || LOG_LOGGER_PCK.F_SEP ||
                             'address_type_in = '         || address_type_in         || LOG_LOGGER_PCK.F_SEP ||
                             'address_in = '              || address_in              || LOG_LOGGER_PCK.F_SEP ||
                             'address_number_in = '       || address_number_in       || LOG_LOGGER_PCK.F_SEP ||
                             'complement_in = '           || complement_in           || LOG_LOGGER_PCK.F_SEP ||
                             'postal_code1_in = '         || postal_code1_in         || LOG_LOGGER_PCK.F_SEP ||
                             'postal_code2_in = '         || postal_code2_in         || LOG_LOGGER_PCK.F_SEP ||
                             'quarter_in = '              || quarter_in              || LOG_LOGGER_PCK.F_SEP ||
                             'city_in = '                 || city_in                 || LOG_LOGGER_PCK.F_SEP ||
                             'country_prefix_in = '       || country_prefix_in       || LOG_LOGGER_PCK.F_SEP ||
                             'geographical_state_in = '   || geographical_state_in   || LOG_LOGGER_PCK.F_SEP ||
                             'cost_value1_in = '          || cost_value1_in          || LOG_LOGGER_PCK.F_SEP ||
                             'cost_value2_in = '          || cost_value2_in          || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '               || reason_in               || LOG_LOGGER_PCK.F_SEP ||
                             'obs_in = '                  || obs_in                  || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '                 || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
WHEN OTHERS THEN
   ROLLBACK;
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.EXPRESS_REGISTRATION',
      storedProc_param    => 'operation_in = '            || operation_in            || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '              || account_in              || LOG_LOGGER_PCK.F_SEP ||
                             'entity_type_in = '          || entity_type_in          || LOG_LOGGER_PCK.F_SEP ||
                             'short_name_in = '           || short_name_in           || LOG_LOGGER_PCK.F_SEP ||
                             'confidential_in = '         || confidential_in         || LOG_LOGGER_PCK.F_SEP ||
                             'name_in = '                 || name_in                 || LOG_LOGGER_PCK.F_SEP ||
                             'birth_date_in = '           || birth_date_in           || LOG_LOGGER_PCK.F_SEP ||
                             'sex_in = '                  || sex_in                  || LOG_LOGGER_PCK.F_SEP ||
                             'civil_state_in = '          || civil_state_in          || LOG_LOGGER_PCK.F_SEP ||
                             'rg_in = '                   || rg_in                   || LOG_LOGGER_PCK.F_SEP ||
                             'rg_type_in = '              || rg_type_in              || LOG_LOGGER_PCK.F_SEP ||
                             'rg_emission_date_in = '     || rg_emission_date_in     || LOG_LOGGER_PCK.F_SEP ||
                             'rg_state_in = '             || rg_state_in             || LOG_LOGGER_PCK.F_SEP ||
                             'rg_org_exp_in = '           || rg_org_exp_in           || LOG_LOGGER_PCK.F_SEP ||
                             'nif_in = '                  || nif_in                  || LOG_LOGGER_PCK.F_SEP ||
                             'nif_type_in = '             || nif_type_in             || LOG_LOGGER_PCK.F_SEP ||
                             'passport_in = '             || passport_in             || LOG_LOGGER_PCK.F_SEP ||
                             'passport_type_in = '        || passport_type_in        || LOG_LOGGER_PCK.F_SEP ||
                             'driving_license_in = '      || driving_license_in      || LOG_LOGGER_PCK.F_SEP ||
                             'driving_license_type_in = ' || driving_license_type_in || LOG_LOGGER_PCK.F_SEP ||
                             'to_the_care_of_in = '       || to_the_care_of_in       || LOG_LOGGER_PCK.F_SEP ||
                             'phone_in = '                || phone_in                || LOG_LOGGER_PCK.F_SEP ||
                             'fax_in = '                  || fax_in                  || LOG_LOGGER_PCK.F_SEP ||
                             'e_mail_in = '               || e_mail_in               || LOG_LOGGER_PCK.F_SEP ||
                             'family_unit_in = '          || family_unit_in          || LOG_LOGGER_PCK.F_SEP ||
                             'com_regist_conserv_in = '   || com_regist_conserv_in   || LOG_LOGGER_PCK.F_SEP ||
                             'com_regist_in = '           || com_regist_in           || LOG_LOGGER_PCK.F_SEP ||
                             'profession_code_in = '      || profession_code_in      || LOG_LOGGER_PCK.F_SEP ||
                             'academic_qualif_in = '      || academic_qualif_in      || LOG_LOGGER_PCK.F_SEP ||
                             'mobile_phone_in = '         || mobile_phone_in         || LOG_LOGGER_PCK.F_SEP ||
                             'segment_type_in = '         || segment_type_in         || LOG_LOGGER_PCK.F_SEP ||
                             'segment_sub_type_in = '     || segment_sub_type_in     || LOG_LOGGER_PCK.F_SEP ||
                             'month_salary_in = '         || month_salary_in         || LOG_LOGGER_PCK.F_SEP ||
                             'cc_in = '                   || cc_in                   || LOG_LOGGER_PCK.F_SEP ||
                             'bank_in = '                 || bank_in                 || LOG_LOGGER_PCK.F_SEP ||
                             'iepj_in = '                 || iepj_in                 || LOG_LOGGER_PCK.F_SEP ||
                             'name_suffix_in = '          || name_suffix_in          || LOG_LOGGER_PCK.F_SEP ||
                             'first_name_in = '           || first_name_in           || LOG_LOGGER_PCK.F_SEP ||
                             'last_name_in = '            || last_name_in            || LOG_LOGGER_PCK.F_SEP ||
                             'contact_name_in = '         || contact_name_in         || LOG_LOGGER_PCK.F_SEP ||
                             'employee_letter_in = '      || employee_letter_in      || LOG_LOGGER_PCK.F_SEP ||
                             'address_type_in = '         || address_type_in         || LOG_LOGGER_PCK.F_SEP ||
                             'address_in = '              || address_in              || LOG_LOGGER_PCK.F_SEP ||
                             'address_number_in = '       || address_number_in       || LOG_LOGGER_PCK.F_SEP ||
                             'complement_in = '           || complement_in           || LOG_LOGGER_PCK.F_SEP ||
                             'postal_code1_in = '         || postal_code1_in         || LOG_LOGGER_PCK.F_SEP ||
                             'postal_code2_in = '         || postal_code2_in         || LOG_LOGGER_PCK.F_SEP ||
                             'quarter_in = '              || quarter_in              || LOG_LOGGER_PCK.F_SEP ||
                             'city_in = '                 || city_in                 || LOG_LOGGER_PCK.F_SEP ||
                             'country_prefix_in = '       || country_prefix_in       || LOG_LOGGER_PCK.F_SEP ||
                             'geographical_state_in = '   || geographical_state_in   || LOG_LOGGER_PCK.F_SEP ||
                             'cost_value1_in = '          || cost_value1_in          || LOG_LOGGER_PCK.F_SEP ||
                             'cost_value2_in = '          || cost_value2_in          || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '               || reason_in               || LOG_LOGGER_PCK.F_SEP ||
                             'obs_in = '                  || obs_in                  || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '                 || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

END EXPRESS_REGISTRATION;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_POSSIBLE_PLANS                                            **
*****************************************************************************/
-- Desc:
-- Call API from Account reponsible to get the possible plans
-- that the current account can change
PROCEDURE GET_POSSIBLE_PLANS(
   account_in                IN VARCHAR2,
   product_type_in           IN VARCHAR2,
   user_in                   IN VARCHAR2,
   plan_list_out             OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   -- Calls the ACC API --
   ACC_CRM_PCK.ACC_GET_POSSIBLE_PLANS(
      account_in             => TO_NUMBER(account_in),
      product_type_in        => TO_NUMBER(product_type_in),
      possible_plan_list_out => plan_list_out,
      error_out              => error_out);

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_POSSIBLE_PLANS',
      storedProc_param    => 'account_in = '      || account_in      || LOG_LOGGER_PCK.F_SEP ||
                             'product_type_in = ' || product_type_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '         || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_POSSIBLE_PLANS',
      storedProc_param    => 'account_in = '      || account_in      || LOG_LOGGER_PCK.F_SEP ||
                             'product_type_in = ' || product_type_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '         || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_POSSIBLE_PLANS;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_LOST_SERVICES                                             **
*****************************************************************************/
-- Desc:
-- Call API reponsible to get the lost services
-- if the current account change to another plan
PROCEDURE GET_LOST_SERVICES(
   account_in                IN VARCHAR2,
   user_in                   IN VARCHAR2,
   lost_services_list_out    OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   -- call the SRV API --
   NGIN_SRV_BD1.PRIV_GET_LOST_SERVICES(
      in_account => TO_NUMBER(account_in),
      out_data   => lost_services_list_out,
      out_error  => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_LOST_SERVICES',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_LOST_SERVICES',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_LOST_SERVICES;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_COUNTRY_LIST                                              **
*****************************************************************************/
-- Desc: Calls API from Account to list all Countries
PROCEDURE GET_COUNTRY_LIST(
   country_list_out          OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_GET_COUNTRY(
      country_list_out => country_list_out,
      error_out        => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_COUNTRY_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_COUNTRY_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_COUNTRY_LIST;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_GEO_STATE_LIST                                            **
*****************************************************************************/
-- Desc: Calls API from Account to list all Geo states
PROCEDURE GET_GEO_STATE_LIST(
   geo_state_list_out        OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_GET_GEO_STATE(
      geo_state_list_out => geo_state_list_out,
      error_out          => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_GEO_STATE_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_GEO_STATE_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END  GET_GEO_STATE_LIST;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_ENTITY_TYPE_LIST                                          **
*****************************************************************************/
-- Desc: Calls API from Account to list all Entity types
PROCEDURE GET_ENTITY_TYPE_LIST(
   entity_type_list_out      OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_GET_ENTITY_TYPE(
      entity_type_list_out => entity_type_list_out,
      error_out            => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ENTITY_TYPE_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ENTITY_TYPE_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_ENTITY_TYPE_LIST;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: CHANGE_PROFILE                                                **
*****************************************************************************/
PROCEDURE CHANGE_PROFILE(
   operation_code_in         IN VARCHAR2,
   account_in                IN VARCHAR2,
   new_plan_in               IN VARCHAR2,
   cost_in                   IN VARCHAR2,
   cost_flag_in              IN VARCHAR2,
   reason_code_in            IN VARCHAR2,
   obs_in                    IN VARCHAR2,
   user_in                   IN VARCHAR2,
   ip_address_in             IN VARCHAR2,
   error_out                 OUT NUMBER
) IS
   trans_id_code             VARCHAR2(3);
   trans_id_nr               NUMBER;
   procedure_error           EXCEPTION;

BEGIN

   trans_id_code := CAR_GENERIC_PCK.TRANS_ID_CODE;
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;

   ACC_CRM_PCK.CHANGE_PROFILE(
      in_trans_id_code => trans_id_code,
      in_trans_id_nr   => trans_id_nr,
      in_operation     => operation_code_in,
      in_account       => TO_NUMBER(account_in),
      in_new_plan      => new_plan_in,
      in_cost_value1   => TO_NUMBER(cost_in, NGIN_GER_BD.CURRENCY_MASK, NGIN_GER_BD.CURRENCY_MASK_OPTIONS),
      in_cost_value2   => cost_flag_in,
      in_reason_code   => TO_NUMBER(reason_code_in),
      in_obs           => obs_in,
      in_user          => user_in,
      in_ip_address    => ip_address_in,
      out_error        => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) = 0 THEN
      COMMIT;
   ELSE
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_code_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_PROFILE',
      storedProc_param    => 'operation_code_in = ' || operation_code_in || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '        || account_in        || LOG_LOGGER_PCK.F_SEP ||
                             'new_plan_in = '       || new_plan_in       || LOG_LOGGER_PCK.F_SEP ||
                             'cost_in = '           || cost_in           || LOG_LOGGER_PCK.F_SEP ||
                             'cost_flag_in = '      || cost_flag_in      || LOG_LOGGER_PCK.F_SEP ||
                             'reason_code_in = '    || reason_code_in    || LOG_LOGGER_PCK.F_SEP ||
                             'obs_in = '            || obs_in            || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '           || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   ROLLBACK;
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_code_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_PROFILE',
      storedProc_param    => 'operation_code_in = ' || operation_code_in || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '        || account_in        || LOG_LOGGER_PCK.F_SEP ||
                             'new_plan_in = '       || new_plan_in       || LOG_LOGGER_PCK.F_SEP ||
                             'cost_in = '           || cost_in           || LOG_LOGGER_PCK.F_SEP ||
                             'cost_flag_in = '      || cost_flag_in      || LOG_LOGGER_PCK.F_SEP ||
                             'reason_code_in = '    || reason_code_in    || LOG_LOGGER_PCK.F_SEP ||
                             'obs_in = '            || obs_in            || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '           || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END CHANGE_PROFILE;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_PRIVATE_ACCOUNTS                                          **
*****************************************************************************/
PROCEDURE GET_PRIVATE_ACCOUNTS(
   in_account                  IN  VARCHAR2,
   out_private_accounts_query  OUT VARCHAR2,
   out_error                   OUT NUMBER
) IS
   procedure_error             EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_GET_PRIVATE_ACCOUNTS(
      account_in           => in_account,
      private_accounts_out => out_private_accounts_query,
      error_out            => out_error
   );

   IF out_error <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PRIVATE_ACCOUNTS',
      storedProc_param    => 'in_account = ' || in_account,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PRIVATE_ACCOUNTS',
      storedProc_param    => 'in_account = ' || in_account,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_PRIVATE_ACCOUNTS;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: UNLINK_CELLULAR                                               **
*****************************************************************************/
-- Desc: Desprogramacao de linha --
PROCEDURE UNLINK_CELLULAR(
   in_account                   IN VARCHAR2,
   in_reason_code               IN VARCHAR2,
   in_obs                       IN VARCHAR2,
   in_user                      IN VARCHAR2,
   ip_address_in                IN VARCHAR2,
   out_error                    OUT NUMBER
) IS
   trans_id_code                VARCHAR2(3);
   trans_id_nr                  NUMBER;
   error_out_dblink             NUMBER;
   procedure_error              EXCEPTION;

BEGIN

   trans_id_code := CAR_GENERIC_PCK.trans_id_code;
   SELECT car_trans_id_nr_seq.NEXTVAL INTO trans_id_nr FROM dual;

   ACC_CRM_PCK.ACC_SERIAL_UNPROG(
      in_trans_id_code => trans_id_code,
      in_trans_id_nr   => trans_id_nr,
      in_account       => TO_NUMBER(in_account),
      in_reason_code   => TO_NUMBER(in_reason_code),
      in_obs           => in_obs,
      in_user          => in_user,
      in_ip_address    => ip_address_in,
      out_error        => out_error
   );

   IF NGIN_GER_BD.CHECK_ERROR(out_error) = 0 THEN
      COMMIT;
      NGIN_GER_BD1.CLOSE_DBLINK_ATOB(
         in_multi_operation_code => 7, --MBL_DESPROG - Desprograma��o de celular
         in_dblink               => NULL,
         out_error               => error_out_dblink
      );
   ELSE
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;

   NGIN_GER_BD1.CLOSE_DBLINK_ATOB(
      in_multi_operation_code => 7, --MBL_DESPROG - Desprograma��o de celular
      in_dblink               => NULL,
      out_error               => error_out_dblink
   );

   IF error_out_dblink <> 0 THEN
      out_error := error_out_dblink;
   END IF;

   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => 7, --MBL_DESPROG - Desprograma��o de celular
      storedProc_name     => 'CAR_ACCOUNT_PCK.UNLINK_CELLULAR',
      storedProc_param    => 'in_account = '     || in_account     || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason_code = ' || in_reason_code || LOG_LOGGER_PCK.F_SEP ||
                             'in_obs = '         || in_obs         || LOG_LOGGER_PCK.F_SEP ||
                             'in_user = '        || in_user,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   ROLLBACK;
   out_error := SQLCODE;

   NGIN_GER_BD1.CLOSE_DBLINK_ATOB(
      in_multi_operation_code => 7, --MBL_DESPROG - Desprograma��o de celular
      in_dblink               => NULL,
      out_error               => error_out_dblink
   );

   IF error_out_dblink <> 0 THEN
      out_error := error_out_dblink;
   END IF;

   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => 7, --MBL_DESPROG - Desprograma��o de celular
      storedProc_name     => 'CAR_ACCOUNT_PCK.UNLINK_CELLULAR',
      storedProc_param    => 'in_account = '     || in_account     || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason_code = ' || in_reason_code || LOG_LOGGER_PCK.F_SEP ||
                             'in_obs = '         || in_obs         || LOG_LOGGER_PCK.F_SEP ||
                             'in_user = '        || in_user,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );

END UNLINK_CELLULAR;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: CHANGE_ESN                                                    **
*****************************************************************************/
-- Desc: Calls API from Account to change ESN(equipment) of a CDMA cellular
PROCEDURE CHANGE_ESN(
   in_trans_id_code           IN VARCHAR2,
   in_operation               IN VARCHAR2,
   in_account                 IN VARCHAR2,
   in_esn_new                 IN VARCHAR2,
   in_equip_model_new         IN VARCHAR2,
   in_cost                    IN VARCHAR2,
   in_cost_flag               IN VARCHAR2,
   in_reason                  IN VARCHAR2,
   in_dealer_new              IN VARCHAR2,
   in_observation             IN VARCHAR2,
   in_promotions              IN VARCHAR2,
   in_user                    IN VARCHAR2,
   in_ip_address              IN VARCHAR2,
   in_esn_type_new            IN VARCHAR2,
   out_error                  OUT NUMBER
) IS
   procedure_error            EXCEPTION;
   trans_id_nr                NUMBER;
   promotion_list_out         INT_LIST;
   promotion_list_in          INT_LIST;
   v_esn_new_decimal          VARCHAR2(15);
   V_FLAG_IS_HABILIT          NUMBER := 0;

BEGIN

   v_esn_new_decimal := CAR_INVENTORY_PCK.VALIDATE_AND_CONVERT_ESN(in_esn_new, in_esn_type_new);

   NGIN_GER_BD.VARCHAR_TO_INTEGER_LIST(in_promotions, ';', promotion_list_out, out_error);
   promotion_list_in := promotion_list_out;

    ACC_CRM_PCK.GET_ESN_STATE(
               in_trans_id_code  => in_trans_id_code,
               in_trans_id_nr    => trans_id_nr,
               in_operation      => TO_NUMBER(in_operation),
               in_esn            => v_esn_new_decimal,
               out_error         => out_error,
               out_esn_state     => V_FLAG_IS_HABILIT
        );

    IF (out_error <> 0) THEN
         RAISE PROCEDURE_ERROR;
    END IF;

   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;

   ACC_CRM_PCK.CHANGE_ESN(
      in_trans_id_code   => in_trans_id_code,
      in_trans_id_nr     => trans_id_nr,
      in_operation       => TO_NUMBER(in_operation),
      in_account         => TO_NUMBER(in_account),
      in_esn_new         => v_esn_new_decimal,
      in_equip_model_new => in_equip_model_new,
      in_cost_value1     => TO_NUMBER(in_cost, NGIN_GER_BD.CURRENCY_MASK, NGIN_GER_BD.CURRENCY_MASK_OPTIONS),
      in_cost_value2     => in_cost_flag,
      in_reason          => in_reason,
      in_dealer_new      => in_dealer_new,
      in_user            => in_user,
      in_obs             => in_observation,
      in_promotions      => promotion_list_in,
      in_ip_address      => in_ip_address,
      out_error          => out_error,
      in_esn_state       => V_FLAG_IS_HABILIT
   );
   
   IF (out_error <> 0) THEN
        RAISE PROCEDURE_ERROR;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => in_trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_ESN',
      storedProc_param    => 'in_trans_id_code = '       || in_trans_id_code       || LOG_LOGGER_PCK.F_SEP ||
                               'in_operation = '           || in_operation           || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '             || in_account             || LOG_LOGGER_PCK.F_SEP ||
                             'in_esn_new = '             || v_esn_new_decimal      || LOG_LOGGER_PCK.F_SEP ||
                             'in_equip_model_new = '     || in_equip_model_new     || LOG_LOGGER_PCK.F_SEP ||
                             'in_cost = '                || in_cost                || LOG_LOGGER_PCK.F_SEP ||
                             'in_cost_flag = '           || in_cost_flag           || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason = '              || in_reason              || LOG_LOGGER_PCK.F_SEP ||
                             'in_dealer_new = '          || in_dealer_new          || LOG_LOGGER_PCK.F_SEP ||
                             'in_observation = '         || in_observation         || LOG_LOGGER_PCK.F_SEP ||
                             'in_promotions = '          || in_promotions          || LOG_LOGGER_PCK.F_SEP ||
                             'in_user = '                || in_user                || LOG_LOGGER_PCK.F_SEP ||
                             'in_esn_type_new = '        || in_esn_type_new,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => in_trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_ESN',
      storedProc_param    => 'in_trans_id_code = '       || in_trans_id_code       || LOG_LOGGER_PCK.F_SEP ||
                               'in_operation = '           || in_operation           || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '             || in_account             || LOG_LOGGER_PCK.F_SEP ||
                             'in_esn_new = '             || v_esn_new_decimal      || LOG_LOGGER_PCK.F_SEP ||
                             'in_equip_model_new = '     || in_equip_model_new     || LOG_LOGGER_PCK.F_SEP ||
                             'in_cost = '                || in_cost                || LOG_LOGGER_PCK.F_SEP ||
                             'in_cost_flag = '           || in_cost_flag           || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason = '              || in_reason              || LOG_LOGGER_PCK.F_SEP ||
                             'in_dealer_new = '          || in_dealer_new          || LOG_LOGGER_PCK.F_SEP ||
                             'in_observation = '         || in_observation         || LOG_LOGGER_PCK.F_SEP ||
                             'in_promotions = '          || in_promotions          || LOG_LOGGER_PCK.F_SEP ||
                             'in_user = '                || in_user                || LOG_LOGGER_PCK.F_SEP ||
                             'in_esn_type_new = '        || in_esn_type_new,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );

END CHANGE_ESN;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: CHECK_CEP                                                     **
*****************************************************************************/
PROCEDURE CHECK_CEP(
   postal_code1              IN VARCHAR2,
   postal_code2              IN VARCHAR2,
   quarter_city_out          OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_CHECK_CEP(
      postal_code1_in  => postal_code1,
      postal_code2_in  => postal_code2,
      quarter_city_out => quarter_city_out,
      error_out        => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_CEP',
      storedProc_param    => 'postal_code1 = ' || postal_code1 || LOG_LOGGER_PCK.F_SEP ||
                             'postal_code2 = ' || postal_code2,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_CEP',
      storedProc_param    => 'postal_code1 = ' || postal_code1 || LOG_LOGGER_PCK.F_SEP ||
                             'postal_code2 = ' || postal_code2,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END CHECK_CEP;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_CIVIL_STATE_LIST                                          **
*****************************************************************************/
PROCEDURE GET_CIVIL_STATE_LIST(
   civil_state_list_out      OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_GET_CIVIL_STATE(
      civil_state_list_out => civil_state_list_out,
      error_out            => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CIVIL_STATE_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CIVIL_STATE_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_CIVIL_STATE_LIST;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_LST_COST_CHG_PROFILE                                      **
*****************************************************************************/
PROCEDURE GET_LST_COST_CHG_PROFILE(
   account_in                IN NUMBER,
   cost_chg_profile_out      OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.GET_LST_COST_CHG_PROFILE(
      in_account           => account_in,
      out_cost_chg_profile => cost_chg_profile_out,
      out_error            => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_LST_COST_CHG_PROFILE',
      storedProc_param    => 'account_in = ' || account_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_LST_COST_CHG_PROFILE',
      storedProc_param    => 'account_in = ' || account_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_LST_COST_CHG_PROFILE;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: SIMULTANEOUS_ESN_CHANGE                                       **
*****************************************************************************/
-- Desc: Calls API from account to perform simultaneous equipment change
PROCEDURE SIMULTANEOUS_ESN_CHANGE(
   operation_code_in         IN VARCHAR2,
   account_in                IN VARCHAR2,
   changing_account_in       IN VARCHAR2,
   cost_in                   IN VARCHAR2,
   costFlag_in               IN VARCHAR2,
   reason_code_in            IN VARCHAR2,
   dealer_code_in            IN VARCHAR2,
   observation_in            IN VARCHAR2,
   user_in                   IN VARCHAR2,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;
   trans_id_code             VARCHAR2(3);
   trans_id_nr               NUMBER;

BEGIN

   trans_id_code := CAR_GENERIC_PCK.TRANS_ID_CODE;
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;

   ACC_CRM_PCK.CHANGE_ESN_SIMULT(
      in_trans_id_code => trans_id_code,
      in_trans_id_nr   => trans_id_nr,
      in_operation     => operation_code_in,
      in_account_a     => account_in,
      in_account_b     => changing_account_in,
      in_cost_value1   => cost_in,
      in_cost_value2   => costFlag_in,
      in_reason        => reason_code_in,
      in_dealer        => dealer_code_in,
      in_user          => user_in,
      in_obs           => observation_in,
      out_error        => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) = 0 THEN
      COMMIT;
   ELSE
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_code_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.SIMULTANEOUS_ESN_CHANGE',
      storedProc_param    => 'operation_code_in = '   || operation_code_in   || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '          || account_in          || LOG_LOGGER_PCK.F_SEP ||
                             'changing_account_in = ' || changing_account_in || LOG_LOGGER_PCK.F_SEP ||
                             'cost_in = '             || cost_in             || LOG_LOGGER_PCK.F_SEP ||
                             'costFlag_in = '         || costFlag_in         || LOG_LOGGER_PCK.F_SEP ||
                             'reason_code_in = '      || reason_code_in      || LOG_LOGGER_PCK.F_SEP ||
                             'dealer_code_in = '      || dealer_code_in      || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = '      || observation_in      || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '             || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   ROLLBACK;
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_code_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.SIMULTANEOUS_ESN_CHANGE',
      storedProc_param    => 'operation_code_in = '   || operation_code_in   || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '          || account_in          || LOG_LOGGER_PCK.F_SEP ||
                             'changing_account_in = ' || changing_account_in || LOG_LOGGER_PCK.F_SEP ||
                             'cost_in = '             || cost_in             || LOG_LOGGER_PCK.F_SEP ||
                             'costFlag_in = '         || costFlag_in         || LOG_LOGGER_PCK.F_SEP ||
                             'reason_code_in = '      || reason_code_in      || LOG_LOGGER_PCK.F_SEP ||
                             'dealer_code_in = '      || dealer_code_in      || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = '      || observation_in      || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '             || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END SIMULTANEOUS_ESN_CHANGE;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_PLAFOND_TYPES_LIST                                        **
*****************************************************************************/
PROCEDURE GET_PLAFOND_TYPES_LIST(
   user_in                   IN VARCHAR2,
   operationType             IN VARCHAR2,
   plafond_list_out          OUT REF_CURSOR,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

   ACC_CRM_PCK.ACC_GET_PLAFOND_TYPES_LIST(
      in_operation_type => operationType,
      plafond_type_list_out => plafond_list_out,
      error_out             => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PLAFOND_TYPES_LIST',
      storedProc_param    => 'user_in = ' || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PLAFOND_TYPES_LIST',
      storedProc_param    => 'user_in = ' || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_PLAFOND_TYPES_LIST;

	PROCEDURE GET_FIXA_PLAFOND_TYPE_LIST (
		USER_IN				IN VARCHAR2,
		OPERATION_TYPE		IN VARCHAR2,
		PLAFOND_LIST_OUT	OUT REF_CURSOR,
		ERROR_OUT			OUT NUMBER
	) 
	IS
		PROCEDURE_ERROR EXCEPTION;
	BEGIN
		ACC_CRM_PCK.ACC_GET_FIXA_PLAFOND_TYPE_LIST (
			IN_OPERATION_TYPE => OPERATION_TYPE,
			PLAFOND_TYPE_LIST_OUT => PLAFOND_LIST_OUT,
			ERROR_OUT => ERROR_OUT
   		);
		IF ERROR_OUT <> 0 THEN
			RAISE PROCEDURE_ERROR;
		END IF;
	EXCEPTION
		WHEN PROCEDURE_ERROR THEN
   			LOG_LOGGER_PCK.LOG (
				SEVERITY => LOG_LOGGER_PCK.WARN_SEVERITY,
				TRANS_ID_CODE => NULL,
				TRANS_ID_NR => NULL,
				OPERATION => NULL,
				STOREDPROC_NAME => 'CAR_ACCOUNT_PCK.GET_FIXA_PLAFOND_TYPE_LIST',
				STOREDPROC_PARAM => 'USER_IN = ' || USER_IN,
				STOREDPROC_TYPE => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
				ERROR_CODE => ERROR_OUT,
				SQL_ERROR => NULL,
				ACCOUNT_ID => NULL,
				LINE_CODE => NULL,
				ADDITIONAL_TEXT => NULL
			);
		WHEN OTHERS THEN
			ERROR_OUT := SQLCODE;
			LOG_LOGGER_PCK.LOG (
				SEVERITY => LOG_LOGGER_PCK.ERROR_SEVERITY,
				TRANS_ID_CODE => NULL,
				TRANS_ID_NR => NULL,
				OPERATION => NULL,
				STOREDPROC_NAME => 'CAR_ACCOUNT_PCK.GET_FIXA_PLAFOND_TYPE_LIST',
				STOREDPROC_PARAM => 'USER_IN = ' || USER_IN,
				STOREDPROC_TYPE => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
				ERROR_CODE => SQLCODE,
				SQL_ERROR => SQLERRM,
				ACCOUNT_ID => NULL,
				LINE_CODE => NULL,
				ADDITIONAL_TEXT => NULL
   			);
	END GET_FIXA_PLAFOND_TYPE_LIST;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_MSISDN_FROM_ACCOUNT                                       **
*****************************************************************************/
PROCEDURE GET_MSISDN_FROM_ACCOUNT(
   account_in                IN VARCHAR2,
   user_in                   IN VARCHAR2,
   msisdn_out                OUT VARCHAR2,
   error_out                 OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

  -----------------------------------------
  --- Busca informa��es sobre o cliente ---
  -----------------------------------------
   ACC_CONTEXT_PCK.SET_CONTEXT(
      account_in => account_in,
      error_out  => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

   msisdn_out := ACC_CONTEXT_PCK.msisdn;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_MSISDN_FROM_ACCOUNT',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_MSISDN_FROM_ACCOUNT',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_MSISDN_FROM_ACCOUNT;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: SALE_USER_CONFIRMATION                                        **
*****************************************************************************/
-- Desc:  Realiza a confirma��o da Venda da Venda
PROCEDURE SALE_USER_CONFIRMATION(
   account_in          IN  VARCHAR2,
   dealer_code_in      IN  VARCHAR2,
   sale_user_in        IN  VARCHAR2,
   exec_user_in        IN  VARCHAR2,
   process_in          IN  VARCHAR2,
   ip_address_in       IN  VARCHAR2,
   error_out           OUT NUMBER
) IS
   procedure_error     EXCEPTION;
   operation           GER_OPERATION_EVENT.CODE%TYPE;
   trans_id_code       VARCHAR2(3) := CAR_GENERIC_PCK.TRANS_ID_CODE;
   trans_id_nr         NUMBER;

BEGIN

   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;

   IF process_in = 'NORM' THEN
      operation := 109;
   ELSIF process_in = 'CONT' THEN
      operation := 110;
   END IF;

   ACC_CRM_PCK.SALE_USER_REGISTER(
      in_trans_id_code => trans_id_code,
      in_trans_id_nr   => trans_id_nr,
      in_account       => account_in,
      in_dealer_code   => dealer_code_in,
      in_sale_user     => sale_user_in,
      in_exec_user     => exec_user_in,
      in_operation     => operation,
      in_ip_address    => ip_address_in,
      out_error        => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) = 0 THEN
      COMMIT;
   ELSE
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.SALE_USER_CONFIRMATION',
      storedProc_param    => 'account_in = '     || account_in     || LOG_LOGGER_PCK.F_SEP ||
                             'dealer_code_in = ' || dealer_code_in || LOG_LOGGER_PCK.F_SEP ||
                             'sale_user_in = '   || sale_user_in   || LOG_LOGGER_PCK.F_SEP ||
                             'exec_user_in = '   || exec_user_in   || LOG_LOGGER_PCK.F_SEP ||
                             'process_in = '     || process_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   ROLLBACK;
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.SALE_USER_CONFIRMATION',
      storedProc_param    => 'account_in = '     || account_in     || LOG_LOGGER_PCK.F_SEP ||
                             'dealer_code_in = ' || dealer_code_in || LOG_LOGGER_PCK.F_SEP ||
                             'sale_user_in = '   || sale_user_in   || LOG_LOGGER_PCK.F_SEP ||
                             'exec_user_in = '   || exec_user_in   || LOG_LOGGER_PCK.F_SEP ||
                             'process_in = '     || process_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END SALE_USER_CONFIRMATION;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_SALE_INFORMATION                                          **
*****************************************************************************/
PROCEDURE GET_SALE_INFORMATION(
   account_in           IN VARCHAR2,
   user_in              IN VARCHAR2,
   sale_info_out        OUT REF_CURSOR,
   error_out            OUT NUMBER
) IS
   procedure_error      EXCEPTION;
BEGIN

   ACC_CRM_PCK.GET_SALE_INFORMATION(
      in_account      =>  TO_NUMBER(account_in),
      out_sale_info   =>  sale_info_out,
      out_error       =>  error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_SALE_INFORMATION',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_SALE_INFORMATION',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '    || user_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_SALE_INFORMATION;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: PRIV_GET_ACC_SERVICE_STATE                                    **
*****************************************************************************/
/* Retorna o estado e data de aprovisionamento para um determinado servi�o e account */
PROCEDURE PRIV_GET_ACC_SERVICE_STATE(
   account_in           IN VARCHAR2,
   service_in           IN VARCHAR2,
   state_out            OUT VARCHAR2,
   contract_nr_out      OUT NUMBER,
   provision_date_out   OUT DATE,
   error_out            OUT NUMBER
) IS
   procedure_error      EXCEPTION;
BEGIN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.INFO_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.PRIV_GET_ACC_SERVICE_STATE',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'service_in = ' || service_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => NULL,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

   NGIN_SRV_BD1.PRIV_GET_ACC_SERVICE_STATE(
      in_account         => account_in,
      in_service         => service_in,
      out_state          => state_out,
      out_contract_nr    => contract_nr_out,
      out_provision_date => provision_date_out,
      out_error          => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.PRIV_GET_ACC_SERVICE_STATE',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'service_in = ' || service_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.PRIV_GET_ACC_SERVICE_STATE',
      storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                             'service_in = ' || service_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END PRIV_GET_ACC_SERVICE_STATE;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: CHANGE_EQUIP_MODEL                                            **
*****************************************************************************/
PROCEDURE CHANGE_EQUIP_MODEL(
   in_operation             IN VARCHAR2,
   in_account               IN VARCHAR2,
   in_equip_model_new       IN VARCHAR2,
   in_cost_value1           IN VARCHAR2,
   in_cost_value2           IN VARCHAR2,
   in_reason                IN VARCHAR2,
   in_user_id               IN VARCHAR2,
   in_obs                   IN VARCHAR2,
   in_ip_address            IN VARCHAR2,
   out_error                OUT NUMBER
) IS
   procedure_error          EXCEPTION;
   trans_id_code            VARCHAR2(10);
   trans_id_nr              NUMBER;

BEGIN

   trans_id_code := CAR_GENERIC_PCK.TRANS_ID_CODE;
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM DUAL;

   ACC_CRM_PCK.CHANGE_EQUIP_MODEL(
      in_trans_id_code   => trans_id_code,
      in_trans_id_nr     => trans_id_nr,
      in_operation       => in_operation,
      in_account         => in_account,
      in_equip_model_new => in_equip_model_new,
      in_cost_value1     => TO_NUMBER(in_cost_value1, NGIN_GER_BD.CURRENCY_MASK, NGIN_GER_BD.CURRENCY_MASK_OPTIONS),
      in_cost_value2     => in_cost_value2,
      in_reason          => in_reason,
      in_user_id         => in_user_id,
      in_obs             => in_obs,
      in_ip_address      => in_ip_address,
      out_error          => out_error
   );

   IF NGIN_GER_BD.CHECK_ERROR(out_error) = 0 THEN
      COMMIT;
   ELSE
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_EQUIP_MODEL',
      storedProc_param    => 'in_operation = '       || in_operation       || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '         || in_account         || LOG_LOGGER_PCK.F_SEP ||
                             'in_equip_model_new = ' || in_equip_model_new || LOG_LOGGER_PCK.F_SEP ||
                             'in_cost_value1 = '     || in_cost_value1     || LOG_LOGGER_PCK.F_SEP ||
                             'in_cost_value2 = '     || in_cost_value2     || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason = '          || in_reason          || LOG_LOGGER_PCK.F_SEP ||
                             'in_user_id = '         || in_user_id         || LOG_LOGGER_PCK.F_SEP ||
                             'in_obs = '             || in_obs,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   ROLLBACK;
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_EQUIP_MODEL',
      storedProc_param    => 'in_operation = '       || in_operation       || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '         || in_account         || LOG_LOGGER_PCK.F_SEP ||
                             'in_equip_model_new = ' || in_equip_model_new || LOG_LOGGER_PCK.F_SEP ||
                             'in_cost_value1 = '     || in_cost_value1     || LOG_LOGGER_PCK.F_SEP ||
                             'in_cost_value2 = '     || in_cost_value2     || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason = '          || in_reason          || LOG_LOGGER_PCK.F_SEP ||
                             'in_user_id = '         || in_user_id         || LOG_LOGGER_PCK.F_SEP ||
                             'in_obs = '             || in_obs,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );

END CHANGE_EQUIP_MODEL;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: VALIDATE_TELCO_LIST                                           **
*****************************************************************************/
/* Dados 2 area_codes valida se os mesmas pertencem � mesma regional. Caso n�o perten�am devolve erro. */
PROCEDURE VALIDATE_TELCO_LIST(
   area_code1_in        IN ACC_CLIENT.area_code%TYPE,
   area_code2_in        IN ACC_CLIENT.area_code%TYPE,
   error_out            OUT NUMBER
) IS
   procedure_error      EXCEPTION;
   v_telco1             GER_TELCO.cod%TYPE;
   v_telco2             GER_TELCO.cod%TYPE;

BEGIN

   ACC_CRM_PCK.VALIDATE_TELCO_LIST(
      area_code1_in => area_code1_in,
      area_code2_in => area_code2_in,
      error_out     => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.VALIDATE_TELCO_LIST',
      storedProc_param    => 'area_code1_in = ' || area_code1_in || LOG_LOGGER_PCK.F_SEP ||
                             'area_code2_in = ' || area_code2_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.VALIDATE_TELCO_LIST',
      storedProc_param    => 'area_code1_in = ' || area_code1_in || LOG_LOGGER_PCK.F_SEP ||
                             'area_code2_in = ' || area_code2_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END VALIDATE_TELCO_LIST;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_CLIENT_INFO                                               **
*****************************************************************************/
PROCEDURE GET_CLIENT_INFO(
   in_msisdn                 IN VARCHAR2,
   in_account                IN VARCHAR2,
   in_client_type            IN VARCHAR2,
   in_user                   IN VARCHAR2,
   in_address_category       IN VARCHAR2,
   out_account               OUT NUMBER,
   out_change_flag           OUT NUMBER,
   out_old_msisdn            OUT VARCHAR2,
   out_new_msisdn            OUT VARCHAR2,
   out_change_date           OUT DATE,
   out_esn                   OUT VARCHAR2,
   out_imei                  OUT VARCHAR2,
   out_imsi                  OUT VARCHAR2,
   out_provision_date        OUT DATE,
   out_provision_type        OUT VARCHAR2,
   out_dig7                  OUT NUMBER,
   out_tecnology             OUT VARCHAR2,
   out_entity_type           OUT VARCHAR2,
   out_name                  OUT VARCHAR2,
   out_nif                   OUT VARCHAR2,
   out_rg                    OUT VARCHAR2,
   out_confidential          OUT VARCHAR2,
   out_equip_code            OUT VARCHAR2,
   out_equip_name            OUT VARCHAR2,
   out_equip_brand           OUT NUMBER,
   out_equip_brand_desc      OUT VARCHAR2,
   out_geographical_state    OUT VARCHAR2,
   out_dealer                OUT VARCHAR2,
   out_prf_master            OUT VARCHAR2,
   out_prf_master_desc       OUT VARCHAR2,
   out_language_code         OUT NUMBER,
   out_language_desc         OUT VARCHAR2,
   out_state_code            OUT NUMBER,
   out_state_name            OUT VARCHAR2,
   out_state_desc            OUT VARCHAR2,
   out_state_date            OUT TIMESTAMP WITH TIME ZONE,
   out_is_state_confirmed    OUT VARCHAR2,
   out_msisdn                OUT VARCHAR2,
   out_min                   OUT VARCHAR2,
   out_iccid                 OUT VARCHAR2,
   out_first_recharge        OUT DATE,
   out_first_rec_value       OUT NUMBER,
   out_last_recharge         OUT DATE,
   out_last_recharge_value   OUT NUMBER,
   out_next_state_code       OUT NUMBER,
   out_next_state_desc       OUT VARCHAR2,
   out_next_state_date       OUT DATE,
   out_first_use             OUT TIMESTAMP WITH TIME ZONE,
   out_documents_lost_fg     OUT NUMBER,
   out_profile               OUT VARCHAR2,
   out_profile_desc          OUT VARCHAR2,
   out_client_type           OUT NUMBER,
   out_product_type          OUT NUMBER,
   out_parent_account        OUT NUMBER,
   out_portability_situation OUT VARCHAR2,
   out_our_number            OUT VARCHAR2,
   out_block_ageing_fg         OUT NUMBER,
   out_block_ageing_reason     OUT NUMBER,
   out_block_ageing_reason_desc OUT VARCHAR2,
   out_error                 OUT NUMBER
) IS
   v_in_client_type          INT_LIST;
   v_out_client_type         INT_LIST;
   procedure_error           EXCEPTION;
BEGIN

   --Converts to INT_LIST
   IF in_client_type IS NOT NULL THEN
      NGIN_GER_BD.VARCHAR_TO_INTEGER_LIST(
         in_varchar_list => in_client_type,
         in_separator    => ';',
         out_int_list    => v_out_client_type,
         out_error       => out_error
      );
      v_in_client_type := v_out_client_type;
   END IF;

   NGIN_ACC_BD1.GET_CLIENT_INFO(
      in_msisdn               => in_msisdn,
      in_slr_account          => TO_NUMBER(in_account),
      in_client_type          => v_in_client_type,
      in_address_category     => TO_NUMBER(in_address_category),
      out_account             => out_account,
      out_change_flag         => out_change_flag,
      out_old_msisdn          => out_old_msisdn,
      out_new_msisdn          => out_new_msisdn,
      out_change_date         => out_change_date,
      out_esn                 => out_esn,
      out_imei                => out_imei,
      out_imsi                => out_imsi,
      out_provision_date      => out_provision_date,
      out_provision_type      => out_provision_type,
      out_dig7                => out_dig7,
      out_tecnology           => out_tecnology,
      out_entity_type         => out_entity_type,
      out_name                => out_name,
      out_nif                 => out_nif,
      out_rg                  => out_rg,
      out_confidential        => out_confidential,
      out_equip_code          => out_equip_code,
      out_equip_name          => out_equip_name,
      out_equip_brand         => out_equip_brand,
      out_equip_brand_desc    => out_equip_brand_desc,
      out_geographical_state  => out_geographical_state,
      out_dealer              => out_dealer,
      out_prf_master          => out_prf_master,
      out_prf_master_desc     => out_prf_master_desc,
      out_language_code       => out_language_code,
      out_language_desc       => out_language_desc,
      out_state_code          => out_state_code,
      out_state_name          => out_state_name,
      out_state_desc          => out_state_desc,
      out_state_date          => out_state_date,
      out_is_state_confirmed  => out_is_state_confirmed,
      out_msisdn              => out_msisdn,
      out_min                 => out_min,
      out_iccid               => out_iccid,
      out_first_recharge      => out_first_recharge,
      out_first_rec_value     => out_first_rec_value,
      out_last_recharge       => out_last_recharge,
      out_last_recharge_value => out_last_recharge_value,
      out_next_state_code     => out_next_state_code,
      out_next_state_desc     => out_next_state_desc,
      out_next_state_date     => out_next_state_date,
      out_first_use           => out_first_use,
      out_documents_lost_fg   => out_documents_lost_fg,
      out_profile             => out_profile,
      out_profile_desc        => out_profile_desc,
      out_client_type         => out_client_type,
      out_product_type        => out_product_type,
      out_parent_account      => out_parent_account,
      out_portability_situation => out_portability_situation,
      out_our_number            => out_our_number,
      out_block_ageing_fg        => out_block_ageing_fg,
      out_block_ageing_reason     => out_block_ageing_reason,
         out_block_ageing_reason_desc => out_block_ageing_reason_desc,
      out_error               => out_error);

   IF out_error <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CLIENT_INFO',
      storedProc_param    => 'in_msisdn = '             || in_msisdn       || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '            || in_account      || LOG_LOGGER_PCK.F_SEP ||
                             'in_client_type = '        || in_client_type  || LOG_LOGGER_PCK.F_SEP ||
                             'in_user = '               || in_user         || LOG_LOGGER_PCK.F_SEP ||
                             'in_address_category = '   || in_address_category,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CLIENT_INFO',
      storedProc_param    => 'in_msisdn = '             || in_msisdn        || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '            || in_account       || LOG_LOGGER_PCK.F_SEP ||
                             'in_user = '               || in_user          || LOG_LOGGER_PCK.F_SEP ||
                             'in_address_category = '   || in_address_category,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_CLIENT_INFO;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: CHARGE_OPERATION                                              **
*****************************************************************************/
PROCEDURE CHARGE_OPERATION(
   in_trans_id_code IN VARCHAR2,
   in_trans_id_nr   IN VARCHAR2,
   in_account       IN VARCHAR2,
   in_operation     IN VARCHAR2,
   in_reason_code   IN VARCHAR2,
   in_cost_value1   IN VARCHAR2,
   in_cost_value2   IN VARCHAR2,
   in_observation   IN VARCHAR2,
   in_user          IN VARCHAR2,
   out_error        OUT NUMBER) IS
BEGIN
   NGIN_ACC_BD1.CHARGE_OPERATION(
      in_trans_id_code => in_trans_id_code,
      in_trans_id_nr   => TO_NUMBER(in_trans_id_nr),
      in_account       => TO_NUMBER(in_account),
      in_operation     => TO_NUMBER(in_operation),
      in_reason_code   => TO_NUMBER(in_reason_code),
      in_cost_value1   => TO_NUMBER(in_cost_value1),
      in_cost_value2   => in_cost_value2,
      in_observation   => in_observation,
      in_user          => in_user,
      out_error        => out_error);
END CHARGE_OPERATION;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_COST_OPERATION_LIST                                       **
*****************************************************************************/
PROCEDURE GET_COST_OPERATION_LIST(
   account_in         IN  VARCHAR2,
   operation_in       IN  VARCHAR2,
   cost_operation_out OUT REF_CURSOR,
   error_out          OUT NUMBER
) IS
   procedure_error           EXCEPTION;

BEGIN

    /**
     * Obt�m lista de custos de uma opera��o
     */
    ACC_CRM_PCK.GET_LST_COST_OPERATION(
        in_account         => account_in,
        in_operation       => operation_in,
        out_cost_operation => cost_operation_out,
        out_error          => error_out
    );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_COST_OPERATION_LIST',
      storedProc_param    => 'operation_in = ' || operation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => account_in,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_COST_OPERATION_LIST',
      storedProc_param    => 'operation_in = ' || operation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => account_in,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_COST_OPERATION_LIST;


/* Valida a possibilidade de execu��o da opera��o de acordo com o estado e o perfil do celular. */
PROCEDURE CHECK_OPERATION(
   operation_in               IN  VARCHAR2,
   state_in                   IN  VARCHAR2,
   profile_in                 IN  VARCHAR2,
   portability_situation_in IN  VARCHAR2,
   error_out                  OUT NUMBER

) IS

   procedure_error           EXCEPTION;

BEGIN

    NGIN_ACC_BD1.CHECK_OPERATION(
        operation_in  => TO_NUMBER(operation_in),
        state_in      => TO_NUMBER(state_in),
        client_type_in => NULL,
        profile_in    => profile_in,
        portability_situation_in => TO_NUMBER(portability_situation_in),
        error_out     => error_out
    );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_OPERATION',
      storedProc_param    => 'operation_in = ' || operation_in || LOG_LOGGER_PCK.F_SEP ||
                             'state_in = '     || state_in     || LOG_LOGGER_PCK.F_SEP ||
                             'profile_in = '   || profile_in   || LOG_LOGGER_PCK.F_SEP ||
                             'portability_situation_in = '   || portability_situation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_OPERATION',
      storedProc_param    => 'operation_in = ' || operation_in || LOG_LOGGER_PCK.F_SEP ||
                             'state_in = '     || state_in     || LOG_LOGGER_PCK.F_SEP ||
                             'profile_in = '   || profile_in   || LOG_LOGGER_PCK.F_SEP ||
                             'portability_situation_in = '   || portability_situation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END CHECK_OPERATION;

/* Valida a possibilidade de execu��o da opera��o de acordo com o estado e o perfil do celular. */
PROCEDURE CHECK_OPERATION(
   operation_in       IN  VARCHAR2,
   account_in           IN  VARCHAR2,
   error_out          OUT NUMBER

) IS

   procedure_error           EXCEPTION;

BEGIN

    NGIN_ACC_BD1.CHECK_OPERATION_BY_ACCOUNT(
        operation_in  => TO_NUMBER(operation_in),
        account_in      => TO_NUMBER(account_in),
        error_out     => error_out
    );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_OPERATION',
      storedProc_param    => 'operation_in = ' || operation_in || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '     || account_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_OPERATION',
      storedProc_param    => 'operation_in = ' || operation_in || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '     || account_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END CHECK_OPERATION;

PROCEDURE GET_ESN_STATE(
   trans_id_code_in IN VARCHAR2,
   operation_in     IN VARCHAR2,
   esn_in           IN VARCHAR2,
   esn_state_out    OUT NUMBER,
   error_out        OUT NUMBER
) IS
procedure_error EXCEPTION;
v_trans_id_nbr               NUMBER;
BEGIN

    SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nbr FROM dual;

    ACC_CRM_PCK.GET_ESN_STATE(
           in_trans_id_code  => trans_id_code_in,
           in_trans_id_nr    => v_trans_id_nbr,
           in_operation      => TO_NUMBER(operation_in),
           in_esn            => esn_in,
           out_error         => error_out,
           out_esn_state     => esn_state_out
    );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_BRL_PCK.GET_ESN_STATE',
      storedProc_param    => 'esn_in=' || esn_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   ROLLBACK;
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_BRL_PCK.GET_ESN_STATE',
      storedProc_param    => 'esn_in=' || esn_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
END GET_ESN_STATE;

/*
 * Implementa��o CHK_ZIP_CODE.
 */
PROCEDURE CHK_ZIP_CODE(
    zip_code_prefix_in   IN VARCHAR2,
    zip_code_suffix_in   IN VARCHAR2,
    error_out            OUT VARCHAR2,
    address_lst_out      OUT REF_CURSOR
) IS
BEGIN
    error_out := 0;
    NGIN_CID_BD1.CHK_ZIP_CODE(
        in_zip_code1     => zip_code_prefix_in,
        in_zip_code2     => zip_code_suffix_in,
        out_error        => error_out,
        out_list         => address_lst_out
    );

EXCEPTION
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHK_ZIP_CODE',
      storedProc_param    => 'zip_code_prefix_in=' || zip_code_prefix_in || LOG_LOGGER_PCK.F_SEP ||
                             'zip_code_suffix_in=' || zip_code_suffix_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
END CHK_ZIP_CODE;

/*
 * Implementa��o CHK_FISCAL_ID.
 */
PROCEDURE CHK_FISCAL_ID(
    fiscal_document_in  IN VARCHAR2,
    error_out           OUT VARCHAR2
) IS
BEGIN

    NGIN_ACC_BD1.CHK_FISCAL_ID(
        in_fiscal_id     => fiscal_document_in,
        out_error        => error_out
    );

EXCEPTION
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHK_FISCAL_ID',
      storedProc_param    => 'fiscal_document_in=' || fiscal_document_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
END CHK_FISCAL_ID;

/*
 * Implementa��o GET_ACADEMIC_DEGREE_LIST.
 */
PROCEDURE GET_ACADEMIC_DEGREE_LIST(
    error_out            OUT VARCHAR2,
    academic_degree_list OUT REF_CURSOR
) IS
BEGIN
    error_out := 0;
    NGIN_CID_BD1.GET_ACADEMIC_QUALIFICATION_LST(
        out_error                         => error_out,
        out_list     => academic_degree_list
    );

EXCEPTION
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ACADEMIC_DEGREE_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
END GET_ACADEMIC_DEGREE_LIST;

/*
 * Implementa��o GET_PROFESSION_LIST.
 */
PROCEDURE GET_PROFESSION_LIST(
    error_out            OUT VARCHAR2,
    profession_list      OUT REF_CURSOR
) IS
BEGIN
    error_out := 0;
    NGIN_CID_BD1.GET_JOB_LST(
        out_error    => error_out,
        out_list => profession_list
    );

EXCEPTION
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PROFESSION_LIST',
      storedProc_param    => NULL,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
END GET_PROFESSION_LIST;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: CHANGE_OWNER                                                  **
*****************************************************************************/
PROCEDURE CHANGE_OWNER(
        in_trans_id_code    IN VARCHAR2,
        in_operation        IN VARCHAR2,
        in_invoice_acc      IN VARCHAR2,
        in_regist_acc       IN VARCHAR2,
        in_ext_credit_chk   IN VARCHAR2,
        in_cost_value       IN VARCHAR2,
        in_cost_fg          IN VARCHAR2,
        in_reason           IN VARCHAR2,
        in_observation      IN VARCHAR2,
        in_username         IN VARCHAR2,
        in_ip_address       IN VARCHAR2,
        in_cell_number      IN VARCHAR2,
        out_error           OUT NUMBER
) IS
   procedure_error     EXCEPTION;
   v_trans_id_nbr      NUMBER;

BEGIN

   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nbr FROM DUAL;

   VIVO_PRE_BRL_BD1.CHANGE_OWNER(
      in_trans_id_code   => in_trans_id_code,
      in_trans_id_nbr    => v_trans_id_nbr,
      in_operation       => TO_NUMBER(in_operation),
      in_msisdn          => in_cell_number,
      in_invoice_acc     => TO_NUMBER(in_invoice_acc),
      in_regist_acc      => TO_NUMBER(in_regist_acc),
      in_ext_credit_chk  => TO_NUMBER(in_ext_credit_chk),
      in_cost_value      => TO_NUMBER(in_cost_value),
      in_cost_fg         => in_cost_fg,
      in_reason          => TO_NUMBER(in_reason),
      in_observation     => in_observation,
      in_username        => in_username,
      in_ip_address      => in_ip_address,
      out_error          => out_error
   );

   IF NGIN_GER_BD.CHECK_ERROR(out_error) = 0 THEN
      COMMIT;
   ELSE
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => in_trans_id_code,
      trans_id_nr         => v_trans_id_nbr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_OWNER',
      storedProc_param    => 'in_operation = '       || in_operation       || LOG_LOGGER_PCK.F_SEP ||
                             'in_invoice_acc = '     || in_invoice_acc     || LOG_LOGGER_PCK.F_SEP ||
                             'in_regist_acc = '      || in_regist_acc      || LOG_LOGGER_PCK.F_SEP ||
                             'in_observation = '     || in_observation     || LOG_LOGGER_PCK.F_SEP ||
                             'in_username = '        || in_username        || LOG_LOGGER_PCK.F_SEP ||
                             'in_ext_credit_chk = '  || in_ext_credit_chk,

      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => TO_NUMBER(in_invoice_acc),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   ROLLBACK;
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => in_trans_id_code,
      trans_id_nr         => v_trans_id_nbr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_OWNER',
      storedProc_param    => 'in_operation = '       || in_operation       || LOG_LOGGER_PCK.F_SEP ||
                             'in_invoice_acc = '     || in_invoice_acc     || LOG_LOGGER_PCK.F_SEP ||
                             'in_regist_acc = '      || in_regist_acc      || LOG_LOGGER_PCK.F_SEP ||
                             'in_observation = '     || in_observation     || LOG_LOGGER_PCK.F_SEP ||
                             'in_username = '        || in_username        || LOG_LOGGER_PCK.F_SEP ||
                             'in_ext_credit_chk = '  || in_ext_credit_chk,

      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => TO_NUMBER(in_invoice_acc),
      line_code           => NULL,
      additional_text     => NULL
   );

END CHANGE_OWNER;

PROCEDURE GET_CHILD_ACCOUNTS(
    account_in           IN  VARCHAR2,
    error_out            OUT VARCHAR2,
    cellular_list       OUT REF_CURSOR
)IS
BEGIN

    NGIN_ACC_BD1.GET_CHILD_ACCOUNT_LIST(
        in_account                => to_number(account_in),
        out_error                 => error_out,
        out_accounts_lst    => cellular_list
    );

EXCEPTION
WHEN OTHERS THEN
   ROLLBACK;
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CHILD_ACCOUNTS',
      storedProc_param    => 'account_in = '       || account_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
END GET_CHILD_ACCOUNTS;

PROCEDURE GET_ACCOUNT_HIERARCHY(
    in_account            IN NUMBER,
    out_error           OUT NUMBER,
    out_hierarchy        OUT REF_CURSOR
) IS

    BEGIN

        NGIN_ACC_BD1.GET_ACCOUNT_HIERARCHY
        (
            in_account                => in_account,
            out_error                => out_error,
            out_accounts_lst          => out_hierarchy
        );

        EXCEPTION
        WHEN
            OTHERS
        THEN
            out_error := SQLCODE;
            LOG_LOGGER_PCK.LOG
            (
                severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
                trans_id_code       => NULL,
                trans_id_nr         => NULL,
                operation           => NULL,
                storedProc_name     => 'NGIN_ACC_BD1.GET_ACCOUNT_HIERARCHY',
                storedProc_param    =>    'in_account = ' || in_account,
                storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
                error_code          => out_error,
                sql_error           => NULL,
                account_id          => TO_NUMBER(in_account),
                line_code           => NULL,
                additional_text     => NULL
            );


    END GET_ACCOUNT_HIERARCHY;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_ADDRESS_TYPE_LST                                          **
*****************************************************************************/
PROCEDURE GET_ADDRESS_TYPE_LST(
      out_address_type_lst    OUT REF_CURSOR,
      out_error               OUT VARCHAR2
) IS
   procedure_error     EXCEPTION;

BEGIN

      NGIN_CID_BD1.GET_ADDRESS_TYPE_LST (
        out_error    => out_error,
        out_list     => out_address_type_lst
      );

EXCEPTION
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity         => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code    => NULL,
      trans_id_nr      => NULL,
      operation        => NULL,
      storedProc_name  => 'CAR_ACCOUNT_PCK.GET_ADDRESS_TYPE_LST',
      storedProc_param => NULL,
      storedProc_type  => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code       => SQLCODE,
      sql_error        => SQLERRM,
      account_id       => NULL,
      line_code        => NULL,
      additional_text  => NULL
   );
END GET_ADDRESS_TYPE_LST;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: ADD_ADDRESS                                                   **
*****************************************************************************/
PROCEDURE ADD_ADDRESS (
   in_zip_code_id          IN VARCHAR2,
   in_quarter              IN VARCHAR2,
   in_addr_type_id         IN VARCHAR2,
   in_location_id          IN VARCHAR2,
   in_address              IN VARCHAR2,
   out_error               OUT VARCHAR2
) IS
   procedure_error     EXCEPTION;

BEGIN

   NGIN_CID_BD1.ADD_ADDRESS (
      in_zip_code_id       => TO_NUMBER(in_zip_code_id),
      in_quarter           => in_quarter,
      in_addr_type_id      => TO_NUMBER(in_addr_type_id),
      in_location_id       => TO_NUMBER(in_location_id),
      in_address           => in_address,
      out_error            => out_error
    );

EXCEPTION
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.ADD_ADDRESS',
      storedProc_param    => 'in_zip_code_id = '       || in_zip_code_id     ||
                             'in_quarter = '           || in_quarter         ||
                             'in_addr_type_id = '      || in_addr_type_id    ||
                             'in_location_id = '       || in_location_id     ||
                             'in_address = '           || in_address,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
END ADD_ADDRESS;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_ZIP_CODE_DETAILS                                          **
*****************************************************************************/
PROCEDURE GET_ZIP_CODE_DETAILS(
    in_zip_code          IN VARCHAR2,
    out_error            OUT VARCHAR2,
    out_list             OUT REF_CURSOR
) IS
    procedure_error     EXCEPTION;

BEGIN

    NGIN_CID_BD1.GET_ZIP_CODE_DETAILS (
        in_zip_code  => in_zip_code,
        out_error    => out_error,
        out_list     => out_list
    );

EXCEPTION
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity         => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code    => NULL,
      trans_id_nr      => NULL,
      operation        => NULL,
      storedProc_name  => 'CAR_ACCOUNT_PCK.GET_ZIP_CODE_DETAILS',
      storedProc_param => 'in_zip_code = ' || in_zip_code,
      storedProc_type  => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code       => SQLCODE,
      sql_error        => SQLERRM,
      account_id       => NULL,
      line_code        => NULL,
      additional_text  => NULL
   );
END GET_ZIP_CODE_DETAILS;

/*****************************************************************************
** Procedure: GET_TECHNOLOGY_BY_OPERATION                                   **
** Obt�m as tecnologias v�lidas para a multi-opera��o.                      **
*****************************************************************************/
PROCEDURE GET_TECHNOLOGY_BY_OPERATION(
    in_trans_id_code    IN  VARCHAR2,
    in_multi_operation  IN  VARCHAR2,
    out_error           OUT NUMBER,
    out_technology_list OUT REF_CURSOR
) IS
   v_trans_id_nbr               NUMBER;
  BEGIN

    SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nbr FROM dual;

    NGIN_ACC_BD1.GET_TECHNOLOGY_BY_OPERATION (
      in_trans_id_code      => in_trans_id_code,
      in_trans_id_nr        => v_trans_id_nbr,
      in_multi_operation    => TO_NUMBER(in_multi_operation),
      out_error             => out_error,
      out_technology_list   => out_technology_list
    );
EXCEPTION
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity         => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code    => NULL,
      trans_id_nr      => NULL,
      operation        => NULL,
      storedProc_name  => 'CAR_#########_PCK.GET_TECHNOLOGY_BY_OPERATION',
      storedProc_param => in_trans_id_code
                          ||LOG_LOGGER_PCK.F_SEP||v_trans_id_nbr
                          ||LOG_LOGGER_PCK.F_SEP||in_multi_operation,
      storedProc_type  => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code       => SQLCODE,
      sql_error        => SQLERRM,
      account_id       => NULL,
      line_code        => NULL,
      additional_text  => NULL
   );
END GET_TECHNOLOGY_BY_OPERATION;

/*****************************************************************************
** Procedure: GET_PROFILE_MASTER_INFO                                          **
** Coleta de informa��es relacionadas ao profile master                     **
*****************************************************************************/
PROCEDURE GET_PROFILE_MASTER_INFO (
    profile_in                IN VARCHAR2,
    error_out                OUT NUMBER,
    out_external_code        OUT VARCHAR2,
    out_profile_description    OUT VARCHAR2,
    out_product_type        OUT NUMBER
) IS
  BEGIN

    NGIN_ACC_BD1.GET_PROFILE_INFO (
      in_profile                     => profile_in,
      out_external_code          => out_external_code,
      out_profile_description   => out_profile_description,
      out_product_type          => out_product_type,
       out_error                   => error_out
    );
EXCEPTION
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity         => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code    => NULL,
      trans_id_nr      => NULL,
      operation        => NULL,
      storedProc_name  => 'CAR_Account_PCK.GET_PROFILE_MASTER_INFO',
      storedProc_param => profile_in,
      storedProc_type  => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code       => SQLCODE,
      sql_error        => SQLERRM,
      account_id       => NULL,
      line_code        => NULL,
      additional_text  => NULL
   );
END GET_PROFILE_MASTER_INFO;
/*****************************************************************************
** Procedure: SEND_BALANCE_SMS                                              **
** Envia saldo atraves de SMS                                               **
*****************************************************************************/
PROCEDURE SEND_BALANCE_SMS (
    trans_id_code_in    IN VARCHAR2,
    account_in          IN VARCHAR2,
    operator_in         IN VARCHAR2,
    operation_code_in   IN VARCHAR2,
    interface_in        IN VARCHAR2,
    sid_in              IN VARCHAR2,
    reason_in           IN VARCHAR2,
    error_out           OUT NUMBER
) IS
    v_trans_id_nbr NUMBER;
    procedure_error          EXCEPTION;
  BEGIN
    SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nbr FROM dual;

       LOG_LOGGER_PCK.LOG(
          severity         => LOG_LOGGER_PCK.INFO_SEVERITY,
          trans_id_code    => trans_id_code_in,
          trans_id_nr      => v_trans_id_nbr,
          operation        => operation_code_in,
          storedProc_name  => 'CAR_Account_PCK.SEND_BALANCE_SMS',
          storedProc_param => trans_id_code_in
                              ||LOG_LOGGER_PCK.F_SEP||v_trans_id_nbr
                              ||LOG_LOGGER_PCK.F_SEP||account_in
                               ||LOG_LOGGER_PCK.F_SEP||operator_in
                               ||LOG_LOGGER_PCK.F_SEP||operation_code_in,
          storedProc_type  => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
          error_code       => NULL,
          sql_error        => NULL,
          account_id       => account_in,
          line_code        => NULL,
          additional_text  => NULL
       );

      VIVO_PRE_BRL_BD1.SEND_BALANCE_SMS (
      in_trans_id_code      => trans_id_code_in,
      in_trans_id_nr        => v_trans_id_nbr,
      in_operation          => operation_code_in,
      in_account            => account_in,
      in_interface          => interface_in,
      in_interface_channel  => sid_in,
      in_reason             => reason_in,
      OUT_ERROR               => error_out
    );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code_in,
      trans_id_nr         => v_trans_id_nbr,
      operation           => operation_code_in,
      storedProc_name     => 'CAR_Account_PCK.SEND_BALANCE_SMS',
      storedProc_param => trans_id_code_in
                           ||LOG_LOGGER_PCK.F_SEP||v_trans_id_nbr
                           ||LOG_LOGGER_PCK.F_SEP||account_in
                           ||LOG_LOGGER_PCK.F_SEP||operator_in
                           ||LOG_LOGGER_PCK.F_SEP||operation_code_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity         => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code    => trans_id_code_in,
      trans_id_nr      => v_trans_id_nbr,
      operation        => operation_code_in,
      storedProc_name  => 'CAR_Account_PCK.SEND_BALANCE_SMS',
      storedProc_param => trans_id_code_in
                          ||LOG_LOGGER_PCK.F_SEP||v_trans_id_nbr
                          ||LOG_LOGGER_PCK.F_SEP||account_in
                           ||LOG_LOGGER_PCK.F_SEP||operator_in
                           ||LOG_LOGGER_PCK.F_SEP||operation_code_in,
      storedProc_type  => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code       => SQLCODE,
      sql_error        => SQLERRM,
      account_id       => TO_NUMBER(account_in),
      line_code        => NULL,
      additional_text  => NULL
   );
END SEND_BALANCE_SMS;

/*****************************************************************************
** Procedure: GET_SUSPENSION_OPTIONS                                          **
** Obt�m lista de per�odos para exibi��o na tela de mudan�a de estado.      **
*****************************************************************************/
PROCEDURE GET_SUSPENSION_OPTIONS (
    list_out        OUT VARCHAR2,
    error_out        OUT VARCHAR2
) IS
  BEGIN
    ACC_CRM_PCK.ACC_GET_SUSPENSION_OPTIONS (
      list_out   => list_out,
      error_out  => error_out
    );
EXCEPTION
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity         => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code    => NULL,
      trans_id_nr      => NULL,
      operation        => NULL,
      storedProc_name  => 'CAR_ACCOUNT_PCK.GET_SUSPENSION_OPTIONS',
      storedProc_param => NULL,
      storedProc_type  => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code       => SQLCODE,
      sql_error        => SQLERRM,
      account_id       => NULL,
      line_code        => NULL,
      additional_text  => NULL
   );
END GET_SUSPENSION_OPTIONS;

PROCEDURE SEND_MAIL_IMPUGN_PRINT_LASER (
    in_client_msisdn    IN VARCHAR2,
    in_client_account   IN VARCHAR2,
    in_client_name           IN VARCHAR2,
    in_address_p1         IN VARCHAR2,
    in_address_p2         IN VARCHAR2,
    in_address_p3        IN VARCHAR2,
    in_address_p4         IN VARCHAR2,
    in_analisis_result     IN VARCHAR2,
    in_value_final         IN VARCHAR2,
    in_unit_desc         IN VARCHAR2,
    error_out             OUT VARCHAR2
) IS

v_in_date_time TIMESTAMP WITH LOCAL TIME ZONE := SYSDATE;

BEGIN

  med_impugnation_answer(in_id_record         => '2',
                         in_client_account     => in_client_account,
                         in_client_name     => in_client_name,
                         in_address_p1         => in_address_p1,
                         in_address_p2         => in_address_p2,
                         in_address_p3         => in_address_p3,
                         in_address_p4         => in_address_p4,
                         in_date_time         => v_in_date_time,
                         in_analisis_result => in_analisis_result,
                         in_value_final     => in_value_final,
                         in_unidade         => in_unit_desc,
                         in_msisdn          => in_client_msisdn);
EXCEPTION
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity         => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code    => NULL,
      trans_id_nr      => NULL,
      operation        => NULL,
      storedProc_name  => 'med_impugnation_answer',
      storedProc_param => NULL,
      storedProc_type  => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code       => SQLCODE,
      sql_error        => SQLERRM,
      account_id       => NULL,
      line_code        => NULL,
      additional_text  => NULL
   );
END SEND_MAIL_IMPUGN_PRINT_LASER;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: CDR_IMPUGN                                                    **
*****************************************************************************/
-- Desc: CDR Impugnation --
PROCEDURE CDR_IMPUGN(
   trans_id_code_in         IN VARCHAR2,
   operation_in             IN VARCHAR2,
   account_in               IN VARCHAR2,
   cdr_list_in              IN VARCHAR2,
   reason_in                IN VARCHAR2,
   observation_in           IN VARCHAR2,
   user_in                  IN VARCHAR2,
   send_type_in             IN VARCHAR2,
   send_value_in            IN VARCHAR2,
   send_observation_in      IN VARCHAR2,
   corrected_val_out        OUT VARCHAR2,
   error_out                OUT NUMBER
) IS
   procedure_error          EXCEPTION;
   trans_id_code            VARCHAR2(3);
   trans_id_nr              NUMBER;

BEGIN

   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;

   ACC_CRM_PCK.CDR_TOTAL_IMPUGN(
      trans_id_code_in => trans_id_code_in,
      trans_id_nr_in   => trans_id_nr,
      operation_in     => operation_in,
      account_in       => TO_NUMBER(account_in),
      cdr_list_in      => cdr_list_in,
      reason_in        => reason_in,
      observation_in   => observation_in,
      user_in          => user_in,
      send_type_in     => send_type_in,
      send_value_in    => send_value_in,
      send_observation_in => send_observation_in,
      corrected_val_out => corrected_val_out,
      error_out        => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) != 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CDR_IMPUGN',
      storedProc_param    => 'operation_in = '   || operation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '     || account_in     || LOG_LOGGER_PCK.F_SEP ||
                             'cdr_list_in = '    || cdr_list_in    || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '      || reason_in      || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = ' || observation_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '        || user_in        || LOG_LOGGER_PCK.F_SEP ||
                             'send_type_in = '   || send_type_in   || LOG_LOGGER_PCK.F_SEP ||
                             'send_value_in = '  || send_value_in  || LOG_LOGGER_PCK.F_SEP ||
                             'send_observation_in = ' || send_observation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CDR_IMPUGN',
      storedProc_param    => 'operation_in = '   || operation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '     || account_in     || LOG_LOGGER_PCK.F_SEP ||
                             'cdr_list_in = '    || cdr_list_in    || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '      || reason_in      || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = ' || observation_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '        || user_in        || LOG_LOGGER_PCK.F_SEP ||
                             'send_type_in = '   || send_type_in   || LOG_LOGGER_PCK.F_SEP ||
                             'send_value_in = '  || send_value_in  || LOG_LOGGER_PCK.F_SEP ||
                             'send_observation_in = ' || send_observation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END CDR_IMPUGN;


/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: TDR_IMPUGN                                                    **
*****************************************************************************/
-- Desc: TDR Impugnation --
PROCEDURE TDR_IMPUGN(
   trans_id_code_in         IN VARCHAR2,
   operation_in             IN VARCHAR2,
   account_in               IN VARCHAR2,
   TDR_list_in              IN VARCHAR2,
   reason_in                IN VARCHAR2,
   observation_in           IN VARCHAR2,
   user_in                  IN VARCHAR2,
   send_type_in             IN VARCHAR2,
   send_value_in            IN VARCHAR2,
   send_observation_in      IN VARCHAR2,
   corrected_val_out        OUT VARCHAR2,
   error_out                OUT NUMBER
) IS
   procedure_error          EXCEPTION;
   trans_id_code            VARCHAR2(3);
   trans_id_nr              NUMBER;

BEGIN

   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;

   ACC_CRM_PCK.TDR_TOTAL_IMPUGN(
      trans_id_code_in => trans_id_code_in,
      trans_id_nr_in   => trans_id_nr,
      operation_in     => operation_in,
      account_in       => TO_NUMBER(account_in),
      TDR_list_in      => TDR_list_in,
      reason_in        => reason_in,
      observation_in   => observation_in,
      user_in          => user_in,
      send_type_in     => send_type_in,
      send_value_in    => send_value_in,
      send_observation_in => send_observation_in,
      corrected_val_out => corrected_val_out,
      error_out        => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) != 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.TDR_IMPUGN',
      storedProc_param    => 'operation_in = '   || operation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '     || account_in     || LOG_LOGGER_PCK.F_SEP ||
                             'TDR_list_in = '    || TDR_list_in    || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '      || reason_in      || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = ' || observation_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '        || user_in        || LOG_LOGGER_PCK.F_SEP ||
                             'send_type_in = '   || send_type_in   || LOG_LOGGER_PCK.F_SEP ||
                             'send_value_in = '  || send_value_in  || LOG_LOGGER_PCK.F_SEP ||
                             'send_observation_in = ' || send_observation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.TDR_IMPUGN',
      storedProc_param    => 'operation_in = '   || operation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '     || account_in     || LOG_LOGGER_PCK.F_SEP ||
                             'TDR_list_in = '    || TDR_list_in    || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '      || reason_in      || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = ' || observation_in || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '        || user_in        || LOG_LOGGER_PCK.F_SEP ||
                             'send_type_in = '   || send_type_in   || LOG_LOGGER_PCK.F_SEP ||
                             'send_value_in = '  || send_value_in  || LOG_LOGGER_PCK.F_SEP ||
                             'send_observation_in = ' || send_observation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END TDR_IMPUGN;


/*****************************************************************************
** Procedure: CDR_IMPUGN_PARTIAL                                            **
** Permite impugnar parcialmente uma chamada/SMS.                           **
*****************************************************************************/
PROCEDURE CDR_IMPUGN_PARTIAL (
   trans_id_code_in    IN VARCHAR2,
   operation_in           IN VARCHAR2,
   account_in          IN VARCHAR2,
   tid_in              IN VARCHAR2,
   sk_in               IN VARCHAR2,
   dump_instance_in    IN VARCHAR2,
   core_code_in        IN VARCHAR2,
   amount_in           IN VARCHAR2,
   reason_in           IN VARCHAR2,
   observation_in      IN VARCHAR2,
   user_in             IN VARCHAR2,
   send_type_in        IN VARCHAR2,
   send_value_in       IN VARCHAR2,
   send_observation_in IN VARCHAR2,
   partition_date      IN VARCHAR2,
   corrected_val_out   OUT NUMBER,
   error_out           OUT NUMBER
) IS
   procedure_error          EXCEPTION;
   trans_id_code            VARCHAR2(3);
   trans_id_nr              NUMBER;
  BEGIN


   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
   ACC_CRM_PCK.CDR_PARTIAL_IMPUGN(
      trans_id_code_in    => trans_id_code_in,
      trans_id_nr_in      => trans_id_nr,
      operation_in        => TO_NUMBER(operation_in),
      account_in          => TO_NUMBER(account_in),
      tid_in              => TO_NUMBER(tid_in),
      sk_in               => TO_NUMBER(sk_in),
      dump_instance_in    => TO_NUMBER(dump_instance_in),
      core_cod_in         => TO_NUMBER(core_code_in),
      amount_in           => TO_NUMBER(amount_in),
      reason_in           => TO_NUMBER(reason_in),
      observation_in      => observation_in,
      user_in             => user_in,
      send_type_in        => send_type_in,
      send_value_in       => send_value_in,
      partition_date      => partition_date,
      send_observation_in => send_observation_in,
      corrected_val_out   => corrected_val_out,
      error_out           => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) != 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CDR_IMPUGN',
      storedProc_param    => 'operation_in = '        || operation_in     || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '          || account_in       || LOG_LOGGER_PCK.F_SEP ||
                             'tid_in = '              || tid_in           || LOG_LOGGER_PCK.F_SEP ||
                             'sk_in = '               || sk_in            || LOG_LOGGER_PCK.F_SEP ||
                             'dump_instance_in = '    || dump_instance_in || LOG_LOGGER_PCK.F_SEP ||
                             'core_code_in = '        || core_code_in     || LOG_LOGGER_PCK.F_SEP ||
                             'amount_in = '           || amount_in        || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '           || reason_in        || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = '      || observation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '             || user_in          || LOG_LOGGER_PCK.F_SEP ||
                             'send_type_in = '        || send_type_in     || LOG_LOGGER_PCK.F_SEP ||
                             'send_value_in = '       || send_value_in    || LOG_LOGGER_PCK.F_SEP ||
                             'send_observation_in = ' || send_observation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CDR_IMPUGN',
      storedProc_param    => 'operation_in = '        || operation_in     || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '          || account_in       || LOG_LOGGER_PCK.F_SEP ||
                             'tid_in = '              || tid_in           || LOG_LOGGER_PCK.F_SEP ||
                             'sk_in = '               || sk_in            || LOG_LOGGER_PCK.F_SEP ||
                             'dump_instance_in = '    || dump_instance_in || LOG_LOGGER_PCK.F_SEP ||
                             'core_code_in = '        || core_code_in     || LOG_LOGGER_PCK.F_SEP ||
                             'amount_in = '           || amount_in        || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '           || reason_in        || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = '      || observation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '             || user_in          || LOG_LOGGER_PCK.F_SEP ||
                             'send_type_in = '        || send_type_in     || LOG_LOGGER_PCK.F_SEP ||
                             'send_value_in = '       || send_value_in    || LOG_LOGGER_PCK.F_SEP ||
                             'send_observation_in = ' || send_observation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END CDR_IMPUGN_PARTIAL;

/*****************************************************************************
** Procedure: TDR_IMPUGN_PARTIAL                                            **
** Permite impugnar parcialmente uma chamada/SMS.                           **
*****************************************************************************/
PROCEDURE TDR_IMPUGN_PARTIAL (
   trans_id_code_in    IN VARCHAR2,
   operation_in           IN VARCHAR2,
   account_in          IN VARCHAR2,
   tid_in              IN VARCHAR2,
   sk_in               IN VARCHAR2,
   dump_instance_in    IN VARCHAR2,
   db_name_in          IN VARCHAR2,
   amount_in           IN VARCHAR2,
   reason_in           IN VARCHAR2,
   observation_in      IN VARCHAR2,
   user_in             IN VARCHAR2,
   send_type_in        IN VARCHAR2,
   send_value_in       IN VARCHAR2,
   send_observation_in IN VARCHAR2,
   corrected_val_out   OUT NUMBER,
   error_out           OUT NUMBER
) IS
   procedure_error          EXCEPTION;
   trans_id_code            VARCHAR2(3);
   trans_id_nr              NUMBER;
  BEGIN
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
   ACC_CRM_PCK.TDR_PARTIAL_IMPUGN(
      trans_id_code_in    => trans_id_code_in,
      trans_id_nr_in      => trans_id_nr,
      operation_in        => TO_NUMBER(operation_in),
      account_in          => TO_NUMBER(account_in),
      tid_in              => TO_NUMBER(tid_in),
      dump_instance_in    => TO_NUMBER(dump_instance_in),
      db_name_in          => db_name_in,
      amount_in           => TO_NUMBER(amount_in),
      reason_in           => TO_NUMBER(reason_in),
      observation_in      => observation_in,
      user_in             => user_in,
      send_type_in        => send_type_in,
      send_value_in       => send_value_in,
      send_observation_in => send_observation_in,
      corrected_val_out   => corrected_val_out,
      error_out           => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) != 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.TDR_IMPUGN',
      storedProc_param    => 'operation_in = '        || operation_in     || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '          || account_in       || LOG_LOGGER_PCK.F_SEP ||
                             'tid_in = '              || tid_in           || LOG_LOGGER_PCK.F_SEP ||
                             'sk_in = '               || sk_in            || LOG_LOGGER_PCK.F_SEP ||
                             'dump_instance_in = '    || dump_instance_in || LOG_LOGGER_PCK.F_SEP ||
                             'db_name_in = '          || db_name_in       || LOG_LOGGER_PCK.F_SEP ||
                             'amount_in = '           || amount_in        || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '           || reason_in        || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = '      || observation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '             || user_in          || LOG_LOGGER_PCK.F_SEP ||
                             'send_type_in = '        || send_type_in     || LOG_LOGGER_PCK.F_SEP ||
                             'send_value_in = '       || send_value_in    || LOG_LOGGER_PCK.F_SEP ||
                             'send_observation_in = ' || send_observation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.TDR_IMPUGN',
      storedProc_param    => 'operation_in = '        || operation_in     || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '          || account_in       || LOG_LOGGER_PCK.F_SEP ||
                             'tid_in = '              || tid_in           || LOG_LOGGER_PCK.F_SEP ||
                             'sk_in = '               || sk_in            || LOG_LOGGER_PCK.F_SEP ||
                             'dump_instance_in = '    || dump_instance_in || LOG_LOGGER_PCK.F_SEP ||
                             'db_name_in = '          || db_name_in       || LOG_LOGGER_PCK.F_SEP ||
                             'amount_in = '           || amount_in        || LOG_LOGGER_PCK.F_SEP ||
                             'reason_in = '           || reason_in        || LOG_LOGGER_PCK.F_SEP ||
                             'observation_in = '      || observation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'user_in = '             || user_in          || LOG_LOGGER_PCK.F_SEP ||
                             'send_type_in = '        || send_type_in     || LOG_LOGGER_PCK.F_SEP ||
                             'send_value_in = '       || send_value_in    || LOG_LOGGER_PCK.F_SEP ||
                             'send_observation_in = ' || send_observation_in,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END TDR_IMPUGN_PARTIAL;


-- Desc: CDR Contestation --
PROCEDURE CDR_CONTEST (
   trans_id_code_in         IN VARCHAR2,
   operation_code_in        IN VARCHAR2,
   tid_in                   IN VARCHAR2,
   sk_in                    IN VARCHAR2,
   dump_instance_number_in  IN VARCHAR2,
   core_cod_in              IN VARCHAR2,
   client_account_in        IN VARCHAR2,
   partition_date_in        IN VARCHAR2,
   reason_in                IN VARCHAR2,
   observation_in           IN VARCHAR2,
   user_in                  IN VARCHAR2,
   error_out                OUT NUMBER
)
IS
   v_trans_id_nr               NUMBER;
   procedure_error             EXCEPTION;

BEGIN
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nr FROM dual;


   -- chama a api do ACC --
   ACC_CRM_PCK.CDR_CONTEST(
        in_trans_id_code            => trans_id_code_in,
        in_trans_id_nr              => v_trans_id_nr,
        in_operation                => TO_NUMBER(operation_code_in),
          in_tid                      => TO_NUMBER(tid_in),
          in_sk                       => TO_NUMBER(sk_in),
          in_Dump_instance_number     => TO_NUMBER(dump_instance_number_in),
        in_core_cod                 => TO_NUMBER(core_cod_in),
        in_client_account           => client_account_in,
        in_partition_date           => partition_date_in,
        in_reason                   => TO_NUMBER(reason_in),
        in_observation              => observation_in,
        in_user                     => user_in,
         error_out                   => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN

   LOG_LOGGER_PCK.LOG (LOG_LOGGER_PCK.ERROR_SEVERITY, 'CAR', NULL, NULL, 'CAR_ACCOUNT_PCK.CDR_CONTEST',
   LOG_LOGGER_PCK.F_SEP ||
   client_account_in || LOG_LOGGER_PCK.F_SEP ||
   reason_in || LOG_LOGGER_PCK.F_SEP ||
   observation_in || LOG_LOGGER_PCK.F_SEP ||
   user_in,
   LOG_LOGGER_PCK.INITIAL_PROC_TYPE, error_out, NULL, NULL, NULL, NULL);

WHEN OTHERS THEN

   LOG_LOGGER_PCK.LOG (LOG_LOGGER_PCK.ERROR_SEVERITY, 'CAR', NULL, NULL, 'CAR_ACCOUNT_PCK.CDR_CONTEST',
   LOG_LOGGER_PCK.F_SEP ||
   client_account_in || LOG_LOGGER_PCK.F_SEP ||
   reason_in || LOG_LOGGER_PCK.F_SEP ||
   observation_in || LOG_LOGGER_PCK.F_SEP ||
   user_in,
   LOG_LOGGER_PCK.INITIAL_PROC_TYPE, SQLCODE, SQLERRM, NULL, NULL, NULL);
   error_out := SQLCODE;

END CDR_CONTEST;

-- Desc: TDR Contestation --
PROCEDURE TDR_CONTEST (
   trans_id_code_in         IN VARCHAR2,
   operation_code_in        IN VARCHAR2,
   tid_in                   IN VARCHAR2,
   sk_in                    IN VARCHAR2,
   dump_instance_number_in  IN VARCHAR2,
   db_name_in               IN VARCHAR2,
   client_account_in        IN VARCHAR2,
   partition_date_in        IN VARCHAR2,
   reason_in                IN VARCHAR2,
   observation_in           IN VARCHAR2,
   user_in                  IN VARCHAR2,
   error_out                OUT NUMBER
)
IS
   v_trans_id_nr               NUMBER;
   procedure_error             EXCEPTION;

BEGIN
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nr FROM dual;


   -- chama a api do ACC --
   ACC_CRM_PCK.TDR_CONTEST(
        in_trans_id_code            => trans_id_code_in,
        in_trans_id_nr              => v_trans_id_nr,
        in_operation                => TO_NUMBER(operation_code_in),
          in_tid                      => TO_NUMBER(tid_in),
          in_Dump_instance_number     => TO_NUMBER(dump_instance_number_in),
        in_db_name                  => db_name_in,
        in_client_account           => client_account_in,
        in_partition_date            => TO_CHAR(to_timestamp_tz(partition_date_in, 'DD-MON-YY HH.MI.SS.FF6 PM'), 'yyyy-mm-dd hh24:mi:ss.ff6 tzr'),
        in_reason                   => TO_NUMBER(reason_in),
        in_observation              => observation_in,
        in_user                     => user_in,
         error_out                   => error_out
   );

   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN

   LOG_LOGGER_PCK.LOG (LOG_LOGGER_PCK.ERROR_SEVERITY, 'CAR', NULL, NULL, 'CAR_ACCOUNT_PCK.TDR_CONTEST',
   LOG_LOGGER_PCK.F_SEP ||
   client_account_in || LOG_LOGGER_PCK.F_SEP ||
   reason_in || LOG_LOGGER_PCK.F_SEP ||
   observation_in || LOG_LOGGER_PCK.F_SEP ||
   user_in,
   LOG_LOGGER_PCK.INITIAL_PROC_TYPE, error_out, NULL, NULL, NULL, NULL);

WHEN OTHERS THEN

   LOG_LOGGER_PCK.LOG (LOG_LOGGER_PCK.ERROR_SEVERITY, 'CAR', NULL, NULL, 'CAR_ACCOUNT_PCK.TDR_CONTEST',
   LOG_LOGGER_PCK.F_SEP ||
   client_account_in || LOG_LOGGER_PCK.F_SEP ||
   reason_in || LOG_LOGGER_PCK.F_SEP ||
   observation_in || LOG_LOGGER_PCK.F_SEP ||
   user_in,
   LOG_LOGGER_PCK.INITIAL_PROC_TYPE, SQLCODE, SQLERRM, NULL, NULL, NULL);
   error_out := SQLCODE;

END TDR_CONTEST;

PROCEDURE CDR_NOT_PROCEED (
    trans_id_code_in         IN VARCHAR2,
    operation_code_in        IN VARCHAR2,
    account_in               IN VARCHAR2,
    tid_in                   IN VARCHAR2,
    sk_in                    IN VARCHAR2,
    dump_instance_number_in  IN VARCHAR2,
    core_cod_in              IN VARCHAR2,
    reason_in                IN VARCHAR2,
    observation_in           IN VARCHAR2,
    user_in                  IN VARCHAR2,
    send_type_in                IN VARCHAR2,
    send_value_in              IN VARCHAR2,
    send_observation_in      IN VARCHAR2,
    error_out                OUT NUMBER
)
IS
   v_trans_id_nr               NUMBER;
BEGIN

  SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nr FROM dual;

  ACC_CRM_PCK.CDR_NOT_PROCEED(
      trans_id_code_in        => trans_id_code_in,
      trans_id_nr_in          => v_trans_id_nr,
      operation_in            => TO_NUMBER(operation_code_in),
      account_in              => TO_NUMBER(account_in),
      tid_in                  => TO_NUMBER(tid_in),
      sk_in                   => TO_NUMBER(sk_in),
      dump_instance_number_in => TO_NUMBER(dump_instance_number_in),
      core_cod_in             => TO_NUMBER(core_cod_in),
      reason_in               => TO_NUMBER(reason_in),
      observation_in          => observation_in,
      user_in                 => user_in,
      send_type_in              => send_type_in,
      send_value_in             => send_value_in,
      send_observation_in     => send_observation_in,
      error_out               => error_out);

EXCEPTION WHEN OTHERS THEN
    error_out := SQLCODE;

    Log_Logger_Pck.LOG (Log_Logger_Pck.ERROR_SEVERITY, NULL, NULL, NULL, 'CAR_ACCOUNT_PCK.CDR_NOT_PROCEED',
    trans_id_code_in||LOG_LOGGER_PCK.F_SEP||
    v_trans_id_nr||LOG_LOGGER_PCK.F_SEP||
    operation_code_in||LOG_LOGGER_PCK.F_SEP||
    account_in||LOG_LOGGER_PCK.F_SEP||
    tid_in||LOG_LOGGER_PCK.F_SEP||
    sk_in||LOG_LOGGER_PCK.F_SEP||
    dump_instance_number_in||LOG_LOGGER_PCK.F_SEP||
    reason_in||LOG_LOGGER_PCK.F_SEP||
    observation_in||LOG_LOGGER_PCK.F_SEP||
    user_in||LOG_LOGGER_PCK.F_SEP||
    send_type_in||LOG_LOGGER_PCK.F_SEP||
    send_value_in||LOG_LOGGER_PCK.F_SEP||
    send_observation_in,
    Log_Logger_Pck.INITIAL_PROC_TYPE, SQLCODE, SQLERRM, NULL, NULL, NULL);

END CDR_NOT_PROCEED;

PROCEDURE TDR_NOT_PROCEED (
    trans_id_code_in         IN VARCHAR2,
    operation_code_in        IN VARCHAR2,
       account_in               IN VARCHAR2,
    tid_in                   IN VARCHAR2,
    dump_instance_number_in  IN VARCHAR2,
    db_name_in               IN VARCHAR2,
    reason_in                IN VARCHAR2,
    observation_in           IN VARCHAR2,
    user_in                  IN VARCHAR2,
    send_type_in                IN VARCHAR2,
    send_value_in            IN VARCHAR2,
    send_observation_in      IN VARCHAR2,
    error_out                OUT NUMBER
)
IS
   v_trans_id_nr               NUMBER;
BEGIN

  SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nr FROM dual;

  ACC_CRM_PCK.TDR_NOT_PROCEED(
      trans_id_code_in        => trans_id_code_in,
      trans_id_nr_in          => v_trans_id_nr,
      operation_in            => TO_NUMBER(operation_code_in),
      account_in              => TO_NUMBER(account_in),
      tid_in                  => TO_NUMBER(tid_in),
      dump_instance_number_in => TO_NUMBER(dump_instance_number_in),
      db_name_in              => db_name_in,
      reason_in               => TO_NUMBER(reason_in),
      observation_in          => observation_in,
      user_in                 => user_in,
      send_type_in            => send_type_in,
      send_value_in              => send_value_in,
      send_observation_in      => send_observation_in,
      error_out               => error_out);

EXCEPTION WHEN OTHERS THEN
    error_out := SQLCODE;

    Log_Logger_Pck.LOG (Log_Logger_Pck.ERROR_SEVERITY, NULL, NULL, NULL, 'CAR_ACCOUNT_PCK.TDR_NOT_PROCEED',
    trans_id_code_in||LOG_LOGGER_PCK.F_SEP||
    v_trans_id_nr||LOG_LOGGER_PCK.F_SEP||
    operation_code_in||LOG_LOGGER_PCK.F_SEP||
    account_in||LOG_LOGGER_PCK.F_SEP||
    tid_in||LOG_LOGGER_PCK.F_SEP||
    dump_instance_number_in||LOG_LOGGER_PCK.F_SEP||
    db_name_in||LOG_LOGGER_PCK.F_SEP||
    reason_in||LOG_LOGGER_PCK.F_SEP||
    observation_in||LOG_LOGGER_PCK.F_SEP||
    user_in||LOG_LOGGER_PCK.F_SEP||
    send_type_in||LOG_LOGGER_PCK.F_SEP||
    send_value_in||LOG_LOGGER_PCK.F_SEP||
    send_observation_in,
    Log_Logger_Pck.INITIAL_PROC_TYPE, SQLCODE, SQLERRM, NULL, NULL, NULL);

END TDR_NOT_PROCEED;






PROCEDURE GET_PENDCALL_BAL (
   trans_id_code_in            IN VARCHAR2,
   account_in                IN  VARCHAR2,
   client_balance_out         OUT NUMBER,
   error_out                OUT NUMBER
)
IS
   v_trans_id_nr               NUMBER;
BEGIN

  SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nr FROM dual;
  
  LOG_LOGGER_CONTEXT.SET_CONTEXT (
               in_account_id     => account_in, 
               in_trans_id_code  => trans_id_code_in, 
               in_trans_id_nr    => v_trans_id_nr, 
               in_operation      => NULL
   );

  NGIN_ACC_BD1.GET_PENDCALL_BAL(
            trans_id_code_in   => trans_id_code_in,
            trans_id_nr_in     => v_trans_id_nr,
            account_in         => account_in,
            client_balance_out => client_balance_out,
            error_out          => error_out
        );
        
  LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

EXCEPTION WHEN OTHERS THEN
    error_out := SQLCODE;

    Log_Logger_Pck.LOG (Log_Logger_Pck.ERROR_SEVERITY, NULL, NULL, NULL, 'CAR_ACCOUNT_PCK.GET_PENDCALL_BAL',
    trans_id_code_in||LOG_LOGGER_PCK.F_SEP||
    v_trans_id_nr||LOG_LOGGER_PCK.F_SEP||
    account_in,
    Log_Logger_Pck.INITIAL_PROC_TYPE, SQLCODE, SQLERRM, NULL, NULL, NULL);
    
    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

END GET_PENDCALL_BAL;










PROCEDURE PRE_POS_VALIDATION (
   in_trans_id_code            IN VARCHAR2,
   in_operation              IN VARCHAR2,
   in_account                IN VARCHAR2,
   in_reason_code            IN VARCHAR2,
   in_obs                    IN VARCHAR2,
   in_user                   IN VARCHAR2,
   out_name                  OUT VARCHAR2,
   out_esn                   OUT VARCHAR2,
   out_imei                  OUT VARCHAR2,
   out_iccid                 OUT VARCHAR2,
   out_min                   OUT VARCHAR2,
   out_cost_value1           OUT NUMBER,
   out_cost_value2           OUT VARCHAR2,
   out_promotions            OUT VARCHAR2,
   out_equipment_model       OUT VARCHAR2,
   out_error                  OUT NUMBER
)
IS
   v_trans_id_nr                NUMBER;
   promotions                   BOP_WR.LIST_PROMO2NOTIFY;
BEGIN

  SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nr FROM dual;
  
  LOG_LOGGER_CONTEXT.SET_CONTEXT (
               in_account_id     => in_account, 
               in_trans_id_code  => in_trans_id_code, 
               in_trans_id_nr    => v_trans_id_nr, 
               in_operation      => in_operation
   );

  NGIN_ACC_BD1.PRE_POS_VALIDATION(
            in_trans_id_code => in_trans_id_code,
            in_trans_id_nr   => v_trans_id_nr,
            in_operation     => TO_NUMBER(in_operation),
            in_account       => TO_NUMBER(in_account),
            in_reason_code   => TO_NUMBER(in_reason_code),
            in_obs           => in_obs,
            in_user          => in_user,
            out_name         => out_name,
            out_esn          => out_esn,
            out_imei         => out_imei,
            out_iccid        => out_iccid,
            out_min                   => out_min,
            out_cost_value1        => out_cost_value1,
            out_cost_value2         => out_cost_value2,
            out_error               => out_error,
            out_list_promo2notify  => promotions,
            out_equipment_model   => out_equipment_model
        );

    IF promotions IS NOT NULL and promotions.count > 0 THEN
        out_promotions := 'S';
    ELSE
        out_promotions := 'N';
    END IF;

    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

EXCEPTION WHEN OTHERS THEN
    out_error := SQLCODE;

    Log_Logger_Pck.LOG (Log_Logger_Pck.ERROR_SEVERITY, NULL, NULL, NULL, 'CAR_ACCOUNT_PCK.PRE_POS_VALIDATION',
    in_trans_id_code||LOG_LOGGER_PCK.F_SEP||
    v_trans_id_nr||LOG_LOGGER_PCK.F_SEP||
    in_operation||LOG_LOGGER_PCK.F_SEP||
    in_account||LOG_LOGGER_PCK.F_SEP||
    in_reason_code||LOG_LOGGER_PCK.F_SEP||
    in_obs||LOG_LOGGER_PCK.F_SEP||
    in_user,
    Log_Logger_Pck.INITIAL_PROC_TYPE, SQLCODE, SQLERRM, NULL, NULL, NULL);
    
    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();



END PRE_POS_VALIDATION;



/*****************************************************************************
** Procedure: GET_ACCOUNT_FROM_MSISDN                                       **
** Obtem o account pelo msisdn                                                **
*****************************************************************************/
PROCEDURE GET_ACCOUNT_FROM_MSISDN (
   in_trans_id_code IN VARCHAR2,
   in_operation     IN VARCHAR2,
   in_msisdn        IN VARCHAR2,
   out_account      OUT NUMBER,
   out_error        OUT NUMBER
)
IS
   v_trans_id_nr               NUMBER;
BEGIN

  SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nr FROM dual;

  NGIN_ACC_BD1.GET_ACCOUNT_FROM_MSISDN(
            in_trans_id_code   => in_trans_id_code,
            in_trans_id_nr     => TO_NUMBER(v_trans_id_nr),
            in_operation       => TO_NUMBER(in_operation),
            in_msisdn          => in_msisdn,
            out_account        => out_account,
            out_error          => out_error
        );

EXCEPTION WHEN OTHERS THEN
    out_error := SQLCODE;

    Log_Logger_Pck.LOG (Log_Logger_Pck.ERROR_SEVERITY, NULL, NULL, NULL, 'CAR_ACCOUNT_PCK.GET_ACCOUNT_FROM_MSISDN',
    in_trans_id_code||LOG_LOGGER_PCK.F_SEP||
    v_trans_id_nr||LOG_LOGGER_PCK.F_SEP||
    in_operation||LOG_LOGGER_PCK.F_SEP||
    in_msisdn,
    Log_Logger_Pck.INITIAL_PROC_TYPE, SQLCODE, SQLERRM, NULL, NULL, NULL);

END GET_ACCOUNT_FROM_MSISDN;


/*****************************************************************************
** Procedure: GET_PARENT_ACCOUNT                                           **
** Obtem o account pai de um account qualquer                              **
*****************************************************************************/
PROCEDURE GET_PARENT_ACCOUNT (
   in_account              IN VARCHAR2,
   out_parent_account      OUT VARCHAR2,
   out_error               OUT NUMBER
)
IS
   v_acc_client_row        ACC_CLIENT%ROWTYPE;
BEGIN

      NGIN_ACC_BD1.GET_CLIENT_DATA(
        account_in         => TO_NUMBER(in_account),
        account_data_out   => v_acc_client_row,
        error_out          => out_error
    );

    out_parent_account := v_acc_client_row.parent_account;

EXCEPTION WHEN OTHERS THEN
    out_error := SQLCODE;

    Log_Logger_Pck.LOG (Log_Logger_Pck.ERROR_SEVERITY, NULL, NULL, NULL, 'CAR_ACCOUNT_PCK.GET_PARENT_ACCOUNT',
    in_account,
    Log_Logger_Pck.INITIAL_PROC_TYPE, SQLCODE, SQLERRM, NULL, NULL, NULL);

END GET_PARENT_ACCOUNT;

PROCEDURE GET_ALL_CLI_TAGS(
   trans_id_code_in         IN VARCHAR2,
   operation_in             IN NUMBER,
   account_in               IN VARCHAR2,
   out_all_cli_tags         OUT CTC_WR.CTC_REF_CURSOR,
   error_out                OUT NUMBER
) IS
   procedure_error          EXCEPTION;
   trans_id_nr              NUMBER;
BEGIN

    ACC_CONTEXT_PCK.SET_CONTEXT(
        account_in => account_in,
        error_out  => error_out
    );
       
    IF (error_out <> 0) THEN
        RAISE procedure_error;
    END IF;

   --SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
   CTC_WR.GET_ALL_CLI_TAGS(in_time          => ACC_CONTEXT_PCK.CURRENT_TIMESTAMP_AT_AREA,
                              in_trans_id_code => trans_id_code_in,
                             in_trans_id_nr   => TO_NUMBER(0),
                             in_operation     => operation_in,
                             in_account       => TO_NUMBER(account_in),
                           in_partition_key => mod(account_in, 128),
                           out_all_cli_tags => out_all_cli_tags,
                             out_error        => error_out);

   IF NGIN_GER_BD.CHECK_ERROR(error_out) != 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code_in,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ALL_CLI_TAGS',
      storedProc_param    => 'operation_in = '   || operation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '     || account_in     || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code_in,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(operation_in),
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_ALL_CLI_TAGS',
      storedProc_param    => 'operation_in = '   || operation_in   || LOG_LOGGER_PCK.F_SEP ||
                             'account_in = '     || account_in     || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(account_in),
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_ALL_CLI_TAGS;

PROCEDURE CHECK_SUSP_GRACE_PERIOD(
   in_trans_id_code         IN VARCHAR2,
   in_operation             IN NUMBER,
   in_account               IN VARCHAR2,
   out_error                OUT NUMBER
) IS
   procedure_error          EXCEPTION;
   v_trans_id_nr            NUMBER;
BEGIN

   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO v_trans_id_nr FROM dual;
   
   NGIN_ACC_BD1.VALIDATE_SUSP_GRACE_PERIOD(
        in_trans_id_code       => in_trans_id_code,
        in_trans_id_nr       => v_trans_id_nr,
        in_operation           => in_operation,
        in_account             => TO_NUMBER(in_account),
        out_error              => out_error
    );

   IF out_error <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => in_trans_id_code,
      trans_id_nr         => v_trans_id_nr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_SUSP_GRACE_PERIOD',
      storedProc_param    => 'in_operation = '   || in_operation   || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '     || in_account     || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => in_trans_id_code,
      trans_id_nr         => v_trans_id_nr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.CHECK_SUSP_GRACE_PERIOD',
      storedProc_param    => 'in_operation = '   || in_operation   || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '     || in_account     || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );
END CHECK_SUSP_GRACE_PERIOD;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_CLI_SMS                                  **
*****************************************************************************/
/* Desc: retorna a lista de permiss�es para determinado account*/
PROCEDURE GET_CLI_PERMISSIONS(  
       in_account                 IN VARCHAR2, 
       in_interface_id            IN VARCHAR2,
       in_item_type               IN VARCHAR2,
       out_permission_list     OUT REF_CURSOR,
       error_out                 OUT NUMBER

)
IS
    procedure_error           EXCEPTION;
    
BEGIN
  
    
     -- chama a api do CRM para obter a lista de permiss�es para determinado account --
   DCM_WR.GET_CLI_SMS_PERMISSIONS(
      in_account => TO_NUMBER(in_account),
      in_interface_id   => TO_NUMBER(in_interface_id),
      in_item_type   => in_item_type,
      out_permission_list   => out_permission_list,
      out_error  => error_out
   );
   
   IF error_out <> 0 THEN
      RAISE procedure_error;
   END IF;


EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CLI_PERMISSIONS',
      storedProc_param    => 'in_account = ' || in_account,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => in_account,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => NULL,
      trans_id_nr         => NULL,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CLI_PERMISSIONS',
      storedProc_param    => 'in_account = ' || in_account,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => in_account,
      line_code           => NULL,
      additional_text     => NULL
   );
END GET_CLI_PERMISSIONS;

PROCEDURE TDR_AUTOMATIC_IMPUGN(
   in_trans_id_code         IN VARCHAR2,
   in_operation             IN NUMBER,
   in_account               IN NUMBER,
   in_tid                   IN NUMBER,
   in_dump_instance_number  IN NUMBER,
   in_db_name               IN VARCHAR2,
   in_reason                IN NUMBER,
   in_observation           IN VARCHAR2,
   in_user                  IN VARCHAR2,
   in_partition_date        IN VARCHAR2,
   in_send_type             IN VARCHAR2,
   in_send_value            IN VARCHAR2,
   in_send_observation      IN VARCHAR2,
   in_debit_reason          IN VARCHAR2,
   out_imp_corrected_val    OUT NUMBER,
   error_out                OUT NUMBER
) IS
   procedure_error          EXCEPTION;
   trans_id_nr              NUMBER;
BEGIN

   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
   
  LOG_LOGGER_CONTEXT.SET_CONTEXT (
               in_account_id     => in_account, 
               in_trans_id_code  => in_trans_id_code, 
               in_trans_id_nr    => trans_id_nr, 
               in_operation      => in_operation
   );


   ngin_acc_bd1.TDR_AUTOMATIC_IMPUGN(
      in_trans_id_code        => in_trans_id_code,
      in_trans_id_nr          => trans_id_nr,
      in_operation            => in_operation,
      in_account              => in_account,
      in_tid                  => in_tid,
      in_dump_instance_number => in_dump_instance_number,
      in_db_name              => in_db_name,
      in_debit_reason         => in_debit_reason,
      in_reason               => in_reason,
      in_observation          => in_observation,
      in_user                 => in_user,
      in_partition_date       => TO_CHAR(to_timestamp_tz(in_partition_date, 'DD-MON-YY HH.MI.SS.FF6 PM'), 'yyyy-mm-dd hh24:mi:ss.ff6 tzr'),
      in_send_type            => in_send_type,
      in_send_value           => in_send_value,
      in_send_observation     => in_send_observation,
      out_imp_corrected_val   => out_imp_corrected_val,
      out_error               => error_out
   );

   IF NGIN_GER_BD.CHECK_ERROR(error_out) != 0 THEN
      RAISE procedure_error;
   END IF;
   
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => in_trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => in_operation,
      storedProc_name     => 'CAR_ACCOUNT_PCK.TDR_AUTOMATIC_IMPUGN',
      storedProc_param    => 'in_trans_id_code = '        || in_trans_id_code        || LOG_LOGGER_PCK.F_SEP ||
                             'in_operation = '            || in_operation            || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '              || in_account              || LOG_LOGGER_PCK.F_SEP ||
                             'in_tid = '                  || in_tid                  || LOG_LOGGER_PCK.F_SEP ||
                             'in_dump_instance_number = ' || in_dump_instance_number || LOG_LOGGER_PCK.F_SEP ||
                             'in_db_name = '              || in_db_name              || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason = '               || in_reason               || LOG_LOGGER_PCK.F_SEP ||
                             'in_observation = '          || in_observation          || LOG_LOGGER_PCK.F_SEP ||
                             'in_user = '                 || in_user                 || LOG_LOGGER_PCK.F_SEP ||
                             'in_partition_date = '       || in_partition_date       || LOG_LOGGER_PCK.F_SEP ||
                             'in_debit_reason = '         || in_debit_reason         || LOG_LOGGER_PCK.F_SEP ||
                             'in_send_type = '            || in_send_type            || LOG_LOGGER_PCK.F_SEP ||
                             'in_send_value = '           || in_send_value           || LOG_LOGGER_PCK.F_SEP ||
                             'in_send_observation = '     || in_send_observation,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => error_out,
      sql_error           => NULL,
      account_id          => in_account,
      line_code           => NULL,
      additional_text     => NULL
   );
   
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
   
WHEN OTHERS THEN
   error_out := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => in_trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => in_operation,
      storedProc_name     => 'CAR_ACCOUNT_PCK.TDR_AUTOMATIC_IMPUGN',
      storedProc_param    => 'in_trans_id_code = '        || in_trans_id_code        || LOG_LOGGER_PCK.F_SEP ||
                             'in_operation = '            || in_operation            || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '              || in_account              || LOG_LOGGER_PCK.F_SEP ||
                             'in_tid = '                  || in_tid                  || LOG_LOGGER_PCK.F_SEP ||
                             'in_dump_instance_number = ' || in_dump_instance_number || LOG_LOGGER_PCK.F_SEP ||
                             'in_db_name = '              || in_db_name              || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason = '               || in_reason               || LOG_LOGGER_PCK.F_SEP ||
                             'in_observation = '          || in_observation          || LOG_LOGGER_PCK.F_SEP ||
                             'in_user = '                 || in_user                 || LOG_LOGGER_PCK.F_SEP ||
                             'in_partition_date = '       || in_partition_date       || LOG_LOGGER_PCK.F_SEP ||
                             'in_debit_reason = '         || in_debit_reason         || LOG_LOGGER_PCK.F_SEP ||
                             'in_send_type = '            || in_send_type            || LOG_LOGGER_PCK.F_SEP ||
                             'in_send_value = '           || in_send_value           || LOG_LOGGER_PCK.F_SEP ||
                             'in_send_observation = '     || in_send_observation,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => in_account,
      line_code           => NULL,
      additional_text     => NULL
   );
   
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

END TDR_AUTOMATIC_IMPUGN;

PROCEDURE CHANGE_INCENTIVE_SMS_STATE(
        in_trans_id_code         IN  VARCHAR2,
        in_operation             IN  VARCHAR2,
        in_account               IN  VARCHAR2,
        in_notif_category_list   IN  VARCHAR2,
        in_status_list           IN  VARCHAR2,
        out_error                OUT NUMBER
)
is
     procedure_error           EXCEPTION;
     trans_id_nr                 NUMBER;
BEGIN
    
    SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;

  LOG_LOGGER_CONTEXT.SET_CONTEXT (
               in_account_id     => in_account, 
               in_trans_id_code  => in_trans_id_code, 
               in_trans_id_nr    => trans_id_nr, 
               in_operation      => in_operation
   );

    NGIN_ACC_BD1.ADD_NOTIF_PERMISSIONS( 
            in_trans_id_code =>  in_trans_id_code,
            in_trans_id_nr    => trans_id_nr,
            in_operation =>     TO_NUMBER(in_operation),
            in_account =>       TO_NUMBER(in_account),
            in_notif_category_list =>  in_notif_category_list,
            in_status_list  =>   in_status_list,
            out_error   =>     out_error
    );

   IF NGIN_GER_BD.CHECK_ERROR(out_error) = 0 THEN
      COMMIT;
   ELSE
      RAISE procedure_error;
   END IF;

   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

    EXCEPTION
    WHEN procedure_error THEN
       LOG_LOGGER_PCK.LOG(
          severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
          trans_id_code       => NULL,
          trans_id_nr         => trans_id_nr,
          operation           => NULL,
          storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_INCENTIVE_SMS_STATE',
          storedProc_param    => 'in_account = ' || in_account,
          storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
          error_code          => out_error,
          sql_error           => NULL,
          account_id          => in_account,
          line_code           => NULL,
          additional_text     => NULL
       );

    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
    WHEN OTHERS THEN
       out_error := SQLCODE;
       LOG_LOGGER_PCK.LOG(
          severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
          trans_id_code       => NULL,
          trans_id_nr         => trans_id_nr,
          operation           => NULL,
          storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_INCENTIVE_SMS_STATE',
          storedProc_param    => 'in_account = ' || in_account,
          storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
          error_code          => SQLCODE,
          sql_error           => SQLERRM,
          account_id          => in_account,
          line_code           => NULL,
          additional_text     => NULL
       );   

   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

END CHANGE_INCENTIVE_SMS_STATE;

--------------------------------------------------------------------------------
-- Retorna a data de expira��o dos pacotes referentes ao programa de pontos de 
-- acordo com n�mero da linha do cliente. Tais pacotes s�o parametriz�veis e 
-- est�o no referidos na entidade 144110 do Minerva.
--------------------------------------------------------------------------------
PROCEDURE GET_EXPIRE_PACK_DATE_PP(
   in_trans_id_code  IN VARCHAR2,
   in_account        IN VARCHAR2,
   out_cursor        OUT REF_CURSOR,
   out_error         OUT NUMBER
)
IS
    out_list SRV_SERVICE_LIST;
    trans_id_nr NUMBER;
    procedure_error EXCEPTION;
    
BEGIN
   

    -----------------------------------------
    --- Busca informa��es sobre o cliente ---
    -----------------------------------------  
    ACC_CONTEXT_PCK.SET_CONTEXT(
        IN_ACCOUNT, 
        OUT_ERROR,
        'N'
    );


   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
    
   SRV_WR.GET_CLIENT_PACKAGES_PP(in_trans_id_code => in_trans_id_code,
                                   in_trans_id_nr  => trans_id_nr,
                                   in_trans_oper   => C_MULTIOPERATION_PP,
                                   in_account      => TO_NUMBER(in_account),
                                   out_srv_list    => out_list,
                                   out_error       => out_error);
    
   IF NGIN_GER_BD.CHECK_ERROR(out_error) = 0 THEN
      COMMIT;
   ELSE
      RAISE procedure_error;
   END IF;
   
   OPEN out_cursor FOR
      SELECT ID as EXPIRE_PACK_CODE, 
             validity_date as EXPIRE_DATE_PACK,
             b.COMMERCIAL_NAME as EXPIRE_PACK 
       FROM SRV_SERVICE b,(
          SELECT ID, validity_date
          FROM TABLE (CAST  (out_list as SRV_SERVICE_LIST))) a
          WHERE a.ID = b.CODE;
  
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
   EXCEPTION
   WHEN procedure_error THEN
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.GET_EXPIRE_PACK_DATE_PP',
         storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_account = ' || in_account,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => out_error,
         sql_error           => NULL,
         account_id          => in_account,
         line_code           => NULL,
         additional_text     => NULL
      );   

   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
   WHEN OTHERS THEN
      out_error := SQLCODE;
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.GET_EXPIRE_PACK_DATE_PP',
         storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_account = ' || in_account,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => SQLCODE,
         sql_error           => SQLERRM,
         account_id          => in_account,
         line_code           => NULL,
         additional_text     => NULL
      );   

   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
END GET_EXPIRE_PACK_DATE_PP;

--------------------------------------------------------------------------------
-- Ativa os pacotes que est�o dispon�veis para o programa de pontos de um 
-- determinado cliente. Tais pacotes s�o parametriz�veis e est�o no referidos 
-- na entidade 144110 do Minerva.
--------------------------------------------------------------------------------
PROCEDURE MBL_ACTIVE_PACK_PP(
   in_trans_id_code  IN VARCHAR2,
   in_pack_code       IN VARCHAR2,
   in_account        IN VARCHAR2,
   in_user           IN VARCHAR2,
   out_cursor        OUT REF_CURSOR,
   out_error         OUT NUMBER
)
IS
    outContractNbr    NUMBER;
    id_multioperacao  NUMBER;
    trans_id_nr       NUMBER;
    procedure_error   EXCEPTION;
    cursor_temp      REF_CURSOR; 
  
    regOutData regPRIV_GET_SRV_OPER_COST;
    v_operation     VARCHAR2(30);
    v_dealer        VARCHAR2(30);
    v_service         VARCHAR2(15);
    v_param_list      VARCHAR2(4000);
    v_reason        NUMBER;
    v_trans_id_oper NUMBER;
BEGIN

  SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
  
  v_operation := 'ACT';
  v_reason := 1;
  v_dealer := 'CAR-ACTIVE PACK';
  
  v_trans_id_oper := 14;
  
   SRV_WR.GET_SRV_TEMPLATE_BY_CATEGORY(
     	in_trans_id_code    => in_trans_id_code,
     	in_trans_id_nr      => trans_id_nr,
     	in_trans_id_oper    => v_trans_id_oper,
     	in_account          => in_account,
     	in_service          => in_pack_code,
     	in_param_list       => null,
     	out_service         => v_service,
     	out_param_list      => v_param_list,
     	out_error           => out_error
  	); 
  	
  	
  IF NGIN_GER_BD.CHECK_ERROR(out_error) != 0 THEN
    RAISE procedure_error;
  END IF;

  SRV_WR.PRIV_GET_SRV_OPER_COST(
                in_account       => in_account,
                in_service       => v_service,
                in_srv_operation => v_operation,
                in_reason        => v_reason,
               in_param_list    => v_param_list,
                out_data         => cursor_temp,
                out_error        => out_error
  );
                          

  IF NGIN_GER_BD.CHECK_ERROR(out_error) != 0 THEN
    RAISE procedure_error;
  END IF;
    
  
  FETCH cursor_temp INTO regOutData;
    --NULL;
  CLOSE cursor_temp;
   
    
  SRV_WR.PRIV_SET_CLIENT_PP(in_trans_id_code    => in_trans_id_code,
                             in_trans_id_nr     => trans_id_nr,
                             in_trans_oper      => C_MULTIOPERATION_PP,
                             in_user            => in_user,
                             in_account         => in_account,
                             in_service         => v_service,
                             in_param_list      => v_param_list,
                             in_contract_nr     => NULL,
                             in_operation       => v_operation,
                             in_reason          => v_reason,
                             in_cost_value1     => regOutData.COST1,
                             in_cost_value2     => regOutData.COST2,
                             in_observation     => NULL,
                             in_dealer          => 'CAR-ACTIVE PACK',
                             out_contract_nr    => outContractNbr,
                             out_error          => out_error);
   
  IF NGIN_GER_BD.CHECK_ERROR(out_error) = 0 THEN
    COMMIT;
  ELSE
    RAISE procedure_error;
  END IF;
   
  LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

  EXCEPTION
   WHEN procedure_error THEN
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.MBL_ACTIVE_PACK_PP',
         storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_pack_code = ' || in_pack_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_account = ' || in_account || LOG_LOGGER_PCK.F_SEP ||
                                'in_user = ' || in_user,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => out_error,
         sql_error           => NULL,
         account_id          => in_account,
         line_code           => NULL,
         additional_text     => NULL
      );

   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
   WHEN OTHERS THEN
      out_error := SQLCODE;
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.MBL_ACTIVE_PACK_PP',
         storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_pack_code = ' || in_pack_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_account = ' || in_account || LOG_LOGGER_PCK.F_SEP ||
                                'in_user = ' || in_user,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => SQLCODE,
         sql_error           => SQLERRM,
         account_id          => in_account,
         line_code           => NULL,
         additional_text     => NULL
      );
      
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

END MBL_ACTIVE_PACK_PP;
--------------------------------------------------------------------------------
-- Retorna todos os saldos de um celular aprovisionado no NGIN, agrupados
-- pelo tipo (Plafond_Type), inclusive os seus eventuais limites.
--------------------------------------------------------------------------------
PROCEDURE GET_PLAFOND_CONS_SUM(
   in_trans_id_code  IN VARCHAR2,
   in_user           IN VARCHAR2,
   in_account        IN VARCHAR2,
   out_date          OUT DATE,
   out_cursor        OUT REF_CURSOR,
   out_error         OUT NUMBER
)IS
    trans_id_nr       NUMBER;
    V_OPERATION       NUMBER;
    procedure_error   EXCEPTION;
BEGIN
    --C�digo Multi opera��o
    V_OPERATION := 436;
    
    SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;

    NGIN_PAY_BD1.PLAFOND_GET_CONSUMPTION_SUM(in_trans_id_code,
                                            trans_id_nr,
                                            V_OPERATION,
                                            in_account,
                                            out_date,
                                            out_cursor,
                                            out_error);
   
    IF NGIN_GER_BD.CHECK_ERROR(out_error) != 0 THEN
        RAISE procedure_error;
    END IF;
   
    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

    EXCEPTION
    WHEN procedure_error THEN
        LOG_LOGGER_PCK.LOG(
            severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
            trans_id_code       => NULL,
            trans_id_nr         => trans_id_nr,
            operation           => NULL,
            storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PLAFOND_CONS_SUM',
            storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_account = ' || in_account || LOG_LOGGER_PCK.F_SEP ||
                                'in_user = ' || in_user,
            storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
            error_code          => out_error,
            sql_error           => NULL,
            account_id          => in_account,
            line_code           => NULL,
            additional_text     => NULL
        );

        LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
    WHEN OTHERS THEN
        out_error := SQLCODE;
        LOG_LOGGER_PCK.LOG(
        severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
        trans_id_code       => NULL,
        trans_id_nr         => trans_id_nr,
        operation           => NULL,
        storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PLAFOND_CONS_SUM',
        storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                               'in_account = ' || in_account || LOG_LOGGER_PCK.F_SEP ||
                               'in_user = ' || in_user,
        storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
        error_code          => SQLCODE,
        sql_error           => SQLERRM,
        account_id          => in_account,
        line_code           => NULL,
        additional_text     => NULL
        );
      
    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
END;

--------------------------------------------------------------------------------
-- Consulta de Saldos e Limites por API - Retorno das informacoes de SMS de 
-- Extrato Detalhado via API
--------------------------------------------------------------------------------
PROCEDURE GET_PLAFOND_CONS_DETAILS(
   in_trans_id_code  IN VARCHAR2,
   in_user           IN VARCHAR2,
   in_account        IN VARCHAR2,
   out_date          OUT DATE,
   out_cursor        OUT REF_CURSOR,
   out_error         OUT NUMBER
)
IS
   trans_id_nr       NUMBER;
   V_OPERATION       NUMBER;
   procedure_error   EXCEPTION;

BEGIN 
   --C�digo Multi opera��o
  V_OPERATION := 402;
   
  SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
   
  
  NGIN_PAY_BD1.PLAFOND_GET_CONSUMPTION_DET(in_trans_id_code,
                                            trans_id_nr,
                                            V_OPERATION,
                                            in_account,
                                            out_date,
                                            out_cursor,
                                            out_error);

   
  IF NGIN_GER_BD.CHECK_ERROR(out_error) != 0 THEN
    RAISE procedure_error;
  END IF;
   
  LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

  EXCEPTION
   WHEN procedure_error THEN
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PLAFOND_CONS_DETAILS',
         storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_account = ' || in_account || LOG_LOGGER_PCK.F_SEP ||
                                'in_user = ' || in_user,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => out_error,
         sql_error           => NULL,
         account_id          => in_account,
         line_code           => NULL,
         additional_text     => NULL
      );

   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
   WHEN OTHERS THEN
      out_error := SQLCODE;
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.GET_PLAFOND_CONS_DETAILS',
         storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_account = ' || in_account || LOG_LOGGER_PCK.F_SEP ||
                                'in_user = ' || in_user,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => SQLCODE,
         sql_error           => SQLERRM,
         account_id          => in_account,
         line_code           => NULL,
         additional_text     => NULL
      );
      
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

END GET_PLAFOND_CONS_DETAILS;

--------------------------------------------------------------------------------
--  disponibiliza o envio de SMS contendo os saldos detalhados de uma linha de 
-- clientes Pr� Pago e Plano Controle, de acordo com o c�digo do grupo de saldo
-- solicitado. O uso t�pico desta API ocorre atrav�s do acesso via URA do 
-- atendimento da Vivo (*8486).
--------------------------------------------------------------------------------
PROCEDURE MBL_SEND_PLAFOND_DETAILS(
   in_trans_id_code  IN VARCHAR2,
   in_account        IN VARCHAR2,
   in_plafond_group  IN VARCHAR2,
   out_error         OUT NUMBER
)
IS
   trans_id_nr       NUMBER;
   V_OPERATION       NUMBER;
   procedure_error   EXCEPTION;
   OUT_DATE          DATE;

BEGIN 
   --C�digo Multi opera��o
  V_OPERATION := 401;
   
  SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
   
   
  VIVO_PRE_BRL_BD1.SEND_BALANCE_SMS_DETAIL (in_trans_id_code, 
                                            trans_id_nr,
                                            V_OPERATION,
                                            in_account, 
                                            in_plafond_group,
                                            null,
                                            null,
                                            null,
                                            out_error);

   
  IF NGIN_GER_BD.CHECK_ERROR(out_error) = 0 THEN
    COMMIT;
  ELSE
    RAISE procedure_error;
  END IF;
   
  LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

  EXCEPTION
   WHEN procedure_error THEN
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.MBL_SEND_PLAFOND_DETAILS',
         storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_account = ' || in_account || LOG_LOGGER_PCK.F_SEP ||
                                'in_plafond_group = ' || in_plafond_group,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => out_error,
         sql_error           => NULL,
         account_id          => in_account,
         line_code           => NULL,
         additional_text     => NULL 
      );

   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
   WHEN OTHERS THEN
      out_error := SQLCODE;
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.MBL_SEND_PLAFOND_DETAILS',
         storedProc_param    => 'in_trans_id_code = ' || in_trans_id_code || LOG_LOGGER_PCK.F_SEP ||
                                'in_account = ' || in_account || LOG_LOGGER_PCK.F_SEP ||
                                'in_plafond_group = ' || in_plafond_group,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => SQLCODE,
         sql_error           => SQLERRM,
         account_id          => in_account,
         line_code           => NULL,
         additional_text     => NULL
      );
      
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

END MBL_SEND_PLAFOND_DETAILS;

--------------------------------------------------------------------------------
-- Este procedimento é responsável por alterar a Situação de Bloqueio de   
-- Ageing de um cliente.
--------------------------------------------------------------------------------
PROCEDURE CHANGE_BLOCK_AGEING(
    inUsername                IN  VARCHAR2,
    inCellNumber            IN  VARCHAR2,
    inBlockCod                IN  NUMBER,
    inReasonBlockCod        IN  NUMBER,
    outError                OUT NUMBER,
    outErrorDesc            OUT VARCHAR2) IS
    
       V_TRANS_ID_NR            NUMBER;
       V_UIF_ERROR_CODE         NUMBER;
       V_EXT_SYS                VARCHAR2(2);
       V_SERVICE_ID            VARCHAR2(100);
       V_OPERATION                NUMBER;
       V_TRANS_ID_CODE          VARCHAR2 (20) := 'UIB';
       
       PROCEDURE_ERROR            EXCEPTION;
       --Variaveis que contemplam o tipo slr info
    V_SLR_CARE_DB           NUMBER;
    V_SLR_CARE_INSTANCE     NUMBER;
    V_SLR_CARE_ALT_INSTANCE NUMBER;
    V_SLR_CARE_PARTITION    NUMBER;
    V_SLR_ACCOUNT_ID        VARCHAR2(10);
    V_SLR_CLIENT_TYPE       NUMBER;
    V_SLR_PROFILE           VARCHAR2(15);
    V_SLR_SERVICE_STATUS    NUMBER;

BEGIN
    
    SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO V_TRANS_ID_NR FROM dual;
    V_EXT_SYS    := '1';
    V_SERVICE_ID:= 'mblTransBlockAgeing';
    outError := 0;
    
    --recupera as informa��es do slr para preencher o type PAY_DEF.type_slr_info �:
    NGIN_SLR_BD.GET_CLIENT_BY_MSISDN (inCellNumber,
                                      V_SLR_CARE_DB,
                                      V_SLR_CARE_INSTANCE,
                                      V_SLR_CARE_ALT_INSTANCE,
                                      V_SLR_CARE_PARTITION,
                                      V_SLR_ACCOUNT_ID,
                                      V_SLR_CLIENT_TYPE,
                                      V_SLR_PROFILE,
                                      V_SLR_SERVICE_STATUS,
                                      outError);
    
    V_OPERATION := NULL;
    IF inBlockCod=0 THEN
        V_OPERATION := 438; --Desbloqueio    
    ELSIF inBlockCod=1 THEN
        V_OPERATION := 437; --Bloqueio
    END IF;
    
    IF NGIN_GER_BD.CHECK_ERROR(outError) <> 0 THEN
        V_UIF_ERROR_CODE := outError;
        --Traduz o erro do uif para o erro do sistema externo
        CAR_MAPPING_PCK.GET_MAPPING_ERROR_UIF(V_EXT_SYS,
                                            V_SERVICE_ID,                                                
                                            V_UIF_ERROR_CODE,
                                            V_TRANS_ID_NR,
                                            outError,
                                            outErrorDesc);
        RAISE PROCEDURE_ERROR;
    END IF;
    
    VIVO_PRE_BRL_BD1.CHANGE_BLOCK_AGEING (
        in_trans_id_code        =>    V_TRANS_ID_CODE,
        in_trans_id_nr            =>    V_TRANS_ID_NR,
        in_operation            =>    V_OPERATION,
        in_account                =>    V_SLR_ACCOUNT_ID,
        in_block_ageing_fg        =>    inBlockCod,
        in_block_ageing_reason    =>    inReasonBlockCod,
        in_user                    =>    inUsername,
        out_error                =>    outError
    );
    
    IF NGIN_GER_BD.CHECK_ERROR(outError) <> 0 THEN
        v_uif_error_code := outError;
        --Traduz o erro do uif para o erro do sistema externo
        CAR_MAPPING_PCK.GET_MAPPING_ERROR_UIF(V_EXT_SYS,
                                            V_SERVICE_ID,
                                            TO_CHAR(V_UIF_ERROR_CODE),
                                            V_TRANS_ID_NR,
                                            outError,
                                            outErrorDesc);

        RAISE PROCEDURE_ERROR;
    END IF;
    
    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    COMMIT;

    EXCEPTION
    WHEN procedure_error THEN
    LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => V_TRANS_ID_NR,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_BLOCK_AGEING',
         storedProc_param    => 'inUsername = ' || inUsername || LOG_LOGGER_PCK.F_SEP ||
                                'inCellNumber = ' || inCellNumber || LOG_LOGGER_PCK.F_SEP ||
                                'inBlockCod = ' || inBlockCod || LOG_LOGGER_PCK.F_SEP ||
                                'inReasonBlockCod = ' || inReasonBlockCod || LOG_LOGGER_PCK.F_SEP,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => outError,
         sql_error           => NULL,
         account_id          => NULL,
         line_code           => NULL,
         additional_text     => NULL 
      );
    ROLLBACK;
    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
   WHEN OTHERS THEN
      outError := SQLCODE;
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => v_trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.CHANGE_BLOCK_AGEING',
         storedProc_param    => 'inUsername = ' || inUsername || LOG_LOGGER_PCK.F_SEP ||
                                'inCellNumber = ' || inCellNumber || LOG_LOGGER_PCK.F_SEP ||
                                'inBlockCod = ' || inBlockCod || LOG_LOGGER_PCK.F_SEP ||
                                'inReasonBlockCod = ' || inReasonBlockCod || LOG_LOGGER_PCK.F_SEP,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => SQLCODE,
         sql_error           => SQLERRM,
         account_id          => NULL,
         line_code           => NULL,
         additional_text     => NULL
      );
    ROLLBACK;      
       LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

END CHANGE_BLOCK_AGEING;

--------------------------------------------------------------------------------
-- Este procedimento é responsável por retornar as informações da situação de    
-- Bloqueio de Ageing de um cliente.
--------------------------------------------------------------------------------
PROCEDURE GET_BLOCK_AGEING_INFO (
        inUsername                IN  VARCHAR2,
        inCellNumber            IN  VARCHAR2,
        outBlockCod                OUT NUMBER,
        outReasonBlockCod        OUT NUMBER,
        outReasonBlockDesc        OUT VARCHAR2,
        outError                OUT NUMBER,
        outErrorDesc            OUT VARCHAR2
) IS
    V_TRANS_ID_NR            NUMBER;
       V_UIF_ERROR_CODE         NUMBER;
       V_EXT_SYS                VARCHAR2(2);
       V_SERVICE_ID            VARCHAR2(100);
       V_OPERATION                NUMBER;
       V_TRANS_ID_CODE          VARCHAR2 (20) := 'UIB';
       
       PROCEDURE_ERROR            EXCEPTION;
       --Variaveis que contemplam o tipo slr info
    V_SLR_CARE_DB           NUMBER;
    V_SLR_CARE_INSTANCE     NUMBER;
    V_SLR_CARE_ALT_INSTANCE NUMBER;
    V_SLR_CARE_PARTITION    NUMBER;
    V_SLR_ACCOUNT_ID        VARCHAR2(10);
    V_SLR_CLIENT_TYPE       NUMBER;
    V_SLR_PROFILE           VARCHAR2(15);
    V_SLR_SERVICE_STATUS    NUMBER;
    
BEGIN
    SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO V_TRANS_ID_NR FROM dual;
    V_EXT_SYS    := '2';
    V_SERVICE_ID:= 'getBlockAgeing';
    outError := 0;
    
    V_OPERATION := 439; --Consulta ao sistemas externos
    
    --recupera as informa��es do slr para preencher o type PAY_DEF.type_slr_info �:
    NGIN_SLR_BD.GET_CLIENT_BY_MSISDN (inCellNumber,
                                      V_SLR_CARE_DB,
                                      V_SLR_CARE_INSTANCE,
                                      V_SLR_CARE_ALT_INSTANCE,
                                      V_SLR_CARE_PARTITION,
                                      V_SLR_ACCOUNT_ID,
                                      V_SLR_CLIENT_TYPE,
                                      V_SLR_PROFILE,
                                      V_SLR_SERVICE_STATUS,
                                      outError);
    IF NGIN_GER_BD.CHECK_ERROR(outError) <> 0 THEN
        v_uif_error_code := outError;

        RAISE PROCEDURE_ERROR;
    END IF;
    
    VIVO_PRE_BRL_BD1.GET_BLOCK_AGEING_INFO (
        in_trans_id_code        =>    V_TRANS_ID_CODE,
        in_trans_id_nr            =>    V_TRANS_ID_NR,
        in_operation            =>    V_OPERATION,
        in_account                =>    V_SLR_ACCOUNT_ID,
        out_flag                =>    outBlockCod,
        out_reason                =>    outReasonBlockCod,
        out_reason_desc            =>    outReasonBlockDesc,
        out_error                =>    outError
    );
    
    IF NGIN_GER_BD.CHECK_ERROR(outError) <> 0 THEN
        v_uif_error_code := outError;

        RAISE PROCEDURE_ERROR;
    END IF;
    
    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
    EXCEPTION
    WHEN procedure_error THEN
    outErrorDesc:=LOG_LOGGER_PCK.GET_ERROR_MSG (outError);
    LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => V_TRANS_ID_NR,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.GET_BLOCK_AGEING_INFO',
         storedProc_param    => 'inUsername = ' || inUsername || LOG_LOGGER_PCK.F_SEP ||
                                'inCellNumber = ' || inCellNumber || LOG_LOGGER_PCK.F_SEP,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => outError,
         sql_error           => NULL,
         account_id          => NULL,
         line_code           => NULL,
         additional_text     => NULL 
    );

    LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
   WHEN OTHERS THEN
      outError := SQLCODE;
      outErrorDesc:=LOG_LOGGER_PCK.GET_ERROR_MSG (outError);
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => v_trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.GET_BLOCK_AGEING_INFO',
         storedProc_param    => 'inUsername = ' || inUsername || LOG_LOGGER_PCK.F_SEP ||
                                'inCellNumber = ' || inCellNumber || LOG_LOGGER_PCK.F_SEP,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => SQLCODE,
         sql_error           => SQLERRM,
         account_id          => NULL,
         line_code           => NULL,
         additional_text     => NULL
      );
      
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
END GET_BLOCK_AGEING_INFO;

PROCEDURE GET_CLIENT_REWARDS_BY_DATE (
	account_in       IN NUMBER,
	start_date_in    IN VARCHAR2,
	end_date_in      IN VARCHAR2, 
	result_out       OUT REF_CURSOR,
	outerror        OUT NUMBER
	
)IS
   trans_id_nr       NUMBER;
   V_OPERATION       NUMBER;
   procedure_error   EXCEPTION;
   v_start_date_in   DATE;
   v_end_date_in     DATE;

BEGIN
	
	v_start_date_in := TO_DATE(start_date_in,'DD/MM/YYYY HH24:MI:SS');
    v_end_date_in   := TO_DATE(end_date_in  ,'DD/MM/YYYY HH24:MI:SS');

	CBR_WR_RWD.GET_CLIENT_REWARDS_BY_DATE(
		in_account       => account_in,
		in_start_date    => v_start_date_in,
		in_end_date      => v_end_date_in, 
		out_result       => result_out,
		out_error        => outerror
	);


  LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();

  EXCEPTION
   WHEN procedure_error THEN
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CLIENT_REWARDS_BY_DATE',
         storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                                'start_date_in = ' || v_start_date_in ||
                                'in_end_date = ' || v_end_date_in || LOG_LOGGER_PCK.F_SEP,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => outerror,
         sql_error           => NULL,
         account_id          => account_in,
         line_code           => NULL,
         additional_text     => NULL
      );

   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
    
   WHEN OTHERS THEN
      outerror := SQLCODE;
      LOG_LOGGER_PCK.LOG(
         severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
         trans_id_code       => NULL,
         trans_id_nr         => trans_id_nr,
         operation           => NULL,
         storedProc_name     => 'CAR_ACCOUNT_PCK.GET_CLIENT_REWARDS_BY_DATE',
         storedProc_param    => 'account_in = ' || account_in || LOG_LOGGER_PCK.F_SEP ||
                                'start_date_in = ' || v_start_date_in ||
                                'in_end_date = ' || v_start_date_in || LOG_LOGGER_PCK.F_SEP,
         storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
         error_code          => SQLCODE,
         sql_error           => SQLERRM,
         account_id          => account_in,
         line_code           => NULL,
         additional_text     => NULL
      );
      
   LOG_LOGGER_CONTEXT.CLEAR_CONTEXT();
	
END GET_CLIENT_REWARDS_BY_DATE;

PROCEDURE NOTIFY_REFUND(
   in_operation             IN NUMBER,
   in_account               IN VARCHAR2,
   in_origin_id             IN VARCHAR2,
   in_reason                IN NUMBER,
   in_user                  IN VARCHAR2,
   in_obs                   IN VARCHAR2,
   out_error                OUT NUMBER
) IS
   procedure_error          EXCEPTION;
   trans_id_code            VARCHAR2(10);
   trans_id_nr              NUMBER;

BEGIN

   trans_id_code := CAR_GENERIC_PCK.TRANS_ID_CODE;
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM DUAL;

   VIVO_PRE_BRL_BD1.NOTIFY_REFUND(
		in_trans_id_code  => trans_id_code, 
		in_trans_id_nr    => trans_id_nr,
		in_operation      => in_operation,
		in_account        => in_account,
		in_origin_id      => in_origin_id,
		in_reason_code    => in_reason,
		in_user           => in_user,
		in_obs            => in_obs,
		out_error         => out_error);

   IF NGIN_GER_BD.CHECK_ERROR(out_error) = 0 THEN
      COMMIT;
   ELSE
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   ROLLBACK;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.NOTIFY_REFUND',
      storedProc_param    => 'in_operation = '       || in_operation       || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '         || in_account         || LOG_LOGGER_PCK.F_SEP ||
                             'in_origin_id = '       || in_origin_id       || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason = '          || in_reason          || LOG_LOGGER_PCK.F_SEP ||
                             'in_user_id = '         || in_user            || LOG_LOGGER_PCK.F_SEP ||
                             'in_obs = '             || in_obs,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => NULL,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   ROLLBACK;
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => TO_NUMBER(in_operation),
      storedProc_name     => 'CAR_ACCOUNT_PCK.NOTIFY_REFUND',
      storedProc_param    => 'in_operation = '       || in_operation       || LOG_LOGGER_PCK.F_SEP ||
                             'in_account = '         || in_account         || LOG_LOGGER_PCK.F_SEP ||
                             'in_origin_id = '       || in_origin_id       || LOG_LOGGER_PCK.F_SEP ||
                             'in_reason = '          || in_reason          || LOG_LOGGER_PCK.F_SEP ||
                             'in_user_id = '         || in_user            || LOG_LOGGER_PCK.F_SEP ||
                             'in_obs = '             || in_obs,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => SQLCODE,
      sql_error           => SQLERRM,
      account_id          => TO_NUMBER(in_account),
      line_code           => NULL,
      additional_text     => NULL
   );

END NOTIFY_REFUND;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_HIER_BY_MSISN                                                   **
*****************************************************************************/
PROCEDURE GET_HIER_BY_MSISDN(
   in_msisdn              IN VARCHAR2,
   out_hierarchy_id       OUT NUMBER,
   out_external_account       OUT VARCHAR2,
   out_error                 OUT NUMBER
) IS

   trans_id_code             VARCHAR2(3);
   trans_id_nr               NUMBER;
   procedure_error           EXCEPTION;

BEGIN
	
   trans_id_code := CAR_GENERIC_PCK.TRANS_ID_CODE;
   
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
   
    out_error := 0;

   NGIN_ACC_BD1.GET_HIER_BY_MSISDN(
      in_trans_id_code => trans_id_code,
      in_trans_id_nr => trans_id_nr,
      in_operation => NULL,
      in_msisdn => in_msisdn,
      out_hierarchy_id  => out_hierarchy_id,
      out_external_account  => out_external_account,
      out_error    => out_error
   );
   

   IF out_error <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_HIER_BY_MSISN',
      storedProc_param    => 'in_msisdn = ' || in_msisdn || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => substr(LOG_LOGGER_PCK.GET_ERROR_MSG(out_error),1,512),
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_HIER_BY_MSISN',
      storedProc_param    => 'in_msisdn = ' || in_msisdn || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => substr(LOG_LOGGER_PCK.GET_ERROR_MSG(out_error),1,512),
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_HIER_BY_MSISDN;

/*****************************************************************************
** IMPLEMENTATION                                                           **
** Procedure: GET_EXT_ACC_BY_HIER_ID                                        **
*****************************************************************************/
PROCEDURE GET_EXT_ACC_BY_HIER_ID(in_trans_id_code     IN  VARCHAR2,
                                    in_trans_id_nr       IN  NUMBER,
                                    in_operation         IN  NUMBER,
                                    in_hierarchy_id      IN  NUMBER,
                                    out_external_account OUT VARCHAR2,
                                    out_error            OUT NUMBER)
 IS

   trans_id_code             VARCHAR2(3);
   trans_id_nr               NUMBER;
   procedure_error           EXCEPTION;

BEGIN
    
   trans_id_code := CAR_GENERIC_PCK.TRANS_ID_CODE;
   
   SELECT CAR_TRANS_ID_NR_SEQ.NEXTVAL INTO trans_id_nr FROM dual;
   
    out_error := 0;
    out_external_account:=null;

   NGIN_ACC_BD1.GET_EXT_ACC_BY_HIER_ID(in_trans_id_code  => trans_id_code,
                                    in_trans_id_nr       => trans_id_nr,
                                    in_operation         => NULL,
                                    in_hierarchy_id      => in_hierarchy_id,
                                    out_external_account => out_external_account,
                                    out_error            => out_error);


   IF out_error <> 0 THEN
      RAISE procedure_error;
   END IF;

EXCEPTION
WHEN procedure_error THEN
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.WARN_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_EXT_ACC_BY_HIER_ID',
      storedProc_param    => 'in_hierarchy_id = ' || in_hierarchy_id || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => substr(LOG_LOGGER_PCK.GET_ERROR_MSG(out_error),1,512),
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );
WHEN OTHERS THEN
   out_error := SQLCODE;
   LOG_LOGGER_PCK.LOG(
      severity            => LOG_LOGGER_PCK.ERROR_SEVERITY,
      trans_id_code       => trans_id_code,
      trans_id_nr         => trans_id_nr,
      operation           => NULL,
      storedProc_name     => 'CAR_ACCOUNT_PCK.GET_EXT_ACC_BY_HIER_ID',
      storedProc_param    => 'in_hierarchy_id = ' || in_hierarchy_id || LOG_LOGGER_PCK.F_SEP,
      storedProc_type     => LOG_LOGGER_PCK.INITIAL_PROC_TYPE,
      error_code          => out_error,
      sql_error           => substr(LOG_LOGGER_PCK.GET_ERROR_MSG(out_error),1,512),
      account_id          => NULL,
      line_code           => NULL,
      additional_text     => NULL
   );

END GET_EXT_ACC_BY_HIER_ID;

END CAR_ACCOUNT_PCK;
/
