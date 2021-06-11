/* Created by Dionysios Taxiarchis Balaskas - 1115201700094 */

package symbolTable;

import java.util.ArrayList;
import java.util.List;

public class ClassType extends SymbolTableNode {
    // FIELDS
    private ClassType superClass;
    private String className;
    private List<VariableType> fields;
    private List<MethodType> methods;
    private int methodOffset;
    private int fieldOffset;

    // GETTERS
    public String getName() {
        return this.className;
    }
    public ClassType getSuperClass() {
        return this.superClass;
    }
    public List<VariableType> getFields() {
        return this.fields;
    }
    public List<MethodType> getMethods() {
        return this.methods;
    }
    public int getFieldsCount() {
        return this.fields.size();
    }
    public int getMethodsCount() {
        return this.methods.size();
    }
    
    // CONSTRUCTOR
    public ClassType(String _className) {
        this.superClass = null;
        this.methodOffset = 0;
        this.fieldOffset = 0;
        this.className = _className;
        this.fields = new ArrayList<VariableType>();
        this.methods = new ArrayList<MethodType>();
    }
    
    // METHODS
    public void setSuperClass(ClassType superClass) {
        // Sets super class.
        this.superClass = superClass;
        this.methodOffset = superClass.methodOffset;
        this.fieldOffset  = superClass.fieldOffset;
    }

    public void addMethod(MethodType method) {
        // Adds <method> in Methods list.
        if (this.isValidMethod(method)) {
            if (!method.isMain() && !this.overridesMethod(method)) {
                method.setOffset(this.methodOffset);
                this.methodOffset += method.getSize();
            }
            // } else if (!method.isMain()) {
            //     MethodType overridedMethod = this.getMethod(method.getName());
            //     method.setOffset(overridedMethod.getOffset());
            //     overridedMethod.setOffset(-1);
            // }
            this.methods.add(method);
        } else {
            throw new RuntimeException("Exception in "+this.className+": Error: method overloading: method '" + method.getName() + "' already exists with different arguments or/and return type.");
        }
    }

    public void addField(VariableType field) {
        // Adds <field> in Fields list.
        if (this.isValidField(field.getName())) {
            this.fields.add(field);
            // if (!method.isMain() && !this.overridesMethod(method)) {
            // }
            field.setOffset(this.fieldOffset);
            this.fieldOffset += field.getSize();
        } else {
            throw new RuntimeException("Exception in "+this.className+": Error: duplicated field declaration: Field '"+this.className+"."+field.getName()+"' already exists.");
        }
    }

    public boolean isValidMethod(MethodType method) {
        // Checks if already exists a method with name <fieldName>, if it does check if the new method overloads the old one.
        for (int i=0; i<this.getMethodsCount(); i++) {
            if (method.getName().equals(this.methods.get(i).getName())) return false;
        }
        if (this.superClass != null) return !this.superClass.overloadsMethod(method);
        return true;
    }

    public boolean overloadsMethod(MethodType method) {
        // Checks if the method on arguments overloads in class.
        for (int i=0; i<this.getMethodsCount(); i++) {
            if (method.overloads(this.methods.get(i))) return true;
        }
        if (this.superClass != null) return this.superClass.overloadsMethod(method);
        return false;
    }

    public boolean overridesMethod(MethodType method) {
        // Checks if the method on arguments overrides in class.
        for (int i=0; i<this.getMethodsCount(); i++) {
            if (method.overrides(this.methods.get(i))) return true;
        }
        if (this.superClass != null) return this.superClass.overridesMethod(method);
        return false;
    }

    private boolean isValidField(String fieldName) {
        // Check if already exists a field with name <fieldName>.
        for (int i=0;i<this.getFieldsCount();i++) {
            if (this.fields.get(i).getName().equals(fieldName))return false;
        }
        return true;
    }

    public MethodType getMethod(String methodName) {
        // Returns method with name: <methodName> if exists. Else returns null.
        // Firstly search method in class.
        for (int i=0; i < this.getMethodsCount(); i++) {
            if (this.methods.get(i).getName().equals(methodName)) return this.methods.get(i);
        }
        // At this point method was not found in class. Search in super class if exists.
        if (this.superClass != null) return this.superClass.getMethod(methodName);
        return null;
    }

    public MethodType getMethod(int methodIndex) {
        // Returns method at index : <methodIndex> if exists. Else returns null.
        if (methodIndex >= this.getMethodsCount()) {
            return null;
        }
        return this.methods.get(methodIndex);
    }

    public VariableType getField(String fieldName){
        // Returns field with name: <fieldName> if exists. Else returns null.
        // Firstly search field in class.
        for (int i=0; i < this.getFieldsCount(); i++) {
            if (this.fields.get(i).getName().equals(fieldName)) return this.fields.get(i);
        }
        // At this point field was not found in class. Search in super class if exists.
        if (this.superClass != null) return this.superClass.getField(fieldName);
        return null;
    }

    public VariableType getField(int fieldIndex) {
        // Returns field at index : <fieldIndex> if exists. Else returns null.
        if (fieldIndex >= this.getFieldsCount()) {
            return null;
        }
        return this.fields.get(fieldIndex);
    }

    public String getFieldType(String fieldName){
        VariableType field = this.getField(fieldName);
        if (field != null) {
            return field.getType();
        }
        return null;
    }

    public boolean hasSuperClass(String superClassName) {
        // Checks if class has a super class with name <superClassName>.
        if (this.superClass == null) return false;
        if (this.superClass.getName().equals(superClassName)) return true;
        return this.superClass.hasSuperClass(superClassName);
    }
    
    public boolean hasSuperClass() {
        // Checks if class has a super class.
        return this.superClass != null;
    }
    
    public boolean isMain() {
        // Checks if class contains the main method.
        MethodType main = this.getMethod("main");
        return (main != null && main.isMain());
    }

    // PRINT METHODS
    public void print() {
        System.out.println("----- Class " + this.className + " -----");
        System.out.println("--- Fields ---");
        for (int i=0; i < this.getFieldsCount(); i++) {
            System.out.println(this.className + "." + this.fields.get(i).getName() + ": " + this.fields.get(i).getOffset());
        }
        System.out.println("--- Methods ---");
        for (int i=0; i < this.getMethodsCount(); i++) {
            if (!this.methods.get(i).isMain() && this.methods.get(i).getOffset() != -1)
                System.out.println(this.className + "." + this.methods.get(i).getName() + ": " + this.methods.get(i).getOffset());
        }
        System.out.println();
    }
}
