<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%
    // --- SECURITY CHECK ---
    // This code runs on the server before the page is sent.
    // Check if user is logged in. If not, redirect to the account page.
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    if (userId == null) {
        // No user in session, redirect to the "account required" page
        response.sendRedirect("account.html");
        return; // Stop processing the rest of this page
    }
    // If we are here, the user IS logged in.
%><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RailSetu Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Playfair+Display:ital,wght@1,400..900&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        // New header color derived from the uploaded image
                        'header-dark': '#2D3748', 
                        'rail-blue': '#1D4ED8', 
                        'sidebar-active': '#E0F2F1', 
                        'sidebar-hover': '#F3F4F6',
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                        // UPDATED: Using Playfair Display as requested
                        display: ['Playfair Display', 'Georgia', 'Times New Roman', 'serif'], 
                    }
                }
            }
        }
    </script>
    <style>
        /* Custom styles for layout and scrollbar */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f7f7f9;
        }

        /* Set the main container grid for Header, Sidebar, and Main Content */
        #app-layout {
            display: grid;
            grid-template-rows: 64px 1fr; /* Header height, rest of content */
            grid-template-columns: 250px 1fr; /* Sidebar width, main content */
            height: 100vh;
        }

        /* Ensure header spans all columns */
        #header {
            grid-column: 1 / -1;
        }

        /* Set the sidebar and main content areas */
        #sidebar {
            grid-row: 2 / 3;
            grid-column: 1 / 2;
            overflow-y: auto;
        }

        #main-content-wrapper {
            grid-row: 2 / 3;
            grid-column: 2 / 3;
            overflow-y: auto;
            padding: 32px;
        }

        /* Hero Banner specific styling */
        .hero-banner {
            background-image: url('https://static.investindia.gov.in/s3fs-public/2019-07/railway4.jpg');
            background-size: cover;
            background-position: center;
            height: 350px;
        }

        /* Mobile layout adjustments */
        @media (max-width: 1024px) {
            #app-layout {
                grid-template-columns: 1fr;
                grid-template-rows: 64px 1fr;
            }
            #sidebar {
                display: none; /* Hide sidebar on small screens for simplicity in this single file demo */
            }
            #main-content-wrapper {
                grid-column: 1 / -1;
                padding: 16px;
            }
        }
    </style>
