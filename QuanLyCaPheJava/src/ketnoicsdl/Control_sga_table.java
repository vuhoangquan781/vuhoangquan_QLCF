/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.SGA;
/**
 *
 * @author lenovo
 */
public class Control_sga_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<SGA> LayDS(){
        ArrayList<SGA> ds=new ArrayList<SGA>();
        try {
            p.Open(); 
            String query="Select * from v$sga";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                SGA tmp =  new SGA();
                tmp.setNam_e(rs.getString(1));
                tmp.setVa_lue(rs.getString(2));
                tmp.setCon_ID(rs.getString(3));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
}
