CREATE OR REPLACE PACKAGE BODY /* $Id: CAR_MENU_PKB.sql 39221 2017-01-02 12:35:43Z edson.f.barbosa $ */ Car_Menu_Pck IS

PROCEDURE Get_Menus (
   out_menus                    OUT REF_CURSOR,
   out_error                    OUT NUMBER
) IS

BEGIN
   OPEN out_menus FOR '
      SELECT
         cmn.ID,
         cmn.PARENT_ID,
         cmn.DESCRIPTION,
         cmn.TOP_FORWARD,
         cmn.MENU_ORDER,
         cmc.MENU_ID,
         cmc.CLIENT_TYPE
      FROM CAR_MENU_CLIENT cmc, CAR_MENU cmn
      WHERE cmc.menu_id = cmn.ID
      START WITH parent_id IS NULL
      CONNECT BY PRIOR id = parent_id
	  order by level, menu_order, client_type';

   --OPEN out_menus FOR '
   --SELECT *
   --FROM CAR_MENU
   --START WITH parent_id IS NULL
   --CONNECT BY PRIOR id = parent_id';
   
   /*OPEN out_menus FOR '
      SELECT
         cmn.ID,
         cmn.PARENT_ID,
         cmn.DESCRIPTION,
         cmn.TOP_FORWARD,
         cmn.MENU_ORDER,
         cmc.MENU_ID,
         cmc.CLIENT_TYPE,
         cmn.ROWNUM_x
      FROM
         (SELECT 
            ID,
            PARENT_ID,
            DESCRIPTION,
            TOP_FORWARD,
            MENU_ORDER,
            ROWNUM AS ROWNUM_x
          FROM CAR_MENU
          START WITH parent_id IS NULL
          CONNECT BY PRIOR id = parent_id
         ) cmn,
         CAR_MENU_CLIENT cmc
      WHERE cmc.menu_id = cmn.ID
      ORDER BY cmn.ROWNUM_x';*/

   out_error := 0;
   
EXCEPTION WHEN NO_DATA_FOUND THEN
   out_error := 0;
END Get_Menus;

PROCEDURE GET_APP_CONTEXTS (
	OUT_CONTEXTS		OUT REF_CURSOR,
	OUT_ERROR			OUT NUMBER
) IS
BEGIN
	OPEN OUT_CONTEXTS FOR '
	SELECT * 
	  FROM CAR_APP_CONTEXT';

   out_error := 0;
   
EXCEPTION WHEN NO_DATA_FOUND THEN
   out_error := 0;

END GET_APP_CONTEXTS;

END Car_Menu_Pck;
/

