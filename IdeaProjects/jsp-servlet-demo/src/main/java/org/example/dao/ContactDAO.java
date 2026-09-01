package org.example.dao;

import org.example.model.ContactRequest;
import org.example.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {
    public boolean saveContact(
            String fullName,
            String email,
            String message) throws SQLException {

        String sql = "INSERT INTO contact_requests " + "(full_name, email, message, status) " + "VALUES (?, ?, ?, 'ACTIVE')";
        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {
            statement.setString(1, fullName);
            statement.setString(2, email);
            statement.setString(3, message);
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        }
    }
    public List<ContactRequest> getAllRequests()
            throws SQLException {
        List<ContactRequest> requests = new ArrayList<>();

        String sql = "SELECT id, full_name, email, message, status " + "FROM contact_requests " + "ORDER BY id DESC";
        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {
            while (resultSet.next()) {
                ContactRequest contact = new ContactRequest();
                contact.setId(resultSet.getInt("id"));
                contact.setFullName(resultSet.getString("full_name"));
                contact.setEmail(resultSet.getString("email"));
                contact.setMessage(resultSet.getString("message"));
                contact.setStatus(resultSet.getString("status"));
                requests.add(contact);
            }
        }
        return requests;
    }
    public boolean archiveRequest(int id)
            throws SQLException {

        String sql = "UPDATE contact_requests " + "SET status = 'ARCHIVED' " + "WHERE id = ?";
        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {
            statement.setInt(1, id);
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    public boolean restore(int id)
            throws SQLException {

        String sql = "UPDATE contact_requests " + "SET status = 'ACTIVE' " + "WHERE id = ?";
        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {
            statement.setInt(1, id);
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        }
    }
}