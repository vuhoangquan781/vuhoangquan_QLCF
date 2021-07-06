/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quanlycaphejava;

import java.sql.*;
/**
 *
 * @author lenovo
 */
public class QuanLyCaPheJava {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try{  
    // Buoc 1: Tai lop Driver  
    Class.forName("oracle.jdbc.driver.OracleDriver");  
  
    // Buoc 2: Tao doi tuong Connection  
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","doan_oracle","doan_oracle");  
  
    // Buoc 3: Tao doi tuong Statement  
    Statement stmt=con.createStatement();  
  
    // Buoc 4: Thuc thi truy van  
    ResultSet rs=stmt.executeQuery("select * from menu");  
    while(rs.next())  
    System.out.println(rs.getInt(1)+"  "+rs.getString(2)); //+"  "+rs.getString(3)+ rs.getInt(4));  
  
    // Buoc 5: Dong doi tuong Connection  
    con.close();  
  
    }catch(Exception e){ System.out.println(e);}  
  
    }
    
}
