package br.com.eisa.checklistcreator;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.io.IOException;
import java.io.InputStream;

import org.junit.Test;

import br.com.eisa.checklistcreator.constants.Query;

public class ChecklistCreatorTestCase {

	@Test
	public void compileStringTest() {
		
		String packageName = "WORLD";
		String schema = "HELLO";
		String objectType = "PACKAGE";
		String code = "CREATE OR REPLACE " + objectType + " " + packageName + " IS "
				+ "END " + packageName + ";";
		String expected = String.format(Query.DBA_OBJECTS_IS_VALID, schema, packageName, objectType);
		
		ChecklistCreator cc = new ChecklistCreator();
		String result = cc.compile(schema, code);
		
		assertNotNull(result);
		assertEquals(expected, result);
		
	}
	
	@Test
	public void compileSingleInsertFileTest() throws IOException {
		String fileName = "BD1/ADMINPROV2_10/ACT_BD/0519_CAR_SYSTEM_PARAMETER.sql";
		
		ClassLoader classLoader = getClass().getClassLoader();
		InputStream code = classLoader.getResourceAsStream(fileName);
		String schema = "ADMINPROV2_10";
		String tableName = "CAR_SYSTEM_PARAMETER";
		String where = "PROP_NAME = 'be.qtMeses.retencao.bdb' AND PROP_VALUE = '3'";		
		String expected = String.format(Query.INSERT, schema, tableName, where);
		
		ChecklistCreator cc = new ChecklistCreator();
		String result =  cc.compile(schema, code);
		
		assertNotNull(result);
		assertEquals(expected, result);
	}
	
	@Test
	public void compileMultipleInsertFileTest() throws IOException {
		String fileName = "BD1/ADMINPROV2_10/ACT_BD/157_dml_DisplayCDROperationsWithErrorsFunc.sql";
		
		ClassLoader classLoader = getClass().getClassLoader();
		InputStream code = classLoader.getResourceAsStream(fileName);
		String schema = "ADMINPROV2_10";
		 
		ChecklistCreator cc = new ChecklistCreator();
		String result = cc.compile(schema, code);
		
		assertNotNull(result);
		
	}
	
	@Test
	public void compilePackageSpecFileTest() throws IOException {
		String fileName = "BD1/ADMINPROV2_10/PKH/CAR_ACCOUNT_PKH.sql";		
		ClassLoader classLoader = getClass().getClassLoader();
		InputStream code = classLoader.getResourceAsStream(fileName);
		String schema = "ADMINPROV2_10";		
		String packageName = "CAR_ACCOUNT_PCK";		
		String objectType = "PACKAGE";		
		String expected = String.format(Query.DBA_OBJECTS_IS_VALID, schema, packageName, objectType);
		
		ChecklistCreator cc = new ChecklistCreator();
		String result  = cc.compile(schema, code);
		
		assertNotNull(result);
		assertEquals(expected, result);
	}
	
	@Test
	public void compilePackageBodyFileTest() throws IOException {
		String fileName = "BD1/ADMINPROV2_10/PKB/CAR_ACCOUNT_PKB.sql";		
		ClassLoader classLoader = getClass().getClassLoader();
		InputStream code = classLoader.getResourceAsStream(fileName);
		String schema = "ADMINPROV2_10";		 
		String packageName = "CAR_ACCOUNT_PCK";		
		String objectType = "PACKAGE BODY";		
		String expected = String.format(Query.DBA_OBJECTS_IS_VALID, schema, packageName, objectType);
		
		ChecklistCreator cc = new ChecklistCreator();
		String result = cc.compile(schema, code);
		
		assertNotNull(result);
		assertEquals(expected, result);
	}
	
	@Test
	public void compileGrantFileTest() throws IOException {
		String fileName = "BD2/ADMINPROV2_10/GRANTS/grant_CTT_CDRS_FIXA.sql";		
		ClassLoader classLoader = getClass().getClassLoader();
		InputStream code = classLoader.getResourceAsStream(fileName);
		String schema = "ADMINPROV2_10";		 
		String tableViewName = "CTT_CDRS_FIXA";		
		String privilegeType = "SELECT";
		String grantee = "CLIPROV2_10";
		String expected = String.format(Query.GRANT, schema, tableViewName, privilegeType, grantee); 
		
		ChecklistCreator cc = new ChecklistCreator();
		String result = cc.compile(schema, code);
		
		assertNotNull(result);
		assertEquals(expected, result);
	}
	

}
