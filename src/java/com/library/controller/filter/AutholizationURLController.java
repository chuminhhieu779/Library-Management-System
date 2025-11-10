/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.controller.filter;

/**
 *
 * @author hieuchu
 */
public class AutholizationURLController {

    public static final String[] pageForUser() {
        String[] url = {
            // Borrowing
            "/borrowing/borrow",
            "/borrowing/borrowed",
            "/borrowing/returned",
            "/borrowing/return",
            "/borrowing/extend",
            // Favorites
            "/favorite/add-book",
            "/favorite/books",
            // Books
            "/book/list",
            "/book/detail",
            "/book/search",
            "/book/category",
            // User info
            "/user/dashboard",
            "/user/setting",
            "/user/update-profile",
            "/user/change-password",
            // Auth
            "/user/register",
            "/LogOut"
        };
        return url;
    }
    
    public static final String[] pageForAdmin() {
        String[] tmp ={     
        "/admin/login",
        "/admin/dashboard",
        "/ActivityLog",
    
        
        "/admin/books",
        "/admin/book/add",
        "/admin/books/edit",
        "/admin/books/delete",

        "/admin/user-manager",
        "/admin/user-borrowing-record",
        "/admin/user/delete",
        "/admin/user/logout",
        "/admin/users/logout-all"
    };
       return tmp ;
    }
}
