/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.util;

import com.library.dao.UserSessionDao;
import com.library.dao.UserSessionDaoImpl;
import com.library.factory.DaoFactory;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
public class SessionTracker implements HttpSessionListener {

    private static final Map<String, HttpSession> map = new HashMap<>();
    public static UserSessionDao dao = DaoFactory.getUserSessionDao();

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        map.put(se.getSession().getId(), se.getSession());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        map.remove(se.getSession().getId());
    }

    public static HttpSession getSessionOnServer(String sessionIDFromDB) {
        return map.get(sessionIDFromDB);
    }
   
    public static void addSessionToServer(String sessionIDFromDB, HttpSession se) {
        map.put(sessionIDFromDB, se);
    }

    public static List<HttpSession> getAllValue() {   
       List<HttpSession> listSessionID = new ArrayList<>();
        List<String> listSession = dao.getSessionIDUser();
        for(String s : listSession){
            if(s.equals(map.keySet())){
                listSessionID.add((HttpSession) map.values());
            }
        }      
        return listSessionID;
    }

    public static boolean isEmpty() {
        return map.isEmpty();
    }

    public static int getSize() {
        return map.size();
    }

    public static Map<String, HttpSession> getMap() {
        return map;
    }
}
