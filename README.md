# Compilers - Second Project
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
1. **db_visitor**: Package with the used visitor classes. (SymbolTableFillerVisitor & TypeCheckerVisitor)
1. **symbolTable**: Package that handles symbols table. (SymbolTable class and other subclasses for better abstractiveness of the implementation).

Each package is under the directory with the same name. Implementation is based on the lectures, and the tutorials on course's site. Also created the Main.java file based on the tutorials too.

I tested the implementation with many test cases from the provided examples and the programs from piazza. My goal was to minimize as much as possible the possibility to appear a bug in unsuspecting time. 

### **package symbolTable**
1. **VariableType**: Class to represent variables in the visitor. (Primitive types or pointer)
1. **MethodType**: Class to represent the methods in the visitor.
1. **ClassType**: Class to represent the classes in the visitor.
1. **SymbolTableNode**: It's an abstract class without fields or methods. This class created to be used as argument in visit methods of visitors. Inside these methods it is decided if the instance will be read as a MethodType or ClassType.
1. **SymbolTable**: Class to represent the symbol table. It contains only one static field 'classes' and is a HashTable with the existed classes. All its methods are static for easier use between the visit methods. It contains methods to manage the declared classes.