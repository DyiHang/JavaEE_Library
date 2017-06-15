package demo.servlet;

import demo.model.Book;
import demo.util.Db;
import demo.util.Error;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mingfei.net@gmail.com
 * 6/15/17 14:22
 * https://github.com/thu/JavaEE_Library/
 */
@WebServlet(urlPatterns = "/book")
public class BookAction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            add(req, resp);
            return;
        }

        if ("queryAll".equals(action)) {
            queryAll(req, resp);
            return;
        }

        Error.showError(req, resp);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title").trim();
        String author = req.getParameter("author").trim();
        String pub = req.getParameter("pub").trim();
        String time = req.getParameter("time").trim();
        double price = Double.parseDouble(req.getParameter("price").trim());
        int amount = Integer.parseInt(req.getParameter("amount").trim());

        Connection connection = Db.getConnection();
        PreparedStatement preparedStatement = null;
        String sql = "INSERT INTO javaee_library.book VALUES(NULL, ?, ?, ?, ?, ?, ?)";

        try {
            if (connection != null) {
                preparedStatement = connection.prepareStatement(sql);
            } else {
                Error.showError(req, resp);
                return;
            }
            preparedStatement.setString(1, title);
            preparedStatement.setString(2, author);
            preparedStatement.setString(3, pub);
            preparedStatement.setString(4, time);
            preparedStatement.setDouble(5, price);
            preparedStatement.setInt(6, amount);

            preparedStatement.executeUpdate();

            resp.sendRedirect("book?action=queryAll");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Db.close(null, preparedStatement, connection);
        }
    }

    private void queryAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Connection connection = Db.getConnection();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        String sql = "SELECT * FROM javaee_library.book ORDER BY id";

        try {
            if (connection != null) {
                preparedStatement = connection.prepareStatement(sql);
            } else {
                Error.showError(req, resp);
                return;
            }

            resultSet = preparedStatement.executeQuery();
            List<Book> books = new ArrayList<>();

            while (resultSet.next()) {
                Book book = new Book(
                        resultSet.getInt("id"),
                        resultSet.getString("title"),
                        resultSet.getString("author"),
                        resultSet.getString("pub"),
                        resultSet.getString("time" ),
                        resultSet.getDouble("price"),
                        resultSet.getInt("amount")
                );
                books.add(book);
            }

            req.getSession().setAttribute("books", books);
            resp.sendRedirect("admin.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            Db.close(resultSet, preparedStatement, connection);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
