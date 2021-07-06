package ketnoicsdl;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author lenovo
 */
public class ketnoi_truyvan {
    String driver="oracle.jdbc.OracleDriver";
    //Dường dẫn kết nối port, tên DB
    String urlConnection="jdbc:oracle:thin:@localhost:1521:orcl";
    String name="doan_oracle";
    String pass="doan_oracle";
    
    public Connection connection=null;
    //Phương thức mở kết nối
    public void Open() throws ClassNotFoundException, SQLException{
        Class.forName(driver);
        connection=DriverManager.getConnection(urlConnection,name,pass);
    }
    //Phương thức đóng kết nối
    public void Close() throws SQLException{
        connection.close();
    }
    //Phương thức Thực thi câu lệnh dạng select và trả về table
    public ResultSet executeQuery(String sql) throws SQLException 
    {
        Statement statement=connection.createStatement();
        ResultSet rs =statement.executeQuery(sql);
        return rs;
    }
    //Phương thức Thực thi câu lệnh dạng insert, update, delete và trả về số dòng đã thực thi
     public int executeUpdate(String sql) throws SQLException
    {
        int n=-1;
        Statement stm=connection.createStatement();
        n=stm.executeUpdate(sql);
        return n;
    }
}
