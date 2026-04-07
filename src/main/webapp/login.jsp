<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RailSetu Login</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Background image fix & overlay */
        .background-image {
            /* Using the full provided URL */
            background-image: url('https://media.istockphoto.com/id/176957261/photo/railway-tracks.jpg?s=612x612&w=0&k=20&c=aJ6X4pFB24zzMueaE0MxWGRPVsRZxHfAvTTdQnXUWl8=');
            background-size: cover;
            background-position: center;
            background-attachment: fixed; /* Ensures the image stays put */
            position: relative;
        }

        /* Dark overlay for contrast */
        .background-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            /* Added a subtle dark layer (black with 30% opacity) */
            background-color: rgba(0, 0, 0, 0.3); 
            z-index: -1; /* Place overlay behind content but above the image */
        }

        /* Ensure body content is layered correctly */
        body {
            z-index: 0;
        }

        /* Custom scrollbar to match the clean design */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-thumb { background: #6366f1; border-radius: 4px; }
        ::-webkit-scrollbar-track { background: #f0f0f0; }
    </style>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'primary-purple': '#6366f1',
                        'secondary-blue': '#4f46e5',
                    },
                    // Custom font family configuration for Times New Roman
                    fontFamily: {
                        'serif': ['"Times New Roman"', 'serif'],
                    }
                }
            }
        }
    </script>
</head>
<!-- Applying font-serif class to use Times New Roman -->
<body class="background-image flex items-center justify-center min-h-screen p-4 font-serif">

    <!-- Login Card Container -->
    <!-- Increased opacity slightly for better visibility against the new dark overlay -->
    <div class="w-full max-w-sm p-8 bg-white bg-opacity-[0.98] rounded-xl shadow-2xl backdrop-blur-sm transition-all duration-500 ease-in-out hover:shadow-primary-purple/50 z-10">

        <!-- Logo/Title Section (Updated: Logo Removed, RailSetu is Primary Title) -->
        <div class="flex flex-col items-center mb-6">
            <!-- RailSetu as the larger, primary app name -->
            <h1 class="text-4xl font-extrabold text-gray-800 tracking-tight">RailSetu</h1>
            <!-- Indian Railways as the smaller, secondary company name -->
            <p class="text-lg font-medium text-gray-500 mt-0.5">Indian Railways</p>
        </div>

        <!-- Login Title: Line border classes removed -->
        <h2 class="text-2xl font-semibold text-gray-700 mb-6 text-center">Login</h2>

        <!-- Login Form -->
        <form id="loginForm" action="login" method="POST">
            
            <div class="mb-4">
                <!-- ✅ BUG FIX #2: Added name="email" -->
                <input type="email" id="email" name="email" placeholder="Email Address" required
                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-purple focus:border-primary-purple transition duration-200"
                       aria-label="Email Address">
            </div>

            <div class="mb-6">
                <!-- ✅ BUG FIX #3: Added name="password" -->
                <input type="password" id="password" name="password" placeholder="Password" required
                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-purple focus:border-primary-purple transition duration-200"
                       aria-label="Password">
            </div>

            <button type="submit" 
                    class="w-full py-3 bg-primary-purple text-white font-bold text-lg rounded-lg shadow-md hover:bg-secondary-blue transition duration-300 ease-in-out transform hover:scale-[1.01] focus:outline-none focus:ring-4 focus:ring-primary-purple/50">
                LOGIN NOW
            </button>
        </form>
        
        <div id="messageBox" class="mt-6 p-3 text-sm rounded-lg text-center
            <% if (request.getAttribute("errorMessage") != null) { %>
                bg-red-100 text-red-700
            <% } else if (request.getParameter("message") != null) { %>
                bg-green-100 text-green-700
            <% } %>
        ">
            <% if (request.getAttribute("errorMessage") != null) { %>
                <span class="font-bold">Error:</span> <%= request.getAttribute("errorMessage") %>
            <% } else if (request.getParameter("message") != null) { %>
                <span class="font-bold">Success:</span> <%= request.getParameter("message") %>
            <% } %>
        </div>
        
        <!-- Link to Signup Page -->
        <div class="mt-4 text-center">
            <p class="text-sm text-gray-600">
                Don't have an account? 
                <a href="signup.jsp" class="font-semibold text-primary-purple hover:text-secondary-blue">Sign Up here</a>
            </p>
        </div>

    </div>

        
</body>
</html>

