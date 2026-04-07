<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Success</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { color: #28a745; } /* Green for success */
        a { color: #007bff; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <!-- 
      This code gets the "message" attribute set by the servlet.
      If the message is null, it will simply print nothing (not "null").
    -->
    <h2>${message}</h2>
    
    <br>
    <a href="index.html">Go Back to Home</a>
</body>
</html>



