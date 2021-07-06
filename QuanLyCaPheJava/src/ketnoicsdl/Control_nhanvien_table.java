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
import POP.nhanvien;

/**
 *
 * @author lenovo
 */
public class Control_nhanvien_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<nhanvien> LayDS(){
        ArrayList<nhanvien> ds=new ArrayList<nhanvien>();
        try {
            p.Open(); 
            String query="Select * from nhanvien";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                nhanvien tmp =  new nhanvien();
                tmp.setManv(rs.getString(1));
                tmp.setTennv(rs.getString(2));
                tmp.setMacv(rs.getString(3));
                tmp.setNgaysinh(rs.getString(4));
                tmp.setNgayvaolam(rs.getString(5));
                tmp.setCa(rs.getInt(6));
                tmp.setLuong(rs.getFloat(7));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
    public void Them(nhanvien x){
        try {
            p.Open(); 
            String query="insert into nhanvien (manv, tennv, macv, ngaysinh, ngayvaolam, ca, luong) values ('"+x.getManv()+"','"+x.getTennv()+"','"+x.getMacv()+"',To_date('"+x.getNgaysinh()+"', 'DD-MON-YYYY'),To_date('"+x.getNgayvaolam()+"', 'DD-MON-YYYY'),'"+x.getCa()+"')";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    public void Xoa(nhanvien x){
        try {
            p.Open(); 
            String query="Delete from nhanvien where MANV='"+x.getManv()+"'";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
     public int checkpassNV(String query)
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
        } catch (ClassNotFoundException ex) {
            JOptionPane.showConfirmDialog(null,"Ket noi that bai","Thong Bao",OK_OPTION);
        } catch (SQLException ex) {      
        }
        return kq;
    }
}
