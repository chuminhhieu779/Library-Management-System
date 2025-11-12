/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.enums;

/**
 *
 * @author hieuchu
 */
public enum RequestStatus {
    PENDING("pending"),
    APPROVED("approved"),
    REJECTED("rejected");

    private final String value;

    RequestStatus(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static RequestStatus fromString(String status) {
        for (RequestStatus rs : RequestStatus.values()) {
            if (rs.value.equalsIgnoreCase(status)) {
                return rs;
            }
        }
        return null;
    }

}
