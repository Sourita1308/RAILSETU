package model;

public class Passenger {
    private int passengerId;
    private String name;
    private int age;
    private String gender;

    public Passenger() {
        // default constructor
    }

    // ✅ Add this constructor to fix the error
    public Passenger(String name, int age, String gender) {
        this.name = name;
        this.age = age;
        this.gender = gender;
    }

    // Getters and setters
    public int getPassengerId() { return passengerId; }
    public void setPassengerId(int passengerId) { this.passengerId = passengerId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
}
