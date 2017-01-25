/*$Id: CAR_ACCOUNT_PKH.sql 39222 2017-01-02 12:39:09Z edson.f.barbosa $*/

CREATE OR REPLACE PACKAGE /* $Id: CAR_ACCOUNT_PKH.sql 39222 2017-01-02 12:39:09Z edson.f.barbosa $ */                                                                       
                                ADMINPROV2_10.Car_Account_Pck IS
    
C_MULTIOPERATION_PP   CONSTANT NUMBER := 400;    

Type REF_CURSOR IS REF CURSOR;

TYPE regPRIV_GET_SRV_OPER_COST IS RECORD (
    REASON                      NUMBER(4),
    REASON_NAME                 VARCHAR2(50),
    OPERATION                   VARCHAR2(10),
    COST1                       NUMBER(12,3),
    COST2                       VARCHAR2(10),
    NEW_COST                    NUMBER(12,3),
    NEW_COST_INTERNAL_REASON    VARCHAR2(25),
    REASON_TYPE                 VARCHAR2(5)
);

/* Desc: retorna a lista de planos */
PROCEDURE GET_PROFILE_LIST (
  user_in                   IN VARCHAR2,
  plan_list_out             OUT REF_CURSOR,
  error_out                 OUT NUMBER
);


/* Desc: retorna a lista de planos para um determinado product_type*/
PROCEDURE GET_PROFILES_BY_PRODUCT_TYPE (
  product_type_in     IN VARCHAR2,
  user_in             IN VARCHAR2,
  area_code_in        IN VARCHAR2,
  plan_list_out       OUT REF_CURSOR,
  error_out           OUT NUMBER
);


PROCEDURE get_allowed_cellular_events (
    account_in            IN VARCHAR2,
    user_in                IN VARCHAR2,
    out_states            OUT REF_CURSOR,
    error_out            OUT NUMBER
);

PROCEDURE change_cellular_state (
    account_in                IN VARCHAR2,
    operation_in            IN VARCHAR2,
    cost_in                    IN VARCHAR2,
    cost_flag_in            IN VARCHAR2,
    reason_in                IN VARCHAR2,
    observation_in            IN VARCHAR2,
    police_report_no_in        IN VARCHAR2,
    police_report_date_in    IN VARCHAR2,
    police_station_in        IN VARCHAR2,
    city_name_in            IN VARCHAR2,
    num_days_in                IN VARCHAR2,
    service_cost_in            IN VARCHAR2,
    service_cost_flag_in    IN VARCHAR2,
    call_intercept_flag_in    IN VARCHAR2,
    call_intercept_num_in    IN VARCHAR2,
    user_in                    IN VARCHAR2,
    police_report_uf_in     IN VARCHAR2,
    documents_lost_fg_in    IN VARCHAR2,
    equipment_lost_fg_in    IN VARCHAR2,
    dealer_in                IN VARCHAR2,
    ip_address_in           IN VARCHAR2,
    error_out                OUT NUMBER
);

PROCEDURE get_reasons (
    operation_in        IN VARCHAR2,
    user_in                IN VARCHAR2,
    out_reasons            OUT REF_CURSOR,
    error_out            OUT NUMBER
);

PROCEDURE get_reasons_with_cost (
    account_in            IN VARCHAR2,
    operation_in        IN VARCHAR2,
    user_in                IN VARCHAR2,
    out_reasons            OUT REF_CURSOR,
    error_out            OUT NUMBER
);

/****************************************************************************
** Procedure:   GET_CELLULAR_LIST                                          **
**                                                                         **
** Description: Busca uma lista de celulares dado um crit�rio de busca.    **
**                                                                         **
** Parameters:  search_type_in - Tipo de Busca:                            **
**                      MSISDN - Busca por msisdn.                         **
**                      ESN    - Busca por esn decimal.                    **
**                      CNPJ   - Busca por cnpj.                           **
**                      RG     - Busca por rg.                             **
**                      NAME   - Busca por nome da entidade.               **
**                      MSISDN_REUT - Busca por reutilizacoes MSISDN.      **
**                      ESN_REUT - Busca por ESN reutilizacoes.            **
**              value_in - Valor da busca                                  **
**              client_type_in - Tipo de conta a ser consultada.           **
**              query_out - Query de saida a ser executada.                **
**              out_error - C�digo do erro                                 **
** Throws:                                                                 **
**                                                                         **
** Version  Date       Author     Description                              **
** -------- ---------- ---------- ---------------------------------------- **
** 01.00.00 17/05/2006 Renato H.  1. Implementacao busca por reutilizacoes **
****************************************************************************/
PROCEDURE GET_CELLULAR_LIST (
   search_type_in IN VARCHAR2,
   value_in IN VARCHAR2,
   client_type_in IN VARCHAR2,
   query_out OUT VARCHAR2,
   error_out OUT NUMBER
);

PROCEDURE GET_ACCOUNT_INFO (
   account_in   IN  VARCHAR2,
   info_out     OUT REF_CURSOR,
   error_out    OUT NUMBER
);

