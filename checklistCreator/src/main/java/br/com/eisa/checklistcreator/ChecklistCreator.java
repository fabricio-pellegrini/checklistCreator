package br.com.eisa.checklistcreator;

import java.io.IOException;
import java.io.InputStream;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.TokenStream;
import org.apache.commons.io.IOUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import br.com.eisa.checklistcreator.visitors.ChecklistCreatorVisitor;

public class ChecklistCreator {

	private static final String DEFAULT_ENCODING = "UTF-8";
	private static final Logger LOGGER = LogManager.getLogger(ChecklistCreator.class);

	public String compile(String schema, String code) {
		//TODO Entender o motivo do parser nao conseguir processar corretamente a String quando eh convertida para um InputStream
		//return compile(schema, IOUtils.toInputStream(code, DEFAULT_ENCODING));
		LOGGER.debug("Compiling: schema [{}]  code [{}] ", schema, code);

		String output = "";
		
		CharStream charStream = new ANTLRInputStream(code);		
		plsqlLexer lexer = new plsqlLexer(charStream);
		TokenStream tokens = new CommonTokenStream(lexer);
		plsqlParser parser = new plsqlParser(tokens);

		ChecklistCreatorVisitor classVisitor = new ChecklistCreatorVisitor(schema);
		output = classVisitor.visit(parser.compilation_unit());

		LOGGER.debug("Compiling: output [{}] ", output);
		
		return output;
		
	}

	public String compile(String schema, InputStream code) throws IOException {
		//LOGGER.debug("Compiling: schema [{}]  code [{}] ", schema, IOUtils.toString(code, DEFAULT_ENCODING));

		String output = "";
		
		CharStream charStream = new ANTLRInputStream(code);		
		plsqlLexer lexer = new plsqlLexer(charStream);
		TokenStream tokens = new CommonTokenStream(lexer);
		plsqlParser parser = new plsqlParser(tokens);

		ChecklistCreatorVisitor classVisitor = new ChecklistCreatorVisitor(schema);
		output = classVisitor.visit(parser.compilation_unit());

		LOGGER.debug("Compiling: output [{}] ", output);
		
		return output;
	}

}
