/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.entity.Activity;
import com.library.model.dto.UserActivityDTO;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public interface ActivityDao {
    void insertData(int userID, int actionID, String detail , LocalDateTime log_time);     
    Activity getLatestByAction(int actionID);
    public void deleteUserFromActivityLog(Connection conn ,int userId);
}