PROCEDURE get_cellular (
   account_in        IN VARCHAR2,
   user_in        IN VARCHAR2,
   cellular_out        OUT REF_CURSOR,
   error_out         OUT NUMBER
);

PROCEDURE CHECK_CHANGE_CELLULAR (
   account_destiny_in    IN VARCHAR2,
   area_code_origin_in    IN VARCHAR2,
   error_out        OUT NUMBER
);

PROCEDURE get_client (
   account_in            IN VARCHAR2,
   client_type_in        IN VARCHAR2,
   user_in               IN VARCHAR2,
   address_category_in   IN VARCHAR2,
   client_out        OUT REF_CURSOR,
   error_out        OUT NUMBER
);

-- Desc: Calls API from Account to generate new account number
PROCEDURE GET_ACCOUNT (
    account_code_out    OUT NUMBER,
    error_out            OUT NUMBER
);





PROCEDURE express_registration (
   trans_id_code         IN VARCHAR2,
   operation_in             IN VARCHAR2,
   account_in                 IN VARCHAR2,
   event_date_in             IN VARCHAR2,
   entity_type_in             IN VARCHAR2,
   short_name_in            IN VARCHAR2,
   confidential_in             IN VARCHAR2,
   name_in                     IN VARCHAR2,
   birth_date_in             IN VARCHAR2,
   sex_in                     IN VARCHAR2,
   civil_state_in            IN VARCHAR2,
   rg_in                     IN VARCHAR2,
   rg_type_in                IN VARCHAR2,
   rg_emission_date_in        IN VARCHAR2,
   rg_state_in                IN VARCHAR2,
   rg_org_exp_in             IN VARCHAR2,
   nif_in                     IN VARCHAR2,
   nif_type_in                IN VARCHAR2,
   passport_in                IN VARCHAR2,
   passport_type_in            IN VARCHAR2,
   driving_license_in        IN VARCHAR2,
   driving_license_type_in    IN VARCHAR2,
   to_the_care_of_in        IN VARCHAR2,
   phone_in                 IN VARCHAR2,
   fax_in                     IN VARCHAR2,
   e_mail_in                 IN VARCHAR2,
   family_unit_in            IN VARCHAR2,
   com_regist_conserv_in    IN VARCHAR2,
   com_regist_in            IN VARCHAR2,
   profession_code_in        IN VARCHAR2,
   academic_qualif_in        IN VARCHAR2,
   mobile_phone_in            IN VARCHAR2,
   segment_type_in            IN VARCHAR2,
   segment_sub_type_in        IN VARCHAR2,
   month_salary_in            IN VARCHAR2,
   cc_in                    IN VARCHAR2,
   bank_in                    IN VARCHAR2,
   iepj_in                    IN VARCHAR2,
   name_suffix_in            IN VARCHAR2,
   first_name_in            IN VARCHAR2,
   last_name_in                IN VARCHAR2,
   contact_name_in            IN VARCHAR2,
   employee_letter_in        IN VARCHAR2,
   address_type_in            IN VARCHAR2,
   address_in                 IN VARCHAR2,
   address_number_in         IN VARCHAR2,
   complement_in             IN VARCHAR2,
   postal_code1_in             IN VARCHAR2,
   postal_code2_in             IN VARCHAR2,
   quarter_in                  IN VARCHAR2,
   city_in                     IN VARCHAR2,
   country_prefix_in         IN VARCHAR2,
   geographical_state_in    IN VARCHAR2,
   cost_value1_in           IN VARCHAR2,
   cost_value2_in           IN VARCHAR2,
   reason_in                 IN VARCHAR2,
   obs_in                     IN VARCHAR2,
   user_in                     IN VARCHAR2,
   ip_address_in            IN VARCHAR2,
   category_in               IN VARCHAR2,
   reference_point_in        IN VARCHAR2,
   cnl_code_in                IN VARCHAR2,
   ibge_code_in                IN VARCHAR2,
   error_out                 OUT NUMBER
);


PROCEDURE get_possible_plans (
  account_in                IN VARCHAR2,
  product_type_in           IN VARCHAR2,
  user_in                   IN VARCHAR2,
  plan_list_out             OUT REF_CURSOR,
  error_out                 OUT NUMBER
);

PROCEDURE get_lost_services (
  account_in                IN VARCHAR2,
  user_in                   IN VARCHAR2,
  lost_services_list_out    OUT REF_CURSOR,
  error_out                 OUT NUMBER
);

PROCEDURE get_country_list(

   country_list_out             OUT REF_CURSOR,
   error_out                      OUT NUMBER
);



-- Desc:
PROCEDURE get_geo_state_list(
   geo_state_list_out           OUT REF_CURSOR,
   error_out                    OUT NUMBER
);



-- Desc: Lista o tipo de entidade para o cadastro expresso --
PROCEDURE get_entity_type_list (
   entity_type_list_out         OUT REF_CURSOR,
   error_out                    OUT NUMBER
);


