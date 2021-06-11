/* Created by Dionysios Taxiarchis Balaskas - 1115201700094 */

package symbolTable;

import java.util.LinkedHashMap;
import java.util.Map;

// SymbolTable will be used as static!
public class SymbolTable {
    // FIELDS
    public static LinkedHashMap<String, ClassType> classes = new LinkedHashMap<>();

    // METHODS
    public static void addClass(ClassType newClass) {
        // Adds a class with name <newClass> in symbol table.
        String className = newClass.getName();
        if (isValidClass(className)) {
            classes.put(className, newClass);
        } else {
            throw new RuntimeException("Class " + className + " already exists");
        }
    }

    public static boolean isValidClass(String className){
        // Check if already exists a class with name <className>.
        for (Map.Entry<String, ClassType> entry : classes.entrySet()) {
            if (entry.getKey().equals(className)) return false;
        }
        return true;
    }

    public static Boolean isValidAssignment(String var1, String var2) {
        // Checks if an assignment of var2 to var1 is valid.
        return var1.equals(var2) || hasSuperClass(var2, var1);
    }

    public static ClassType getClass(String className) {
        // Returns the class with name <className>.
        for (Map.Entry<String, ClassType> entry : classes.entrySet()) {
            if (entry.getKey().equals(className)) return (ClassType) entry.getValue();
        }
        return null;
    }

    public static String getMainClass() {
        // Returns the class with the main method.
        for (Map.Entry<String, ClassType> entry : classes.entrySet()) {
            if (((ClassType) entry.getValue()).isMain()) return entry.getValue().getName();
        }
        return null;
    }

    public static boolean hasSuperClass(String className, String superClassName) {
        // Checks if class with name <className> has a superclass with name <superClassName>.
        ClassType curClass = getClass(className);
        return curClass != null && curClass.hasSuperClass(superClassName);
    }

    public static boolean hasSuperClass(String className) {
        // Checks if class with name <className> has a superclass.
        ClassType curClass = getClass(className);
        return curClass != null && curClass.hasSuperClass();
    }

    public static boolean isPrimitiveType(String typeName){
        // Checks if <typeName> represents a primitive type.
        if (typeName.equals("int")) return true;
        if (typeName.equals("boolean")) return true;
        if (typeName.equals("int[]")) return true;
        return false;
    }

    public static void clear() {
        // Clears symbol table.
        classes.clear();
    }

    // PRINT METHODS
    public static void print() {
        classes.forEach( (key,value)-> ((ClassType) value).print() );
    }
}