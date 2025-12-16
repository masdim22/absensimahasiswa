package koneksi;

import java.sql.Connection;
import java.sql.DriverManager;

public class Koneksi {

    public static Connection getConnection() {
        try {
            
            Class.forName("com.mysql.jdbc.Driver");

            
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/db_absensi",
                "root",
                ""
            );

            return con;

        } catch (Exception e) {
            System.out.println("Koneksi Gagal: " + e.getMessage());
            return null;
        }
    }
}