-- Desc: Altera��o de Plano (agrupador de perfis) --
PROCEDURE Change_Profile (
   operation_code_in            IN VARCHAR2,
   account_in                   IN VARCHAR2,
   new_plan_in                  IN VARCHAR2,
   cost_in                      IN VARCHAR2,
   cost_flag_in                 IN VARCHAR2,
   reason_code_in               IN VARCHAR2,
   obs_in                       IN VARCHAR2,
   user_in                      IN VARCHAR2,
   ip_address_in                IN VARCHAR2,
   error_out                    OUT NUMBER
);



-- Desc: Consulta das contas utilizada na consulta de clientes --
PROCEDURE Get_Private_Accounts (
   in_account                   IN VARCHAR2,
   out_private_accounts_query   OUT VARCHAR2,
   out_error                    OUT NUMBER
);



-- Desc: Desprogramar uma linha --
PROCEDURE Unlink_Cellular (
   in_account                   IN VARCHAR2,
   in_reason_code                    IN VARCHAR2,
   in_obs                       IN VARCHAR2,
   in_user                      IN VARCHAR2,
   ip_address_in                IN VARCHAR2,
   out_error                    OUT NUMBER
);



-- Desc: Mudan�a de Equipamento --
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
);


-- Desc: Valida o CEP (Codigo Postal) --
PROCEDURE Check_Cep(
   postal_code1                 IN VARCHAR2,
   postal_code2                 IN VARCHAR2,
   quarter_city_out             OUT REF_CURSOR,
   error_out                    OUT NUMBER
);



-- Desc: Lista dos estados civis --
PROCEDURE Get_Civil_State_List(
   civil_state_list_out         OUT REF_CURSOR,
   error_out                    OUT NUMBER
);


PROCEDURE GET_LST_COST_CHG_PROFILE(
   account_in                    IN NUMBER,
   cost_chg_profile_out         OUT REF_CURSOR,
   error_out                     OUT NUMBER
);

-- Desc: Calls API from account to perform simultaneous equipment change
PROCEDURE SIMULTANEOUS_ESN_CHANGE(
    operation_code_in        IN VARCHAR2,
    account_in                IN VARCHAR2,
    changing_account_in        IN VARCHAR2,
    cost_in                    IN VARCHAR2,
    costFlag_in                IN VARCHAR2,
    reason_code_in            IN VARCHAR2,
    dealer_code_in            IN VARCHAR2,
    observation_in            IN VARCHAR2,
    user_in                    IN VARCHAR2,
    error_out                OUT NUMBER
);

PROCEDURE GET_PLAFOND_TYPES_LIST (
  user_in                   IN VARCHAR2,
  operationType             IN VARCHAR2,
  plafond_list_out          OUT REF_CURSOR,
  error_out                 OUT NUMBER
);

PROCEDURE GET_FIXA_PLAFOND_TYPE_LIST (
  user_in                   IN VARCHAR2,
  operation_Type            IN VARCHAR2,
  plafond_list_out          OUT REF_CURSOR,
  error_out                 OUT NUMBER
);

PROCEDURE GET_MSISDN_FROM_ACCOUNT (
    account_in                IN VARCHAR2,
    user_in                    IN VARCHAR2,
    msisdn_out                OUT VARCHAR2,
    error_out                OUT NUMBER
);

-- Desc:  Realiza a confirma��o da Venda da Venda
PROCEDURE SALE_USER_CONFIRMATION (
    account_in          IN  VARCHAR2,
    dealer_code_in      IN  VARCHAR2,
    sale_user_in        IN  VARCHAR2,
    exec_user_in        IN  VARCHAR2,
    process_in          IN  VARCHAR2,
    ip_address_in       IN  VARCHAR2,
    error_out           OUT NUMBER
);

PROCEDURE GET_SALE_INFORMATION (
   account_in           IN VARCHAR2,
   user_in              IN VARCHAR2,
   sale_info_out        OUT REF_CURSOR,
   error_out            OUT NUMBER
);



/* Retorna o estado e data de aprovisionamento para um determinado servi�o e account */
PROCEDURE PRIV_GET_ACC_SERVICE_STATE(
   account_in           IN VARCHAR2,
   service_in           IN VARCHAR2,
   state_out            OUT VARCHAR2,
   contract_nr_out      OUT NUMBER,
   provision_date_out   OUT DATE,
   error_out            OUT NUMBER
);

/****************************************************************************
** Procedure:   CHANGE_EQUIP_MODEL                                         **
**                                                                         **
** Description: Atualiza��o do modelo de equipamento                       **
**                                                                         **
** Parameters:  in_operation - C�digo da multiopera��o                     **
**              in_account - C�digo do account                             **
**              in_equip_model_new - C�digo do novo modelo de equipamento  **
**              in_cost_value1 - Valor do custo                            **
**              in_cost_value2 - Flag do Custo                             **
**              in_reason - Motivo                                         **
**              in_user_id - C�digo do usu�rio                             **
**              in_obs - Observa��o                                        **
**              out_error - C�digo do erro                                 **
** Throws:      -                                                          **
**                                                                         **
** Version  Date       Author     Description                              **
** -------- ---------- ---------- ---------------------------------------- **
** 01.00.00 12/05/2006 Carlos J.  1. Vers�o Inicial                        **
****************************************************************************/
PROCEDURE CHANGE_EQUIP_MODEL (
        in_operation        IN VARCHAR2,
        in_account          IN VARCHAR2,
        in_equip_model_new  IN VARCHAR2,
        in_cost_value1      IN VARCHAR2,
        in_cost_value2      IN VARCHAR2,
        in_reason           IN VARCHAR2,
        in_user_id          IN VARCHAR2,
        in_obs              IN VARCHAR2,
        in_ip_address       IN VARCHAR2,
        out_error           OUT NUMBER
);

