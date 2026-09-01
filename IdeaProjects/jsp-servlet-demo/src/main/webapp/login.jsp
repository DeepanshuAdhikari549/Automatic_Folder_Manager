<%@ page contentType="text/html;charset=UTF-8" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Login</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }

        .login-container {
            width: 90%;
            max-width: 450px;
            margin: 80px auto;
            background: white;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.12);
        }

        h1 {
            margin-top: 0;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }

        input:focus {
            outline: none;
            border-color: #555;
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            background: #222;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #444;
        }

        .error {
            margin-bottom: 20px;
            padding: 12px;
            background: #ffe8e8;
            color: #a00000;
            border-radius: 5px;
        }

        .back {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #333;
            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="login-container">

    <h1>Admin Login</h1>

    <% if (request.getParameter("error") != null) { %>

        <div class="error">
            <%= request.getParameter("error") %>
        </div>

    <% } %>

    <form
            action="<%= request.getContextPath() %>/admin/login"
            method="post"
            autocomplete="off">

        <div class="form-group">

            <label for="username">
                Username
            </label>

            <input
                    type="text"
                    id="username"
                    name="username"
                    required
                    autocomplete="username">

        </div>

        <div class="form-group">

            <label for="password">
                Password
            </label>

            <input
                    type="password"
                    id="password"
                    name="password"
                    required
                    autocomplete="new-password">

        </div>

        <button type="submit">
            LOGIN
        </button>

    </form>

    <a
            class="back"
            href="<%= request.getContextPath() %>/contactus.jsp">
        Back to Contact Us
    </a>

</div>

</body>

</html>