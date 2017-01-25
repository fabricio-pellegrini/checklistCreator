package br.com.eisa.checklistcreator.visitors;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import br.com.eisa.checklistcreator.plsqlBaseVisitor;
import br.com.eisa.checklistcreator.plsqlParser;
import br.com.eisa.checklistcreator.plsqlParser.Package_bodyContext;
import br.com.eisa.checklistcreator.plsqlParser.Package_specContext;
import br.com.eisa.checklistcreator.plsqlParser.Regular_idContext;
import br.com.eisa.checklistcreator.plsqlParser.Single_table_insertContext;
import br.com.eisa.checklistcreator.constants.Query;

public class ChecklistCreatorVisitor extends plsqlBaseVisitor<String> {
	
	private static final Logger LOGGER = LogManager.getLogger(ChecklistCreatorVisitor.class);
	private String schema;
	
	public ChecklistCreatorVisitor(String schema) {
		this.schema = schema.toUpperCase();
	}

	@Override
	public String visitPackage_body(Package_bodyContext ctx) {
		
		String packageName = ctx.package_name(0).getText().toUpperCase();
		String objectType = "PACKAGE BODY";
		
		if(packageName.contains(".")){
			packageName = packageName.split("\\.")[1];
		}
		
		return String.format(Query.DBA_OBJECTS_IS_VALID, schema, packageName, objectType);
	}

	@Override
	public String visitPackage_spec(Package_specContext ctx) {		

		String packageName = ctx.package_name(0).getText().toUpperCase();		
		String objectType = "PACKAGE";		
		if(packageName.contains(".")){
			packageName = packageName.split("\\.")[1];
		}
		return String.format(Query.DBA_OBJECTS_IS_VALID, schema, packageName, objectType);
	}	
	
	@Override
	public String visitSingle_table_insert(Single_table_insertContext ctx) {

		String tableName =  ctx.insert_into_clause().general_table_ref().getText().toUpperCase();
		String where = "";
		String and =  "";
		for(int i = 0; i < ctx.insert_into_clause().column_name().size(); i++ ){
			String columnName = ctx.insert_into_clause().column_name(i).getText().toUpperCase();
			String columnValue = ctx.values_clause().expression_list().expression(i).getText();
			where += and + String.format(Query.ASSING, columnName, columnValue);
			and = " AND ";
		}
		return String.format(Query.INSERT, schema, tableName, where);
	}
	
	@Override 
	public String visitGrant_statement(plsqlParser.Grant_statementContext ctx) { 
		
		String privilegeType = ctx.privilege_type().getText().toUpperCase();
		String tableViewName = ctx.tableview_name().getText().toUpperCase();
		String grantee = ctx.grantee().getText().toUpperCase();
		
		return String.format(Query.GRANT, schema, tableViewName, privilegeType, grantee); 
	}
	
	
	@Override
	public String visitRegular_id(Regular_idContext ctx) {
		super.visitRegular_id(ctx);
		LOGGER.trace("regular_id [{}]",ctx.getText());
		return ctx.getText();
	}

	@Override
	protected String aggregateResult(String aggregate, String nextResult) {
		LOGGER.trace("aggregate [{}] nextResult[{}]", aggregate, nextResult);
		
		if(StringUtils.isEmpty(aggregate) && StringUtils.isEmpty(nextResult)){
			return "";
		} else if (StringUtils.isEmpty(aggregate)){
			return nextResult;
		} else if (StringUtils.isEmpty(nextResult)){
			return aggregate;
		} else {
			return aggregate + nextResult;
		}
	}	
	

}
