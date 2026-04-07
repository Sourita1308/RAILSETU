<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Import JSTL for the loops -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Book Ticket</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Book Ticket</h2>
    
    <!-- 
      This form's ACTION still points to /bookTicket (your TicketServlet)
      That servlet is already correct and doesn't need to change.
    -->
    <form action="bookTicket" method="post">
    
        <!-- PASSENGER DROPDOWN -->
        <label for="passenger-select">Select Passenger:</label><br>
        <select name="passenger_id" id="passenger-select" required>
            <option value="">-- Please choose a passenger --</option>
            <c:forEach var="p" items="${passengerList}">
                <!-- 
                  The VALUE is the ID (what the servlet needs)
                  The TEXT is the Name (what the user sees)
                -->
                <option value="${p.getPassengerId()}">${p.getName()}</option>
            </c:forEach>
        </select>
        <br><br>

        <!-- TRAIN DROPDOWN -->
        <label for="train-select">Select Train:</label><br>
        <select name="train_id" id="train-select" required>
            <option value="">-- Please choose a train --</option>
            <c:forEach var="t" items="${trainList}">
                <option value="${t.getTrainId()}">
                    ${t.getTrainName()} (${t.getSource()} to ${t.getDestination()})
                </option>
            </c:forEach>
        </select>
        <br><br>

        <input type="submit" value="Book Ticket">
    </form>
    <br>
    <a href="index.html">Go Back to Home</a>
</body>
</html>
