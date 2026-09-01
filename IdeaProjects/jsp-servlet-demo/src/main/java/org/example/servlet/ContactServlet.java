package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.example.dao.ContactDAO;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        if (fullName == null || fullName.trim().isEmpty() || email == null || email.trim().isEmpty() || message == null || message.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/contactus.jsp?error=All fields are required");
            return;
        }
        try {
            boolean saved = contactDAO.saveContact(
                    fullName.trim(), email.trim(), message.trim()
            );
            if (saved) {
                response.sendRedirect(request.getContextPath() + "/contactus.jsp?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/contactus.jsp?error=Message could not be saved");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/contactus.jsp?error=Database error");
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/contactus.jsp"
        );
    }
}