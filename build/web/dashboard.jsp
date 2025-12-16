<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // SESSION CHECK
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <h2>Dashboard</h2>

    <p>Selamat datang, <b><%= session.getAttribute("user") %></b></p>
<a href="logout.jsp" onclick="return confirm('Yakin ingin logout?')">Logout</a>

    <hr>

    <ul>
        <li><a href="mahasiswa.jsp">Data Mahasiswa</a></li>
        <li><a href="absensi.jsp">Absensi Mahasiswa</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</div>

</body>
</html>

