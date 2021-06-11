/* Created by Dionysios Taxiarchis Balaskas - 1115201700094 */

package symbolTable;

// Primitive Data Types: 
//   1.  INT
//   2.  BOOLEAN
//   3.  INT_ARRAY
//   4.  POINTER

public class VariableType extends SymbolTableNode {
    // FIELDS
    private String name;
    private String type;
    private int offset;
    private int size;

    // GETTERS
    public String getName() {
        return this.name;
    }
    public String getType() {
        return this.type;
    }
    public int getOffset() {
        return this.offset;
    }
    public int getSize() {
        return this.size;
    }

    // CONSTRUCTOR
    public VariableType(String _name, String _type) {
        this.name = _name;
        this.type = _type;
        this.offset = -1;
        // SET SIZE
        if (this.type.equals("int")) {                      // INT
            this.size = 4;
        } else if (this.type.equals("boolean")) {           // BOOLEAN
            this.size = 1;
        } else if (this.type.equals("int[]")) {             // INT_ARRAY
            this.size = 8;
        } else {                                            // POINTER
            this.size = 8;
        }
    }

    // METHODS
    public void setOffset(int _offset) {
        // Sets offset.
        this.offset = _offset;
    }

    // PRINT METHODS
    public void print() {
        System.out.print(this.name + "." + this.offset);
    }
}