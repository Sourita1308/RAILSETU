<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - RailSetu</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Background image fix & overlay */
        .background-image {
            background-image: url('https://media.istockphoto.com/id/176957261/photo/railway-tracks.jpg?s=612x612&w=0&k=20&c=aJ6X4pFB24zzMueaE0MxWGRPVsRZxHfAvTTdQnXUWl8=');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
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
            background-color: rgba(0, 0, 0, 0.3); 
            z-index: -1;
        }

        body {
            z-index: 0;
        }

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
                    fontFamily: {
                        'serif': ['"Times New Roman"', 'serif'],
                    }
                }
            }
        }
    </script>
</head>
<body class="background-image flex items-center justify-center min-h-screen p-4 font-serif">

    <div class="w-full max-w-sm p-8 bg-white bg-opacity-[0.98] rounded-xl shadow-2xl backdrop-blur-sm transition-all duration-500 ease-in-out hover:shadow-primary-purple/50 z-10">

        <div class="flex flex-col items-center mb-6">
            <h1 class="text-4xl font-extrabold text-gray-800 tracking-tight">RailSetu</h1>
            <p class="text-lg font-medium text-gray-500 mt-0.5">Indian Railways</p>
        </div>

        <h2 class="text-2xl font-semibold text-gray-700 mb-2 text-center">Reset Password</h2>
        <p class="text-sm text-gray-500 text-center mb-6">Enter your email and a new password.</p>

        <form id="forgotPasswordForm" action="forgot-password" method="POST">
            
            <div class="mb-4">
                <input type="email" id="email" name="email" placeholder="Email Address" required
                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-purple focus:border-primary-purple transition duration-200"
                       aria-label="Email Address">
            </div>

            <div class="mb-6">
                <input type="password" id="new_password" name="new_password" placeholder="New Password" required
                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-purple focus:border-primary-purple transition duration-200"
                       aria-label="New Password">
            </div>

            <button type="submit" 
                    class="w-full py-3 bg-primary-purple text-white font-bold text-lg rounded-lg shadow-md hover:bg-secondary-blue transition duration-300 ease-in-out transform hover:scale-[1.01] focus:outline-none focus:ring-4 focus:ring-primary-purple/50">
                RESET PASSWORD
            </button>
        </form>
        
        <div id="messageBox" class="mt-6 text-sm rounded-lg text-center
            <% if (request.getParameter("error") != null) { %>
                p-3 bg-red-100 text-red-700
            <% } %>
        ">
            <% if (request.getParameter("error") != null) { %>
                <span class="font-bold">Error:</span> <%= request.getParameter("error") %>
            <% } %>
        </div>
        
        <div class="mt-4 text-center">
            <p class="text-sm text-gray-600">
                Remember your password? 
                <a href="login.jsp" class="font-semibold text-primary-purple hover:text-secondary-blue">Login here</a>
            </p>
        </div>

    </div>
        
</body>
</html>
