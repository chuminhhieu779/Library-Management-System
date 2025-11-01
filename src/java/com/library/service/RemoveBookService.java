    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    package com.library.service;

    import com.library.dao.BookDao;
    import com.library.dao.BorrowingDao;
    import com.library.dao.FavoriteDao;
    import com.library.util.DBConnection;
    import java.sql.Connection;
    import java.sql.SQLException;

    /**
     *
     * @author hieuchu
     */
    public class RemoveBookService {
        private final BookDao bookDao;
        private final BorrowingDao borrowDao ;
        private final FavoriteDao favoriteDao ;

        public RemoveBookService(BookDao bookDao, BorrowingDao borrowDao, FavoriteDao favoriteDao) {
            this.bookDao = bookDao;
            this.borrowDao = borrowDao;
            this.favoriteDao = favoriteDao;
        }

        public boolean isBookRemoved(int bookID){
            try(
                Connection conn = DBConnection.getInstance().getConnection()){
                conn.setAutoCommit(false);            
                try{
                    if(this.borrowDao.canDeleteBook(bookID)){
                        this.borrowDao.deleteBorrowingsByBookId(conn, bookID);
                        this.favoriteDao.removeBookByID(conn, bookID);
                        this.bookDao.deleteBook(conn, bookID);
                        conn.commit();
                        return true ;
                    }
                }catch(SQLException s){
                  conn.rollback();
                }
            }catch(SQLException s){
                s.printStackTrace();
            }               
            return false;
        }

    }
