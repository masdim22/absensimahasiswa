<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="koneksi.Koneksi"%>

<!DOCTYPE html>
<html>
<head>
    <title>Data Mahasiswa</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <h2>Data Mahasiswa</h2>

    <!-- FORM INPUT MAHASISWA -->
    <form method="post">
        <input type="hidden" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">

        <input type="text" name="nim" placeholder="NIM" required
               value="<%= request.getParameter("nim") != null ? request.getParameter("nim") : "" %>">

        <input type="text" name="nama" placeholder="Nama" required
               value="<%= request.getParameter("nama") != null ? request.getParameter("nama") : "" %>">

        <input type="text" name="jurusan" placeholder="Jurusan" required
               value="<%= request.getParameter("jurusan") != null ? request.getParameter("jurusan") : "" %>">

        <button type="submit" name="simpan">Simpan</button>
        <button type="submit" name="update">Update</button>
    </form>

    <hr>

    <!-- PROSES CREATE & UPDATE -->
    <%
        Connection con = Koneksi.getConnection();

        // SIMPAN DATA (CREATE)
        if (request.getParameter("simpan") != null) {
            String sql = "INSERT INTO mahasiswa (nim, nama, jurusan) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("nim"));
            ps.setString(2, request.getParameter("nama"));
            ps.setString(3, request.getParameter("jurusan"));
            ps.executeUpdate();
            response.sendRedirect("mahasiswa.jsp");
        }

        // UPDATE DATA
        if (request.getParameter("update") != null) {
            String sql = "UPDATE mahasiswa SET nim=?, nama=?, jurusan=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("nim"));
            ps.setString(2, request.getParameter("nama"));
            ps.setString(3, request.getParameter("jurusan"));
            ps.setString(4, request.getParameter("id"));
            ps.executeUpdate();
            response.sendRedirect("mahasiswa.jsp");
        }

        // DELETE DATA
        if (request.getParameter("hapus") != null) {
            String sql = "DELETE FROM mahasiswa WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("hapus"));
            ps.executeUpdate();
            response.sendRedirect("mahasiswa.jsp");
        }
    %>

    <!-- TABEL DATA MAHASISWA (READ) -->
    <table border="1" width="100%" cellpadding="5">
        <tr>
            <th>No</th>
            <th>NIM</th>
            <th>Nama</th>
            <th>Jurusan</th>
            <th>Aksi</th>
        </tr>

        <%
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM mahasiswa");
            int no = 1;
            while (rs.next()) {
        %>
        <tr>
            <td><%= no++ %></td>
            <td><%= rs.getString("nim") %></td>
            <td><%= rs.getString("nama") %></td>
            <td><%= rs.getString("jurusan") %></td>
            <td>
                <a href="mahasiswa.jsp?id=<%=rs.getString("id")%>&nim=<%=rs.getString("nim")%>&nama=<%=rs.getString("nama")%>&jurusan=<%=rs.getString("jurusan")%>">Edit</a>
                |
                <a href="mahasiswa.jsp?hapus=<%=rs.getString("id")%>" onclick="return confirm('Yakin hapus?')">Hapus</a>
            </td>
        </tr>
        <% } %>
    </table>

    <br>
    <a href="dashboard.jsp">Kembali ke Dashboard</a>

</div>

</body>
</html>