/* Dados 2 area_codes valida se os mesmas pertencem � mesma regional. Caso n�o perten�am devolve erro. */
PROCEDURE VALIDATE_TELCO_LIST (
   area_code1_in        IN ACC_CLIENT.area_code%TYPE,
   area_code2_in        IN ACC_CLIENT.area_code%TYPE,
   error_out            OUT NUMBER
);

/*******************************************************************************************
** Procedure:   GET_CLIENT_INFO                                                           **
**                                                                                        **
** Description: Atualiza��o do modelo de equipamento                                      **
**                                                                                        **
** Parameters:  in_msisdn - Msisdn pesquisado                                             **
**              in_account - Account retornado pelo SLR (in_msisdn).                      **
**              in_client_type - Tipo de cliente.                                         **
**              in_user - Usu�rio que realizou a consulta.                                **
**              out_account - Ultimo account associado ao Msisdn no ProCare.              **
**              out_change_flag - Flag que identifica se houve troca de n�mero            **
**                               (0 - n�o; 1 - sim)                                       **
**              out_old_msisdn - Msisdn que foi pesquisado.                               **
**              out_new_msisdn - Novo Msisdn (no caso de troca).                          **
**              out_change_date - Data da mudan�a de MSISDN                               **
**              out_esn - Equipment Serial Number                                         **
**              out_imei - C�digo do Equipamento em GSM                                   **
**                out_imsi
**              out_provision_date - Data de aprovisionamento da conta.                   **
**              out_provision_type - C�digo da opera��o de aprovisionamento.              **
**              out_dig7 - Identifica��o de n�mera��o antiga da GT.                       **
**              out_tecnology - Tecnologia do cliente: CDMA, TDMA, APMS, GSM.             **
**              out_entity_type - Tipo de entidade: Fisica ou Juridica.                   **
**              out_name - Nome do cliente.                                               **
**              out_nif - N�mero de identifica��o fiscal.                                 **
**              out_rg - N�mero de identifica��o pessoal.                                 **
**              out_confidential - Dados do cliente confidenciais (Y) ou (N).             **
**              out_equip_code - C�digo do modelo de equipamento.                         **
**              out_equip_name - Descri��o do modelo de equipamento.                      **
**              out_equip_brand - C�digo da marca do aparelho.                            **
**              out_equip_brand_desc - Descri��o da marca do aparelho.                    **
**              out_geographical_state - Unidade federativa real do cliente.              **
**              out_dealer - C�digo do dealer.                                            **
**              out_prf_master - C�digo do perfil.                                        **
**              out_prf_master_desc - Descri��o do perfil.                                **
**              out_language_code - C�digo do idioma.                                     **
**              out_language_desc - Descri��o do idioma.                                  **
**              out_state_code - C�digo do estado atual do cliente.                       **
**              out_state_desc - Descri�ao do estado atual do cliente.                    **
**              out_state_date - Data de aprovisionamento no estado atual.                **
**              out_is_state_confirmed - Indica se o cliente confirmou o roubo no SICS.   **
**              out_msisdn - N�mero do celular do cliente (Msisdn).                       **
**              out_min - Mobile Identification Number.                                   **
**              out_iccid - N�mero do cart�o SIM associado a linha.                       **
**              out_first_recharge - Data da primeira recarga.                            **
**              out_first_rec_value - Valor da primeira recarga.                          **
**              out_last_recharge - Data da ultima recarga.                               **
**              out_last_recharge_value - Valor da ultima recarga.                        **
**              out_next_state_desc - Descri��o do pr�ximo estado do cliente              **
**              out_next_state_date - Data de mudan�a para o pr�ximo estado               **
**              out_first_use - Data da activa��o                                         **
**              out_documents_lost_fg - Indica se houve perda de documentos               **
**                              NULL - N�o definido;                                      **
**                              1 - docs perdidos;                                        **
**                              0 - docs n�o perdidos.
**                out_portability_situation - Situa��o da portabilidade                      **
**                out_our_number            -                                               **
**				out_block_ageing_fg		 OUT NUMBER,
**				out_block_ageing_reason	 OUT NUMBER,
**				out_block_ageing_reason_desc OUT VARCHAR2,	
**              out_error - Resultado da execu��o.                                        **
**                                                                                        **
**                **                                                                      **
** Throws:      -                                                                         **
**                                                                                        **
** Version  Date       Author         Description                                         **
** -------- ---------- -------------  ----------------------------------------            **
** 01.00.00 01/02/2007 Daniel Cunha    1. Vers�o Inicial                                  **
** 01.01.00 27/05/2008 Miguel Horlle   2. Portabilidade
*******************************************************************************************/
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
   out_block_ageing_fg		 OUT NUMBER,
   out_block_ageing_reason	 OUT NUMBER,
   out_block_ageing_reason_desc OUT VARCHAR2,
   out_error                 OUT NUMBER
);

