/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.OK_OPTION;
import POP.khachhang;
/**
 *
 * @author lenovo
 */
public class Control_khachhang_table {
        ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<khachhang> LayDS()
    {
        ArrayList<khachhang> ds=new ArrayList<khachhang>();
        try {
            p.Open(); 
            String query="Select * from khachhang";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                khachhang tmp =  new khachhang();
                tmp.setMakh(rs.getString(1));
                tmp.setTenkh(rs.getString(2));
                tmp.setLoaikh(rs.getString(3));
                ds.add(tmp);
            }
            p.Close();
            } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
    public void Them(khachhang x)
    {
        try {
            p.Open(); 
            String query="insert into khachhang (makh, tenkh,loaikh) values ('"+x.getMakh()+"','"+x.getTenkh()+"','"+x.getLoaikh()+"')";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
            } catch (SQLException ex) {
        }
    }
    
    public void Xoa(khachhang x)
    {
        try {
            p.Open(); 
            String query="Delete from Khach where makh='"+x.getMakh()+"'";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
            } catch (SQLException ex) {
        }
    }
    
    public void Sua(khachhang x)
    {
        try {
            p.Open(); 
            String query="update khachhang set tenkh ='"+x.getTenkh()+"', loaikh='"+x.getLoaikh()+"' where makh='"+x.getMakh()+"'";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
            } catch (SQLException ex) {
        }
    }
          public int checkpassKH(String query)
    {
        int kq = 0;
        try {
            p.Open();  
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                kq=rs.getInt(1);
            }
            p.Close();
        } catch (ClassNotFoundException ex) 
            {
                JOptionPane.showConfirmDialog(null,"Ket noi that bai","Thong Bao",OK_OPTION);
            }   catch (SQLException ex) {      
        }
        return kq;
    }
}
