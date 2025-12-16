<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
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

    <!-- HEADER -->
    <div class="dashboard-header">
        <h2>Dashboard</h2>
        <p>Selamat datang, <b><%= session.getAttribute("user") %></b></p>
    </div>

    <!-- MENU -->
    <div class="dashboard-menu">

        <a href="mahasiswa.jsp" class="dashboard-card">
            <h3>📘 Data Mahasiswa</h3>
            <p>Kelola data mahasiswa</p>
        </a>

        <a href="absensi.jsp" class="dashboard-card">
            <h3>📝 Absensi Mahasiswa</h3>
            <p>Input dan lihat absensi</p>
        </a>

        <a href="logout.jsp" 
           class="dashboard-card logout"
           onclick="return confirm('Yakin ingin logout?')">
            <h3>🚪 Logout</h3>
            <p>Keluar dari sistem</p>
        </a>

    </div>

</div>

</body>
</html>
