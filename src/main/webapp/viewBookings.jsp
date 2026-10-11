<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    // --- SECURITY CHECK & USER DATA ---
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    
    if (userId == null) {
        response.sendRedirect("account.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Playfair+Display:ital,wght@1,400..900&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'header-dark': '#2D3748', 
                        'rail-blue': '#1D4ED8', 
                        'sidebar-active': '#E0F2F1', 
                        'sidebar-hover': '#F3F4F6',
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                        display: ['Playfair Display', 'Georgia', 'Times New Roman', 'serif'], 
                    }
                }
            }
        }
    </script>
    <style>
        /* This is the working layout from dashboard.jsp */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f7f7f9;
        }
        #app-layout {
            display: grid;
            grid-template-rows: 64px 1fr; /* Header height, rest of content */
            grid-template-columns: 250px 1fr; /* Sidebar width, main content */
            height: 100vh;
        }
        #header {
            grid-column: 1 / -1;
        }
        #sidebar {
            grid-row: 2 / 3;
            grid-column: 1 / 2;
            overflow-y: auto;
        }
        #main-content-wrapper {
            grid-row: 2 / 3;
            grid-column: 2 / 3;
            overflow-y: auto;
            padding: 32px; /* Add padding for the content */
        }
        @media (max-width: 1024px) {
            #app-layout {
                grid-template-columns: 1fr;
                grid-template-rows: 64px 1fr;
            }
            #sidebar {
                display: none; 
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
        <a href="dashboard.jsp" class="flex items-center space-x-3 py-3 px-4 rounded-lg text-gray-600 hover:bg-sidebar-hover transition duration-150">
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
        <a href="viewBookings" class="flex items-center space-x-3 py-3 px-4 rounded-lg bg-sidebar-active text-rail-blue font-semibold transition duration-150">
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
      <h2 class="text-3xl font-bold text-gray-800 mb-6">My Bookings</h2>

      <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Passenger</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Train</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Route</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Journey Date</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fare</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            
            <c:forEach var="booking" items="${bookingList}">
              <tr class="hover:bg-gray-50">
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm font-medium text-gray-900">${booking.passengerName}</div>
                  <div class="text-sm text-gray-500">Age: ${booking.age}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm font-medium text-blue-600">${booking.trainName}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm text-gray-900">${booking.source} &rarr; ${booking.destination}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm font-semibold text-gray-800">
                    <c:choose>
                      <c:when test="${not empty booking.journeyDate}">
                        <fmt:formatDate value="${booking.journeyDate}" pattern="dd/MM/yyyy" />
                      </c:when>
                      <c:otherwise>-</c:otherwise>
                    </c:choose>
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm font-semibold text-gray-800">
                    ₹<fmt:formatNumber value="${booking.fare}" maxFractionDigits="0" />
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-4">
    <a href="printTicket?bookingId=${booking.bookingId}" target="_blank" class="text-rail-blue hover:text-blue-800">
      Print Ticket
    </a>

    <form action="cancelBooking" method="POST" style="display:inline;">
        <input type="hidden" name="bookingId" value="${booking.bookingId}" />
        <button type="submit" class="text-red-600 hover:text-red-900">
          Cancel
        </button>
    </form>
</td>
              </tr>
            </c:forEach>
            
            <c:if test="${empty bookingList}">
              <tr>
                <td colspan="5" class="px-6 py-8 text-center text-gray-500">
                  You have no active bookings.
                </td>
              </tr>
            </c:if>

          </tbody>
        </table>
      </div>

    </main>

</body>
</html>