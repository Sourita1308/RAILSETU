<div align="center">
  
  # 🚂 RAILSETU - Railway Management System
  
  **A comprehensive, web-based CRUD application designed to seamlessly manage railway operations, including train schedules, passenger registrations, and ticket bookings.**

  [![Java Support](https://img.shields.io/badge/Java-17+-orange.svg?style=flat-square&logo=java)](#)
  [![Jakarta EE](https://img.shields.io/badge/Jakarta_EE-Servlets_&_JSP-blue.svg?style=flat-square&logo=eclipse)](#)
  [![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1.svg?style=flat-square&logo=mysql&logoColor=white)](#)
  [![Apache Tomcat](https://img.shields.io/badge/Tomcat-10.1+-F8DC75.svg?style=flat-square&logo=apachetomcat&logoColor=black)](#)
  [![Maven](https://img.shields.io/badge/Maven-Build_Tool-C71A36.svg?style=flat-square&logo=apachemaven&logoColor=white)](#)

</div>

---

## 🚀 Features

- **🚆 Train Management:** Admin portal to add new trains, update existing train details (source, destination, fare), and view a consolidated list of all available trains.
- **👥 Passenger Registration:** Seamless user registration flow to manage passengers by capturing their details (name, age, gender).
- **🎫 Ticket Booking System:** Dynamic and interactive booking interface allowing users to select registered passengers and pair them with available trains to confirm bookings.
- **📋 Booking Management:** Comprehensive dashboard to view all active bookings (displaying passenger details alongside train and fare information) with options to cancel specific bookings.
- **🔐 Secure Authentication:** Secured user credentials with BCrypt password hashing integration.

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| **Backend** | Java 17+, Jakarta EE (Servlets & JSP) |
| **Frontend** | HTML5, CSS3, JSP (JavaServer Pages), JSTL |
| **Database** | MySQL (Connector/J 8.0.33) |
| **Build Tool** | Maven |
| **Server** | Apache Tomcat (v10.1+) |
| **Security** | jBCrypt (Password Hashing) |

## 📋 Prerequisites

Ensure you have the following installed to run this project locally:

- **Java Development Kit (JDK)** 17 or higher
- **Apache Tomcat** 10.1 or higher *(Must support `jakarta.*` namespace)*
- **MySQL Server** 8.0.x
- **Maven** installed and added to your system `PATH`

## ⚙️ Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd RailwayManagement
   ```

2. **Database Setup:**
   - Ensure your MySQL server is running.
   - Create a new database for the application (e.g., `railway_db`).
   - Run the initial SQL scripts (if available) to set up tables.
   - Configure your database credentials in the application properties/context files.

3. **Build the project using Maven:**
   ```bash
   mvn clean install
   ```

4. **Deploy to Tomcat:**
   - Copy the generated `.war` file from the `target/` directory to the `webapps/` directory of your Tomcat installation.
   - Start the Tomcat server.

5. **Access the application:**
   - Open your browser and navigate to `http://localhost:8080/RailwayManagement`

---

<div align="center">
  <i>Built with ❤️ for efficient railway administration.</i>
</div>
