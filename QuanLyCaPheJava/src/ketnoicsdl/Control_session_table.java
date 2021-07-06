/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.Session;
/**
 *
 * @author lenovo
 */
public class Control_session_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<Session> LayDS(){
        ArrayList<Session> ds=new ArrayList<Session>();
        try {
            p.Open(); 
            String query="Select SID,SERIAL#,STATUS,SERVER,SCHEMA# from v$session";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                Session tmp =  new Session();
                tmp.setSID(rs.getString(1));
                tmp.setSeri(rs.getString(2));
                tmp.setStatus(rs.getString(3));
                tmp.setServer(rs.getString(4));
                tmp.setSchema(rs.getString(5));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
}
}
