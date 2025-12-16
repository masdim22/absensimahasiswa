<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="koneksi.Koneksi"%>

<%
    
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Absensi Mahasiswa</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <h2>Absensi Mahasiswa</h2>

    
    <form method="post">
        <input type="hidden" name="id"
               value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">

        <input type="text" name="nim" placeholder="NIM Mahasiswa" required
               value="<%= request.getParameter("nim") != null ? request.getParameter("nim") : "" %>">

        <input type="date" name="tanggal" required
               value="<%= request.getParameter("tanggal") != null ? request.getParameter("tanggal") : "" %>">

        <select name="status" required>
            <option value="">-- Pilih Status --</option>
            <option value="Hadir">Hadir</option>
            <option value="Izin">Izin</option>
            <option value="Alpha">Alpha</option>
        </select>

        <button type="submit" name="simpan">Simpan</button>
        <button type="submit" name="update">Update</button>
    </form>

    <hr>

    <%
        Connection con = Koneksi.getConnection();

        
        if (request.getParameter("simpan") != null) {
            String sql = "INSERT INTO absensi (nim, tanggal, status) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("nim"));
            ps.setString(2, request.getParameter("tanggal"));
            ps.setString(3, request.getParameter("status"));
            ps.executeUpdate();
            response.sendRedirect("absensi.jsp");
        }

      
        if (request.getParameter("update") != null) {
            String sql = "UPDATE absensi SET nim=?, tanggal=?, status=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("nim"));
            ps.setString(2, request.getParameter("tanggal"));
            ps.setString(3, request.getParameter("status"));
            ps.setString(4, request.getParameter("id"));
            ps.executeUpdate();
            response.sendRedirect("absensi.jsp");
        }

       
        if (request.getParameter("hapus") != null) {
            String sql = "DELETE FROM absensi WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("hapus"));
            ps.executeUpdate();
            response.sendRedirect("absensi.jsp");
        }
    %>

    
    <table border="1" width="100%" cellpadding="5">
        <tr>
            <th>No</th>
            <th>NIM</th>
            <th>Tanggal</th>
            <th>Status</th>
            <th>Aksi</th>
        </tr>

        <%
            ResultSet rs = con.createStatement().executeQuery("SELECT * FROM absensi ORDER BY tanggal DESC");
            int no = 1;
            while (rs.next()) {
        %>
        <tr>
            <td><%= no++ %></td>
            <td><%= rs.getString("nim") %></td>
            <td><%= rs.getString("tanggal") %></td>
            <td><%= rs.getString("status") %></td>
            <td>
                <a href="absensi.jsp?id=<%=rs.getString("id")%>
                   &nim=<%=rs.getString("nim")%>
                   &tanggal=<%=rs.getString("tanggal")%>
                   &status=<%=rs.getString("status")%>">Edit</a>
                |
                <a href="absensi.jsp?hapus=<%=rs.getString("id")%>"
                   onclick="return confirm('Yakin hapus data?')">Hapus</a>
            </td>
        </tr>
        <% } %>
    </table>

    <br>
    <a href="dashboard.jsp">Kembali ke Dashboard</a>

</div>

</body>
</html>
