/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ketnoicsdl;
import POP.datban;
import POP.menu;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author lenovo
 */
public class Control_Datban_table {
    ketnoi_truyvan p =new ketnoi_truyvan();
    public ArrayList<datban> LayDS(){
        ArrayList<datban> ds=new ArrayList<datban>();
        try {
            p.Open(); 
            String query="Select * from datban";
            ResultSet rs=p.executeQuery(query);
            while (rs.next())
            {
                datban tmp =  new datban();
                tmp.setMaban(rs.getString(1));
                tmp.setTenban(rs.getString(2));
                tmp.setTrangthai(rs.getString(3));
                ds.add(tmp);
            }
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
        return ds;
    }
    public void Them(datban x){
        try {
            p.Open(); 
            String query="insert into datban (maban, tenban,trangthai) values ('"+x.getMaban()+"','"+x.getTenban()+"','"+x.getTrangthai()+"')";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    public void Xoa(datban x){
        try {
            p.Open(); 
            String query=" DELETE FROM datban WHERE maban = '"+x.getMaban()+"'";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
    public void Sua(datban x){
        try {
            p.Open(); 
            String query="update datban set maban ='"+x.getMaban()+"', tenban='"+x.getTenban()+"',trangthai='"+x.getTrangthai()+"' from datban'";
            p.executeUpdate(query);
            p.Close();
        } catch (ClassNotFoundException ex) {
        } catch (SQLException ex) {
        }
    }
}
