<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Success</title>
</head>
<body>
    <!-- This is a new file for train success messages -->
    <h2><%= request.getAttribute("message") %></h2>
    <br>
    <a href="index.html">Go Back to Home</a>
</body>
</html>
