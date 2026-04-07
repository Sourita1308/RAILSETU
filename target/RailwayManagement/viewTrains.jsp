<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- This line imports the JSTL core library, which gives us <c:forEach> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>View All Trains</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 80%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #007BFF; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        tr:hover { background-color: #ddd; }
        a { color: #007bff; text-decoration: none; }
        a:hover { text-decoration: underline; }
        .action-links a { margin-right: 10px; }
    </style>
</head>
<body>
    <h2>All Available Trains</h2>

    <table>
        <thead>
            <tr>
                <th>Train ID</th>
                <th>Train Name</th>
                <th>Source</th>
                <th>Destination</th>
                <th>Fare</th>
                <!-- ✅ NEW "ACTIONS" COLUMN -->
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%-- This loop iterates over the trainList sent by the servlet --%>
            <c:forEach var="train" items="${trainList}">
                <tr>
                    <td><c:out value="${train.trainId}" /></td>
                    <td><c:out value="${train.trainName}" /></td>
                    <td><c:out value="${train.source}" /></td>
                    <td><c:out value="${train.destination}" /></td>
                    <td><c:out value="${train.fare}" /></td>

                    <!-- ✅ NEW "UPDATE" LINK -->
                    <!-- This link calls the /loadTrainForUpdate servlet -->
                    <!-- and passes the current train's ID in the URL -->
                    <td class="action-links">
                        <a href="loadTrainForUpdate?id=${train.trainId}">Update</a>
                        <!-- We could add a "Delete Train" link here later -->
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="index.html">Back to Home</a>

</body>
</html>

