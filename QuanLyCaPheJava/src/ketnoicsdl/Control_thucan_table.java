/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.thucan;
/**
 *
 * @author lenovo
 */
public class Control_thucan_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<thucan> LayDS(String sql){
        ArrayList<thucan> ds=new ArrayList<thucan>();
        try {
            p.Open(); 
            String query="Select * from thucan";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                thucan tmp =  new thucan();
                tmp.setMathucan(rs.getString(1));
                tmp.setTenthucan(rs.getString(2));
                tmp.setIdmenu(rs.getString(3));
                tmp.setGiatien(rs.getFloat(4));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
    public void TimThucAn(thucan x){
        try {
            p.Open(); 
            String query="select * from thucan where idmenu = "+x.getIdmenu()+" ";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    public ArrayList<thucan> LayDSthucanmenu(){
        ArrayList<thucan> ds=new ArrayList<thucan>();
        try {
            p.Open(); 
            String query="SELECT*FROM THUCAN JOIN MENU ON THUCAN.IDMENU = MENU.IDMENU";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                thucan tmp =  new thucan();
                tmp.setMathucan(rs.getString(1));
                tmp.setTenthucan(rs.getString(2));
                tmp.setIdmenu(rs.getString(3));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }

}
