package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.example.dao.ContactDAO;
import java.io.IOException;
@WebServlet("/admin/archive")
public class ArchiveServlet extends HttpServlet {
    private final ContactDAO contactDAO = new ContactDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParameter = request.getParameter("id");
        try {
            int id = Integer.parseInt(idParameter);
            boolean archived = contactDAO.archiveRequest(id);
            if (archived) {
                response.sendRedirect(request.getContextPath() + "/admin/contactus/requests");

            } else {
                response.sendRedirect(request.getContextPath() + "/admin/contactus/requests?error=archive");
            }
        } catch (Exception e) {
            throw new ServletException("Error archiving contact request", e);
        }
    }
}