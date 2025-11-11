/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;



import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author hieuchu
 */
public class MailService {

    private static final String USERNAME = "hieuminh9873@gmail.com";
    private static final String PASSWORD = "qifs buxh anin erpa";

    public static void send(String account, String title, String messageText) {
        Properties config = new Properties();
        config.put("mail.smtp.auth", "true"); // true : notice to server need to authentication password and gmail
        config.put("mail.smtp.starttls.enable", "true"); // true : use encytion TLS for sending email 
        config.put("mail.smtp.host", "smtp.gmail.com"); // server addderess 
        config.put("mail.smtp.port", "587"); // 587 entry to send email to starttls 
        
        
        Session session = Session.getInstance(config, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD); // return password and account to server gmail 
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME, "Library System", "UTF-8"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(account));
            message.setSubject(title, "UTF-8");
            message.setContent(messageText, "text/html; charset=UTF-8");

            Transport.send(message); // send message to server
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
