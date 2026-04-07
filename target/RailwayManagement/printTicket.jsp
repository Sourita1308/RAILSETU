<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Ticket (Booking ID: ${booking.bookingId})</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #F3F4F6; /* Light gray background */
        }
        .ticket-container {
            width: 800px;
            margin: 40px auto;
            background-color: #FFFFFF;
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid #E5E7EB;
        }
        .ticket-header {
            background-color: #2D3748; /* Header dark from dashboard */
            color: #FFFFFF;
            padding: 20px 30px;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .ticket-body {
            padding: 30px;
        }
        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px 40px;
        }
        .detail-item {
            padding-bottom: 12px;
            border-bottom: 1px dashed #D1D5DB;
        }
        .detail-item label {
            display: block;
            font-size: 0.8rem;
            font-weight: 600;
            color: #6B7280;
            text-transform: uppercase;
        }
        .detail-item p {
            font-size: 1.1rem;
            font-weight: 500;
            color: #111827;
            margin: 4px 0 0 0;
        }
        .print-button {
            display: inline-block;
            background-color: #1D4ED8; /* rail-blue */
            color: #FFFFFF;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            margin-top: 20px;
            cursor: pointer;
        }
        @media print {
            body {
                background-color: #FFFFFF;
            }
            .ticket-container {
                margin: 0;
                width: 100%;
                box-shadow: none;
                border: none;
            }
            .no-print {
                display: none; /* Hide button when printing */
            }
        }
    </style>
</head>
<body>

    <div class="ticket-container">
        <div class="ticket-header">
            <div>
                <h1 class="text-2xl font-bold">RailSetu E-Ticket</h1>
                <p class="text-sm text-gray-300">Booking ID: ${booking.bookingId}</p>
            </div>
            <h2 class="text-3xl font-bold">₹<fmt:formatNumber value="${booking.fare}" maxFractionDigits="0" /></h2>
        </div>
        
        <div class="ticket-body">
            
            <div class="detail-grid">
                <div class="detail-item" style="grid-column: 1 / -1;">
                    <label>Passenger Name</label>
                    <p>${booking.passengerName}</p>
                </div>
                <div class="detail-item">
                    <label>Age</label>
                    <p>${booking.age}</p>
                </div>
                <div class="detail-item">
                    <label>Gender</label>
                    <p>${booking.gender}</p>
                </div>

                <div class="detail-item" style="grid-column: 1 / -1;">
                    <label>Train</label>
                    <p>${booking.trainName} (${booking.trainNo})</p>
                </div>
                <div class="detail-item">
                    <label>From</label>
                    <p>${booking.source}</p>
                </div>
                <div class="detail-item">
                    <label>To</label>
                    <p>${booking.destination}</p>
                </div>
                <div class="detail-item">
                    <label>Departure</label>
                    <p><fmt:formatDate value="${booking.departureTime}" pattern="HH:mm" /> (24hr)</p>
                </div>
                <div class="detail-item">
                    <label>Arrival</label>
                    <p><fmt:formatDate value="${booking.arrivalTime}" pattern="HH:mm" /> (24hr)</p>
                </div>
            </div>

            <div class="text-center mt-8 no-print">
                <p class="text-gray-500 text-sm">Thank you for booking with RailSetu.</p>
                <button onclick="window.print()" class="print-button">
                    Print This Ticket
                </button>
            </div>

        </div>
    </div>

</body>
</html>