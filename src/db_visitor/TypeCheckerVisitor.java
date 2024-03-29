/* Created by Dionysios Taxiarchis Balaskas - 1115201700094 */

package db_visitor;

import syntaxtree.*;
import visitor.GJDepthFirst;

import symbolTable.*;

public class TypeCheckerVisitor extends GJDepthFirst<String, SymbolTableNode> {
      /**
       * f0 -> MainClass()
       * f1 -> ( TypeDeclaration() )*
       * f2 -> <EOF>
       */
      public String visit(Goal n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         n.f0.accept(this, argu);
         n.f1.accept(this, argu);
         n.f2.accept(this, argu);
         return _ret;
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
      public String visit(MainClass n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String className = n.f1.accept(this, argu);
         ClassType mainClass = SymbolTable.getClass(className);
         if(n.f15.present()) {
            n.f15.accept(this, mainClass.getMethod("main"));
         }
         return _ret;
      }
   
      /**
       * f0 -> ClassDeclaration()
       *       | ClassExtendsDeclaration()
       */
      public String visit(TypeDeclaration n, SymbolTableNode argu) throws Exception {
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
      public String visit(ClassDeclaration n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String className = n.f1.accept(this, argu);
         ClassType curClass = SymbolTable.getClass(className);
         if(n.f4.present()) {
            n.f4.accept(this, curClass);
         }
         return _ret;
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
      public String visit(ClassExtendsDeclaration n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String className = n.f1.accept(this, argu);
         ClassType curClass = SymbolTable.getClass(className);
         if(n.f6.present()) {
            n.f6.accept(this, curClass);
         }
         return _ret;
      }
   
      /**
       * f0 -> Type()
       * f1 -> Identifier()
       * f2 -> ";"
       */
      public String visit(VarDeclaration n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         n.f0.accept(this, argu);
         n.f1.accept(this, argu);
         n.f2.accept(this, argu);
         return _ret;
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
      public String visit(MethodDeclaration n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String methodName = n.f2.accept(this, argu);
         MethodType method = ((ClassType) argu).getMethod(methodName);
         if(n.f8.present()) {
            n.f8.accept(this, method);
         }
         String exprType = n.f10.accept(this, method);
         if (!SymbolTable.isValidAssignment(method.getReturnType(), exprType)) {
            throw new RuntimeException("Exception in "+method.getClassName()+"."+method.getName()+": Error: incompatible types: '"+exprType+"' cannot be converted to '"+method.getReturnType()+"'.");
         }
         return _ret;
      }
   
      /**
       * f0 -> FormalParameter()
       * f1 -> FormalParameterTail()
       */
      public String visit(FormalParameterList n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         n.f0.accept(this, argu);
         n.f1.accept(this, argu);
         return _ret;
      }
   
      /**
       * f0 -> Type()
       * f1 -> Identifier()
       */
      public String visit(FormalParameter n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         n.f0.accept(this, argu);
         n.f1.accept(this, argu);
         return _ret;
      }
   
      /**
       * f0 -> ( FormalParameterTerm() )*
       */
      public String visit(FormalParameterTail n, SymbolTableNode argu) throws Exception {
         return n.f0.accept(this, argu);
      }
   
      /**
       * f0 -> ","
       * f1 -> FormalParameter()
       */
      public String visit(FormalParameterTerm n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         n.f0.accept(this, argu);
         n.f1.accept(this, argu);
         return _ret;
      }
   
      /**
       * f0 -> ArrayType()
       *       | BooleanType()
       *       | IntegerType()
       *       | Identifier()
       */
      public String visit(Type n, SymbolTableNode argu) throws Exception {
         return n.f0.accept(this, argu);
      }
   
      /**
       * f0 -> "int"
       * f1 -> "["
       * f2 -> "]"
       */
      public String visit(ArrayType n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         n.f0.accept(this, argu);
         n.f1.accept(this, argu);
         n.f2.accept(this, argu);
         return _ret;
      }
   
      /**
       * f0 -> "boolean"
       */
      public String visit(BooleanType n, SymbolTableNode argu) throws Exception {
         return n.f0.accept(this, argu);
      }
   
      /**
       * f0 -> "int"
       */
      public String visit(IntegerType n, SymbolTableNode argu) throws Exception {
         return n.f0.accept(this, argu);
      }
   
      /**
       * f0 -> Block()
       *       | AssignmentStatement()
       *       | ArrayAssignmentStatement()
       *       | IfStatement()
       *       | WhileStatement()
       *       | PrintStatement()
       */
      public String visit(Statement n, SymbolTableNode argu) throws Exception {
         return n.f0.accept(this, argu);
      }
   
      /**
       * f0 -> "{"
       * f1 -> ( Statement() )*
       * f2 -> "}"
       */
      public String visit(Block n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         n.f0.accept(this, argu);
         n.f1.accept(this, argu);
         n.f2.accept(this, argu);
         return _ret;
      }
   
      /**
       * f0 -> Identifier()
       * f1 -> "="
       * f2 -> Expression()
       * f3 -> ";"
       */
      public String visit(AssignmentStatement n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         MethodType method = (MethodType) argu;
         String varName = n.f0.accept(this, argu);
         VariableType var = method.getVariable(varName);
         if (var == null) {
            throw new RuntimeException("Exception in "+method.getClassName()+"."+method.getName()+": Error: cannot find variable: '"+varName+"'.");
         }
         String exprType = n.f2.accept(this, argu);
         if (!SymbolTable.isValidAssignment(var.getType(), exprType)) {
            throw new RuntimeException("Exception in "+method.getClassName()+"."+method.getName()+": Error: incompatible types: '"+exprType+"' cannot be converted to '"+var.getType()+"'.");
         }
         return _ret;
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
      public String visit(ArrayAssignmentStatement n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         MethodType method = (MethodType) argu;
         String varName = n.f0.accept(this, argu);
         VariableType var = method.getVariable(varName);
         if (var == null) {
            throw new RuntimeException("Exception in "+method.getClassName()+"."+method.getName()+": Error: cannot find variable: '"+varName+"'.");
         }
         if (var.getType() != "int[]") {
            throw new RuntimeException("Exception in "+method.getClassName()+"."+method.getName()+": Error: 'int[]' required, but '"+var.getType()+"' found.");
         }
         String exprType = n.f2.accept(this, argu);
         if (exprType != "int") {
            throw new RuntimeException("Exception in "+method.getClassName()+"."+method.getName()+": Error: incompatible types: '"+exprType+"' cannot be converted to 'int'.");
         }
         exprType = n.f5.accept(this, argu);
         if (exprType != "int") {
            throw new RuntimeException("Exception in "+method.getClassName()+"."+method.getName()+": Error: incompatible types: '"+exprType+"' cannot be converted to 'int'.");
         }
         return _ret;
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
      public String visit(IfStatement n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType = n.f2.accept(this, argu);
         if (exprType != "boolean") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: incompatible types: '"+exprType+"' cannot be converted to 'boolean'.");
         }
         n.f4.accept(this, argu);
         n.f6.accept(this, argu);
         return _ret;
      }
   
      /**
       * f0 -> "while"
       * f1 -> "("
       * f2 -> Expression()
       * f3 -> ")"
       * f4 -> Statement()
       */
      public String visit(WhileStatement n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType = n.f2.accept(this, argu);
         if (exprType != "boolean") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: incompatible types: '"+exprType+"' cannot be converted to 'boolean'.");
         }
         n.f4.accept(this, argu);
         return _ret;
      }
   
      /**
       * f0 -> "System.out.println"
       * f1 -> "("
       * f2 -> Expression()
       * f3 -> ")"
       * f4 -> ";"
       */
      public String visit(PrintStatement n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType = n.f2.accept(this, argu);
         if (exprType != "int") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: incompatible types: '"+exprType+"' cannot be converted to 'int'.");
         }
         return _ret;
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
      public String visit(Expression n, SymbolTableNode argu) throws Exception {
         return n.f0.accept(this, argu);
      }
   
      /**
       * f0 -> Clause()
       * f1 -> "&&"
       * f2 -> Clause()
       */
      public String visit(AndExpression n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType1 = n.f0.accept(this, argu);
         String exprType2 = n.f2.accept(this, argu);
         if (exprType1 != "boolean" || exprType2 != "boolean") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: the operator '&&' is undefined for the argument type(s) '"+exprType1+"', '"+exprType2+"'.");
         }
         return "boolean";
      }
   
      /**
       * f0 -> PrimaryExpression()
       * f1 -> "<"
       * f2 -> PrimaryExpression()
       */
      public String visit(CompareExpression n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType1 = n.f0.accept(this, argu);
         String exprType2 = n.f2.accept(this, argu);
         if (exprType1 != "int" || exprType2 != "int") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: the operator '<' is undefined for the argument type(s) '"+exprType1+"', '"+exprType2+"'.");
         }
         return "boolean";
      }
   
      /**
       * f0 -> PrimaryExpression()
       * f1 -> "+"
       * f2 -> PrimaryExpression()
       */
      public String visit(PlusExpression n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType1 = n.f0.accept(this, argu);
         String exprType2 = n.f2.accept(this, argu);
         if (exprType1 != "int" || exprType2 != "int") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: the operator '+' is undefined for the argument type(s) '"+exprType1+"', '"+exprType2+"'.");
         }
         return "int";
      }
   
      /**
       * f0 -> PrimaryExpression()
       * f1 -> "-"
       * f2 -> PrimaryExpression()
       */
      public String visit(MinusExpression n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType1 = n.f0.accept(this, argu);
         String exprType2 = n.f2.accept(this, argu);
         if (exprType1 != "int" || exprType2 != "int") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: the operator '-' is undefined for the argument type(s) '"+exprType1+"', '"+exprType2+"'.");
         }
         return "int";
      }
   
