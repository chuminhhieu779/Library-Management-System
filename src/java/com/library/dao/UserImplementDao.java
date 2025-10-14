/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.Users;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class UserImplementDao implements UserDao{

    private static final Logger logger = LoggerFactory.getLogger(UserImplementDao.class);
    private DBConnection db = DBConnection.getInstance();    
    private Connection conn = db.getConnection();
    
    
    @Override
    public List<Users> getALLUser() {
        List<Users> list = new ArrayList<>();
        String sql = "select * from users ";
        try{
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){    
                Users u = new Users();
                u.setUserID(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));
                u.setAccount(rs.getString("account"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                u.setAvatar(rs.getString("avatar"));                
                list.add(u);
               
            }
            
        }catch(SQLException s){
            
        }
        return list ;
    }
    
}