/** Efectua a cobran�a do valor relativo � opera��o.
*
*  @param     in_trans_id_code      C�digo da transac��o
*  @param     in_trans_id_nr        Identificador da transac��o
*  @param     in_account            C�digo da conta do cliente
*  @param     in_operation          Codigo da opera��o
*  @param     in_reason_code        C�digo do Motivo
*  @param     in_cost_value1        Custo da Opera��o
*  @param     in_cost_value2        Tipo de Custo da Opera��o
*  @param     in_observation        Observa��es/coment�rios
*  @param     in_user               Username de quem efectua opera��o
*  @param     error_out             Erro ocorrido
*
**/
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
   out_error        OUT NUMBER
);

/* Obt�m lista custos de uma opera��o. */
PROCEDURE GET_COST_OPERATION_LIST(
   account_in         IN  VARCHAR2,
   operation_in       IN  VARCHAR2,
   cost_operation_out OUT REF_CURSOR,
   error_out          OUT NUMBER
);

/* Valida a possibilidade de execu��o da opera��o de acordo com o estado e o perfil do celular. */
PROCEDURE CHECK_OPERATION(
   operation_in               IN  VARCHAR2,
   state_in                   IN  VARCHAR2,
   profile_in                 IN  VARCHAR2,
   portability_situation_in IN  VARCHAR2,
   error_out                  OUT NUMBER
);

/* Valida a possibilidade de execu��o da opera��o de acordo com o estado e o perfil do celular. */
PROCEDURE CHECK_OPERATION(
   operation_in       IN  VARCHAR2,
   account_in           IN  VARCHAR2,
   error_out          OUT NUMBER
);

/************************************************************************
** Procedure:   GET_ESN_STATE                                          **
**                                                                     **
** Description: Efetua a consulta do estado do esn                     **
**                                                                     **
** Parameters: esn_in - N�mero do ESN                                  **
**             esn_state_out - Estado do ESN                           **
**             error_out - Resultado da execu��o                       **
** Throws:      -                                                      **
**                                                                     **
** Version  Date        Author        Description                      **
** -------- ----------- ------------- ---------------------            **
** 01.00.00 21/03/2007  Daniel Cunha  1. Vers�o Inicial                **
************************************************************************/
PROCEDURE GET_ESN_STATE(
   trans_id_code_in IN VARCHAR2,
   operation_in     IN VARCHAR2,
   esn_in           IN VARCHAR2,
   esn_state_out    OUT NUMBER,
   error_out        OUT NUMBER
);

/***************************************************************************
 * Procedure: CHK_ZIP_CODE                                                **
 *                                                                        **
 * Description: Busca endere�os correspondentes ao c�digo postal.         **
 *                                                                        **
 * Parameters: zip_code_prefix - Prefixo do c�digo postal.                **
 *             zip_code_prefix - Prefixo do c�digo postal.                **
** Throws:      -                                                         **
**                                                                        **
** Version  Date        Author        Description                         **
** -------- ----------- ------------- ---------------------               **
** 01.00.00 06/08/2007  Daniel Cunha  1. Vers�o Inicial                   **
***************************************************************************/
PROCEDURE CHK_ZIP_CODE(
    zip_code_prefix_in   IN VARCHAR2,
    zip_code_suffix_in   IN VARCHAR2,
    error_out            OUT VARCHAR2,
    address_lst_out      OUT REF_CURSOR
);

/***************************************************************************
 * Procedure: CHK_FISCAL_ID                                               **
 *                                                                        **
 * Description: Verifica se um cliente se encontra na lista negra do NGIN.**
 *                                                                        **
 * Parameters: fiscal_document - Documento fiscal do cliente.             **
** Throws:      -                                                         **
**                                                                        **
** Version  Date        Author        Description                         **
** -------- ----------- ------------- ---------------------               **
** 01.00.00 06/08/2007  Daniel Cunha  1. Vers�o Inicial                   **
***************************************************************************/
PROCEDURE CHK_FISCAL_ID(
    fiscal_document_in  IN VARCHAR2,
    error_out           OUT VARCHAR2
);

/***************************************************************************
** Procedure: GET_ACADEMIC_DEGREE_LIST                                    **
**                                                                        **
** Description: Retorna a lista de poss�veis graus de instru��o.          **
**                                                                        **
** Parameters: error_out - c�digo de erro.                                **
**             academic_degree_list - Graus de instru��o.                 **
**                                                                        **
** Throws:      -                                                         **
**                                                                        **
** Version  Date        Author        Description                         **
** -------- ----------- ------------- ---------------------               **
** 01.00.00 06/08/2007  Daniel Cunha  1. Vers�o Inicial                   **
***************************************************************************/
PROCEDURE GET_ACADEMIC_DEGREE_LIST(
    error_out            OUT VARCHAR2,
    academic_degree_list OUT REF_CURSOR
);

