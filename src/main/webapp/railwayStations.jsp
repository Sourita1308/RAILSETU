<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    // --- SECURITY CHECK & USER DATA ---
    // Check if user is logged in. If not, redirect.
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    
    if (userId == null) {
        response.sendRedirect("account.html");
        return; // Stop processing the rest of this page
    }
    // If we are here, the user IS logged in.
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RailSetu Schedule Manager</title>
    <!-- Load Playfair Display Font -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@1,700&display=swap" rel="stylesheet">
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                    colors: {
                        'rail-blue': '#1D4ED8', // Indigo-700 equivalent for primary branding
                        'sidebar-hover': '#EFF6FF', // Blue-50 equivalent
                        'sidebar-active': '#E0F2FE', // Light blue background
                    }
                }
            }
        }
    </script>
    <style>
        /* Custom styles */
        .sidebar {
            min-width: 200px; 
        }
        /* Style for the colored dots */
        .dot {
            width: 12px; /* Increased from 8px */
            height: 12px; /* Increased from 8px */
            border-radius: 9999px;
            margin: auto;
            transition: all 0.15s;
        }
        .dot.available {
            background-color: #10B981;
        }
        .dot.unavailable {
            background-color: #EF4444;
        }

        /* Table specific styles */
        .schedule-table {
            border-spacing: 0;
            width: 100%;
        }
        
        .schedule-table th {
            padding: 16px 20px; /* Increased padding */
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .schedule-table td {
            padding: 20px; /* Increased cell padding */
            vertical-align: middle;
        }
        
        .schedule-table tr:hover {
            background-color: #F8FAFC;
        }

        /* Adjusting for mobile responsiveness */
        @media (max-width: 768px) {
            .min-w-full-mobile {
                min-width: 700px;
            }
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen font-sans" style="padding-top:64px;">

    <!-- Top Navigation Bar -->
    <header class="fixed top-0 left-0 right-0 z-50 bg-gray-900/90 backdrop-blur-md shadow-md border-b border-gray-700/50 h-16">
        <div class="container mx-auto px-6 h-full flex justify-between items-center relative">
            <!-- Logo Text Only: REVERTED TO PREFERRED STYLING -->
            <div class="flex items-center absolute top-1/2 -translate-y-1/2">
                <!-- START: Logo Image (Line 63) - Updated to use the new train graphic and slightly larger dimensions -->
                <img src="Images/logo.png" 
                     alt="RailSetu Logo" 
                     class="h-28 w-24 -mt-2 -mr-2"/>
                <!-- END: Logo Image Placeholder -->
                <!-- Using Playfair Display, italic, bold, and font size 28px -->
                <span class="text-white text-2xl" 
                      style="font-family: 'Playfair Display', serif; 
                             font-style: italic; 
                             font-weight: 700; 
                             color: white; 
                             font-size: 24px;">
                    RailSetu
                </span>
            </div>
            
            <!-- Mobile Menu Button (Placeholder for toggle) -->
            <div class="flex items-center space-x-3 md:ml-auto">
                <button class="md:hidden p-2 text-gray-300 hover:text-white">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path></svg>
                </button>
            </div>
        </div>
    </header>

    <!-- Main Layout Container -->
    <main class="flex">

        <!-- Sidebar -->
        <aside id="sidebar" class="sidebar bg-white border-r border-gray-200 p-4 flex-col shadow-xl h-[calc(100vh-64px)] sticky top-16 overflow-y-auto hidden md:flex">
            
            <!-- Account Link -->
            <div class="flex items-center space-x-3 mb-8 p-2 rounded-lg">
    <div class="h-10 w-10 rounded-full bg-blue-500 flex items-center justify-center text-white font-semibold text-lg uppercase">
        <%= userName != null ? userName.substring(0, 1) : "A" %>
    </div>
    <div>
        <span class="font-semibold text-sm text-gray-800"><%= userName %></span>
        <span class="block text-xs text-gray-500"><%= userEmail %></span>
    </div>
</div>
            <!-- Navigation Links -->
            <nav class="space-y-1">
                
                <!-- Dashboard -->
                <a href="dashboard.jsp" class="flex items-center space-x-3 py-3 px-4 rounded-lg text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <!-- Icon: Dashboard (Layout Grid) -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/></svg>
                    <span>Dashboard</span>
                </a>

                <!-- Railway Stations (Active) -->
                <a href="findTrains" class="flex items-center space-x-3 py-3 px-4 rounded-lg bg-sidebar-active text-rail-blue font-semibold transition duration-150">
                    <!-- Icon: Railway Station (Building) -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M22 17H2a4 4 0 0 0 4 4h12a4 4 0 0 0 4-4ZM18 10a2 2 0 1 0 0 4h-4a2 2 0 1 0 0-4h4Z"/><path d="M12 2v3"/><path d="M4 11h16"/></svg>
                    <span>Railway Stations</span>
                </a>

                <!-- Train Schedule -->
                <a href="trainSchedule" class="flex items-center space-x-3 py-3 px-4 rounded-lg text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <!-- Icon: Train Schedule (Clock/Calendar) -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/><path d="M8 2v4"/><path d="M16 2v4"/></svg>
                    <span>Train Schedule</span>
                </a>

                <!-- Ticket Reservations -->
                <a href="loadBookingPage" class="flex items-center space-x-3 py-3 px-4 rounded-lg text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <!-- Icon: Ticket (Ticket) -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M2 10V7a2 2 0 0 1 2-2h3"/><path d="M14 5h3a2 2 0 0 1 2 2v3"/><path d="M2 14v3a2 2 0 0 0 2 2h3"/><path d="M14 19h3a2 2 0 0 0 2-2v-3"/><path d="M16 11h-3"/><path d="M8 11h3"/><path d="M12 15h1"/></svg>
                    <span>Ticket Reservations</span>
                </a>
                
                <!-- NEW: View Bookings -->
                <a href="viewBookings" class="flex items-center space-x-3 py-3 px-4 rounded-lg text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <!-- Icon: List/Bookings -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M2.5 17a2.5 2.5 0 0 1 0-5 .5.5 0 0 0 0-1 2.5 2.5 0 0 1 0-5m19 11a2.5 2.5 0 0 0 0-5 .5.5 0 0 1 0-1 2.5 2.5 0 0 0 0-5"/><path d="M8 6h8"/><path d="M8 12h8"/><path d="M8 18h8"/></svg>
                    <span>View Bookings</span>
                </a>

            </nav>

            <!-- Log Out Link (at the bottom) -->
            <a href="logout" class="mt-auto flex items-center space-x-3 py-3 px-4 rounded-lg text-red-500 hover:bg-red-50 transition duration-150">
                <!-- Icon: Log Out (Log Out) -->
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/></svg>
                <span class="font-medium">Log Out</span>
            </a>

        </aside>

        <!-- Main Content Area -->
        <section class="flex-grow p-4 md:p-8 w-full md:w-auto">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Railway Stations</h2>

            <!-- Start/End Location Selection -->
            <form action="findTrains" method="POST" class="flex flex-col md:flex-row gap-4 mb-6 p-4 bg-white rounded-xl shadow-lg border border-gray-100">
    
    <div class="w-full md:w-2/5">
        <label for="start-location" class="block text-sm font-medium text-gray-700 mb-1">Start Location</label>
        <select id="start-location" name="start-location" class="w-full p-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 transition duration-150 shadow-sm">
            <option value="" disabled <c:if test="${empty selectedStart}">selected</c:if>>Select Starting Station</option>
            <c:forEach var="station" items="${stations}">
                <option value="${station}" <c:if test="${station eq selectedStart}">selected</c:if>>
                    ${station}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="w-full md:w-2/5">
        <label for="end-location" class="block text-sm font-medium text-gray-700 mb-1">End Location</label>
        <select id="end-location" name="end-location" class="w-full p-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 transition duration-150 shadow-sm">
            <option value="" disabled <c:if test="${empty selectedEnd}">selected</c:if>>Select Destination Station</option>
            <c:forEach var="station" items="${stations}">
                <option value="${station}" <c:if test="${station eq selectedEnd}">selected</c:if>>
                    ${station}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="w-full md:w-1/5 flex items-end">
        <button type="submit" class="w-full p-3 bg-rail-blue text-white rounded-lg font-semibold hover:bg-blue-700 transition duration-150">
            Find Trains
        </button>
    </div>
</form>

            <!-- Schedule Table Container -->
            <div class="p-6 bg-white rounded-xl shadow-lg border border-gray-100">
    
    <h3 id="schedule-header" class="text-xl font-bold mb-6 text-gray-800">
        <c:choose>
            <c:when test="${not empty selectedStart and not empty selectedEnd}">
                Live Schedule: ${selectedStart} to ${selectedEnd}
            </c:when>
            <c:otherwise>
                Select Start and End Locations to view Schedule
            </c:otherwise>
        </c:choose>
    </h3>
    
    <div class="overflow-x-auto rounded-lg border border-gray-200">
        <table class="schedule-table min-w-full-mobile divide-y divide-gray-200">
            <thead class="bg-gray-50">
                <tr>
                    <th class="text-left text-gray-700">Train No.</th>
                    <th class="text-left text-gray-700">Train Name</th>
                    <th class="text-left text-gray-700">Type</th>
                    <th class="text-left text-gray-700">Departure</th>
                    <th class="text-left text-gray-700">Frequency</th>
                    <th class="text-left text-gray-700">Classes</th>
                </tr>
            </thead>
            <tbody id="schedule-body" class="bg-white divide-y divide-gray-200">
                
                <c:choose>
                    <c:when test="${not empty trainList}">
                        <c:forEach var="train" items="${trainList}">
                            <tr class="hover:bg-gray-50">
                                <td class="font-medium text-gray-900">${train.trainNo}</td>
                                <td class="text-blue-600 font-medium">${train.trainName}</td>
                                <td class="text-gray-600">${train.trainType}</td>
                                <td class="text-gray-900">
                                    <fmt:formatDate value="${train.departureTime}" pattern="HH:mm" />
                                </td>
                                <td class="text-gray-600">${train.frequency}</td>
                                <td class="text-gray-600">${train.classes}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:when test="${not empty selectedStart}">
                        <tr>
                            <td colspan="6" class="text-center py-8 text-gray-500 font-semibold">
                                No direct trains found for this selected route.
                            </td>
                        </tr>
                    </c:when>
                </c:choose>
                
            </tbody>
        </table>
    </div>
</div>
        </section>
    </main>

    
</body>
</html>
