/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.QuanLyUsers;
/**
 *
 * @author lenovo
 */
public class Control_QuanLyUsers_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<QuanLyUsers> LayDS(){
        ArrayList<QuanLyUsers> ds=new ArrayList<QuanLyUsers>();
        try {
            p.Open(); 
            String query="select username,password,user_id,created,expiry_date,last_login from dba_users where account_status ='OPEN'";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                QuanLyUsers tmp =  new QuanLyUsers();
                tmp.setUsername(rs.getString(1));
                tmp.setPass(rs.getString(2));
                tmp.setUserid(rs.getString(3));
                tmp.setCreatedate(rs.getString(4));
                tmp.setExpirydate(rs.getString(5));
                tmp.setLastlogin(rs.getString(6));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
}
    public void Them(QuanLyUsers x){
        try {
            p.Open(); 
            String query="create user "+x.getUsername()+" identified by "+x.getPass()+"";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    
     public void Xoa(QuanLyUsers x){
        try {
            p.Open(); 
            String query="drop user "+x.getUsername()+"";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
     
     public void ThemQuyen(QuanLyUsers x){
        try {
            p.Open(); 
            String query="GRANT "+x.getPass()+" TO "+x.getUsername()+"";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
     
     public void XoaQuyen(QuanLyUsers x){
        try {
            p.Open(); 
            String query="REVOKE "+x.getPass()+" FROM "+x.getUsername()+"";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
}
