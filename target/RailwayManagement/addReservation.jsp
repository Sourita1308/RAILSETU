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
    
    // Check if the train object was passed by the servlet
    if (request.getAttribute("train") == null) {
        // If not, send user to pick a train
        response.sendRedirect("findTrains");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Book Reservation</title>

  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          fontFamily: { sans: ['Inter', 'sans-serif'], },
          colors: {
            'rail-blue': '#1D4ED8',
            'sidebar-hover': '#EFF6FF',
            'sidebar-active': '#E0F2FE',
          }
        }
      }   
    }
  </script>

  <style>
    /* Custom styles from your HTML */
    .sidebar { min-width: 200px; }
    :root {
      --panel-bg: rgba(255,255,255,0.96);
      --accent: #0b86d1;
      --radius: 10px;
      --muted: #f5f8fb;
      --text: #0f1724;
    }
    * { box-sizing: border-box; }
    html, body { height: 100%; margin: 0; font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; }
    
    section {
      background: linear-gradient(180deg, #f8fbff 0%, #eef4fb 100%);
      min-height: calc(100vh - 64px);
    }
    .reservation-box {
      max-width: 1100px;
      margin: 10px auto;
      padding: 22px;
      border-radius: var(--radius);
      background: var(--panel-bg);
      box-shadow: 0 10px 30px rgba(12,30,50,0.06);
      border: 1px solid rgba(15,63,110,0.04);
    }
    .form-container { display: flex; gap: 24px; flex-wrap: wrap; }
    .form-left, .form-right { flex: 1 1 460px; min-width: 300px; }
    .row { display: flex; gap: 12px; margin-top: 10px; }

    input[type="text"], input[type="email"], input[type="tel"], 
    input[type="date"], input[type="time"], input[type="number"], select {
      width: 100%; 
      padding: 10px 12px; 
      border: 1px solid rgba(15,63,110,0.08); 
      border-radius: 6px; 
      background: #fff; 
      font-size: 14px;
      margin-top: 4px; /* Added margin for labels */
    }
    
    label {
        font-size: 0.875rem;
        font-weight: 500;
        color: #374151;
    }
    
    .buttons { margin-top: 18px; text-align: right; }
    .cancel-btn, .submit-btn {
      padding: 10px 16px;
      border-radius: 8px;
      cursor: pointer;
      border: none;
      font-weight: 600;
      margin-left: 8px;
    }
    .cancel-btn {
      background: transparent;
      color: #374151;
      border: 1px solid rgba(0,0,0,0.06);
    }
    .submit-btn {
      background: linear-gradient(90deg, #0f63a4, #0b9bd7);
      color: #fff;
      box-shadow: 0 6px 18px rgba(11,156,215,0.18);
    }
    .price-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 12px;
      padding: 12px 0;
      font-weight: 600;
      border-top: 1px solid #e5e7eb;
    }
    .price-row.total { font-size: 1.15rem; color: var(--text); }
  </style>
</head>

<body class="bg-gray-50 min-h-screen" style="padding-top:64px;">

  <header class="fixed top-0 left-0 right-0 z-50 bg-gray-900/90 backdrop-blur-md shadow-md border-b border-gray-700/50 h-16">
     <div class="container mx-auto px-6 h-full flex justify-between items-center relative">
        <div class="flex items-center absolute top-1/2 -translate-y-1/2">
            <img src="Images/logo.png" alt="RailSetu Logo" class="h-28 w-24 -mt-2 -mr-2">
            <span class="text-white text-2xl" style="font-family: 'Playfair Display', serif; font-style: italic; font-weight:700; color:white; font-size:28px;">RailSetu</span>
        </div>
    </div>
  </header>
 
  <main class="flex">

    <aside id="sidebar" class="bg-white border-r border-gray-200 p-4 flex-col shadow-xl h-[calc(100vh-64px)] sticky top-16 overflow-auto hidden md:flex">
      
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
        <a href="loadBookingPage" class="flex items-center space-x-3 py-3 px-4 rounded-lg bg-sidebar-active text-rail-blue font-semibold transition duration-150">
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

    <section class="flex-grow p-4 md:p-8 w-full md:w-auto">
          
      <div class="reservation-box">
          <h2 class="text-2xl font-bold text-gray-800 mb-6">Book Your Ticket</h2>

        <form id="reservationForm" action="addPassenger" method="POST">
          
          <input type="hidden" name="trainId" value="${train.trainId}">
          <input type="hidden" name="userId" value="${user.id}">
          
          <div class="form-container">
            <div class="form-left">
              <h3 class="text-lg font-semibold text-gray-700">Your Selected Journey</h3>
              
              <div class="mt-4 p-4 bg-gray-50 rounded-lg border">
                <p class="text-sm text-gray-600">Train</p>
                <p class="text-lg font-bold text-rail-blue">${train.trainName} (${train.trainNo})</p>
              </div>
              
              <div class="mt-4 p-4 bg-gray-50 rounded-lg border">
                <p class="text-sm text-gray-600">Route</p>
                <p class="text-md font-semibold text-gray-800">${train.sourceStation} &rarr; ${train.destinationStation}</p>
              </div>

              <div class="mt-4 p-4 bg-gray-50 rounded-lg border">
                <p class="text-sm text-gray-600">Departure</p>
                <p class="text-md font-semibold text-gray-800">
                    <fmt:formatDate value="${train.departureTime}" pattern="HH:mm" />
                </p>
              </div>
              
              <div class="mt-4">
                  <label for="quantity" class="text-sm font-medium text-gray-700">Quantity</label>
                  <input type="number" id="quantity" name="quantity" value="1" min="1" max="10" 
                         class="w-full p-3 border rounded-md">
              </div>

              <div class="price-row total">
                <span>Total Fare</span>
                <span id="total">
                    ₹<fmt:formatNumber value="${train.fare}" maxFractionDigits="0" />
                </span>
              </div>
            </div>

            <div class="form-right">
              <h3 class="text-lg font-semibold text-gray-700">Passenger Details</h3>

              <div id="passenger-forms-container" class="space-y-4 mt-4">
              </div>
              
              <div class="row">
                 <div>
                    <label for="phone">Contact Phone</label>
                    <input type="tel" placeholder="+91" id="phone" name="phone" value="${user.phone}">
                 </div>
              </div>
              
            </div>
          </div>

          <div class="buttons">
            <a href="trainSchedule" class="cancel-btn">CANCEL</a>
            <button type="submit" class="submit-btn">MAKE RESERVATION</button>
          </div>
        </form>
      </div>
    </section>
  </main>

<script>
    // 1. Get the elements
    const quantityInput = document.getElementById('quantity');
    const passengerFormsContainer = document.getElementById('passenger-forms-container');
    const totalFareElement = document.getElementById('total');
    
    // 2. Get the base fare from the JSP
    const baseFare = ${train.fare};

    // 3. This function creates the HTML for a single passenger form
    function createPassengerForm(index) {
        // We use index+1 so the label is "Passenger 1", "Passenger 2", etc.
        return `
            <div class="p-4 bg-gray-50 rounded-lg border">
                <label class="text-md font-semibold text-gray-800">Passenger ${index + 1}</label>
                <div class="row mt-2">
                    <div style="flex: 2;">
                        <label for="passengerName${index}" class="text-sm">Full Name</label>
                        <input type="text" id="passengerName${index}" name="passengerName" placeholder="Full Name" required
                               class="w-full p-2 border rounded-md">
                    </div>
                    <div style="flex: 1;">
                        <label for="passengerAge${index}" class="text-sm">Age</label>
                        <input type="number" id="passengerAge${index}" name="passengerAge" placeholder="Age" min="1" required
                               class="w-full p-2 border rounded-md">
                    </div>
                    <div style="flex: 1;">
                        <label for="passengerGender${index}" class="text-sm">Gender</label>
                        <select id="passengerGender${index}" name="passengerGender" required
                                class="w-full p-2 border rounded-md">
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>
            </div>
        `;
    }

    // 4. This function updates both the forms and the total price
    function updateFormsAndPrice() {
        let quantity = parseInt(quantityInput.value);
        if (isNaN(quantity) || quantity < 1) {
            quantity = 1;
        }

        // Update Total Fare
        const total = baseFare * quantity;
        totalFareElement.textContent = '₹' + total.toLocaleString('en-IN', { 
            maximumFractionDigits: 0 
        });

        // Update Passenger Forms
        passengerFormsContainer.innerHTML = ''; // Clear old forms
        for (let i = 0; i < quantity; i++) {
            passengerFormsContainer.innerHTML += createPassengerForm(i);
        }
    }

    // 5. Listen for changes
    quantityInput.addEventListener('input', updateFormsAndPrice);

    // 6. Run the function once on page load to show the first form
    updateFormsAndPrice();

</script>

</body>
</html>