package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db.DBConnection;
import model.BookingDetails; // Use the BookingDetails model for JOIN results
import model.Ticket;

public class TicketDAO {

    static {
        ensureJourneyDateColumn();
    }

    /**
     * Ensures that the tickets table has the journey_date column.
     */
    public static void ensureJourneyDateColumn() {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("ALTER TABLE tickets ADD COLUMN journey_date DATE NULL");
        } catch (SQLException ignored) {
            // Column already exists or table altered
        }
    }

    /**
     * Books a new ticket with journey date linking user, train, and passenger.
     */
    public boolean bookTicket(int userId, int trainId, int passengerId, java.sql.Date journeyDate) throws SQLException {
        ensureJourneyDateColumn();
        String sql = "INSERT INTO tickets (user_id, train_id, passenger_id, journey_date) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setInt(2, trainId);
            ps.setInt(3, passengerId);
            ps.setDate(4, journeyDate);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            // Fallback if journey_date column error occurs
            return bookTicket(userId, trainId, passengerId);
        }
    }

    /**
     * Books a new ticket by linking user, train, and passenger.
     */
    public boolean bookTicket(int userId, int trainId, int passengerId) throws SQLException {
        String sql = "INSERT INTO tickets (user_id, train_id, passenger_id) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setInt(2, trainId);
            ps.setInt(3, passengerId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
    
    /**
     * FIXED METHOD: This now selects the correct column names
     * (source_station, destination_station) from the 'trains' table.
     */
    public List<BookingDetails> getAllBookings() {
        List<BookingDetails> list = new ArrayList<>();
        
        String query = "SELECT t.ticket_id as booking_id, t.journey_date, p.name as passenger_name, p.age, " + 
                       "tr.train_name, tr.source_station, tr.destination_station, tr.fare " + 
                       "FROM tickets t " +
                       "JOIN passenger p ON t.passenger_id = p.passenger_id " +
                       "JOIN trains tr ON t.train_id = tr.train_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BookingDetails bd = new BookingDetails();
                bd.setBookingId(rs.getInt("booking_id"));
                bd.setPassengerName(rs.getString("passenger_name"));
                bd.setTrainName(rs.getString("train_name"));
                
                bd.setSource(rs.getString("source_station"));
                bd.setDestination(rs.getString("destination_station"));
                
                bd.setAge(rs.getInt("age"));
                bd.setFare(rs.getDouble("fare"));
                try {
                    bd.setJourneyDate(rs.getDate("journey_date"));
                } catch (SQLException ignored) {}
                list.add(bd);
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        }
        return list; 
    }
    
    /**
     * This method fetches bookings only for a specific user.
     * This is used by your ViewBookingsServlet.
     */
    public List<BookingDetails> getAllBookingsByUserId(int userId) {
        List<BookingDetails> list = new ArrayList<>();
        
        String query = "SELECT t.ticket_id as booking_id, t.journey_date, p.name as passenger_name, p.age, " +
                       "tr.train_name, tr.source_station, tr.destination_station, tr.fare " +
                       "FROM tickets t " +
                       "JOIN passenger p ON t.passenger_id = p.passenger_id " +
                       "JOIN trains tr ON t.train_id = tr.train_id " +
                       "WHERE t.user_id = ?"; // Filter by the logged-in user

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, userId); // Set the user ID parameter
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingDetails bd = new BookingDetails();
                    bd.setBookingId(rs.getInt("booking_id"));
                    bd.setPassengerName(rs.getString("passenger_name"));
                    bd.setTrainName(rs.getString("train_name"));
                    
                    bd.setSource(rs.getString("source_station"));
                    bd.setDestination(rs.getString("destination_station"));
                    
                    bd.setAge(rs.getInt("age"));
                    bd.setFare(rs.getDouble("fare"));
                    try {
                        bd.setJourneyDate(rs.getDate("journey_date"));
                    } catch (SQLException ignored) {}
                    list.add(bd);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    /**
     * This method correctly deletes a booking.
     */
    public boolean cancelBooking(int bookingId) throws SQLException {
        String query = "DELETE FROM tickets WHERE ticket_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, bookingId);
            int rows = ps.executeUpdate();
            return (rows > 0);
        }
    }

    /**
     * NEW METHOD: Gets all details for a single booking.
     * This is used by the PrintTicketServlet.
     */
    public BookingDetails getBookingById(int bookingId) {
        BookingDetails bd = null;
        
        String query = "SELECT t.ticket_id as booking_id, t.journey_date, " +
                       "p.name as passenger_name, p.age, p.gender, " +
                       "tr.train_no, tr.train_name, tr.source_station, tr.destination_station, " +
                       "tr.departure_time, tr.arrival_time, tr.fare " +
                       "FROM tickets t " +
                       "JOIN passenger p ON t.passenger_id = p.passenger_id " +
                       "JOIN trains tr ON t.train_id = tr.train_id " +
                       "WHERE t.ticket_id = ?"; 

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            
            ps.setInt(1, bookingId); // Set the booking ID
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bd = new BookingDetails();
                    bd.setBookingId(rs.getInt("booking_id"));
                    bd.setPassengerName(rs.getString("passenger_name"));
                    bd.setAge(rs.getInt("age"));
                    bd.setGender(rs.getString("gender"));
                    bd.setTrainNo(rs.getInt("train_no"));
                    bd.setTrainName(rs.getString("train_name"));
                    bd.setSource(rs.getString("source_station"));
                    bd.setDestination(rs.getString("destination_station"));
                    bd.setDepartureTime(rs.getTime("departure_time"));
                    bd.setArrivalTime(rs.getTime("arrival_time"));
                    bd.setFare(rs.getDouble("fare"));
                    try {
                        bd.setJourneyDate(rs.getDate("journey_date"));
                    } catch (SQLException ignored) {}
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bd;
    }
}