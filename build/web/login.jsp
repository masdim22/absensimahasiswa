<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="koneksi.Koneksi"%>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <h2>Login</h2>

    <form method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit" name="login">Login</button>
    </form>

    <p>
        <a href="register.jsp">Register</a> |
        <a href="lupa_password.jsp">Lupa Password</a>
    </p>

    <%
        // PROSES LOGIN
        if (request.getParameter("login") != null) {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Connection con = Koneksi.getConnection();

            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                
                session.setAttribute("user", rs.getString("nama"));
                session.setAttribute("email", rs.getString("email"));

                response.sendRedirect("dashboard.jsp");
            } else {
    %>
                <p style="color:red;">Email atau Password salah</p>
    <%
            }
        }
    %>

</div>

</body>
</html>
