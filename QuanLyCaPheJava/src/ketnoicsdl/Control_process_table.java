/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.Process;
/**
 *
 * @author lenovo
 */
public class Control_process_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<Process> LayDS(){
        ArrayList<Process> ds=new ArrayList<Process>();
        try {
            p.Open(); 
            String query="Select * from v$process";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                Process tmp =  new Process();
                tmp.setPID(rs.getString(1));
                tmp.setSOSID(rs.getString(2));
                tmp.setSPID(rs.getString(3));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
}
