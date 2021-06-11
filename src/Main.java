/* Created by Dionysios Taxiarchis Balaskas - 1115201700094 */

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
// import java.nio.file.*;

import syntaxtree.Goal;
import db_visitor.*;
import symbolTable.SymbolTable;

public class Main {
    public static void main(String[] args) throws Exception {
        if(args.length == 0){
            System.err.println("Usage: java Main <inputFile1> <inputFile2> ...");
            System.exit(1);
        }

        System.err.println("Created by Dionysis Balaskas!");

        FileInputStream fis = null;
        String fileName = null;
        for (int i = 0; i < args.length; i++) {
            try {
                // Open program's file
                fis = new FileInputStream(args[i]);

                // Parsing
                // ----------------------------------
                // Parse the program.
                MiniJavaParser parser = new MiniJavaParser(fis);
                // Print file's name
                // System.out.println("_________________________________________________________________");
                // System.out.println("MiniJava file \""+args[i]+"\" parsed successfully.\n");

                
                // Semantic Analysis
                // ----------------------------------
                // Initialize root for semantic analysis
                Goal root = parser.Goal();
                // Fill the symbol table.
                SymbolTableFillerVisitor symbolTableFillerVisitor = new SymbolTableFillerVisitor();
                root.accept(symbolTableFillerVisitor, null);
                // Implement type checking.
                TypeCheckerVisitor typeCheckerVisitor = new TypeCheckerVisitor();
                root.accept(typeCheckerVisitor, null);

                // !Old project 2.
                // // Print results
                // // ----------------------------------
                // SymbolTable.print();

                // 3rd homework
                // ----------------------------------
                // Implement code generation.
            fileName = args[i].split("\\.java")[0];
            CodeGenVisitor codeGenVisitor = new CodeGenVisitor(fileName);
                root.accept(codeGenVisitor, null);
            }
            catch (ParseException ex) {
                System.out.println(ex.getMessage());
            }
            catch (FileNotFoundException ex) {
                System.err.println(ex.getMessage());
            }
            finally {
                try {
                    if (fis != null) {
                        // Clear SymbolTable for the next program. (if it exists)
                        SymbolTable.clear();
                        // Close program's file.
                        fis.close();
                    }
                }
                catch (IOException ex) {
                    System.err.println(ex.getMessage());
                }
            }
        }
    }
}
