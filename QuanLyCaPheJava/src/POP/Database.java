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
public class Database {
    private String DBID;
    private String Name;
    private String Crea;
    private String Reset;
    private String Log;

    public String getDBID() {
        return DBID;
    }

    public void setDBID(String DBID1) {
        DBID = DBID1;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name1) {
       Name = Name1;
    }

    public String getCrea() {
        return Crea;
    }

    public void setCrea(String Crea1) {
        Crea = Crea1;
    }

    public String getReset() {
        return Reset;
    }

    public void setReset(String Reset1) {
       Reset = Reset1;
    }

    public String getLog() {
        return Log;
    }

    public void setLog(String Log1) {
        Log = Log1;
    }
}
