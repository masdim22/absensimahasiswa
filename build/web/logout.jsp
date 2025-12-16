<%
    // Hapus semua session
    session.invalidate();

    // Kembali ke halaman login
    response.sendRedirect("login.jsp");
%>
