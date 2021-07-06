/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.Tablespace;
/**
 *
 * @author lenovo
 */
public class Control_tablespace_table {
    String owner;
         ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<Tablespace> LayDS(){
        ArrayList<Tablespace> ds=new ArrayList<Tablespace>();
        try {
            p.Open(); 
            String query="select owner,table_name, tablespace_name from dba_tables where owner ='SYS'";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                Tablespace tmp =  new Tablespace();
                tmp.setOwner(rs.getString(1));
                tmp.setTable_name(rs.getString(2));
                tmp.setSpace_name(rs.getString(3));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
    public void TimUsers(Tablespace x)
    {
        
    }
    
}
    
