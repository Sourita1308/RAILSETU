package model;

public class Ticket {
    private int ticketId;
    private int passengerId;
    private int trainId;
    private java.sql.Date journeyDate;

    public Ticket() {}

    public Ticket(int passengerId, int trainId) {
        this.passengerId = passengerId;
        this.trainId = trainId;
    }

    public Ticket(int passengerId, int trainId, java.sql.Date journeyDate) {
        this.passengerId = passengerId;
        this.trainId = trainId;
        this.journeyDate = journeyDate;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getPassengerId() {
        return passengerId;
    }

    public void setPassengerId(int passengerId) {
        this.passengerId = passengerId;
    }

    public int getTrainId() {
        return trainId;
    }

    public void setTrainId(int trainId) {
        this.trainId = trainId;
    }

    public java.sql.Date getJourneyDate() {
        return journeyDate;
    }

    public void setJourneyDate(java.sql.Date journeyDate) {
        this.journeyDate = journeyDate;
    }
}
