<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    // --- SECURITY CHECK & USER DATA ---
    // This code runs on the server before the page is sent.
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    
    if (userId == null) {
        // No user in session, redirect to the "account required" page
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
    <title>RailSetu Schedule</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                    colors: {
                        'rail-blue': '#1D4ED8',
                        'sidebar-hover': '#EFF6FF',
                        'sidebar-active': '#E0F2FE',
                        /* Style for the active station link */
                        'station-active-bg': '#eef2ff',
                        'station-active-text': '#4338ca',
                    }
                }
            }
        }
    </script>
    <style>
        /* Custom styles from your HTML */
        .sidebar {
            min-width: 280px;
            width: 280px;
        }
        .main-line-list {
            min-width: 200px;
            width: 200px;
        }
        .station-list {
            max-height: calc(100vh - 250px);
            overflow-y: auto;
        }
        /* Style for the active station, configured in tailwind.config */
        .station-list a.active {
            background-color: tailwind.config.theme.extend.colors['station-active-bg'];
            color: tailwind.config.theme.extend.colors['station-active-text'];
            font-weight: 600;
        }
        /* Scrollbar styles */
        .station-list::-webkit-scrollbar { width: 6px; }
        .station-list::-webkit-scrollbar-track { background: #f1f1f1; }
        .station-list::-webkit-scrollbar-thumb { background: #ddd; border-radius: 3px; }
        .station-list::-webkit-scrollbar-thumb:hover { background: #bbb; }
    </style>

</head>
<body class="bg-gray-50 min-h-screen" style="padding-top:64px;">

    <header class="fixed top-0 left-0 right-0 z-50 bg-gray-900/90 backdrop-blur-md shadow-md border-b border-gray-700/50 h-16">
        <div class="container mx-auto px-6 h-full flex justify-between items-center relative">
             <div class="flex items-center absolute top-1/2 -translate-y-1/2">
                  <img src="Images/logo.png" 
                       alt="RailSetu Logo" 
                       class="h-28 w-24 -mt-2 -mr-2">
                 <span class="text-white text-2xl" style="font-family: 'Playfair Display', serif; font-style: italic; font-weight:700; color:white; font-size:28px;">RailSetu</span>
            </div>
            
            <div class="flex items-center space-x-3">
                <button class="md:hidden p-2 text-gray-300 hover:text-white">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path></svg>
                </button>
            </div>
        </div>
    </header>

    <main class="flex">

        <aside id="sidebar" class="sidebar bg-white border-r border-gray-200 p-6 flex-col shadow-xl h-[calc(100vh-64px)] sticky top-16 overflow-y-auto hidden md:flex">
            
            <div class="flex items-center space-x-3 mb-8 p-2 rounded-lg">
    <div class="h-10 w-10 rounded-full bg-blue-500 flex items-center justify-center text-white font-semibold text-lg uppercase">
        <%= userName != null ? userName.substring(0, 1) : "A" %>
    </div>
                <div>
                    <span class="font-semibold text-base text-gray-800"><%= userName %></span>
                    <p class="text-sm text-gray-500"><%= userEmail %></p>
                </div>
            </div>

            <nav class="space-y-2">
                <a href="dashboard.jsp" class="flex items-center space-x-4 py-4 px-5 rounded-xl text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-6 h-6"><rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/></svg>
                    <span class="text-base">Dashboard</span>
                </a>
                
                <a href="findTrains" class="flex items-center space-x-3 py-4 px-5 rounded-xl text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M22 17H2a4 4 0 0 0 4 4h12a4 4 0 0 0 4-4ZM18 10a2 2 0 1 0 0 4h-4a2 2 0 1 0 0-4h4Z"/><path d="M12 2v3"/><path d="M4 11h16"/></svg>
                    <span>Railway Stations</span>
                </a>

                <a href="trainSchedule" class="flex items-center space-x-3 py-4 px-5 rounded-xl bg-sidebar-active text-rail-blue font-semibold transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/><path d="M8 2v4"/><path d="M16 2v4"/></svg>
                    <span>Train Schedule</span>
                </a>

                <a href="loadBookingPage" class="flex items-center space-x-3 py-4 px-5 rounded-xl text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M2 10V7a2 2 0 0 1 2-2h3"/><path d="M14 5h3a2 2 0 0 1 2 2v3"/><path d="M2 14v3a2 2 0 0 0 2 2h3"/><path d="M14 19h3a2 2 0 0 0 2-2v-3"/><path d="M16 11h-3"/><path d="M8 11h3"/><path d="M12 15h1"/></svg>
                    <span>Ticket Reservations</span>
                </a>
                
                <a href="viewBookings" class="flex items-center space-x-3 py-4 px-5 rounded-xl text-gray-600 hover:bg-sidebar-hover transition duration-150">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M2.5 17a2.5 2.5 0 0 1 0-5 .5.5 0 0 0 0-1 2.5 2.5 0 0 1 0-5m19 11a2.5 2.5 0 0 0 0-5 .5.5 0 0 1 0-1 2.5 2.5 0 0 0 0-5"/><path d="M8 6h8"/><path d="M8 12h8"/><path d="M8 18h8"/></svg>
                    <span>View Bookings</span>
                </a>

            </nav>

            <a href="logout" class="mt-auto flex items-center space-x-3 py-3 px-4 rounded-lg text-red-500 hover:bg-red-50 transition duration-150">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="w-5 h-5"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/></svg>
                <span class="font-medium">Log Out</span>
            </a>

        </aside>

        <section class="flex-grow p-6 md:p-10">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Train Schedule</h2>

            <div class="flex flex-col md:flex-row bg-white rounded-xl shadow-lg border border-gray-100 min-h-[500px]">
                
                <div class="main-line-list w-full md:w-1/4 border-r border-gray-200 p-4">
                    <p class="text-sm font-semibold text-gray-600 mb-2">Origin Station</p>
                    <nav id="origin-stations" class="station-list space-y-1">
                        <c:forEach var="station" items="${stations}">
                            <a href="trainSchedule?origin=${station}&destination=${selectedDestination}"
                               class="block p-3 text-gray-600 hover:bg-indigo-50 hover:text-indigo-700 rounded-lg transition duration-150 cursor-pointer ${station eq selectedOrigin ? 'active' : ''}">
                                ${station.split(' ')[0]} <%-- Show only simple name e.g. "Howrah" --%>
                            </a>
                        </c:forEach>
                    </nav>
                </div>

                <div class="main-line-list w-full md:w-1/4 border-r border-gray-200 p-4">
                    <p class="text-sm font-semibold text-gray-600 mb-2">Destination Station</p>
                    <nav id="destination-stations" class="station-list space-y-1">
                        <c:forEach var="station" items="${stations}">
                             <a href="trainSchedule?origin=${selectedOrigin}&destination=${station}"
                               class="block p-3 text-gray-600 hover:bg-indigo-50 hover:text-indigo-700 rounded-lg transition duration-150 cursor-pointer ${station eq selectedDestination ? 'active' : ''}">
                                ${station.split(' ')[0]} <%-- Show only simple name e.g. "Sealdah" --%>
                            </a>
                        </c:forEach>
                    </nav>
                </div>

                <div class="flex-grow p-4 overflow-x-auto">
                    
                    <h4 id="schedule-header" class="text-lg font-bold text-gray-800 mb-4">
                        <c:choose>
                            <c:when test="${not empty trainList}">
                                Schedule: ${selectedOrigin.split(' ')[0]} to ${selectedDestination.split(' ')[0]}
                            </c:when>
                            <c:when test="${not empty selectedOrigin and not empty selectedDestination and selectedOrigin eq selectedDestination}">
                                Origin and Destination must be different.
                            </c:when>
                            <c:when test="${not empty selectedOrigin and not empty selectedDestination}">
                                No direct trains found for this route.
                            </c:when>
                            <c:otherwise>
                                Select Stations to view Schedule
                            </c:otherwise>
                        </c:choose>
                    </h4>

                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-indigo-50">
    <tr>
        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider rounded-tl-xl">Train No</th>
        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider">Train Name</th>
        
        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider">Type</th>
        
        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider">Arrival</th>
        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider">Departure</th>
        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider">End Destination</th>

        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider">Dest. Time</th>

        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider">Frequency</th>
        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider">Classes</th>
        
        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider">Fare</th>

        <th class="px-3 py-3 text-left text-xs font-bold text-indigo-700 uppercase tracking-wider rounded-tr-xl">Book</th>
    </tr>
</thead>
                        <tbody id="schedule-body" class="bg-white divide-y divide-gray-200 text-sm">
                            
                            <c:forEach var="train" items="${trainList}">
    <tr class="hover:bg-sidebar-hover group">
        <td class="px-3 py-3 whitespace-nowrap font-medium text-gray-900">${train.trainNo}</td>
        <td class="px-3 py-3 whitespace-nowrap text-indigo-600 group-hover:text-rail-blue">${train.trainName}</td>
        
        <td class="px-3 py-3 whitespace-nowrap text-gray-600">${train.trainType}</td>
        
        <td class="px-3 py-3 whitespace-nowrap">
            <fmt:formatDate value="${train.arrivalTime}" pattern="HH:mm" />
        </td>
        <td class="px-3 py-3 whitespace-nowrap">
            <fmt:formatDate value="${train.departureTime}" pattern="HH:mm" />
        </td>
        <td class="px-3 py-3 whitespace-nowrap text-gray-600">${train.endDestination}</td>
        
        <td class="px-3 py-3 whitespace-nowrap">
            <fmt:formatDate value="${train.destinationTime}" pattern="HH:mm" />
        </td>

        <td class="px-3 py-3 whitespace-nowrap text-gray-600">${train.frequency}</td>
        <td class="px-3 py-3 whitespace-nowrap text-gray-600">${train.classes}</td>
        
        <td class="px-3 py-3 whitespace-nowrap font-semibold text-gray-800">
            ₹<fmt:formatNumber value="${train.fare}" maxFractionDigits="0" />
        </td>

        <td class="px-3 py-3 whitespace-nowrap">
            <a href="loadBookingPage?trainId=${train.trainId}" class="px-3 py-1 bg-rail-blue text-white text-xs font-semibold rounded-full hover:bg-blue-700 transition duration-150">
                Book Now
            </a>
        </td>
    </tr>
</c:forEach>

                        </tbody>
                    </table>
                </div>

            </div>
        </section>
    </main>

    </body>
</html>