/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.PGA;
/**
 *
 * @author lenovo
 */
public class Control_pga_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<PGA> LayDS(){
        ArrayList<PGA> ds=new ArrayList<PGA>();
        try {
            p.Open(); 
            String query="Select * from v$pgastat";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                PGA tmp =  new PGA();
                tmp.setNam_e(rs.getString(1));
                tmp.setValu_e(rs.getString(2));
                tmp.setUni_t(rs.getString(3));
                tmp.setCon_id(rs.getString(4));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
}
