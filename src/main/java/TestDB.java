import dao.UserDAO;
import db.DBConnection;
import java.sql.SQLException;
import java.sql.Connection;

public class TestDB {
    public static void main(String[] args) {
        System.out.println("Testing DB Connection...");
        try {
            Connection con = DBConnection.getConnection();
            System.out.println("Connection successful!");
            UserDAO dao = new UserDAO();
            try {
                System.out.println("Finding user...");
                dao.findUserByEmail("test@test.com");
                System.out.println("Find user successful.");
                
                System.out.println("Updating password...");
                dao.updatePassword("test@test.com", "newpass123");
                System.out.println("Update successful.");
            } catch (SQLException e) {
                System.err.println("SQL Exception during DAO operation:");
                e.printStackTrace();
            }
        } catch (Exception e) {
            System.err.println("Exception:");
            e.printStackTrace();
        }
    }
}
