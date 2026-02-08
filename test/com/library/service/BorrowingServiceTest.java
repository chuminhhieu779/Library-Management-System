/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.controller.borrowing.BorrowBookController;
import com.library.dao.BookDao;
import com.library.dao.BookDaoTest;
import com.library.dao.BorrowingDao;
import com.library.dao.UserDao;
import com.library.exception.UserNotFoundException;
import com.library.model.dto.BorrowedBookDTO;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertThrows;
import static org.junit.Assert.assertTrue;
import org.junit.Before;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import org.mockito.Mockito;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class BorrowingServiceTest {

    @Test
    public void testBorrowBook_NoSession_Behavior() throws Exception {

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);

        when(request.getSession(false)).thenReturn(null);
        when(request.getContextPath()).thenReturn("");

        BorrowingService borrowService = mock(BorrowingService.class);
        ActivityService activityService = mock(ActivityService.class);

        BorrowBookController controller = new BorrowBookController(borrowService, activityService);

        controller.doGet(request, response);

        verify(response).sendRedirect("/book/list");

        verifyNoInteractions(borrowService);
        verifyNoInteractions(activityService);

    }

    @Test
    public void testBorrowBook_NotLoggedIn() throws Exception {

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        BorrowingService borrowService = mock(BorrowingService.class);
        ActivityService activityService = mock(ActivityService.class);

        when(session.getAttribute("account")).thenReturn(null);
        when(request.getContextPath()).thenReturn("");
        when(request.getSession(false)).thenReturn(session);

        BorrowBookController controller = new BorrowBookController(borrowService, activityService);

        controller.doGet(request, response);

        verify(session).setAttribute(eq("failed"), eq("you have to login before using our service!"));
        verify(response).sendRedirect(request.getContextPath() + "/book/detail");

        verifyNoInteractions(borrowService);
        verifyNoInteractions(activityService);
    }

    @Test
    public void testBorrowBook_Success() throws Exception {

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        BorrowingService borrowService = mock(BorrowingService.class);
        ActivityService activityService = mock(ActivityService.class);

        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("account")).thenReturn("hieuminh9873@gmail.com");
        when(request.getParameter("slug")).thenReturn("book-a");
        when(request.getParameter("bookID")).thenReturn("10");

        when(borrowService.getUserIDByAccount("hieuminh9873@gmail.com")).thenReturn(1);
        when(borrowService.canBorrowBook(10, 1)).thenReturn(true);

        BorrowBookController controller = new BorrowBookController(borrowService, activityService);

        controller.doGet(request, response);

        verify(borrowService).borrowBook("book-a", 10, 1);
        verify(activityService).BookActivityOfUser("hieuminh9873@gmail.com", 3, 10);
        verify(session).setAttribute(eq("success"), anyString());
        verify(response).sendRedirect(request.getContextPath() + "/book/detail?slug=book-a&bookID=10");
    }

    @Test
    public void testBorrowBook_Failed() throws Exception {
        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        ActivityService activityService = mock(ActivityService.class);
        HttpSession session = mock(HttpSession.class);

        BorrowingService borrowService = mock(BorrowingService.class);

        when(request.getSession(false)).thenReturn(session);
        when(request.getContextPath()).thenReturn("");

        when(session.getAttribute("account")).thenReturn("hieu@gmail.com");
        when(request.getParameter("slug")).thenReturn("book-a");
        when(request.getParameter("bookID")).thenReturn("10");

        when(borrowService.getUserIDByAccount("hieu@gmail.com")).thenReturn(1);

        when(borrowService.canBorrowBook(10, 1)).thenReturn(false);

        BorrowBookController controller = new BorrowBookController(borrowService, activityService);

        controller.doGet(request, response);

        verify(session).setAttribute(eq("failed"), eq("you already borrowed this book !!!"));
        verify(response).sendRedirect(request.getContextPath() + "/book/detail?slug=book-a&bookID=10");
        verifyNoInteractions(activityService);
    }

    @Test
    public void testBorrowBook_InvalidBookId_ThrowsNumberFormatException() throws Exception {

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        BorrowingService borrowService = mock(BorrowingService.class);
        ActivityService activityService = mock(ActivityService.class);

        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("account")).thenReturn("hieu@gmail.com");
        when(request.getParameter("slug")).thenReturn("book-a");
        when(request.getParameter("bookID")).thenReturn("abc"); // ❌ invalid
        when(request.getContextPath()).thenReturn("");

        BorrowBookController controller = new BorrowBookController(borrowService, activityService);

        // ASSERT
        assertThrows(
                NumberFormatException.class,
                () -> controller.doGet(request, response)
        );

        verifyNoInteractions(borrowService);
        verifyNoInteractions(activityService);
    }

    @Test
    public void testBorrowBook_InvalidBookId_ThrowWrongException() throws Exception {

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        BorrowingService borrowService = mock(BorrowingService.class);
        ActivityService activityService = mock(ActivityService.class);

        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("account")).thenReturn("hieu@gmail.com");
        when(request.getParameter("slug")).thenReturn("book-a");
        when(request.getParameter("bookID")).thenReturn("1"); // ❌ invalid // abc
        when(request.getContextPath()).thenReturn("");

        BorrowBookController controller
                = new BorrowBookController(borrowService, activityService);

        assertThrows(
                NumberFormatException.class,
                () -> controller.doGet(request, response)
        );

        verifyNoInteractions(borrowService);
        verifyNoInteractions(activityService);
    }

    @Test
    public void testBorrowBook_MissingSlug() throws Exception {

        HttpServletRequest request = mock(HttpServletRequest.class);
        HttpServletResponse response = mock(HttpServletResponse.class);
        HttpSession session = mock(HttpSession.class);

        BorrowingService borrowService = mock(BorrowingService.class);
        ActivityService activityService = mock(ActivityService.class);

        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("account")).thenReturn("hieu@gmail.com");

        when(request.getParameter("slug")).thenReturn(null); // missing
        when(request.getParameter("bookID")).thenReturn("10");
        when(request.getContextPath()).thenReturn("");

        BorrowBookController controller = new BorrowBookController(borrowService, activityService);

        controller.doGet(request, response);

        verify(session).setAttribute("failed", "you already borrowed this book !!!");
        verify(response).sendRedirect(request.getContextPath() + "/book/detail?slug=book-a&bookID=10");

    }

    private static final Logger logger = LoggerFactory.getLogger(BorrowingServiceTest.class);
    private BorrowingDao borrowDao;
    private UserDao userDao;
    private BookDao bookDao;

    private BorrowingService service;

    @Before
    public void setUp() {
        borrowDao = mock(BorrowingDao.class);
        userDao = mock(UserDao.class);
        bookDao = mock(BookDao.class);

        service = new BorrowingService(borrowDao, userDao, bookDao);
    }

    @Test
    public void checkUserExists() {
        when(userDao.findUserID("hieu")).thenReturn(5);

        int result = service.getUserIDByAccount("hieu");

        assertEquals(5, result);
    }

    @Test
    public void checkUserNotExists() {
        when(userDao.findUserID("hieu")).thenReturn(-1);
        int result = service.getUserIDByAccount("hieu");
        assertEquals(-1, result);
    }

    @Test
    public void canBorrowBook_NotBorrowed_And_LessThan10_ReturnTrue() {
        when(borrowDao.hasUserBorrowedBook(1, 2)).thenReturn(false);
        when(borrowDao.numberOfBorrowBookOnPerUser()).thenReturn(5);

        boolean result = service.canBorrowBook(1, 2);

        assertTrue(
                "User chưa mượn sách này và số sách < 10 → được mượn",
                result
        );
    }

    @Test
    public void canBorrowBook_AlreadyBorrowed_ReurnFalset() {
        when(borrowDao.hasUserBorrowedBook(1, 2)).thenReturn(true);
        when(borrowDao.numberOfBorrowBookOnPerUser()).thenReturn(5);

        boolean result = service.canBorrowBook(1, 2);

        assertFalse(
                "User has this borrowed book",
                result
        );
    }

    @Test
    public void canBorrowBookExceed() {

        when(borrowDao.hasUserBorrowedBook(1, 2)).thenReturn(false);
        when(borrowDao.numberOfBorrowBookOnPerUser()).thenReturn(90);

        boolean result = service.canBorrowBook(1, 2);

        assertFalse(
                "borrowedCount = 10 should be rejected (<10), ",
                result
        );
    }

    @Test
    public void canBorrowBook_Boundary_Count9_ReturnTrue() {
        when(borrowDao.hasUserBorrowedBook(1, 2)).thenReturn(false);
        when(borrowDao.numberOfBorrowBookOnPerUser()).thenReturn(9);

        boolean result = service.canBorrowBook(1, 2);

        assertTrue(
                "borrowedCount = 9 (<10) → được phép mượn",
                result
        );
    }

    @Test
    public void canBorrowBook_Boundary_Count11_ReturnFalse() {
        when(borrowDao.hasUserBorrowedBook(1, 2)).thenReturn(false);
        when(borrowDao.numberOfBorrowBookOnPerUser()).thenReturn(11);

        boolean result = service.canBorrowBook(1, 2);

        assertFalse(
                "borrowedCount = 11 (>10) → bị từ chối mượn",
                result
        );
    }

    @Test
    public void getBorrowDate_ReturnCorrectDate() {
        LocalDate date = LocalDate.of(2024, 10, 1);
        when(borrowDao.getBorrowDate(10)).thenReturn(date);

        LocalDate result = service.getBorrowDate(10);

        assertEquals(date, result);
    }

    @Test
    public void getExtendCount_ReturnCorrectValue() {

        when(borrowDao.getExtendCount(10, "hieu@gmail.com")).thenReturn(2);

        int result = service.getExtendCount(10, "hieu@gmail.com");

        assertEquals(2, result);
    }

    @Test
    public void borrowedBooksList_ReturnList() {
        List<BorrowedBookDTO> mockList = List.of(mock(BorrowedBookDTO.class));

        when(borrowDao.borrowedBooksList("hieu@gmail.com")).thenReturn(mockList);

        List<BorrowedBookDTO> result = service.borrowedBooksList("hieu@gmail.com");

        assertEquals(1, result.size());
        assertSame(mockList, result);
    }

    @Test
    public void incrementExtendCount_CallDao() {

        service.incrementExtendCount(10, "hieu@gmail.com");
        verify(borrowDao).incrementExtendCount(10, "hieu@gmail.com");
    }

    @Test
    public void getBorrowingID_ReturnCorrectId() {
        when(borrowDao.getBorrowingIdByBookId(10, "hieu@gmail.com")).thenReturn(99);

        int result = service.getBorrowingID(10, "hieu@gmail.com");

        assertEquals(99, result);
    }

}
