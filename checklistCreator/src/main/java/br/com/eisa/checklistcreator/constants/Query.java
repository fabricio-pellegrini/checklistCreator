package br.com.eisa.checklistcreator.constants;

public class Query {

	private static final String SELECT_ESPERADO_VS_NO_AMBIENTE = "SELECT DECODE(ESPERADOS, NO_AMBIENTE, 'OK', 'NOK') STATUS\n"
				+ "FROM (SELECT 1 ESPERADOS, COUNT (*) NO_AMBIENTE\n";

	public static final String DBA_OBJECTS_IS_VALID = SELECT_ESPERADO_VS_NO_AMBIENTE
			+ "\tFROM DBA_OBJECTS\n"
			+ "\tWHERE OWNER = '%s'\n"
			+ "\t\t AND STATUS = 'VALID'\n"
			+ "\t\t AND OBJECT_NAME = '%s'\n"
			+ "\t\t AND OBJECT_TYPE = '%s'\n"
			+ ");\n";
	
	public static final String INSERT = SELECT_ESPERADO_VS_NO_AMBIENTE
			+ "\tFROM %s.%s\n"
			+ "\tWHERE %s\n"
			+ ");\n";
	
	public static final String GRANT = SELECT_ESPERADO_VS_NO_AMBIENTE
			+ "\tFROM DBA_TAB_PRIVS\n"
			+ "\tWHERE OWNER = '%s' \n"
			+ "\t\tAND TABLE_NAME = '%s'\n"
			+ "\t\tAND PRIVILEGE = '%s'\n"
			+ "\t\tAND GRANTEE = '%s'\n"			
			+ ");\n";	
	
	public static final String SYNONYM = SELECT_ESPERADO_VS_NO_AMBIENTE
			+ "\tFROM DBA_SYNONYMS\n"
			+ "\tWHERE OWNER = '%s'\n"
			+ "\t\tAND SYNONYM_NAME = '%s'\n"
			+ "\t\tAND TABLE_OWNER = '%s'\n"
			+ "\t\tAND TABLE_NAME = '%s'\n"
			+ ");\n";
	
	
	public static final String ASSING = "%s = %s";
}
