/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.Instance;
/**
 *
 * @author lenovo
 */
public class Control_instance_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<Instance> LayDS(){
        ArrayList<Instance> ds=new ArrayList<Instance>();
        try {
            p.Open(); 
            String query="Select * from v$instance";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                Instance tmp =  new Instance();
                tmp.setI_Num(rs.getString(1));
                tmp.setI_Name(rs.getString(2));
                tmp.setH_Name(rs.getString(3));
                tmp.setVer(rs.getString(4));
                tmp.setStart(rs.getString(5));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
}
