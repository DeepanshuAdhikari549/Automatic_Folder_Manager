<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Contact Us</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        .contact-container {
            width: 500px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.12);
            overflow: hidden;
        }

        .contact-header {
            padding: 30px 25px;
            background: #f8f8f8;
            border-bottom: 1px solid #ddd;
        }

        .contact-header h1 {
            font-size: 24px;
            margin-bottom: 8px;
            color: #222;
        }

        .contact-header p {
            color: #666;
            font-size: 14px;
        }

        .contact-form {
            padding: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #222;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            font-family: Arial, sans-serif;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #777;
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .button-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-top: 10px;
        }

        .submit-btn,
        .admin-btn {
            border: none;
            border-radius: 5px;
            padding: 11px 20px;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .submit-btn {
            background: #777;
            color: white;
        }

        .submit-btn:hover {
            background: #555;
        }

        .admin-btn {
            background: #222;
            color: white;
        }

        .admin-btn:hover {
            background: #444;
        }
    </style>
</head>

<body>

<div class="contact-container">

    <div class="contact-header">
        <h1>Contact Us</h1>
        <p>Please fill this form in a decent manner</p>
    </div>

    <form class="contact-form"
          action="<%= request.getContextPath() %>/contact"
          method="post"
          autocomplete="off">

        <div class="form-group">
            <label for="fullName">Full Name</label>

            <input
                    type="text"
                    id="fullName"
                    name="fullName"
                    required
                    autocomplete="off">
        </div>

        <div class="form-group">
            <label for="email">Email</label>

            <input
                    type="email"
                    id="email"
                    name="email"
                    required
                    autocomplete="off">
        </div>

        <div class="form-group">
            <label for="message">Message</label>

            <textarea
                    id="message"
                    name="message"
                    required></textarea>
        </div>

        <div class="button-row">

            <!-- Submit button -->
            <button type="submit" class="submit-btn">
                SUBMIT
            </button>

            <!-- Admin button -->
            <a href="<%= request.getContextPath() %>/login.jsp"
               class="admin-btn">
                Admin Login
            </a>

        </div>

    </form>

</div>

</body>
</html>