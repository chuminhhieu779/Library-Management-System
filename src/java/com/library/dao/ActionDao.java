/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.Action;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public interface ActionDao {
    String getNameByID(int actionID);
    List<Action> getAllAction();
}