      /**
       * f0 -> PrimaryExpression()
       * f1 -> "*"
       * f2 -> PrimaryExpression()
       */
      public String visit(TimesExpression n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType1 = n.f0.accept(this, argu);
         String exprType2 = n.f2.accept(this, argu);
         if (exprType1 != "int" || exprType2 != "int") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: the operator '*' is undefined for the argument type(s) '"+exprType1+"', '"+exprType2+"'.");
         }
         return "int";
      }
   
      /**
       * f0 -> PrimaryExpression()
       * f1 -> "["
       * f2 -> PrimaryExpression()
       * f3 -> "]"
       */
      public String visit(ArrayLookup n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType = n.f0.accept(this, argu);
         if (exprType != "int[]") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: 'int[]' required, but '"+exprType+"' found.");
         }
         exprType = n.f2.accept(this, argu);
         if (exprType != "int") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: incompatible types: '"+exprType+"' cannot be converted to 'int'.");
         }
         return "int";
      }
   
      /**
       * f0 -> PrimaryExpression()
       * f1 -> "."
       * f2 -> "length"
       */
      public String visit(ArrayLength n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType = n.f0.accept(this, argu);
         if (exprType != "int[]") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: 'int[]' required, but '"+exprType+"' found.");
         }
         return "int";
      }
   
      /**
       * f0 -> PrimaryExpression()
       * f1 -> "."
       * f2 -> Identifier()
       * f3 -> "("
       * f4 -> ( ExpressionList() )?
       * f5 -> ")"
       */
      public String visit(MessageSend n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType = n.f0.accept(this, argu);
         String methodName = n.f2.accept(this, argu);
         if (SymbolTable.isPrimitiveType(exprType)) {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: cannot invoke '"+methodName+"()' on the primitive type '"+exprType+"'.");
         }
         ClassType curClass = SymbolTable.getClass(exprType);
         if (curClass == null) {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: cannot find class '"+exprType+"'.");
         }
         MethodType method = curClass.getMethod(methodName);
         if (method == null) {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: cannot find method '"+methodName+"()'.");
         }
         String args = n.f4.accept(this, argu);
         if (!method.areValidArgs(args)) {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: the method '"+methodName+"()' in the class '"+exprType+"' is not applicable for the arguments ("+args+").");
         }
         return method.getReturnType();
      }
   
      /**
       * f0 -> Expression()
       * f1 -> ExpressionTail()
       */
      public String visit(ExpressionList n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String args = n.f0.accept(this, argu) + n.f1.accept(this, argu);
         return args;
      }
   
      /**
       * f0 -> ( ExpressionTerm() )*
       */
      public String visit(ExpressionTail n, SymbolTableNode argu) throws Exception {
         String args = "";
         for(int i=0; i < n.f0.size(); i++) {
            args += n.f0.elementAt(i).accept(this, argu);
         }
         return args;
      }
   
      /**
       * f0 -> ","
       * f1 -> Expression()
       */
      public String visit(ExpressionTerm n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String args = ", " + n.f1.accept(this, argu);   
         return args;
      }
   
      /**
       * f0 -> NotExpression()
       *       | PrimaryExpression()
       */
      public String visit(Clause n, SymbolTableNode argu) throws Exception {
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
      public String visit(PrimaryExpression n, SymbolTableNode argu) throws Exception {
         if (n.f0.choice instanceof Identifier) {
            String varName = n.f0.accept(this, argu);
            VariableType var = ((MethodType) argu).getVariable(varName);
            if (var == null) {
               throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: cannot find variable '"+varName+"'.");
            }
            return var.getType();
         }
         return n.f0.accept(this, argu);
      }
   
      /**
       * f0 -> <INTEGER_LITERAL>
       */
      public String visit(IntegerLiteral n, SymbolTableNode argu) throws Exception {
         return "int";
      }
   
      /**
       * f0 -> "true"
       */
      public String visit(TrueLiteral n, SymbolTableNode argu) throws Exception {
         return "boolean";
      }
   
      /**
       * f0 -> "false"
       */
      public String visit(FalseLiteral n, SymbolTableNode argu) throws Exception {
         return "boolean";
      }
   
      /**
       * f0 -> <IDENTIFIER>
       */
      public String visit(Identifier n, SymbolTableNode argu) throws Exception {
         return n.f0.toString();
      }
   
      /**
       * f0 -> "this"
       */
      public String visit(ThisExpression n, SymbolTableNode argu) throws Exception {
         return ((MethodType) argu).getClassName();
      }
   
      /**
       * f0 -> "new"
       * f1 -> "int"
       * f2 -> "["
       * f3 -> Expression()
       * f4 -> "]"
       */
      public String visit(ArrayAllocationExpression n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType = n.f3.accept(this, argu);
         if (exprType != "int") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: incompatible types: '"+exprType+"' cannot be converted to 'int'.");
         }
         return "int[]";
      }
   
      /**
       * f0 -> "new"
       * f1 -> Identifier()
       * f2 -> "("
       * f3 -> ")"
       */
      public String visit(AllocationExpression n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String className = n.f1.accept(this, argu);
         ClassType curClass = SymbolTable.getClass(className);
         if (curClass == null) {
               throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: cannot find class '"+className+"'.");
         }
         return className;
      }
   
      /**
       * f0 -> "!"
       * f1 -> Clause()
       */
      public String visit(NotExpression n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType = n.f1.accept(this, argu);
         if (exprType != "boolean") {
            throw new RuntimeException("Exception in "+((MethodType) argu).getClassName()+"."+((MethodType) argu).getName()+": Error: the operator '!' is undefined for the argument type(s) '"+exprType+"'.");
         }
         return "boolean";
      }
   
      /**
       * f0 -> "("
       * f1 -> Expression()
       * f2 -> ")"
       */
      public String visit(BracketExpression n, SymbolTableNode argu) throws Exception {
         String _ret=null;
         String exprType = n.f1.accept(this, argu);
         return exprType;
      }
   
   }
   