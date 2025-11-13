/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin;

import com.library.factory.ServiceFactory;
import com.library.model.dto.ExtendRequestViewDTO;
import com.library.service.BookService;
import com.library.service.ExtendBookService;
import com.library.service.UserService;
import com.library.util.MailTransfer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "ApproveRequestController", urlPatterns = {"/admin/approve-request"})
public class ApproveRequestController extends HttpServlet {

    private final UserService userService = ServiceFactory.getUserService();
    private final ExtendBookService extendSerivce = ServiceFactory.getExtendBookService();
    private final BookService bookService = ServiceFactory.getBookService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        List<ExtendRequestViewDTO> list = (List<ExtendRequestViewDTO>) session.getAttribute("extendDTO");
        session.removeAttribute("extendDTO");
        String account = request.getParameter("account");
        String coverImage = request.getParameter("cover");
        int userID = userService.getUserIDByAccount(account);
        String bookTitle = request.getParameter("title");
        int bookID = bookService.getBookIDByCover(coverImage);
        String status = "approved";
        String imageUrl = "https://raw.githubusercontent.com/Suzune705/deploy-image/master/" + coverImage;

        extendSerivce.updateRequestStatus(userID, status);
        String message = "<p>Your extension request has been approved.</p>"
                + "<p>Book: <b>" + bookTitle + "</b></p>"
                + "<img src='" + imageUrl + "' style='width:150px;'>"
                + "<p>Thank you!</p>";
        String subject = "Your Book Extension Request Has Been Approved";
        MailTransfer.send(account, subject, message);
        response.sendRedirect(request.getContextPath() + "/admin/extend-request-manger");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
