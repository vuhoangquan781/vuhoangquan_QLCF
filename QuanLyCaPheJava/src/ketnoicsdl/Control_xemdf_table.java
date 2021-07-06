/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.XemDF;

/**
 *
 * @author lenovo
 */
public class Control_xemdf_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<XemDF> LayDS(){
        ArrayList<XemDF> ds=new ArrayList<XemDF>();
        try {
            p.Open(); 
            String query="select file_name,file_id,tablespace_name from DBA_DATA_FILES";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                XemDF tmp =  new XemDF();
                tmp.setTen(rs.getString(1));
                tmp.setId(rs.getString(2));
                tmp.setTable(rs.getString(3));
               
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
}
