package dao;

import db.DBConnection;
import model.Train; // Make sure this imports your new Train model

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time; // Added this import
import java.util.ArrayList;
import java.util.List;

public class TrainDAO {

    /**
     * NEW METHOD: Gets all trains for a specific route.
     */
    public List<Train> getTrainsByRoute(String source, String destination) {
        List<Train> trains = new ArrayList<>();
        // Query uses new column names
        String sql = "SELECT * FROM trains WHERE source_station = ? AND destination_station = ?"; 
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, source);
            ps.setString(2, destination);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Use the helper method to populate the train object
                    trains.add(mapResultSetToTrain(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trains;
    }

    /**
     * NEW METHOD: Gets all unique station names to populate the dropdowns.
     */
    public List<String> getAllStations() {
        List<String> stations = new ArrayList<>();
        // This query gets all unique station names from both columns
        String sql = "SELECT DISTINCT station FROM (" +
                     "  SELECT source_station AS station FROM trains " +
                     "  UNION " +
                     "  SELECT destination_station AS station FROM trains" +
                     ") AS all_stations ORDER BY station";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                stations.add(rs.getString("station"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stations;
    }

    /**
     * UPDATED METHOD: Fetches all trains.
     * (Used by your ViewTrainsServlet)
     */
    public List<Train> getAllTrains() {
        List<Train> trainList = new ArrayList<>();
        String sql = "SELECT * FROM trains";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // Uses the helper method
                trainList.add(mapResultSetToTrain(rs)); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trainList;
    }
    
    /**
     * UPDATED METHOD: Gets a single train by its ID.
     * (Used by your LoadTrainForUpdateServlet)
     */
    public Train getTrainById(int trainId) {
        Train train = null;
        String sql = "SELECT * FROM trains WHERE train_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, trainId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Uses the helper method
                    train = mapResultSetToTrain(rs); 
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return train;
    }

    /**
     * UPDATED METHOD: Adds a new train.
     * (Used by your TrainServlet)
     * NOTE: Your TrainServlet and addTrain.html will also need to be
     * updated to send all this new information.
     */
    public boolean addTrain(Train train) throws SQLException {
        // SQL now uses all the new columns
        String sql = "INSERT INTO trains (train_no, train_name, train_type, source_station, " +
                     "destination_station, departure_time, frequency, classes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Uses new getters from the Train model
            ps.setInt(1, train.getTrainNo());
            ps.setString(2, train.getTrainName());
            ps.setString(3, train.getTrainType());
            ps.setString(4, train.getSourceStation());
            ps.setString(5, train.getDestinationStation());
            ps.setTime(6, train.getDepartureTime());
            ps.setString(7, train.getFrequency());
            ps.setString(8, train.getClasses());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    /**
     * UPDATED METHOD: Updates an existing train.
     * (Used by your UpdateTrainServlet)
     */
    public boolean updateTrain(Train train) throws SQLException {
        // SQL now uses all the new columns
        String sql = "UPDATE trains SET train_no = ?, train_name = ?, train_type = ?, " +
                     "source_station = ?, destination_station = ?, departure_time = ?, " +
                     "frequency = ?, classes = ? WHERE train_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Uses new getters from the Train model
            ps.setInt(1, train.getTrainNo());
            ps.setString(2, train.getTrainName());
            ps.setString(3, train.getTrainType());
            ps.setString(4, train.getSourceStation());
            ps.setString(5, train.getDestinationStation());
            ps.setTime(6, train.getDepartureTime());
            ps.setString(7, train.getFrequency());
            ps.setString(8, train.getClasses());
            ps.setInt(9, train.getTrainId()); // This is for the WHERE clause

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    /**
     * Standard CRUD method: Deletes a train.
     */
    public boolean deleteTrain(int trainId) throws SQLException {
        String sql = "DELETE FROM trains WHERE train_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, trainId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    /**
     * Private helper method to avoid duplicate code.
     * Maps a ResultSet row to a Train object using new columns.
     */
    private Train mapResultSetToTrain(ResultSet rs) throws SQLException {
    Train train = new Train();
    
    // --- OLD FIELDS ---
    train.setTrainId(rs.getInt("train_id"));
    train.setTrainNo(rs.getInt("train_no"));
    train.setTrainName(rs.getString("train_name"));
    train.setTrainType(rs.getString("train_type"));
    train.setSourceStation(rs.getString("source_station"));
    train.setDestinationStation(rs.getString("destination_station"));
    train.setDepartureTime(rs.getTime("departure_time"));
    train.setFrequency(rs.getString("frequency"));
    train.setClasses(rs.getString("classes"));

    // --- NEW FIELDS ---
    train.setArrivalTime(rs.getTime("arrival_time"));
    train.setEndDestination(rs.getString("end_destination"));
    train.setDestinationTime(rs.getTime("destination_time"));
    train.setFare(rs.getDouble("fare"));
    
    return train;
}
}