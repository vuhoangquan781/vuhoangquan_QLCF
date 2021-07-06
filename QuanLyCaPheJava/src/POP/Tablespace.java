/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POP;

/**
 *
 * @author lenovo
 */
public class Tablespace {
    private String owner, table_name, space_name;

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner1) {
        owner = owner1;
    }

    public String getTable_name() {
        return table_name;
    }

    public void setTable_name(String table_name1) {
        table_name = table_name1;
    }

    public String getSpace_name() {
        return space_name;
    }

    public void setSpace_name(String space_name1) {
        space_name = space_name1;
    }
}
