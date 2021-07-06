/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.Database;

/**
 *
 * @author lenovo
 */
public class Control_db_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<Database> LayDS(){
        ArrayList<Database> ds=new ArrayList<Database>();
        try {
            p.Open(); 
            String query="Select DBID,NAME,CREATED,RESETLOGS_TIME,LOG_MODE from v$database";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                Database tmp =  new Database();
                tmp.setDBID(rs.getString(1));
                tmp.setName(rs.getString(2));
                tmp.setCrea(rs.getString(3));
                tmp.setReset(rs.getString(4));
                tmp.setLog(rs.getString(5));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
}
