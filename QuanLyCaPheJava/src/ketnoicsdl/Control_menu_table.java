package ketnoicsdl;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import POP.menu;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.menu;
import POP.thucan;
import POP.thucuong;
import javax.swing.JOptionPane;
import static javax.swing.JOptionPane.OK_OPTION;
/**
 *
 * @author lenovo
 */
public class Control_menu_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<menu> LayDS(){
        ArrayList<menu> ds=new ArrayList<menu>();
        try {
            p.Open(); 
            String query="Select * from menu";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                menu tmp =  new menu();
                tmp.setIdmenu(rs.getString(1));
                tmp.setTenmenu(rs.getString(2));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
    public void Them(menu x){
        try {
            p.Open(); 
            String query="insert into menu (idmenu, tenmenu) values ('"+x.getIdmenu()+"','"+x.getTenmenu()+"')";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    public void Xoa(menu x){
        try {
            p.Open(); 
            String query=" DELETE FROM MENU WHERE idmenu = '"+x.getIdmenu()+"'";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    public void Sua(menu x){
        try {
            p.Open(); 
            String query="update countries set idmenu ='"+x.getIdmenu()+"', tenmenu='"+x.getTenmenu()+"' from menu'";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    public int checkKHchoseMenu(String query)
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
