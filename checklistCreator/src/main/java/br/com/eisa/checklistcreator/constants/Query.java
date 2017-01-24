package br.com.eisa.checklistcreator.constants;

public class Query {

	public static final String DBA_OBJECTS_IS_VALID = "SELECT DECODE(ESPERADO, NO_AMBIENTE, 'OK', 'NOK')\n"
			+ "FROM (SELECT 1 ESPERADO, COUNT(*) NO_AMBIENTE\n"
			+ "FROM DBA_OBJECTS\n"
			+ "WHERE OWNER = '%s'\n"
			+ "\t\t AND STATUS = 'VALID'\n"
			+ "\t\t AND OBJECT_NAME = '%s'\n"
			+ "\t\t AND OBJECT_TYPE = '%s'\n"
			+ ");\n";
}
