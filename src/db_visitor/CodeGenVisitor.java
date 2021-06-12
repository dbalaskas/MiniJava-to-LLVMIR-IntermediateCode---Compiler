/* Created by Dionysios Taxiarchis Balaskas - 1115201700094 */

package db_visitor;

import java.io.UnsupportedEncodingException;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import visitor.GJDepthFirst;
import symbolTable.*;
import syntaxtree.*;

public class CodeGenVisitor extends GJDepthFirst < String[], SymbolTableNode > {

	// !-------------------------------------------------------------------
	// ? Code generation section
	// !-------------------------------------------------------------------

	private PrintWriter writer;
	private int registersCounter = 0;
	private int labelsCounter = 0;

	public CodeGenVisitor(String fileName) throws UnsupportedEncodingException,
	FileNotFoundException {
		String newFileName = fileName + ".ll";
		writer = new PrintWriter(newFileName, "UTF-8");

		System.out.println("LLVM-IR file for \"" + newFileName + "\" has been created successfully.");
	}
  
	// !-------------------------------------------------------------------
	// ? Helper methods section
	// !-------------------------------------------------------------------

  private void emit(String code) {
		writer.write(code);
	}

  private void resetCounters() {
    this.registersCounter = 0;
    this.labelsCounter = 0;
  }

	private String newRegister(String name) {
    if (name != null) {
		  return "%" + name + String.valueOf(registersCounter++);
    }
		return "%_" + String.valueOf(registersCounter++);
	}

	private String newLabel(String name) {
    if (name != null) {
		  return "" + name + String.valueOf(registersCounter++);
    }
		return "l" + String.valueOf(labelsCounter++);
	}

	private String getType(String type) {
		switch (type) {
			case "int":
				return "i32";
			case "boolean":
				return "i1";
			case "int[]":
				return "i32*";
			default:
				return "i8*";
		}
	}

	private void defineHelperMethods() {
		this.emit(
			"declare i8* @calloc(i32, i32)\n" +
			"declare i32 @printf(i8*, ...)\n" +
			"declare void @exit(i32)\n\n" +

			"@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n" +
			"@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\n" +
			"define void @print_int(i32 %i) {\n" +
			"\t%_str = bitcast [4 x i8]* @_cint to i8*\n" +
			"\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n" +
			"\tret void\n" +
			"}\n\n" +

			"define void @throw_oob() {\n" +
			"\t%_str = bitcast [15 x i8]* @_cOOB to i8*\n" +
			"\tcall i32 (i8*, ...) @printf(i8* %_str)\n" +
			"\tcall void @exit(i32 1)\n" +
			"\tret void\n" +
			"}\n\n"
		);
	}

	private void setVTables() {
		int methodsNum,argsNum;
		List<MethodType> methods;
		ClassType curClass;
		MethodType curMethod;
		// For each class in SymbolTable.
		for (Map.Entry < String, ClassType > entry: SymbolTable.classes.entrySet()) {
			curClass = entry.getValue();
			methods = curClass.getSuperMethods();
			methodsNum = methods.size();
			if (curClass.isMain()) {
				this.emit("@." + curClass.getName() + "_vtable = global [" + (methodsNum - 1) + " x i8*] [");
			} else {
				this.emit("@." + curClass.getName() + "_vtable = global [" + methodsNum + " x i8*] [");
			}
			// For each method in class and superclasses.
			for (int i = 0; i < methodsNum; i++) {
				curMethod = methods.get(i);
				// If method of class is the main method, then continue.
				if (curMethod.isMain()) continue;
				argsNum = curMethod.getArgumentsCount();
				this.emit("i8* bitcast (" + this.getType(curMethod.getReturnType()) + " (i8*");
				// For each argument of method.
				for (int j = 0; j < argsNum; j++) {
					this.emit(", " + this.getType(curMethod.getArgument(j).getType()));
				}
				this.emit(")* @" + curMethod.getClassName() + "." + curMethod.getName() + " to i8*)");
				if (i < methodsNum - 1) {
					this.emit(", ");
				}
			}
			this.emit("]\n");
		}
		this.emit("\n");
	}

	// !-------------------------------------------------------------------
	// ? <visit> section
	// !-------------------------------------------------------------------

