# Compilers - Third Project
## MiniJava Static Checking (Semantic Analysis)

## Created by Dionysios Taxiarchis Balaskas - 1115201700094


#### Compile project with: 
**cd ./src**
**make compile / make**

#### Run semantic analysis on files with: 
**java Main <file1> <file2> ...**

#### Clean project:
**make clean**

### Project info:
For the project's requirements are created two custom packages.
1. **db_visitor**: Package with the used visitor classes. (SymbolTableFillerVisitor, TypeCheckerVisitor and CodeGenVisitor)
1. **symbolTable**: Package that handles symbols table. (SymbolTable class and other subclasses for better abstractiveness of the implementation).

Each package is under the directory with the same name. Implementation is based on the lectures, and the tutorials on course's site. Also created the Main.java file based on the tutorials too.

I tested the implementation with many test cases from the provided examples and the programs from piazza. My goal was to minimize as much as possible the possibility to appear a bug in unsuspecting time. 

### **package symbolTable**
1. **VariableType**: Class to represent variables in the visitor. (Primitive types or pointer)
1. **MethodType**: Class to represent the methods in the visitor.
1. **ClassType**: Class to represent the classes in the visitor.
1. **SymbolTableNode**: It's an abstract class without fields or methods. This class created to be used as argument in visit methods of visitors. Inside these methods it is decided if the instance will be read as a MethodType or ClassType.
1. **SymbolTable**: Class to represent the symbol table. It contains only one static field 'classes' and is a HashTable with the existed classes. All its methods are static for easier use between the visit methods. It contains methods to manage the declared classes.

### **3rd Part - Code Generation**
I created a new visitor that parses the MiniJAVA program and convert it to LLVM-IR.
It extends GJDepthFirst, like the other visitors from 2nd part. Also there are some helper methods too.

Added some extra methods in order to help development and increase the abstractiveness.

1. **private void emit(String code):** writes to LLVM file.
1. **private void resetCounters():** reset register and label counters, after each method.
1. **private String newRegister(String name):** initialize a new register by using the registerCounter and after that it increases it by 1.
1. **private String newLabel(String name):** initialize a new label by using the labelCounter and after that it increases it by 1.
1. **private String getType(String type):** returns a string with the LLVM type of the given MiniJAVA type.
1. **private void defineHelperMethods():** Writes the helper methods to LLVM file.
1. **private void defineHelperMethods():** Writes the helper methods to LLVM file.
1. **private void setVTables():** Set the VTables of the classes.

Also I added some classes to the existed symbolTable's classes in order to match to the needs of the code generation.

For example, in ClassType added:
1. **public List<MethodType> getSuperMethods():** Returns a list with all the methods that the class may use. Including the superclass's methods. Used it mainly in Vtables.
1. **public int getMethodIndex(String methodName):** Returns the index in the returned list of the last method.
1. **public int getSuperMethodsCount():** Returns the number of all the methods that are accessible from class.
1. **public int getSuperFieldsSize():** Returns the sum of all the classe's fields sizes.
1. **Added getters based on the index in the corresponding list and not only based on the name of the element**