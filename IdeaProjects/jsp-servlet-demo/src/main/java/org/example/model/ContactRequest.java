package org.example.model;

import java.sql.Timestamp;

public class ContactRequest {

    private int id;
    private String fullName;
    private String email;
    private String message;
    private String status;
    private Timestamp createdAt;

    public ContactRequest() {
    }

    public ContactRequest(
            int id,
            String fullName,
            String email,
            String message,
            String status,
            Timestamp createdAt
    ) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.message = message;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}