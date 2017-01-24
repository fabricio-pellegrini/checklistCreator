package br.com.eisa.checklistcreator.visitors;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import br.com.eisa.checklistcreator.plsqlBaseVisitor;
import br.com.eisa.checklistcreator.plsqlParser.Package_bodyContext;
import br.com.eisa.checklistcreator.plsqlParser.Package_specContext;
import br.com.eisa.checklistcreator.plsqlParser.Regular_idContext;
import br.com.eisa.checklistcreator.constants.Query;

public class ChecklistCreatorVisitor extends plsqlBaseVisitor<String> {
	
	private static final Logger LOGGER = LogManager.getLogger(ChecklistCreatorVisitor.class);
	private String schema;
	
	public ChecklistCreatorVisitor(String schema) {
		this.schema = schema;
	}

	@Override
	public String visitPackage_body(Package_bodyContext ctx) {
		// TODO Auto-generated method stub
		return super.visitPackage_body(ctx);
	}

	@Override
	public String visitPackage_spec(Package_specContext ctx) {		

		String packageName = ctx.package_name(0).getText().toUpperCase();
		String objectType = "PACKAGE";		
		return String.format(Query.DBA_OBJECTS_IS_VALID, schema, packageName, objectType);
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
