<%@ page import="java.util.List" %>
<%@ page import="org.example.model.ContactRequest" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%
    response.setHeader(
          "Cache-Control",
            "no-cache, no-store, must-revalidate"
    );

    response.setHeader(
            "Pragma",
            "no-cache"
    );

    response.setDateHeader(
            "Expires",
            0
    );

    if (session.getAttribute("adminLoggedIn") == null ||
            !Boolean.TRUE.equals(
                    session.getAttribute("adminLoggedIn")
            )) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );

        return;
    }

    String adminUsername =
            (String) session.getAttribute("adminUsername");

    List<ContactRequest> requests =
            (List<ContactRequest>)
                    request.getAttribute("requests");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Panel</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }

        /* ================= HEADER ================= */

        .header {
            background: #222;
            color: white;

            padding: 20px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .logout-btn {
            background: #e74c3c;
            color: white;

            text-decoration: none;

            padding: 10px 16px;

            border-radius: 5px;

            font-weight: bold;
        }

        .logout-btn:hover {
            background: #c0392b;
        }

        /* ================= CONTAINER ================= */

        .container {
            width: 95%;
            max-width: 1200px;

            margin: 30px auto;
        }

        /* ================= SECTION ================= */

        .section {
            background: white;

            margin-bottom: 30px;

            padding: 25px;

            border-radius: 8px;

            box-shadow:
                    0 3px 12px rgba(0,0,0,0.08);
        }

        .section h2 {
            margin-top: 0;
            margin-bottom: 20px;
        }

        /* ================= REQUEST CARD ================= */

        .request-card {
            border: 1px solid #ddd;

            border-radius: 7px;

            padding: 20px;

            margin-bottom: 15px;

            background: #fafafa;
        }

        .request-card h3 {
            margin-top: 0;
            margin-bottom: 15px;
        }

        .field {
            margin-bottom: 8px;
        }

        .field strong {
            display: inline-block;
            width: 100px;
        }

        /* ================= MESSAGE ================= */

        .message {
            white-space: pre-wrap;

            margin-top: 10px;

            padding: 12px;

            background: white;

            border: 1px solid #ddd;

            border-radius: 5px;
        }

        /* ================= ARCHIVE BUTTON ================= */

        .archive-btn {
            margin-top: 15px;

            background: #777;

            color: white;

            border: none;

            padding: 10px 16px;

            border-radius: 5px;

            cursor: pointer;

            font-weight: bold;
        }

        .archive-btn:hover {
            background: #555;
        }

        /* ================= ARCHIVED ================= */

        .archived {
            background: #f0f0f0;

            opacity: 0.85;
        }

        /* ================= RESTORE ================= */

        .restore-btn {
            margin-top: 15px;

            background: #333;

            color: white;

            border: none;

            padding: 10px 16px;

            border-radius: 5px;

            cursor: pointer;
        }

        .restore-btn:hover {
            background: #111;
        }

        /* ================= EMPTY ================= */

        .empty {
            color: #777;

            padding: 15px 0;
        }

        /* ================= STATUS ================= */

        .status {
            display: inline-block;

            padding: 5px 10px;

            border-radius: 20px;

            font-size: 12px;

            font-weight: bold;
        }

        .active-status {
            background: #d9f7df;

            color: #20752e;
        }

        .archive-status {
            background: #ddd;

            color: #555;
        }

        /* ================= MOBILE ================= */

        @media (max-width: 700px) {

            .header {
                padding: 20px;

                flex-direction: column;

                align-items: flex-start;

                gap: 15px;
            }

            .header-right {
                width: 100%;

                justify-content: space-between;
            }

        }

    </style>

</head>

<body>


<!-- ================= HEADER ================= -->

<div class="header">

    <h1>Admin Panel</h1>

    <div class="header-right">

        <a
                href="<%= request.getContextPath() %>/logout"
                class="logout-btn">

            Logout

        </a>

    </div>

</div>


<div class="container">


    <!-- ================================================= -->
    <!-- ACTIVE REQUESTS -->
    <!-- ================================================= -->

    <div class="section">

        <h2>Active Requests</h2>

        <%

            boolean hasActive = false;

            if (requests != null) {

                for (ContactRequest contact : requests) {

                    if ("ACTIVE".equalsIgnoreCase(
                            contact.getStatus())) {

                        hasActive = true;

        %>
        <div class="request-card">

            <h3>
                <%= contact.getFullName() %>
            </h3>
            <!-- EMAIL -->

            <div class="field">

                <strong>Email:</strong>

                <%= contact.getEmail() %>

            </div>


            <!-- ID -->

            <div class="field">

                <strong>ID:</strong>

                <%= contact.getId() %>

            </div>


            <!-- STATUS -->

            <div class="field">

                <strong>Status:</strong>

                <span class="status active-status">
                    ACTIVE
                </span>

            </div>


            <!-- MESSAGE -->

            <div class="message">

                <%= contact.getMessage() %>

            </div>


            <!-- ARCHIVE -->

            <form
                    action="<%= request.getContextPath() %>/admin/archive"
                    method="post">

                <input
                        type="hidden"
                        name="id"
                        value="<%= contact.getId() %>">

                <button
                        type="submit"
                        class="archive-btn">
                    Archive
                </button>
            </form>
        </div>
        <%
                    }
                }
            }
            if (!hasActive) {
        %>
        <div class="empty">
            No active requests.
        </div>
        <%
            }
        %>

    </div>
    <div class="section">
        <h2>Archived Requests</h2>
        <%
        boolean hasArchived = false;
            if (requests != null) {

                for (ContactRequest contact : requests) {

                    if ("ARCHIVED".equalsIgnoreCase(
                            contact.getStatus())) {

                        hasArchived = true;

        %>


        <div class="request-card archived">

            <h3>
                <%= contact.getFullName() %>
            </h3>


            <!-- EMAIL -->

            <div class="field">

                <strong>Email:</strong>

                <%= contact.getEmail() %>

            </div>


            <!-- ID -->

            <div class="field">

                <strong>ID:</strong>

                <%= contact.getId() %>

            </div>


            <!-- STATUS -->

            <div class="field">

                <strong>Status:</strong>

                <span class="status archive-status">

                    ARCHIVED

                </span>

            </div>


            <!-- MESSAGE -->

            <div class="message">

                <%= contact.getMessage() %>

            </div>
            <form action="<%= request.getContextPath() %>/admin/contactus/restore" method="post">
                <input type="hidden" name="id" value="<%= contact.getId() %>">
                <button type="submit" class="restore-btn">
                    Restore
                </button>
            </form>
        </div>
        <%
                    }
                }
            }
            if (!hasArchived) {
        %>
        <div class="empty"> No archived requests.</div>
        <% } %>
    </div>
</div>
</body>

</html>