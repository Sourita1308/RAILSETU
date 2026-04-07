<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Error</title></head>
<body>
    <h2 style="color:red;">Error</h2>
    <!-- ✅ FIXED: This will now correctly display the error message -->
    <p style="color:red;"><%= request.getAttribute("error") %></p>
    <br>
    <a href="index.html">Go Back to Home</a>
</body>
</html>
