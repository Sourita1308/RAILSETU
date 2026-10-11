package model;

import java.sql.Time;

// This model holds the combined results from a JOIN query
public class BookingDetails {

    // From tickets table
    private int bookingId;
    
    // From passenger table
    private String passengerName;
    private int age;
    private String gender; // <-- NEW
    
    // From trains table
    private String trainName;
    private int trainNo; // <-- NEW
    private String source;
    private String destination;
    private Time departureTime; // <-- NEW
    private Time arrivalTime; // <-- NEW
    private java.sql.Date journeyDate;
    private double fare;

    // --- Getters and Setters for all fields ---

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getPassengerName() { return passengerName; }
    public void setPassengerName(String passengerName) { this.passengerName = passengerName; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getGender() { return gender; } // <-- NEW
    public void setGender(String gender) { this.gender = gender; } // <-- NEW

    public String getTrainName() { return trainName; }
    public void setTrainName(String trainName) { this.trainName = trainName; }

    public int getTrainNo() { return trainNo; } // <-- NEW
    public void setTrainNo(int trainNo) { this.trainNo = trainNo; } // <-- NEW

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public Time getDepartureTime() { return departureTime; } // <-- NEW
    public void setDepartureTime(Time departureTime) { this.departureTime = departureTime; } // <-- NEW

    public Time getArrivalTime() { return arrivalTime; } // <-- NEW
    public void setArrivalTime(Time arrivalTime) { this.arrivalTime = arrivalTime; } // <-- NEW

    public java.sql.Date getJourneyDate() { return journeyDate; }
    public void setJourneyDate(java.sql.Date journeyDate) { this.journeyDate = journeyDate; }

    public double getFare() { return fare; }
    public void setFare(double fare) { this.fare = fare; }
}