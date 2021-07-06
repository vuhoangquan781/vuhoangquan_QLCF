/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import POP.thucuong;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author lenovo
 */
public class Control_thucuong_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<thucuong> LayDS(String sql){
        ArrayList<thucuong> ds=new ArrayList<thucuong>();
        try {
            p.Open(); 
            String query="Select * from thucuong";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                thucuong tmp =  new thucuong();
                tmp.setMathucuong(rs.getString(1));
                tmp.setTenthucuong(rs.getString(2));
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
    public void TimThucAn(thucuong x){
        try {
            p.Open(); 
            String query="select * from thucuong where idmenu = "+x.getIdmenu()+" ";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    public ArrayList<thucuong> LayDSthucuongmenu(){
        ArrayList<thucuong> ds=new ArrayList<thucuong>();
        try {
            p.Open(); 
            String query="SELECT*FROM THUCUONG JOIN MENU ON THUCUONG.IDMENU = MENU.IDMENU";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                thucuong tmp =  new thucuong();
                tmp.setMathucuong(rs.getString(1));
                tmp.setTenthucuong(rs.getString(2));
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
