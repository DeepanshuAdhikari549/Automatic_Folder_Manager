<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="login-container">
    <h1>Admin Login</h1>
    <form
            action="${pageContext.request.contextPath}/admin/login"
            method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Password </label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="submit-button"> Login
        </button>
    </form>
    <a href="${pageContext.request.contextPath}/"> Back to Contact Us </a>
</div>
</body>
</html>