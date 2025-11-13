/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.enums.RequestStatus;
import com.library.factory.ServiceFactory;
import com.library.model.dto.BorrowedBookDTO;
import com.library.model.dto.ExtendRequestDTO;
import com.library.model.entity.Borrowing;
import com.library.model.entity.ExtendRequest;
import com.library.model.entity.User;
import com.library.service.BorrowingService;
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
import java.time.LocalDateTime;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "ConfirmExtendController", urlPatterns = {"/user/request-extend-book"})
public class RequestExtendController extends HttpServlet {

    private final ExtendBookService extendSerivce = ServiceFactory.getExtendBookService();
    private final BorrowingService borrowService = ServiceFactory.getBorrowService();
    private final UserService userSerivce = ServiceFactory.getUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        BorrowedBookDTO dto = (BorrowedBookDTO) session.getAttribute("bookExtend");
        request.setAttribute("dto", dto);
        request.getRequestDispatcher("/WEB-INF/views/user/request_extend_book.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        BorrowedBookDTO dto = (BorrowedBookDTO) session.getAttribute("bookExtend");
        int extensionDays = Integer.parseInt(request.getParameter("extensionDays"));
        String account = request.getParameter("account");
        String fullName = request.getParameter("fullName");
        int borrowingID = borrowService.getBorrowingID(dto.getBookID(), account);
        Borrowing borrow = new Borrowing();
        borrow.setBorrowingID(borrowingID);
        int userID = userSerivce.getUserIDByAccount(account);
        User u = new User();
        u.setUserID(userID);
        ExtendRequestDTO e = new ExtendRequestDTO();
        e.setBorrowing(borrow);
        e.setUser(u);
        extendSerivce.insertData(e);
        session.removeAttribute("bookExtend");
        session.removeAttribute("targetBookID");
        response.sendRedirect(request.getContextPath() + "/user/dashboard");

    }

}
