package model;

public class Train {
    private int trainId;
    private String trainName;
    private String source;
    private String destination;
    private double fare;

    // Constructors
    public Train() {}
    public Train(String trainName, String source, String destination, double fare) {
        this.trainName = trainName;
        this.source = source;
        this.destination = destination;
        this.fare = fare;
    }

    // Getters and setters
    public int getTrainId() { return trainId; }
    public void setTrainId(int trainId) { this.trainId = trainId; }
    public String getTrainName() { return trainName; }
    public void setTrainName(String trainName) { this.trainName = trainName; }
    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }
    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }
    public double getFare() { return fare; }
    public void setFare(double fare) { this.fare = fare; }
}