/***************************************************************************
** Procedure: GET_PROFESSION_LIST                                         **
**                                                                        **
** Description: Retorna a lista de poss�veis profiss�es.                  **
**                                                                        **
** Parameters: error_out - c�digo de erro.                                **
**             profession_list - Pofiss�es.                               **
**                                                                        **
** Throws:      -                                                         **
**                                                                        **
** Version  Date        Author        Description                         **
** -------- ----------- ------------- ---------------------               **
** 01.00.00 06/08/2007  Daniel Cunha  1. Vers�o Inicial                   **
***************************************************************************/
PROCEDURE GET_PROFESSION_LIST(
    error_out            OUT VARCHAR2,
    profession_list      OUT REF_CURSOR
);

/****************************************************************************
** Procedure:   CHANGE_OWNER                                               **
**                                                                         **
** Description: Atualiza��o do titular de conta faturamento                **
**                                                                         **
** Parameters:  in_trans_id_code  - C�digo da transac��o                   **
**              in_operation      - C�digo da multi-opera��o               **
**              in_invoice_acc    - Id. da conta de facturamento           **
**                                  a trocar de titularidade               **
**              in_regist_acc     - Id. da conta de cadastro para a qual   **
**                                  ser� trocada a conta de facturamento   **
**                in_ext_credit_chk - Flag que identifica quais os sistemas  **
**                                    externos que foram consultados para    **
**                                    verificar o cr�dito do cliente         **
**              in_cost_value     - Valor do custo da opera��o             **
**              in_cost_fg        - Flag que identifica o tipo de custo    **
**              in_reason         - C�digo do motivo da opera��o           **
**              in_observation    - Observa��o                             **
**              in_username       - C�digo do usu�rio                      **
**              in_ip_address     - IP da m�quina do utilizador logado     **
**              out_error         - C�digo do erro                         **
** Throws:      -                                                          **
**                                                                         **
** Version  Date       Author     Description                              **
** -------- ---------- ---------- ---------------------------------------- **
** 01.00.00 08/08/2007 J. Goulart 1. Vers�o Inicial                        **
** 01.00.01 24/08/2007 J. Goulart 2. Adi��o de par�metros                  **
****************************************************************************/
PROCEDURE CHANGE_OWNER (
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
);

/***************************************************************************
** Procedure: GET_CHILD_ACCOUNTS                                          **
**                                                                        **
** Description: Retorna as linhas assoaciadas a uma conta de faturamento. **
**                                                                        **
** Parameters:                                                               **
**               account_in - Conta de faturamento.                          **
**               error_out - c�digo de erro.                                **
**             cellular_list - Linhas.                                     **
**                                                                        **
** Throws:      -                                                         **
**                                                                        **
** Version  Date        Author        Description                         **
** -------- ----------- ------------- ---------------------               **
** 01.00.00 06/08/2007  Daniel Cunha  1. Vers�o Inicial                   **
***************************************************************************/
PROCEDURE GET_CHILD_ACCOUNTS(
    account_in           IN  VARCHAR2,
    error_out            OUT VARCHAR2,
    cellular_list       OUT REF_CURSOR
);

PROCEDURE GET_ACCOUNT_HIERARCHY(
    in_account            IN NUMBER,
    out_error           OUT NUMBER,
    out_hierarchy        OUT REF_CURSOR
);

/****************************************************************************
** Procedure:   GET_ADDRESS_TYPE_LST                                       **
**                                                                         **
** Description: Obtem a lista de tipos de endere�os                        **
**                                                                         **
** Parameters: out_address_type_lst - Lista de tipos de endere�os          **
**             out_error            - C�digo do erro                       **
** Throws:      -                                                          **
**                                                                         **
** Version  Date       Author             Description                      **
** -------- ---------- ------------------ -------------------------------- **
** 01.00.00 10/08/2007 Denis C de Azevedo 1. Vers�o Inicial                **
****************************************************************************/
PROCEDURE GET_ADDRESS_TYPE_LST (
        out_address_type_lst    OUT REF_CURSOR,
        out_error               OUT VARCHAR2
);

/****************************************************************************
** Procedure:   ADD_ADDRESS                                                **
**                                                                         **
** Description: Insere um novo endere�o no sistema                         **
**                                                                         **
** Parameters: in_zip_code_id       - C�digo postal                        **
**             in_quarter           - Bairro                               **
**             in_addr_type_id      - Tipo de endere�o                     **
**             in_location_id       - Localidade                           **
**             in_address           - Endere�o                             **
**             out_error            - C�digo do erro                       **
** Throws:      -                                                          **
**                                                                         **
** Version  Date       Author             Description                      **
** -------- ---------- ------------------ -------------------------------- **
** 01.00.00 10/08/2007 Denis C de Azevedo 1. Vers�o Inicial                **
** 01.00.01 15/08/2007 J. Goulart         2. Adequa��o dos par�metros      **
****************************************************************************/
PROCEDURE ADD_ADDRESS (
   in_zip_code_id          IN VARCHAR2,
   in_quarter              IN VARCHAR2,
   in_addr_type_id         IN VARCHAR2,
   in_location_id          IN VARCHAR2,
   in_address              IN VARCHAR2,
   out_error               OUT VARCHAR2
);

