/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author laptop gigabyte
 */
public class user {

    private static final Logger logger = LoggerFactory.getLogger(user.class);

    public static void main(String[] args) {
        logger.trace("TRACE: Logger setup OK!");
        logger.debug("DEBUG: This is a debug message.");
        logger.info("INFO: Hello from SLF4J + Logback!");
        logger.warn("WARN: Something might be wrong...");
        logger.error("ERROR: Something went wrong!");
    }
}
