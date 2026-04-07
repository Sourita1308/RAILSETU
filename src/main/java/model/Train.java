package model;

import java.sql.Time; // Make sure to import java.sql.Time

public class Train {
    
    // Fields matching your new database table
    private int trainId;
    private int trainNo;
    private String trainName;
    private String trainType;
    private String sourceStation;
    private String destinationStation;
    private Time departureTime;
    private String frequency;
    private String classes;
    
    // --- NEW FIELDS WE ADDED ---
    private Time arrivalTime;
    private String endDestination;
    private Time destinationTime;
    private double fare;


    // A no-argument constructor is good practice
    public Train() {}

    // --- Getters and Setters for ALL fields ---

    public int getTrainId() { return trainId; }
    public void setTrainId(int trainId) { this.trainId = trainId; }

    public int getTrainNo() { return trainNo; }
    public void setTrainNo(int trainNo) { this.trainNo = trainNo; }

    public String getTrainName() { return trainName; }
    public void setTrainName(String trainName) { this.trainName = trainName; }

    public String getTrainType() { return trainType; }
    public void setTrainType(String trainType) { this.trainType = trainType; }

    public String getSourceStation() { return sourceStation; }
    public void setSourceStation(String sourceStation) { this.sourceStation = sourceStation; }

    public String getDestinationStation() { return destinationStation; }
    public void setDestinationStation(String destinationStation) { this.destinationStation = destinationStation; }

    public Time getDepartureTime() { return departureTime; }
    public void setDepartureTime(Time departureTime) { this.departureTime = departureTime; }

    public String getFrequency() { return frequency; }
    public void setFrequency(String frequency) { this.frequency = frequency; }

    public String getClasses() { return classes; }
    public void setClasses(String classes) { this.classes = classes; }

    // --- GETTERS/SETTERS FOR NEW FIELDS ---

    public Time getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(Time arrivalTime) { this.arrivalTime = arrivalTime; }

    public String getEndDestination() { return endDestination; }
    public void setEndDestination(String endDestination) { this.endDestination = endDestination; }

    public Time getDestinationTime() { return destinationTime; }
    public void setDestinationTime(Time destinationTime) { this.destinationTime = destinationTime; }

    public double getFare() { return fare; }
    public void setFare(double fare) { this.fare = fare; }
}