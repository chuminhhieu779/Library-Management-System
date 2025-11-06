/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.book;

import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import com.library.exception.BookNotFoundException;
import com.library.model.entity.Book;
import com.library.service.BookService;
import com.library.util.BookDataAccessException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Optional;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "BookDetails", urlPatterns = {"/book/detail"})
public class BookDetailsController extends HttpServlet {

    BookDao bookDao = new BookDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String error = (String) session.getAttribute("error");
        session.removeAttribute("error");
        request.setAttribute("error", error);
        String slug = request.getParameter("slug");
        String bookIDParam = request.getParameter("bookID");

        if (slug != null && bookIDParam != null) {
            session.setAttribute("slug", slug);
            session.setAttribute("bookID", bookIDParam);
        } else {
            slug = (String) session.getAttribute("slug");
            bookIDParam = (String) session.getAttribute("bookID");
        }//         

        int getBookId = Integer.parseInt(bookIDParam);
        Optional<Book> opt = bookDao.showBookDetail(slug, getBookId);
        try {
            opt.ifPresentOrElse(
                    book -> { // Book book = opt.get()
                        request.setAttribute("book", book);
                    },
                    () -> {
                        throw new BookNotFoundException("Book not found");
                    }
            );
            request.getRequestDispatcher("/WEB-INF/views/book/bookdetail.jsp").forward(request, response);
        } catch (BookNotFoundException b) {
            response.sendError(404, "Book not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
