package br.com.eisa.checklistcreator;

import static org.junit.Assert.*;

import java.io.IOException;

import org.junit.Test;

import br.com.eisa.checklistcreator.ChecklistCreator;
import br.com.eisa.checklistcreator.constants.Query;

public class ChecklistCreatorTestUnit {

	@Test
	public void compileStringTest() {
		
		String packageName = "WORLD";
		String schema = "HELLO";
		String objectType = "PACKAGE";
		String code = "CREATE OR REPLACE " + objectType + " " + packageName + " IS "
				+ "END " + packageName + ";";
		String expected = String.format(Query.DBA_OBJECTS_IS_VALID, schema, packageName, objectType);
		ChecklistCreator cc = new ChecklistCreator();
		String result = null;
		
		result = cc.compile(schema, code);
		
		assertNotNull(result);
		assertEquals(expected, result);
		
	}

}
