package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.example.dao.ContactDAO;
import java.io.IOException;
import java.sql.SQLException;
@WebServlet("/admin/contactus/requests")
public class ContactRequestsServlet extends HttpServlet {
    private final ContactDAO contactDAO = new ContactDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("adminLoggedIn"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        try {
            request.setAttribute("requests", contactDAO.getAllRequests());
            request.getRequestDispatcher("/admin/requests.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error while loading contact requests", e);
        }
    }
}