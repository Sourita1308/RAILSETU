<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Page</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Configure custom colors and font -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        // Changed the primary color to a deep blue
                        'primary-blue': '#1D4ED8', 
                    },
                    fontFamily: {
                        // Changed font to Times New Roman
                        sans: ['Times New Roman', 'serif'], 
                    },
                },
            }
        }
    </script>
    <style>
        /* Add the background image to the body */
        body {
            /* Updated background image URL */
            background-image: url('https://media.istockphoto.com/id/176957261/photo/railway-tracks.jpg?s=612x612&w=0&k=20&c=aJ6X4pFB24zzMueaE0MxWGRPVsRZxHfAvTTdQnXUWl8=');
            background-size: cover; /* Ensure the image covers the entire viewport */
            background-position: center; /* Center the image */
            background-attachment: fixed; /* Fixes the image so content scrolls over it */
        }

        /* Custom styling to ensure inputs match the "bottom-border only" look */
        .input-style {
            background-color: transparent;
            border: none;
            border-bottom: 2px solid #e5e7eb; /* Light gray line */
            padding-left: 0.25rem;
            padding-right: 0.25rem;
            padding-bottom: 0.5rem;
            transition: border-color 0.3s;
        }
        .input-style:focus {
            outline: none;
            /* Updated input focus color to the new primary blue */
            border-bottom-color: #1D4ED8; 
        }
        /* Ensure the select dropdown also looks clean and matches */
        .select-style {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 20 20' fill='currentColor'%3E%3Cpath fill-rule='evenodd' d='M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z' clip-rule='evenodd' /%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 1.5em 1.5em;
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 font-sans">

    <!-- Form Container Card -->
    <!-- Reduced vertical padding: p-8/sm:p-10 changed to p-6/sm:p-8 -->
    <div class="w-full max-w-sm bg-white p-6 sm:p-8 rounded-xl shadow-2xl bg-opacity-95">

        <!-- Title - Reduced bottom margin: mb-10 changed to mb-8 -->
        <h1 class="text-4xl font-extrabold text-center text-primary-blue mb-8">Signup</h1>

        <!-- Reduced spacing between elements: space-y-6 changed to space-y-4 -->
        <form action="signup" method="POST" class="space-y-4">

            <!-- Name Input -->
            <div>
                <input type="text" id="name" name="name" placeholder="Name" required 
                       class="input-style w-full text-lg text-gray-700">
            </div>

            <!-- Email Input -->
            <div>
                <input type="email" id="email" name="email" placeholder="Email" required 
                       class="input-style w-full text-lg text-gray-700">
            </div>

            <!-- Phone Number Input -->
            <div>
                <input type="tel" id="phone" name="phone" placeholder="Phone Number" 
                       class="input-style w-full text-lg text-gray-700">
            </div>

            <!-- Location Input -->
            <div>
                <input type="text" id="location" name="location" placeholder="Location" 
                       class="input-style w-full text-lg text-gray-700">
            </div>

            <!-- Select Location Type Dropdown -->
            <div class="relative">
                <!-- Use a standard input style class for consistency -->
                <select id="location-type" name="location-type" required
                        class="select-style input-style w-full text-lg text-gray-500 pr-10">
                    <option value="" disabled selected hidden>Select Location Type</option>
                    <option value="home" class="text-gray-700">Home</option>
                    <option value="work" class="text-gray-700">Work</option>
                    <option value="other" class="text-gray-700">Other</option>
                </select>
            </div>
            
            <!-- Set Password Input -->
            <div>
                <input type="password" id="password" name="password" placeholder="Set Password" required 
                       class="input-style w-full text-lg text-gray-700">
            </div>

            <!-- Age Input -->
            <div>
                <input type="number" id="age" name="age" placeholder="Age" min="1" max="120" 
                       class="input-style w-full text-lg text-gray-700">
            </div>

            <!-- Signup Button - Reduced top padding: pt-4 changed to pt-2 -->
            <div class="pt-2">
                <button type="submit" 
                        class="w-full bg-primary-blue hover:bg-blue-800 text-white font-bold py-3 
                               rounded-lg shadow-md transition duration-300 transform hover:scale-[1.01] text-xl tracking-wider">
                    Signup
                </button>
            
        </form>
    </div>
            <div id="errorMessage" class="mt-4 p-3 text-sm rounded-lg bg-red-100 text-red-700 ${errorMessage == null ? 'hidden' : 'block'}">
    <%-- Check if an error message exists (passed from servlet) --%>
    <%
        String errorMsg = (String) request.getAttribute("errorMessage");
        if (errorMsg != null) {
            out.print(errorMsg);
        }
    %>
    <%-- Using JSP Expression Language (alternative): ${errorMessage} --%>
</div>

    </div>

</body>
</html>
