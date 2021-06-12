/* Created by Dionysios Taxiarchis Balaskas - 1115201700094 */

package symbolTable;

import java.util.ArrayList;
import java.util.List;

public class MethodType extends SymbolTableNode {
    // FIELDS
    private int offset;
    private int size = 8;
    private ClassType methodClass;
    private String methodName;
    private String returnType;
    private List<VariableType> arguments;
    private List<VariableType> variables;

    // GETTERS
    public String getName() {
        return this.methodName;
    }
    public int getOffset() {
        return this.offset;
    }
    public int getSize() {
        return this.size;
    }
    public String getReturnType() {
        return this.returnType;
    }
    public ClassType getMethodClass() {
        return this.methodClass;
    }
    public String getClassName() {
        return this.methodClass.getName();
    }
    public List<VariableType> getArguments() {
        return this.arguments;
    }
    public List<VariableType> getVariables() {
        return this.variables;
    }
    public int getArgumentsCount() {
        return this.arguments.size();
    }
    public int getVariablesCount() {
        return this.variables.size();
    }

    // CONSTRUCTOR
    public MethodType(String _methodName, String _returnType, ClassType _methodClass) {
        this.methodName = _methodName;
        this.returnType = _returnType;
        this.methodClass  = _methodClass;
        this.offset = -1;
        this.arguments  = new ArrayList<VariableType>();
        this.variables  = new ArrayList<VariableType>();
    }

    // METHODS
    public void setOffset(int _offset) {
        // Sets offset.
        this.offset = _offset;
    }

    private boolean isValidArgument(VariableType arg) {
        // Checks if <arg> exists in Arguments lists.
        for (int i=0; i < this.getArgumentsCount(); i++) {
            if (this.arguments.get(i).getName().equals(arg.getName())) return false;
        }
        return true;
    }
    
    public VariableType getArgument(String argName) {
        // Returns value of Argument with name: <argName> if exists. Else returns null.
        for (int i=0; i < this.getArgumentsCount(); i++) {
            if (this.arguments.get(i).getName().equals(argName)) return this.arguments.get(i);
        }
        return null;
    }

    public VariableType getArgument(int argIndex) {
        // Returns value of Argument at index: <argIndex> if exists. Else returns null.
        if (argIndex >= this.getArgumentsCount()) {
            return null;
        }
        return this.arguments.get(argIndex);
    }

    public String getArgumentType(String argumentName){
        VariableType argument = this.getArgument(argumentName);
        if (argument != null) {
            return argument.getType();
        }
        return null;
    }
    
    public void addArgument(VariableType arg) {
        // Adds <arg> in Arguments list
        if (this.isValidArgument(arg)) {
            this.arguments.add(arg);
        } else {
            throw new RuntimeException("Exception in "+this.methodClass.getName()+"."+this.methodName+": Error: duplicated argument declaration: argument '"+arg.getName()+"' already exists.");
        }
    }
    
    private boolean isValidVariable(VariableType var) {
        // Checks if <var> exists in Arguments or Variables lists.
        for (int i=0; i < this.getVariablesCount(); i++) {
            if (this.variables.get(i).getName().equals(var.getName())) return false;
        }
        return true;
    }
    
    public VariableType getVariable(String varName) {
        // Returns value of Variables with name: <varName> if exists. Else returns null.
        // Firstly search variable in method's variables.
        for (int i = 0; i < this.getVariablesCount(); i++) {
            if (this.variables.get(i).getName().equals(varName)) return this.variables.get(i);
        }
        if (this.isMain()) return null;
        // Secondly search variable in method's arguments, if method is not the main.
        for (int i = 0; i < this.getArgumentsCount(); i++) {
            if (this.arguments.get(i).getName().equals(varName)) return this.arguments.get(i);
        }
        // Thirdly search variable in class' fields.
        return methodClass.getField(varName);
    }

    public VariableType getLocalVariable(String varName) {
        // Returns value of Variables with name: <varName> if exists. Else returns null.
        // Firstly search variable in method's variables.
        for (int i = 0; i < this.getVariablesCount(); i++) {
            if (this.variables.get(i).getName().equals(varName)) return this.variables.get(i);
        }
        if (this.isMain()) return null;
        // Secondly search variable in method's arguments, if method is not the main.
        for (int i = 0; i < this.getArgumentsCount(); i++) {
            if (this.arguments.get(i).getName().equals(varName)) return this.arguments.get(i);
        }
        return null;
    }

    public String getVariableType(String variableName){
        VariableType variable = this.getVariable(variableName);
        if (variable != null) {
            return variable.getType();
        }
        return null;
    }

    public String getLocalVariableType(String variableName){
        VariableType variable = this.getLocalVariable(variableName);
        if (variable != null) {
            return variable.getType();
        }
        return null;
    }
    
    public void addVariable(VariableType var) {
        // Adds <var> in Variables list.
        if (this.isValidVariable(var) && this.isValidArgument(var)) {
            this.variables.add(var);
        } else {
            throw new RuntimeException("Exception in "+this.methodClass.getName()+"."+this.methodName+": Error: duplicated variable declaration: variable '"+var.getName()+"' already exists.");
        }
    }

    public boolean overloads(MethodType method) {
        // Checks if method overload <method>.
        List<VariableType> args = method.arguments;
        if (!method.getName().equals(this.methodName)) return false;
        if (method.getArgumentsCount() != this.getArgumentsCount() || !method.getReturnType().equals(this.getReturnType())) return true;
        for (int i=0; i < args.size(); i++) {
            if (args.get(i).getType() != this.arguments.get(i).getType()) return true;
        }
        return false;
    }

    public boolean overrides(MethodType method) {
        // Checks if method overrides <method>.
        List<VariableType> args = method.arguments;
        if (!method.getName().equals(this.methodName)
            || method.getArgumentsCount() != this.getArgumentsCount() 
            || !method.getReturnType().equals(this.getReturnType())) return false;
        for (int i=0; i < args.size(); i++) {
            if (args.get(i).getType() != this.arguments.get(i).getType()) return false;
        }
        return true;
    }

    public boolean isMain() {
        // Checks if method is main.
        return this.methodName == "main" && this.getArgumentsCount() == 1 && this.returnType == "void";
    }

    public boolean areValidArgs(String args) {
        // Checks if <args> (list of args as string) matches the method's arguments.
        if (args != null) {
            String[] argTypes = args.split(", ");
            if (this.arguments.size() != argTypes.length) return false;
            for (int i=0; i < argTypes.length; i++) {
                if (!SymbolTable.isValidAssignment(this.arguments.get(i).getType(), argTypes[i])) return false;
            }
            return true;
        }
        return this.arguments.size() == 0;
    }

    // PRINT METHODS
    public void print() {
        for (int i=0; i < this.getArgumentsCount(); i++) {
            System.out.println(this.methodClass.getName() + "." + this.methodName + "." + this.arguments.get(i).getName() + 
                ": " + this.arguments.get(i).getOffset());
        }
        for (int i=0; i < this.getVariablesCount(); i++) {
            System.out.println(this.methodClass.getName() + "." + this.methodName + "." + this.variables.get(i).getName() + 
                ": " + this.variables.get(i).getOffset());
        }
    }
}