/****************************************************************************
** Procedure:   GET_ZIP_CODE_DETAILS                                       **
**                                                                         **
** Description: Busca os detalhes de um c�digo postal                      **
**                                                                         **
** Parameters: in_zip_code          - C�digo postal                        **
**             out_error            - C�digo do erro                       **
**             out_list             - Endere�o                             **
** Throws:      -                                                          **
**                                                                         **
** Version  Date       Author             Description                      **
** -------- ---------- ------------------ -------------------------------- **
** 01.00.00 03/09/2007 Denis C de Azevedo 1. Vers�o Inicial                **
****************************************************************************/
PROCEDURE GET_ZIP_CODE_DETAILS (
   in_zip_code          IN VARCHAR2,
   out_error            OUT VARCHAR2,
   out_list             OUT REF_CURSOR
);

/*****************************************************************************
** Procedure: GET_TECHNOLOGY_BY_OPERATION                                   **
** Obt�m as tecnologias v�lidas para a multi-opera��o.                      **
*****************************************************************************/
PROCEDURE GET_TECHNOLOGY_BY_OPERATION(
    in_trans_id_code    IN  VARCHAR2,
    in_multi_operation  IN  VARCHAR2,
    out_error           OUT NUMBER,
    out_technology_list OUT REF_CURSOR
);
/****************************************************************************
** Procedure:   GET_PROFILE_MASTER_INFO                                    **
**                                                                         **
** Description: Retorna o numero de homologa��o da anatel para um perfil   **
**                                                                         **
** Parameters: profile_in               -Account do cliente                **
**             out_external_code        - C�digo do plano na ANATEL        **
**             out_profile_description  - Descri��o do plano no NGIN       **
**             out_product_type         - C�digo do product type do plano  **
** Throws:      -                                                          **
**                                                                         **
** Version  Date       Author             Description                      **
** -------- ---------- ------------------ -------------------------------- **
** 01.00.00 14/01/2008 Leonardo C. Almeida 1. Vers�o Inicial               **
****************************************************************************/
PROCEDURE GET_PROFILE_MASTER_INFO (
    profile_in                IN VARCHAR2,
    error_out                OUT NUMBER,
    out_external_code        OUT VARCHAR2,
    out_profile_description    OUT VARCHAR2,
    out_product_type        OUT NUMBER
);
/****************************************************************************
** Procedure:   SEND_BALANCE_SMS                                           **
**                                                                         **
** Description: Envia SMS com saldo do cliente                             **
**                                                                         **
** Parameters: account_in          - Account   cliente                     **
**             operator_in         - Aplica��o respons�vel pela requisi��o **
**                                                                           **
** Throws:      -                                                          **
**                                                                         **
** Version  Date       Author             Description                      **
** -------- ---------- ------------------ -------------------------------- **
** 01.00.00 14/01/2008 Leonardo C. Almeida 1. Vers�o Inicial               **
****************************************************************************/
PROCEDURE SEND_BALANCE_SMS (
    trans_id_code_in    IN VARCHAR2,
    account_in          IN VARCHAR2,
    operator_in         IN VARCHAR2,
    operation_code_in   IN VARCHAR2,
    interface_in        IN VARCHAR2,
    sid_in              IN VARCHAR2,
    reason_in           IN VARCHAR2,
    error_out           OUT NUMBER
);

/*************************************************************************************
** Procedure: GET_SUSPENSION_OPTIONS                                                **
**                                                                                  **
** Description: Obt�m lista de per�odos para exibi��o na tela de mudan�a de estado. **
**                                                                                  **
** Parameters:                                                                         **
**                                                                                    **
** Throws:      -                                                                   **
**                                                                                  **
** Version  Date       Author             Description                               **
** -------- ---------- ------------------ --------------------------------          **
** 01.00.00 05/03/2008 Daniel Cunha       1. Vers�o Inicial                         **
*************************************************************************************/
PROCEDURE GET_SUSPENSION_OPTIONS (
    list_out        OUT VARCHAR2,
    error_out        OUT VARCHAR2
);

-- Submit mail to mediation for sending porpuses
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
);

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
);

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
);

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
);

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
);

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
);

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
);


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
    send_type_in             IN VARCHAR2,
    send_value_in            IN VARCHAR2,
    send_observation_in       IN VARCHAR2,
    error_out                OUT NUMBER
);

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
    send_type_in              IN VARCHAR2,
    send_value_in            IN VARCHAR2,
    send_observation_in         IN VARCHAR2,
    error_out                OUT NUMBER
);

PROCEDURE GET_PENDCALL_BAL (
   trans_id_code_in            IN VARCHAR2,
   account_in                IN  VARCHAR2,
   client_balance_out         OUT NUMBER,
   error_out                OUT NUMBER
);

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
   out_error                 OUT NUMBER
);


PROCEDURE GET_ACCOUNT_FROM_MSISDN (
   in_trans_id_code IN VARCHAR2,
   in_operation     IN VARCHAR2,
   in_msisdn        IN VARCHAR2,
   out_account      OUT NUMBER,
   out_error        OUT NUMBER
);


