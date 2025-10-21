package model;

public class Ticket {
    private int ticketId;
    private int passengerId;
    private int trainId;

    public Ticket() {}

    public Ticket(int passengerId, int trainId) {
        this.passengerId = passengerId;
        this.trainId = trainId;
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
}
