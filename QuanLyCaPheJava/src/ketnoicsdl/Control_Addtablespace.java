/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import POP.Addtablespace;
/**
 *
 * @author lenovo
 */
public class Control_Addtablespace {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<Addtablespace> LayDS(){
        ArrayList<Addtablespace> ds=new ArrayList<Addtablespace>();
        try {
            p.Open(); 
            String query="select TABLESPACE_NAME,FILE_NAME from DBA_DATA_FILES";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                Addtablespace tmp =  new Addtablespace();
                tmp.setTen(rs.getString(1));
                tmp.setTentablespace(rs.getString(2));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
    public void Them(Addtablespace x){
        try {
            p.Open(); 
            String query="create tablespace "+x.getTentablespace()+" datafile 'D:\\APP\\LENOVO\\ORADATA\\ORCL\\"+x.getTen()+".dbf' size 20M";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    public void Xoa(Addtablespace x){
        try {
            p.Open(); 
            String query="drop tablespace "+x.getTen()+" ";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
}
