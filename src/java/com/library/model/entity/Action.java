/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.entity;

import com.library.enums.ActionType;

/**
 *
 * @author hieuchu
 */
public class Action {
    private int actionID;
    private  ActionType type ;

    public Action() {}

    public Action(int actionID, ActionType type) {
        this.actionID = actionID;
        this.type = type;
    }

    public int getActionID() {
        return actionID;
    }

    public void setActionID(int actionID) {
        this.actionID = actionID;
    }

    public ActionType getType() {
        return type;
    }

    public void setType(ActionType type) {
        this.type = type;
    }

   

}
