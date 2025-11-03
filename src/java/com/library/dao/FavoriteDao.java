/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import java.sql.Connection;

/**
 *
 * @author hieuchu
 */
public interface FavoriteDao {

    void removeBookByID(Connection conn, int bookID);

    public void deleteUserFromFavorites(Connection conn, int userId);
}