</head>
<body id="app-layout" class="text-gray-800">

    <header id="header" class="fixed top-0 left-0 right-0 z-50 bg-gray-900/90 backdrop-blur-md shadow-md border-b border-gray-700/50 h-16">
        <div class="container mx-auto px-6 h-full flex justify-between items-center relative">
            <div class="flex items-center absolute top-1/2 -translate-y-1/2">
                <img 
                    src="Images/logo.png" 
                    alt="RailSetu Logo" 
                    class="h-28 w-24 -mt-2 -mr-2"
                >
                <span class="text-white text-2xl" style="font-family: 'Playfair Display', serif; font-style: italic; font-weight:700; color:white; font-size:24px;">RailSetu</span>
            </div>
        </div>
    </header>

        <aside id="sidebar" class="sidebar bg-white border-r border-gray-200 p-4 flex-col shadow-xl h-[calc(100vh-64px)] sticky top-16 overflow-y-auto hidden md:flex">
            
            <div class="flex items-center space-x-3 mb-8 p-2 rounded-lg">
    <div class="h-10 w-10 rounded-full bg-blue-500 flex items-center justify-center text-white font-semibold text-lg uppercase">
        <%= userName != null ? userName.substring(0, 1) : "A" %>
    </div>
                <div>
                    <span class="font-semibold text-sm text-gray-800"><%= userName %></span>
                    <span class="block text-xs text-gray-500"><%= userEmail %></span>
                </div>
            </div>
            <nav class="space-y-1">
                
                <a href="dashboard.jsp" class="flex items-center space-x-3 py-3 px-4 rounded-lg bg-sidebar-active text-rail-blue font-semibold transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/></svg>
                    <span>Dashboard</span>
                </a>

                <a href="findTrains" class="flex items-center space-x-3 py-3 px-4 rounded-lg text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M22 17H2a4 4 0 0 0 4 4h12a4 4 0 0 0 4-4ZM18 10a2 2 0 1 0 0 4h-4a2 2 0 1 0 0-4h4Z"/><path d="M12 2v3"/><path d="M4 11h16"/></svg>
                    <span>Railway Stations</span>
                </a>

                <a href="trainSchedule" class="flex items-center space-x-3 py-3 px-4 rounded-lg text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/><path d="M8 2v4"/><path d="M16 2v4"/></svg>
                    <span>Train Schedule</span>
                </a>

                <a href="loadBookingPage" class="flex items-center space-x-3 py-3 px-4 rounded-lg text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M2 10V7a2 2 0 0 1 2-2h3"/><path d="M14 5h3a2 2 0 0 1 2 2v3"/><path d="M2 14v3a2 2 0 0 0 2 2h3"/><path d="M14 19h3a2 2 0 0 0 2-2v-3"/><path d="M16 11h-3"/><path d="M8 11h3"/><path d="M12 15h1"/></svg>
                    <span>Ticket Reservations</span>
                </a>
                <a href="viewBookings" class="flex items-center space-x-3 py-3 px-4 rounded-lg text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M2.5 17a2.5 2.5 0 0 1 0-5 .5.5 0 0 0 0-1 2.5 2.5 0 0 1 0-5m19 11a2.5 2.5 0 0 0 0-5 .5.5 0 0 1 0-1 2.5 2.5 0 0 0 0-5"/><path d="M8 6h8"/><path d="M8 12h8"/><path d="M8 18h8"/></svg>
                    <span>View Bookings</span>
                </a>
            </nav>

            <a href="logout" class="mt-auto flex items-center space-x-3 py-3 px-4 rounded-lg text-red-500 hover:bg-red-50 transition duration-150">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/></svg>
                <span class="font-medium">Log Out</span>
            </a>

        </aside>

    <main id="main-content-wrapper" class="bg-gray-50">
        
        <h1 class="text-3xl font-semibold mb-6">Welcome to Indian Railways</h1>

        <div class="hero-banner rounded-xl shadow-lg mb-8 relative flex items-center justify-center overflow-hidden">
            <div class="bg-black bg-opacity-40 p-8 rounded-xl text-center max-w-lg mx-auto">
                <h2 class="text-3xl font-bold text-white mb-2">Your Journey Starts with RailSetu</h2>
                <p class="text-gray-200 text-sm">Seamlessly manage your travel plans across the Indian rail network.</p>
            </div>
            <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent"></div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            
            <div class="bg-white p-8 rounded-xl shadow-md text-center hover:shadow-lg transition duration-300 transform hover:-translate-y-0.5">
                <div class="mx-auto w-12 h-12 flex items-center justify-center rounded-full bg-indigo-50/50 mb-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#6366F1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-indigo-600"><path d="M12 2v3"/><path d="M4 11h16"/><path d="M12 17v-3"/><path d="M16 17v-3"/><path d="M8 17v-3"/><path d="M22 17H2a4 4 0 0 0 4 4h12a4 4 0 0 0 4-4Z"/></svg>
                </div>
                <div class="text-xs font-semibold uppercase text-indigo-600 tracking-wider">RAILWAY</div>
                <div class="text-lg font-medium">Stations</div>
            </div>

            <div class="bg-white p-8 rounded-xl shadow-md text-center hover:shadow-lg transition duration-300 transform hover:-translate-y-0.5">
                <div class="mx-auto w-12 h-12 flex items-center justify-center rounded-full bg-purple-50/50 mb-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#A855F7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                </div>
                <div class="text-xs font-semibold uppercase text-purple-600 tracking-wider">TRAIN</div>
                <div class="text-lg font-medium">Schedule</div>
            </div>

            <div class="bg-white p-8 rounded-xl shadow-md text-center hover:shadow-lg transition duration-300 transform hover:-translate-y-0.5">
                <div class="mx-auto w-12 h-12 flex items-center justify-center rounded-full bg-emerald-50/50 mb-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#059669" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-emerald-600"><path d="M2 10V7a2 2 0 0 1 2-2h3"/><path d="M14 5h3a2 2 0 0 1 2 2v3"/><path d="M2 14v3a2 2 0 0 0 2 2h3"/><path d="M14 19h3a2 2 0 0 0 2-2v-3"/><path d="M16 11h-3"/><path d="M8 11h3"/><path d="M12 15h4"/></svg>
                </div>
                <div class="text-xs font-semibold uppercase text-emerald-600 tracking-wider">TICKET</div>
                <div class="text-lg font-medium">Reservations</div>
            </div>

        </div>

    </main>

</body>
</html>