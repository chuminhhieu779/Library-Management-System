/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.util;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
public class SessionTracker implements HttpSessionListener {

    private static final Map<String, HttpSession> map = new HashMap<>();

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        map.put(se.getSession().getId(), se.getSession());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        map.remove(se.getSession().getId());
    }
    
    public static HttpSession getSession(String sessionID){
        return map.get(sessionID);
    }
    
    public static void addSession(String sessionID, HttpSession se){
        map.put(sessionID, se);
    }
    
    public static Collection<HttpSession> getAll(){
        return map.values();
    }
}
