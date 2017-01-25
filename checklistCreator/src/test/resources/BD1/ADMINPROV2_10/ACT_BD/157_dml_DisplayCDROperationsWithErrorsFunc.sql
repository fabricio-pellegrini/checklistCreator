-- $Id$
INSERT INTO CAR_FUNCTIONALITY ( ID, DESCRIPTION, PATH, MENU_ID )
VALUES ('DisplayCDROperationsWithErrorsFunc', 'Chamadas/Eventos/Dados Com Erro', 'cellular/displayCdrOperationsWithErrors', 'CellularConsultMenu');


INSERT INTO CAR_FUNC_CLIENT (FUNC_ID,CLIENT_TYPE) Values ('DisplayCDROperationsWithErrorsFunc',-2);
INSERT INTO CAR_FUNC_CLIENT (FUNC_ID,CLIENT_TYPE) Values ('DisplayCDROperationsWithErrorsFunc',12);
INSERT INTO CAR_FUNC_CLIENT (FUNC_ID,CLIENT_TYPE) Values ('DisplayCDROperationsWithErrorsFunc',13);
INSERT INTO CAR_FUNC_CLIENT (FUNC_ID,CLIENT_TYPE) Values ('DisplayCDROperationsWithErrorsFunc',19);


INSERT INTO CAR_FUNCTIONALITY ( ID, DESCRIPTION, PATH, MENU_ID )
VALUES ('displayCDROperationsWithErrorsFunc', 'Chamadas/Eventos/Dados Com Erro', 'external/cellular/displayCdrOperationsWithErrors', 'ExternalMenu');



