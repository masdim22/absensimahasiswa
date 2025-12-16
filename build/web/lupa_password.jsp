<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="koneksi.Koneksi"%>

<!DOCTYPE html>
<html>
<head>
    <title>Lupa Password</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <h2>Lupa Password</h2>

    <form method="post">
        <input type="email" name="email" placeholder="Email Terdaftar" required>
        <input type="password" name="password" placeholder="Password Baru" required>

        <button type="submit" name="reset">Reset Password</button>
    </form>

    <p>
        <a href="login.jsp">Kembali ke Login</a>
    </p>

    <%
        // PROSES RESET PASSWORD
        if (request.getParameter("reset") != null) {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Connection con = Koneksi.getConnection();

            String sql = "UPDATE users SET password=? WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, password);
            ps.setString(2, email);

            int hasil = ps.executeUpdate();

            if (hasil > 0) {
    %>
                <p style="color:green;">Password berhasil direset</p>
    <%
            } else {
    %>
                <p style="color:red;">Email tidak ditemukan</p>
    <%
            }
        }
    %>

</div>

</body>
</html>
