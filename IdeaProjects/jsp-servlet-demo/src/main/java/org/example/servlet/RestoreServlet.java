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

@WebServlet("/admin/contactus/restore")
public class RestoreServlet extends HttpServlet {
    private final ContactDAO contactDAO = new ContactDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null
                || !Boolean.TRUE.equals(
                session.getAttribute("adminLoggedIn"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        String idParameter = request.getParameter("id");
        if (idParameter == null || idParameter.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/contactus/requests");
            return;
        }
        try {
            int id = Integer.parseInt(idParameter);
            contactDAO.restore(id);
            response.sendRedirect(request.getContextPath() + "/admin/contactus/requests");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/contactus/requests"
            );
        } catch (SQLException e) {
            throw new ServletException("Database error while restoring request", e);
        }
    }
}