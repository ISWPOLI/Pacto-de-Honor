
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MyDb {

    Connection con;

    public Connection getCon() {

        if (con == null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pactohonor", "root", "");
                return con;
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(MyDb.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return con;

    }
}