PROCEDURE GET_PARENT_ACCOUNT (
   in_account              IN VARCHAR2,
   out_parent_account      OUT VARCHAR2,
   out_error               OUT NUMBER
);

PROCEDURE GET_ALL_CLI_TAGS(
   trans_id_code_in         IN VARCHAR2,
   operation_in             IN NUMBER,
   account_in               IN VARCHAR2,
   out_all_cli_tags         OUT CTC_WR.CTC_REF_CURSOR,
   error_out                OUT NUMBER
);

PROCEDURE CHECK_SUSP_GRACE_PERIOD(
   in_trans_id_code         IN VARCHAR2,
   in_operation             IN NUMBER,
   in_account               IN VARCHAR2,
   out_error                OUT NUMBER
);


PROCEDURE GET_CLI_PERMISSIONS(  
       in_account                 IN VARCHAR2, 
       in_interface_id            IN VARCHAR2,
       in_item_type               IN VARCHAR2,
        out_permission_list        OUT REF_CURSOR,
        error_out         OUT NUMBER
);

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
);

PROCEDURE CHANGE_INCENTIVE_SMS_STATE(
        in_trans_id_code         IN  VARCHAR2,
        in_operation             IN  VARCHAR2,
        in_account               IN  VARCHAR2,
        in_notif_category_list   IN  VARCHAR2,
        in_status_list           IN  VARCHAR2,
        out_error                OUT NUMBER
);

PROCEDURE GET_EXPIRE_PACK_DATE_PP(
   in_trans_id_code  IN VARCHAR2,
   in_account        IN VARCHAR2,
   out_cursor        OUT REF_CURSOR,
   out_error         OUT NUMBER
);

PROCEDURE MBL_ACTIVE_PACK_PP(
   in_trans_id_code  IN VARCHAR2,
   in_pack_code       IN VARCHAR2,
   in_account        IN VARCHAR2,
   in_user           IN VARCHAR2,
   out_cursor        OUT REF_CURSOR,
   out_error         OUT NUMBER
);

PROCEDURE GET_PLAFOND_CONS_DETAILS(
   in_trans_id_code  IN VARCHAR2,
   in_user           IN VARCHAR2,
   in_account        IN VARCHAR2,
   out_date          OUT DATE,
   out_cursor        OUT REF_CURSOR,
   out_error         OUT NUMBER
);

PROCEDURE GET_PLAFOND_CONS_SUM(
   in_trans_id_code  IN VARCHAR2,
   in_user           IN VARCHAR2,
   in_account        IN VARCHAR2,
   out_date          OUT DATE,
   out_cursor        OUT REF_CURSOR,
   out_error         OUT NUMBER
);

PROCEDURE MBL_SEND_PLAFOND_DETAILS(
   in_trans_id_code  IN VARCHAR2,
   in_account        IN VARCHAR2,
   in_plafond_group  IN VARCHAR2,
   out_error         OUT NUMBER
);
PROCEDURE CHANGE_BLOCK_AGEING(
		inUsername				IN  VARCHAR2,
		inCellNumber			IN  VARCHAR2,
		inBlockCod				IN  NUMBER,
		inReasonBlockCod		IN  NUMBER,
		outError    			OUT NUMBER,
    	outErrorDesc			OUT VARCHAR2
);

PROCEDURE GET_BLOCK_AGEING_INFO (
		inUsername				IN  VARCHAR2,
		inCellNumber			IN  VARCHAR2,
		outBlockCod				OUT NUMBER,
		outReasonBlockCod		OUT NUMBER,
		outReasonBlockDesc		OUT VARCHAR2,
		outError				OUT NUMBER,
		outErrorDesc			OUT VARCHAR2
);

PROCEDURE GET_CLIENT_REWARDS_BY_DATE (
    account_in       IN NUMBER,
    start_date_in    IN VARCHAR2,
    end_date_in      IN VARCHAR2, 
    result_out       OUT REF_CURSOR,
    outerror        OUT NUMBER
);

PROCEDURE NOTIFY_REFUND(
   in_operation             IN NUMBER,
   in_account               IN VARCHAR2,
   in_origin_id             IN VARCHAR2,
   in_reason                IN NUMBER,
   in_user                  IN VARCHAR2,
   in_obs                   IN VARCHAR2,
   out_error                OUT NUMBER
);

PROCEDURE GET_HIER_BY_MSISDN (
    in_msisdn              IN VARCHAR2,
   out_hierarchy_id       OUT NUMBER,
   out_external_account       OUT VARCHAR2,
   out_error                 OUT NUMBER
);

PROCEDURE GET_EXT_ACC_BY_HIER_ID(in_trans_id_code     IN  VARCHAR2,
                                    in_trans_id_nr       IN  NUMBER,
                                    in_operation         IN  NUMBER,
                                    in_hierarchy_id      IN  NUMBER,
                                    out_external_account OUT VARCHAR2,
                                    out_error            OUT NUMBER);


END Car_Account_Pck;
/