	/**
	 * f0 -> MainClass()
	 * f1 -> ( TypeDeclaration() )*
	 * f2 -> <EOF>
	 */
	public String[] visit(Goal n, SymbolTableNode argu) throws Exception {
		// Initialize VTables and define helper functions.
		this.setVTables();
		this.defineHelperMethods();

    // Visit miniJava
    n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);

    // Close writer
    writer.close();

    return new String[] {};
	}

	/**
	 * f0 -> "class"
	 * f1 -> Identifier()
	 * f2 -> "{"
	 * f3 -> "public"
	 * f4 -> "static"
	 * f5 -> "void"
	 * f6 -> "main"
	 * f7 -> "("
	 * f8 -> "String"
	 * f9 -> "["
	 * f10 -> "]"
	 * f11 -> Identifier()
	 * f12 -> ")"
	 * f13 -> "{"
	 * f14 -> ( VarDeclaration() )*
	 * f15 -> ( Statement() )*
	 * f16 -> "}"
	 * f17 -> "}"
	 */
	public String[] visit(MainClass n, SymbolTableNode argu) throws Exception {
    // Read MiniJAVA file.
		String className = n.f1.accept(this, argu)[0];
		ClassType curClass = SymbolTable.getClass(className);
    MethodType curMethod = curClass.getMethod("main");

    // Define main class.
		this.emit("define i32 @main() {\n");

    // Variable declaration.
		if (n.f14.present()) {
			n.f14.accept(this, curMethod);
		}

    // Statements.
		if (n.f15.present()) {
			n.f15.accept(this, curMethod);
		}

    // Return expr.
		this.emit("\n\tret i32 0\n}\n\n");

		return new String[] {};
	}

	/**
	 * f0 -> ClassDeclaration()
	 *       | ClassExtendsDeclaration()
	 */
	public String[] visit(TypeDeclaration n, SymbolTableNode argu) throws Exception {
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> "class"
	 * f1 -> Identifier()
	 * f2 -> "{"
	 * f3 -> ( VarDeclaration() )*
	 * f4 -> ( MethodDeclaration() )*
	 * f5 -> "}"
	 */
	public String[] visit(ClassDeclaration n, SymbolTableNode argu) throws Exception {
    // Read MiniJAVA file.
		String className = n.f1.accept(this, argu)[0];
		ClassType curClass = SymbolTable.getClass(className);

    // Method declaration.
		if (n.f4.present()) {
			n.f4.accept(this, curClass);
		}

		return new String[] {};
	}

	/**
	 * f0 -> "class"
	 * f1 -> Identifier()
	 * f2 -> "extends"
	 * f3 -> Identifier()
	 * f4 -> "{"
	 * f5 -> ( VarDeclaration() )*
	 * f6 -> ( MethodDeclaration() )*
	 * f7 -> "}"
	 */
	public String[] visit(ClassExtendsDeclaration n, SymbolTableNode argu) throws Exception {
    // Read MiniJAVA file.
		String className = n.f1.accept(this, argu)[0];
		ClassType curClass = SymbolTable.getClass(className);

    // Method declaration.
		if (n.f6.present()) {
			n.f6.accept(this, curClass);
		}
		return new String[] {};
	}

	/**
	 * f0 -> Type()
	 * f1 -> Identifier()
	 * f2 -> ";"
	 */
	public String[] visit(VarDeclaration n, SymbolTableNode argu) throws Exception {
    // Read MiniJAVA file.
		String type = n.f0.accept(this, argu)[0];
		String varName = n.f1.accept(this, argu)[0];

    // Emit to <.ll> file.
		this.emit("\t%" + varName + " = alloca " + this.getType(type) + "\n\n");
		return new String[] {};
	}

	/**
	 * f0 -> "public"
	 * f1 -> Type()
	 * f2 -> Identifier()
	 * f3 -> "("
	 * f4 -> ( FormalParameterList() )?
	 * f5 -> ")"
	 * f6 -> "{"
	 * f7 -> ( VarDeclaration() )*
	 * f8 -> ( Statement() )*
	 * f9 -> "return"
	 * f10 -> Expression()
	 * f11 -> ";"
	 * f12 -> "}"
	 */
	public String[] visit(MethodDeclaration n, SymbolTableNode argu) throws Exception {
    ClassType curClass = (ClassType) argu;
    this.resetCounters();

    // Read MiniJAVA file.
		String type = n.f1.accept(this, argu)[0];
		String methodName = n.f2.accept(this, argu)[0];
		MethodType curMethod = curClass.getMethod(methodName);

    // Define method.
		this.emit("define " + this.getType(type) + " @" + curClass.getName() + "." + methodName + "(i8* %this");

    // Emit arguments' list to <.ll> file.
		List<VariableType> args = curMethod.getArguments();
    for (int i = 0; i < curMethod.getArgumentsCount(); i++){
      this.emit(", "+ this.getType(args.get(i).getType()) + " %." + args.get(i).getName());
    }
		this.emit(") {\n");

    // Define arguments as variables in its body.
		if (n.f4.present()) {
			n.f4.accept(this, curMethod);
		}
    // Variable declaration.
		if (n.f7.present()) {
			n.f7.accept(this, curMethod);
		}
    // Statements.
		if (n.f8.present()) {
			n.f8.accept(this, curMethod);
		}

    // Return expression.
		String ret = n.f10.accept(this, curMethod)[0];
		this.emit("\tret " + ret + "\n}\n\n");

		return new String[] {};
	}

	/**
	 * f0 -> FormalParameter()
	 * f1 -> FormalParameterTail()
	 */
	public String[] visit(FormalParameterList n, SymbolTableNode argu) throws Exception {
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return new String[] {};
	}

	/**
	 * f0 -> Type()
	 * f1 -> Identifier()
	 */
	public String[] visit(FormalParameter n, SymbolTableNode argu) throws Exception {
    // Read MiniJAVA file.
		String type = n.f0.accept(this, argu)[0];
		String argName = n.f1.accept(this, argu)[0];

    // Emit to <.ll> file.
		this.emit("\t%" + argName + " = alloca " + this.getType(type) + "\n");
		this.emit("\tstore " + this.getType(type) + " %." + argName + ", " + this.getType(type) + "* %" + argName + "\n");
		return new String[] {};
	}

	/**
	 * f0 -> ( FormalParameterTerm() )*
	 */
	public String[] visit(FormalParameterTail n, SymbolTableNode argu) throws Exception {
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> ","
	 * f1 -> FormalParameter()
	 */
	public String[] visit(FormalParameterTerm n, SymbolTableNode argu) throws Exception {
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return new String[] {};
	}

	/**
	 * f0 -> ArrayType()
	 *       | BooleanType()
	 *       | IntegerType()
	 *       | Identifier()
	 */
	public String[] visit(Type n, SymbolTableNode argu) throws Exception {
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> "int"
	 * f1 -> "["
	 * f2 -> "]"
	 */
	public String[] visit(ArrayType n, SymbolTableNode argu) throws Exception {
		return new String[] {"int[]"};
	}

	/**
	 * f0 -> "boolean"
	 */
	public String[] visit(BooleanType n, SymbolTableNode argu) throws Exception {
		return new String[] {"boolean"};
	}

	/**
	 * f0 -> "int"
	 */
	public String[] visit(IntegerType n, SymbolTableNode argu) throws Exception {
		return new String[] {"int"};
	}

	/**
	 * f0 -> Block()
	 *       | AssignmentStatement()
	 *       | ArrayAssignmentStatement()
	 *       | IfStatement()
	 *       | WhileStatement()
	 *       | PrintStatement()
	 */
	public String[] visit(Statement n, SymbolTableNode argu) throws Exception {
		this.emit("\n");
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> "{"
	 * f1 -> ( Statement() )*
	 * f2 -> "}"
	 */
	public String[] visit(Block n, SymbolTableNode argu) throws Exception {
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		n.f2.accept(this, argu);
		return new String[] {};
	}

	/**
	 * f0 -> Identifier()
	 * f1 -> "="
	 * f2 -> Expression()
	 * f3 -> ";"
	 */
	public String[] visit(AssignmentStatement n, SymbolTableNode argu) throws Exception {
		MethodType curMethod = (MethodType) argu;

    // Read MiniJAVA file.
		String varName = n.f0.accept(this, argu)[0];
		String expr = n.f2.accept(this, argu)[0];

    // Emit to <.ll> file.
		String type = curMethod.getLocalVariableType(varName);
		if (type != null) {
			this.emit("\tstore " + expr + ", " + this.getType(type) + "* %" + varName + "\n");
		} else {
			ClassType curClass = curMethod.getMethodClass();
			type = curClass.getField(varName).getType();

			String reg1 = this.newRegister(null);
			int offset = curClass.getField(varName).getOffset() + 8;
			this.emit("\t" + reg1 + " = getelementptr i8, i8* %this, i32 " + offset + "\n");
			String reg2 = this.newRegister(null);
			this.emit("\t" + reg2 + " = bitcast i8* " + reg1 + " to " + this.getType(type) + "*\n");
			this.emit("\tstore " + expr + ", " + this.getType(type) + "* " + reg2 + "\n");
		}

		return new String[] {varName};
	}

	/**
	 * f0 -> Identifier()
	 * f1 -> "["
	 * f2 -> Expression()
	 * f3 -> "]"
	 * f4 -> "="
	 * f5 -> Expression()
	 * f6 -> ";"
	 */
	public String[] visit(ArrayAssignmentStatement n, SymbolTableNode argu) throws Exception {
		MethodType curMethod = (MethodType) argu;

    // Read MiniJAVA file.
		String varName = n.f0.accept(this, argu)[0];
		String expr1 = n.f2.accept(this, argu)[0];
		String expr2 = n.f5.accept(this, argu)[0];

		String reg1, reg2;
		String type = curMethod.getLocalVariableType(varName);
		if (type != null) {
      reg1 = this.newRegister(null);
			this.emit("\t" + reg1 + " = load " + this.getType(type) + ", " + this.getType(type) + "* %" + varName + "\n");
		} else {
			ClassType curClass = curMethod.getMethodClass();
			type = curClass.getFieldType(varName);
			int offset = curClass.getField(varName).getOffset() + 8;

      reg1 = this.newRegister(null);
			this.emit("\t" + reg1 + " = getelementptr i8, i8* %this, i32 " + offset + "\n");

			reg2 = this.newRegister(null);
			this.emit("\t" + reg2 + " = bitcast i8* " + reg1 + " to " + this.getType(type) + "*\n");

			reg1 = this.newRegister(null);
			this.emit("\t" + reg1 + " = load " + this.getType(type) + ", " + this.getType(type) + "* " + reg2 + "\n");
		}

    reg2 = this.newRegister(null);
    String reg3 = this.newRegister(null);
		String reg4 = this.newRegister(null);
    String reg5 = this.newRegister(null);
    String oobSafeLabel = this.newLabel("oob_safe");
    String oobErrorLabel = this.newLabel("oob_error");

    emit("\t" + reg2 + " = load i32, i32* " + reg1 + "\n");
    this.emit("\t" + reg3 + " = icmp sge " + expr1 + ", 0\n");
    this.emit("\t" + reg4 + " = icmp slt " + expr1 + ", " + reg2 + "\n");
    this.emit("\t" + reg5 + " = and i1 " + reg3 + ", " + reg4 + "\n");
    this.emit("\tbr i1 " + reg5 + ", label %" + oobSafeLabel + ", label %" + oobErrorLabel + "\n\n");

    this.emit(oobErrorLabel + ":\n");
    this.emit("\tcall void @throw_oob()\n");
	this.emit("\n\tbr label %" + oobSafeLabel + "\n\n");

    this.emit(oobSafeLabel + ":\n");
    reg4 = this.newRegister(null);
    reg3 = this.newRegister(null);
    this.emit("\t" + reg4 + " = add " + expr1 + ", 1\n");
    this.emit("\t" + reg3+ " = getelementptr i32, i32* " + reg1 + ", i32 " + reg4 + "\n");
    this.emit("\tstore " + expr2 + ", i32* " + reg3 + "\n\n");

		return new String[] {};
	}

	/**
	 * f0 -> "if"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> Statement()
	 * f5 -> "else"
	 * f6 -> Statement()
	 */
	public String[] visit(IfStatement n, SymbolTableNode argu) throws Exception {
		String expr = n.f2.accept(this, argu)[0];

		String ifThen = this.newLabel("if_then");
		String ifElse = this.newLabel("if_else");
		String ifEnd = this.newLabel("if_end");

		this.emit("\tbr " + expr + ", label %" + ifThen + ", label %" + ifElse + "\n\n");

    this.emit(ifThen + ":\n");
    n.f4.accept(this, argu);
		this.emit("\n\tbr label %" + ifEnd + "\n\n");

    this.emit(ifElse + ":\n");
		n.f6.accept(this, argu);
		this.emit("\n\tbr label %" + ifEnd + "\n\n");

    this.emit(ifEnd + ":\n");

		return new String[] {};
	}

	/**
	 * f0 -> "while"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> Statement()
	 */
	public String[] visit(WhileStatement n, SymbolTableNode argu) throws Exception {
		String loopStart = this.newLabel("while_cond");
		String labelBody = this.newLabel("while_body");
		String loopEnd = this.newLabel("while_end");

		this.emit("\n\tbr label %" + loopStart + "\n\n");
		this.emit(loopStart + ":\n");
		String expr = n.f2.accept(this, argu)[0];
		this.emit("\tbr " + expr + ", label %" + labelBody + ", label %" + loopEnd + "\n\n");

    	this.emit(labelBody + ":\n");
		n.f4.accept(this, argu);
		this.emit("\n\tbr label %" + loopStart + "\n\n");

    this.emit(loopEnd + ":\n");

		return new String[] {};
	}

	/**
	 * f0 -> "System.out.println"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> ";"
	 */
	public String[] visit(PrintStatement n, SymbolTableNode argu) throws Exception {
		String expr = n.f2.accept(this, argu)[0];
		this.emit("\tcall void (i32) @print_int(" + expr + ")\n");
		return new String[] {};
	}

	/**
	 * f0 -> AndExpression()
	 *       | CompareExpression()
	 *       | PlusExpression()
	 *       | MinusExpression()
	 *       | TimesExpression()
	 *       | ArrayLookup()
	 *       | ArrayLength()
	 *       | MessageSend()
	 *       | Clause()
	 */
	public String[] visit(Expression n, SymbolTableNode argu) throws Exception {
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> Clause()
	 * f1 -> "&&"
	 * f2 -> Clause()
	 */
	public String[] visit(AndExpression n, SymbolTableNode argu) throws Exception {
    String clause = n.f0.accept(this, argu)[0];

    String falseLabel = this.newLabel(null);
    String trueLabel = this.newLabel(null);
    String endLabel = this.newLabel(null);
    String reg = this.newRegister(null);

    this.emit("\tbr " + clause + ", label %" + trueLabel + ", label %" + falseLabel + "\n\n");

	this.emit(trueLabel + ":\n");
	clause = n.f2.accept(this, argu)[0];
	this.emit("\tbr label %" + endLabel + "\n\n");

	this.emit(falseLabel + ":\n");
	this.emit("\tbr label %" + endLabel + "\n\n");

	this.emit(endLabel + ":\n");
	this.emit("\t" + reg + " = phi i1 [ 0, %" + falseLabel + "], [ " + clause.split(" ")[1] + ", %" + trueLabel + "]\n\n");

    return new String[] {clause};
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "<"
	 * f2 -> PrimaryExpression()
	 */
	public String[] visit(CompareExpression n, SymbolTableNode argu) throws Exception {
    String expr1 = n.f0.accept(this, argu)[0];
    String expr2 = n.f2.accept(this, argu)[0];

    String[] primExprTempReg = expr2.split(" ");
    expr2 = primExprTempReg[1];

    String reg = this.newRegister(null);
    this.emit("\t" + reg + " = icmp slt "+ expr1 + ", " + expr2+"\n");

    return  new String[] {"i1 " + reg};
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "+"
	 * f2 -> PrimaryExpression()
	 */
	public String[] visit(PlusExpression n, SymbolTableNode argu) throws Exception {
    String expr1 = n.f0.accept(this, argu)[0];
    String expr2 = n.f2.accept(this, argu)[0];

    String[] primExprTempReg = expr2.split(" ");
    expr2 = primExprTempReg[1];

    String reg = this.newRegister(null);
    this.emit("\t" + reg + " = add "+ expr1 + ", " + expr2+"\n");

    return  new String[] {"i32 " + reg};
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "-"
	 * f2 -> PrimaryExpression()
	 */
	public String[] visit(MinusExpression n, SymbolTableNode argu) throws Exception {
    String expr1 = n.f0.accept(this, argu)[0];
    String expr2 = n.f2.accept(this, argu)[0];

    String[] primExprTempReg = expr2.split(" ");
    expr2 = primExprTempReg[1];

    String reg = this.newRegister(null);
    this.emit("\t" + reg + " = sub "+ expr1 + ", " + expr2+"\n");

    return  new String[] {"i32 " + reg};
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "*"
	 * f2 -> PrimaryExpression()
	 */
	public String[] visit(TimesExpression n, SymbolTableNode argu) throws Exception {
    String expr1 = n.f0.accept(this, argu)[0];
    String expr2 = n.f2.accept(this, argu)[0];

    String[] primExprTempReg = expr2.split(" ");
    expr2 = primExprTempReg[1];

    String reg = this.newRegister(null);
    this.emit("\t" + reg + " = mul "+ expr1 + ", " + expr2+"\n");

    return new String[] {"i32 " + reg};
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "["
	 * f2 -> PrimaryExpression()
	 * f3 -> "]"
	 */
	public String[] visit(ArrayLookup n, SymbolTableNode argu) throws Exception {
    String expr1 = n.f0.accept(this, argu)[0];
    String expr2 = n.f2.accept(this, argu)[0];

    String reg1 = this.newRegister(null);
    String reg2 = this.newRegister(null);
    String obbSafeLabel = this.newLabel("oob_safe");
    String oobErrorLabel = this.newLabel("oob_error");

    String offset = "1";

    String reg3 = this.newRegister(null);
    String reg4 = this.newRegister(null);
    this.emit("\t" + reg1 + " = load i32, " + expr1 + "\n");
    this.emit("\t" + reg2 + " = icmp sge " + expr2 + ", 0\n");
    this.emit("\t" + reg3 + " = icmp slt " + expr2 + ", " + reg1 + "\n");
    this.emit("\t" + reg4 + " = and i1 " + reg2 + ", " + reg3 + "\n");
    this.emit("\tbr i1 " + reg4 + ", label %" + obbSafeLabel + ", label %" + oobErrorLabel + "\n\n");

	this.emit(oobErrorLabel + ":\n");
    this.emit("\tcall void @throw_oob()\n");
    this.emit("\tbr label %" + obbSafeLabel + "\n\n");

	this.emit(obbSafeLabel + ":\n");

    reg4 = this.newRegister(null);
    this.emit("\t" + reg4 + " = add " + expr2 + ", " + offset + "\n");

    reg3 = this.newRegister(null);
    this.emit("\t" + reg3 + " = getelementptr i32, " + expr1 + ", i32 " + reg4 + "\n");

    reg4 = this.newRegister(null);
    this.emit("\t" + reg4 + " = load i32, i32* " + reg3 +"\n");

    return new String[] {"i32 " + reg4, "int"};
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> "length"
	 */
	public String[] visit(ArrayLength n, SymbolTableNode argu) throws Exception {
		String expr = n.f0.accept(this, argu)[0];

		String reg = this.newRegister(null);
		this.emit("\t" + reg + " = load i32, " + expr);
		return new String[] {"i32 " + reg};
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> Identifier()
	 * f3 -> "("
	 * f4 -> ( ExpressionList() )?
	 * f5 -> ")"
	 */
	public String[] visit(MessageSend n, SymbolTableNode argu) throws Exception {
    MethodType curMethod = (MethodType) argu;
		String[] expr = n.f0.accept(this, argu);
		String methodName = n.f2.accept(this, argu)[0];

    String className = expr[1];
		ClassType callClass = SymbolTable.getClass(className);
    if (callClass == null) {
      VariableType curVariable = curMethod.getLocalVariable(className);
      if (curVariable != null) {
        className = curVariable.getType();
        callClass = SymbolTable.getClass(className);
      } else {
      curVariable = curMethod.getMethodClass().getField(className);
      className = curVariable.getType();
      callClass = SymbolTable.getClass(className);
      }
    }
		MethodType callMethod = callClass.getMethod(methodName);

		String type = callMethod.getReturnType();
		int methodOffset = callClass.getMethodIndex(methodName);

		String reg1 = this.newRegister(null);
		String reg2 = this.newRegister(null);
		this.emit("\t; " + className + "." + methodName + " : " + methodOffset + "\n");
		this.emit("\t" + reg1 + " = bitcast " + expr[0] + " to i8***\n");
		this.emit("\t" + reg2 + " = load i8**, i8*** " + reg1 + "\n");
		reg1 = this.newRegister(null);
		this.emit("\t" + reg1 + " = getelementptr i8*, i8** " + reg2 + ", i32 " + methodOffset + "\n");
		reg2 = this.newRegister(null);
		this.emit("\t" + reg2 + " = load i8*, i8** " + reg1 + "\n");
		reg1 = this.newRegister(null);
		this.emit("\t" + reg1 + " = bitcast i8* " + reg2 + " to " + this.getType(type) + " (i8*");
		for (int i = 0; i < callMethod.getArgumentsCount(); i++) {
			this.emit(", " + this.getType(callMethod.getArgument(i).getType()));
		}
		this.emit(")*\n");

		reg2 = this.newRegister(null);
		if (n.f4.present()) {
			String argsList = n.f4.accept(this, argu)[0];
			emit("\t" + reg2 + " = call " + this.getType(type) + " " + reg1 + "(" + expr[0] + ", " + argsList + ")\n");
		} else {
			emit("\t" + reg2 + " = call " + this.getType(type) + " " + reg1 + "(" + expr[0] + ")\n");
		}
		return new String[] {this.getType(type) + " " + reg2, type};
	}

	/**
	 * f0 -> Expression()
	 * f1 -> ExpressionTail()
	 */
	public String[] visit(ExpressionList n, SymbolTableNode argu) throws Exception {
		String expr = n.f0.accept(this, argu)[0];
		String exprTail = n.f1.accept(this, argu)[0];
		return new String[] {expr + exprTail};
	}

	/**
	 * f0 -> ( ExpressionTerm() )*
	 */
	public String[] visit(ExpressionTail n, SymbolTableNode argu) throws Exception {
		String args = "";
		for (int i = 0; i < n.f0.size(); i++) {
			args += n.f0.elementAt(i).accept(this, argu)[0];
		}
		return new String[] {args};
	}

	/**
	 * f0 -> ","
	 * f1 -> Expression()
	 */
	public String[] visit(ExpressionTerm n, SymbolTableNode argu) throws Exception {
		String[] expr = n.f1.accept(this, argu);
    expr[0] = ", " + expr[0];
		return expr;
	}

	/**
	 * f0 -> NotExpression()
	 *       | PrimaryExpression()
	 */
	public String[] visit(Clause n, SymbolTableNode argu) throws Exception {
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> IntegerLiteral()
	 *       | TrueLiteral()
	 *       | FalseLiteral()
	 *       | Identifier()
	 *       | ThisExpression()
	 *       | ArrayAllocationExpression()
	 *       | AllocationExpression()
	 *       | BracketExpression()
	 */
	public String[] visit(PrimaryExpression n, SymbolTableNode argu) throws Exception {
		 MethodType curMethod = (MethodType) argu;

     String[] expr = n.f0.accept(this, argu);

		 if (!expr[0].contains(" ")) {
		   String type = curMethod.getLocalVariableType(expr[0]);
		   if (type != null) {
		     String reg = this.newRegister(null);
		     this.emit("\t" + reg + " = load " + this.getType(type) + ", " + this.getType(type) + "* %" + expr[0] + "\n");

         	 expr[0] = this.getType(type) + " " + reg;
		   } else {
		     type = curMethod.getMethodClass().getFieldType(expr[0]);
		     if (type != null) {
		       String reg1 = this.newRegister(null);
		       String reg2 = this.newRegister(null);
		       String reg3 = this.newRegister(null);

		       ClassType curClass = curMethod.getMethodClass();
		       int vTableSize = 8;
		    //    for (int i=0; i < curClass.getFieldsCount(); i ++) {
			// 	 if (curClass.getField(i).getName().equals(expr[0])) {
			// 	   break;
			// 	 }
		    //      vTableSize += curClass.getField(i).getSize();
		    //    }
			   int offset = curClass.getField(expr[0]).getOffset() + 8;
			   this.emit("\t"+ reg1 + " = getelementptr i8, i8* %this, i32 " + offset + "\n");
		       this.emit("\t" + reg2 + " = bitcast i8* " + reg1 + " to " + this.getType(type) + "*\n");
		       this.emit("\t" + reg3 + " = load " + this.getType(type) +", " + this.getType(type) + "* "+ reg2 + "\n");
		       expr[0] = this.getType(type) + " " + reg3;
		     }
		   }
		 }
     return expr;
	}

	/**
	 * f0 -> <INTEGER_LITERAL>
	 */
	public String[] visit(IntegerLiteral n, SymbolTableNode argu) throws Exception {
		return new String[] {"i32 " + n.f0.toString(), n.f0.toString()};
	}

	/**
	 * f0 -> "true"
	 */
	public String[] visit(TrueLiteral n, SymbolTableNode argu) throws Exception {
		return new String[] {"i1 1", "true"};
	}

	/**
	 * f0 -> "false"
	 */
	public String[] visit(FalseLiteral n, SymbolTableNode argu) throws Exception {
		return new String[] {"i1 0", "false"};
	}

	/**
	 * f0 -> <IDENTIFIER>
	 */
	public String[] visit(Identifier n, SymbolTableNode argu) throws Exception {
    String identifier = n.f0.toString();
		return new String[] {identifier, identifier};
	}

	/**
	 * f0 -> "this"
	 */
	public String[] visit(ThisExpression n, SymbolTableNode argu) throws Exception {
		 MethodType curMethod = (MethodType) argu;
     return new String[] {"i8* %" + n.f0.toString(), curMethod.getMethodClass().getName()};
	}

	/**
	 * f0 -> "new"
	 * f1 -> "int"
	 * f2 -> "["
	 * f3 -> Expression()
	 * f4 -> "]"
	 */
	public String[] visit(ArrayAllocationExpression n, SymbolTableNode argu) throws Exception {
		String expr = n.f3.accept(this, argu)[0];
		String regName = expr.split(" ")[1];
		String reg1 = this.newRegister(null);
		String reg2 = this.newRegister(null);

    String obbSafeLabel = this.newLabel("oob_safe");
    String oobErrorLabel = this.newLabel("oob_error");

    this.emit("\t" + reg1 + " = add i32 1, " + regName + "\n");
    this.emit("\t" + reg2 + " = icmp sge i32 " + reg1 + ", 1\n" );
    this.emit("\tbr i1 " + reg2 + ", label %" + obbSafeLabel + ", label %" + oobErrorLabel + "\n\n");

    this.emit(oobErrorLabel + ":\n");
    this.emit("\tcall void @throw_oob()\n");
	this.emit("\n\tbr label %" + obbSafeLabel + "\n\n");

	reg1 = this.newRegister(null);
	reg2 = this.newRegister(null);
	String reg3 = this.newRegister(null);
	this.emit(obbSafeLabel + ":\n");
	this.emit("\t" + reg1 + " = add i32 1, " + regName + "\n");
	this.emit("\t" + reg2 + " = call i8* @calloc(i32 " + reg1 + " , i32 4)\n");
	this.emit("\t" + reg3 + " = bitcast i8* " + reg2 + " to i32*\n");
	this.emit("\tstore " + expr + ", i32* " + reg3 + "\n\n");

    String[] resp = new String[2];
    resp[0] = "i32* " + reg3;
    resp[1] = "int";
		return resp;
	}

	/**
	 * f0 -> "new"
	 * f1 -> Identifier()
	 * f2 -> "("
	 * f3 -> ")"
	 */
	public String[] visit(AllocationExpression n, SymbolTableNode argu) throws Exception {
		String className = n.f1.accept(this, argu)[0];
		ClassType curClass = SymbolTable.getClass(className);
		String reg1 = this.newRegister(null);
		String reg2 = this.newRegister(null);
		String reg3 = this.newRegister(null);

		int vTableSize = 8 + curClass.getSuperFieldsSize();

		this.emit("\t" + reg1 + " = call i8* @calloc(i32 1, i32 " + vTableSize + ")\n");
		this.emit("\t" + reg2 + " = bitcast i8* " + reg1 + " to i8***\n");

		this.emit("\t" + reg3 + " = getelementptr [" + curClass.getSuperMethodsCount() + " x i8*], [" + curClass.getSuperMethodsCount() + " x i8*]* @." + className + "_vtable, i32 0, i32 0\n");
		this.emit("\tstore i8** " + reg3 + ", i8*** " + reg2 + "\n");

    String[] resp = new String[2];
    resp[0] = "i8* " + reg1;
    resp[1] = className;
		return resp;
	}

	/**
	 * f0 -> "!"
	 * f1 -> Clause()
	 */
	public String[] visit(NotExpression n, SymbolTableNode argu) throws Exception {
		n.f0.accept(this, argu);
		String[] clause = n.f1.accept(this, argu);
		String reg = this.newRegister(null);
		this.emit("\t" + reg + " = xor i1 1, " + clause[0].split(" ")[1] + "\n");

    String[] resp = new String[2];
    resp[0] = "i1 " + reg;
    if (clause.length > 1) {
      resp[1] = clause[1];
    }
		return resp;
	}

	/**
	 * f0 -> "("
	 * f1 -> Expression()
	 * f2 -> ")"
	 */
	public String[] visit(BracketExpression n, SymbolTableNode argu) throws Exception {
		return  n.f1.accept(this, argu);
	}

}