/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.book;

import com.library.enums.BookType;
import com.library.factory.ServiceFactory;
import com.library.model.entity.Book;
import com.library.model.entity.Category;
import com.library.service.BookService;
import com.library.util.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author laptop gigabyte
 */
@WebServlet(name = "saveBooks", urlPatterns = {"/admin/book/add"})
@MultipartConfig
public class AddBookController extends HttpServlet {
        
    BookService bookService = ServiceFactory.getBookService();
    private static final Logger logger = LoggerFactory.getLogger(AddBookController.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        logger.info("category book : {}", category);
        String slug = request.getParameter("slug");
        String unaccent = request.getParameter("title_unaccented");
        String description = request.getParameter("description");              
        String lower = bookService.normalizeCategory(category);
        logger.info("category after : {}", lower);
        int quantity = Integer.parseInt(request.getParameter("quantity"));
         
        Part filePath = request.getPart("coverImage");
        String saveFile2 = "D:\\BTL-PRJ301\\LibraryManagement\\web\\resources\\images\\" + lower;
        String coverImage;
        String fileName = Paths.get(filePath.getSubmittedFileName()).getFileName().toString();
        File saveFile = new File(saveFile2, fileName);
        try (InputStream input = filePath.getInputStream()) {
            Files.copy(input, saveFile.toPath(), StandardCopyOption.REPLACE_EXISTING); // copy file to specific folder
        }
        String relativePath = "/" + lower + "/" + fileName;
        coverImage = relativePath; // save new file path to write it down database 
    
        int categoryID = bookService.getCategoryID(category);
        logger.info("category id : { } ", categoryID);
        Category c = new Category(categoryID, BookType.convert(category));
       
        Book b = new Book(title, unaccent, slug, author, c, quantity, description, coverImage);
        HttpSession session = request.getSession(false);        
       if(bookService.addBook(b)){  
           session.setAttribute("addBookNotice" , "The book is added");           
           response.sendRedirect(request.getContextPath() + "/admin/books");
           return ;
       }        
    }

}
