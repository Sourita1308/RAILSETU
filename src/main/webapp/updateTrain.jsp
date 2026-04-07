<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Train</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Update Train Details</h2>

    <!-- 
      This form will be pre-filled with data from the "train" attribute
      that LoadTrainForUpdateServlet forwarded to us.
      
      The form submits to the /updateTrain servlet.
    -->
    <form action="updateTrain" method="post">
        
        <!-- 
          IMPORTANT: This hidden field stores the train's ID
          so the UpdateTrainServlet knows WHICH train to update.
        -->
        <input type="hidden" name="trainId" value="${train.getTrainId()}">
        
        <label>Train Name:</label>
        <input type="text" name="trainName" value="${train.getTrainName()}" required><br><br>
        
        <label>Source:</label>
        <input type="text" name="source" value="${train.getSource()}" required><br><br>
        
        <label>Destination:</label>
        <input type="text" name="destination" value="${train.getDestination()}" required><br><br>
        
        <label>Fare:</label>
        <input type="number" name="fare" value="${train.getFare()}" step="0.01" required><br><br>
        
        <input type="submit" value="Update Train">
    </form>
    
    <br>
    <a href="viewTrains">Back to Train List</a>
</body>
</html>

