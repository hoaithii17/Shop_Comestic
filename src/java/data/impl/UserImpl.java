/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;

import data.dao.UserDao;
import data.driver.MySQLDriver;
import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author DELL
 */
public class UserImpl implements UserDao {
    Connection con = MySQLDriver.getConnection();
    @Override
    public User findUser(String emailphone, String password) {
        String sql;
        // Dòng 'if' trong ảnh bị che khuất một phần, 
        // đây là code được hoàn chỉnh dựa theo logic của khối 'else':
        if(emailphone.contains("@")) sql="select * from users where email='"+emailphone+"' and password='"+password+"'";
        else sql="select * from users where phone='"+emailphone+"' and password='"+password+"'";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            if(rs.next()) return new User(rs);
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        // (Code trong ảnh thiếu lệnh 'return' ở cuối, 
        // ví dụ 'return null;', nên sẽ gây lỗi biên dịch)
        return null;
    }
    public User findUser(String emailphone) {
        String sql;
        // Dòng 'if' trong ảnh bị che khuất một phần, 
        // đây là code được hoàn chỉnh dựa theo logic của khối 'else':
        if(emailphone.contains("@")) sql="select * from users where email='"+emailphone+"'";
        else sql="select * from users where phone='"+emailphone+"'";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            if(rs.next()) return new User(rs);
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        // (Code trong ảnh thiếu lệnh 'return' ở cuối, 
        // ví dụ 'return null;', nên sẽ gây lỗi biên dịch)
        return null;
    }
    public void insertUser(String name, String email, String phone, String password){
        String str= "insert into users(name, email, phone, password, role) ";
        str+="values('"+name+"','"+email+"','"+phone+"','"+password+"','')";
        try {
            PreparedStatement sttm= con.prepareStatement(str);
            sttm.execute();
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}



