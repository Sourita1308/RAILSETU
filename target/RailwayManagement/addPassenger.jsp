<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Passenger</title>
</head>
<body>
<h2>Add Passenger</h2>
<!-- ✅ FIXED: action points to servlet "addPassenger" -->
<form action="addPassenger" method="post">
    <label>Name:</label>
    <!-- ✅ FIXED: name="name" (matches servlet) -->
    <input type="text" name="name" required><br><br>

    <label>Age:</label>
    <input type="number" name="age" required><br><br>

    <label>Gender:</label>
    <select name="gender" required>
        <option value="Male">Male</option>
        <option value="Female">Female</option>
        <option value="Other">Other</option>
    </select><br><br>

    <input type="submit" value="Add Passenger">
</form>
</body>
</html>
