/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.util;

import com.library.model.entity.Activity;
import java.time.Duration;
import java.time.LocalDateTime;

/**
 *
 * @author hieuchu
 */
public class TimeFormatter {

    public static String timeAgo(LocalDateTime logTime) {
       
        String timeFormatted = "";
        if (logTime != null) {
            Duration duration = Duration.between(logTime, LocalDateTime.now()); // 1h:00 -> 1h:05 => 5 
            long minutes = duration.toMinutes(); // convert 5 to 5 minutes 
            if (minutes < 1) {
                return timeFormatted = "vừa xong";
            }
            if (minutes < 60) {
                return timeFormatted =  minutes + " phút trước";
            }
            long hours = duration.toHours();  // convert to hour unit 
            if (hours < 24) {
                return timeFormatted = hours + " giờ trước";
            }
        }
        return null;
    }
}
