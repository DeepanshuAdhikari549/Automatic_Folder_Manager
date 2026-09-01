<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Contact Us</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }

        .contact-container {
            width: 90%;
            max-width: 650px;
            margin: 60px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.12);
            overflow: hidden;
        }

        .contact-header {
            padding: 30px;
            background: #f8f8f8;
            border-bottom: 1px solid #ddd;
        }

        .contact-header h1 {
            margin: 0 0 8px;
            font-size: 28px;
        }

        .contact-header p {
            margin: 0;
            color: #666;
        }

        .contact-form {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #555;
        }

        .button-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 10px;
        }

        .submit-btn,
        .admin-btn {
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
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

        .success {
            margin: 0 30px 20px;
            padding: 12px;
            background: #e8f7e8;
            color: #237523;
            border-radius: 5px;
        }

        .error {
            margin: 0 30px 20px;
            padding: 12px;
            background: #ffe8e8;
            color: #a00000;
            border-radius: 5px;
        }

        @media (max-width: 600px) {

            .contact-container {
                width: 95%;
                margin: 20px auto;
            }

            .button-row {
                flex-direction: column;
                align-items: stretch;
            }

            .submit-btn,
            .admin-btn {
                text-align: center;
            }
        }

    </style>

</head>

<body>

<div class="contact-container">

    <div class="contact-header">

        <h1>Contact Us</h1>

        <p>
            Please fill this form in a decent manner
        </p>

    </div>


    <%-- SUCCESS MESSAGE --%>

    <% if ("true".equals(request.getParameter("success"))) { %>

        <div class="success">
            Your message has been submitted successfully.
        </div>

    <% } %>


    <%-- ERROR MESSAGE --%>

    <% if (request.getParameter("error") != null) { %>

        <div class="error">
            <%= request.getParameter("error") %>
        </div>

    <% } %>


    <form
            class="contact-form"
            action="<%= request.getContextPath() %>/contact"
            method="post">

        <div class="form-group">

            <label for="fullName">
                Full Name
            </label>

            <input
                    type="text"
                    id="fullName"
                    name="fullName"
                    required
                    autocomplete="name">

        </div>


        <div class="form-group">

            <label for="email">
                Email
            </label>

            <input
                    type="email"
                    id="email"
                    name="email"
                    required
                    autocomplete="email">

        </div>


        <div class="form-group">

            <label for="message">
                Message
            </label>

            <textarea
                    id="message"
                    name="message"
                    required></textarea>

        </div>


        <div class="button-row">

            <button
                    type="submit"
                    class="submit-btn">
                SUBMIT
            </button>

            <a
                    href="<%= request.getContextPath() %>/login.jsp"
                    class="admin-btn">
                ADMIN LOGIN
            </a>

        </div>

    </form>

</div>

</body>

</html>