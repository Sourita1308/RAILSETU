package model;

// This is the model class for a User
public class User {
    private int id;
    private String name;
    private String email;
    private String phone;
    private String location;
    private String locationType;
    private int age;
    
    // This is a temporary field to hold the plain-text password
    // during registration ONLY. It is NOT stored in the database.
    private String password;
    
    // This is for the HASHED password from the database
    private String passwordHash;

    // Default constructor
    public User() {}

    // Constructor for registration
    public User(String name, String email, String phone, String location, String locationType, String password, int age) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.location = location;
        this.locationType = locationType;
        this.password = password; // Plain-text password
        this.age = age;
    }

    // --- Getters and Setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getLocationType() { return locationType; }
    public void setLocationType(String locationType) { this.locationType = locationType; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    // --- Password Getters/Setters ---
    // This is for the plain-text password during registration
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // This is for the hashed password from the DB
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
}

