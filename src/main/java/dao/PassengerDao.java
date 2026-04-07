package dao;

import java.sql.Statement; // <-- ADD THIS LINE
import java.sql.*;
import java.util.ArrayList; // ✅ Fixed: Import ArrayList
import java.util.List;      // ✅ Fixed: Import List
import model.Passenger;
import db.DBConnection;

public class PassengerDao {

/**
     * MODIFIED: Adds a new passenger and returns their new ID.
     * This method now returns the generated passenger_id, or -1 if it fails.
     */
    public int addPassenger(Passenger passenger) throws SQLException { 
        int newPassengerId = -1; // Default to -1 (failure)
        String query = "INSERT INTO passenger (name, age, gender) VALUES (?, ?, ?)";
        
        // Use try-with-resources and ask for generated keys
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, passenger.getName());
            ps.setInt(2, passenger.getAge());
            ps.setString(3, passenger.getGender());

            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                // Get the generated ID
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        newPassengerId = rs.getInt(1); // Get the first generated key
                    }
                }
            }
        } // Connection and PreparedStatement are auto-closed here
        
        return newPassengerId; // Return the new ID (or -1)
    }

    // ✅ This is the method that was broken
    public List<Passenger> getAllPassengers() {
        List<Passenger> list = new ArrayList<>();
        String query = "SELECT * FROM passenger"; // Table is 'passenger'

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Passenger p = new Passenger();
                // ✅ FINAL FIX: Read from the 'passenger_id' column based on your screenshot image_3ea2dc.png
                p.setPassengerId(rs.getInt("passenger_id")); 
                p.setName(rs.getString("name"));   
                p.setAge(rs.getInt("age"));       
                p.setGender(rs.getString("gender")); 
                list.add(p);
            }
        } catch (Exception e) {
            // Keep printing the error for debugging, just in case
            e.printStackTrace(); 
        }
        return list; // Returns the list (or empty list if error)
    }
}

