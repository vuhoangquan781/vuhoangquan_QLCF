/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.XemUser;
/**
 *
 * @author lenovo
 */
public class Control_xem_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<XemUser> LayDS(){
        ArrayList<XemUser> ds=new ArrayList<XemUser>();
        try {
            p.Open(); 
            String query="select username, created,expiry_date, account_status,last_login,profile from dba_users";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                XemUser tmp =  new XemUser();
                tmp.setName(rs.getString(1));
                tmp.setCrea(rs.getString(2));
                tmp.setEx_day(rs.getString(3));
                tmp.setAccount(rs.getString(4));
                tmp.setLast(rs.getString(5));
                tmp.setProf(rs.getString(6));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
}
}
