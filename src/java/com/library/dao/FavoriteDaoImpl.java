/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author hieuchu
 */
public class FavoriteDaoImpl implements FavoriteDao {

    @Override
    public void removeBookByID(Connection conn , int bookID) {
       String sql = "delete from favorites where book_id = ? ";
       try{
           PreparedStatement ps = conn.prepareStatement(sql); 
           ps.setInt(1, bookID);
           ps.executeUpdate();
       }catch(SQLException s){
           s.printStackTrace();
       }
    }
    
}
