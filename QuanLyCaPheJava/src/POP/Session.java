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
public class Session {
    private String SID;
    private String Seri;
     private String Status;
      private String Server;
       private String Schema;

    public String getSID() {
        return SID;
    }

    public void setSID(String SID1) {
        SID = SID1;
    }

    public String getSeri() {
        return Seri;
    }

    public void setSeri(String Seri1) {
        Seri = Seri1;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status1) {
        Status = Status1;
    }

    public String getServer() {
        return Server;
    }

    public void setServer(String Server1) {
        Server = Server1;
    }

    public String getSchema() {
        return Schema;
    }

    public void setSchema(String Schema1) {
      Schema = Schema1;
    }
}
