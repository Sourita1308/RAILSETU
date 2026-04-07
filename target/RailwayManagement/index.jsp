<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RailSetu</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Load Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        /* Custom Styles */
        body {
            background-color: #f8fafc; /* Light Gray background */
            font-family: 'Inter', sans-serif;
            color: #1f2937; /* Darker Gray text */
        }
        .hero-background {
            background-image: url('https://www.rajasthanindiatourdriver.com/img/traintour-train.jpg');
            background-size: cover; background-position: center; background-repeat: no-repeat;
            min-height: 80vh; display: flex; align-items: center;
            padding-top: 6rem; padding-bottom: 4rem; position: relative;
        }
        .hero-overlay {
            position: absolute; top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(10, 10, 15, 0.65);
            box-shadow: inset 0px -120px 100px rgba(0, 0, 0, 0.75);
            z-index: 1;
        }
        .content-section-bg {
            background-color: #ffffff; padding-top: 4rem; padding-bottom: 4rem;
            border-top: 1px solid #e5e7eb;
        }
         /* Review Section Specific Background */
        .review-section-bg {
            background-color: #ffffff; /* Light Pink/Rose like screenshot */
            padding: 4rem 0;
        }
        .review-card {
            background-color: #bfdeeb; /* Light yellow/beige card background */
            border-radius: 0.75rem; /* rounded-xl */
            padding: 1.5rem; /* p-6 */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1); /* shadow-lg */
            border: 1px solid #bfdfe6; /* Light yellow border */
            text-align: center;
            height: 100%; /* Make cards in a row equal height */
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .card-image-wrapper {
            width: 100%; padding-top: 66.66%; /* 3:2 */ position: relative;
            overflow: hidden; border-radius: 0.75rem; background-color: #bfdeeb;
        }
        .card-image {
            position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;
        }
         /* Why Book With Card Image Specific */
        .why-book-image-wrapper {
            width: 100px; /* Increased size */
            height: 100px; /* Increased size */
            flex-shrink: 0;
            overflow: hidden;
            border-radius: 0.75rem; /* rounded-xl */
            background-color: #bfdeeb; /* Light gray bg */
            margin-bottom: 1rem; /* Space below image on small screens */
            margin-right: 0; /* No margin right on small screens */
            display: flex; /* Added for centering image */
            align-items: center; /* Added for centering image */
            justify-content: center; /* Added for centering image */
        }
        @media (min-width: 768px) { /* md breakpoint */
            .why-book-image-wrapper {
                margin-bottom: 0;
                margin-right: 1.5rem; /* space-x-6 -> translates to mr-6 on sibling */
            }
        }
        .why-book-image {
            width: 100%; height: 100%; object-contain;/* Use contain for illustrations */
        }

        .nav-link { /* Simplified Nav Link */
            color: #d1d5db; font-weight: 500; transition: color 0.2s; padding: 0.5rem 0;
        }
        .nav-link:hover { color: #ffffff; }
        footer {
             background-color: #111827; color: #9ca3af; padding: 2rem 0; margin-top: 0; /* Removed margin top */
        }
        .footer-link { transition: color 0.2s; }
        .footer-link:hover { color: #ffffff; }
        /* Style adjustments for focused search form */
        #searchFormContainer {
            background-color: rgba(255, 255, 255, 0.95); /* Slightly transparent white */
            backdrop-filter: blur(5px); /* Optional: blur effect for background */
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body class="antialiased">

    <!-- Top Navigation Bar - FURTHER SIMPLIFIED -->
    <!-- Top Navigation Bar - MODIFIED FOR SESSION -->
    <!-- Top Navigation Bar - MODIFIED (FIXED LAYOUT) -->
<header class="bg-gray-900/90 backdrop-blur-md text-white h-16 fixed top-0 left-0 right-0 z-50 shadow-md">
    <div class="container mx-auto px-6 h-full flex justify-between items-center">
        
        <div class="flex items-center">
            <img src="${pageContext.request.contextPath}/Images/logo.png" 
         alt="RailSetu Logo" 
         class="h-28 w-auto -mt-2 mr-[-0.5rem]">
            <span class="text-white text-2xl" style="font-family: 'Playfair Display', serif; font-style: italic; font-weight:700; color:white; font-size:24px;">
                RailSetu
            </span>
        </div>

        <div class="flex items-center space-x-4">
            <a href="login.jsp" class="text-sm font-medium px-4 py-2 rounded-lg hover:bg-gray-700/60 transition duration-150">
                Login
            </a>
            <a href="signup.jsp" class="text-sm font-medium bg-blue-600 px-4 py-2 rounded-lg hover:bg-blue-700 transition duration-150">
                Sign Up
            </a>
        </div>

    </div>
</header>


    <!-- Hero Section -->
    <div class="hero-background">
        <div class="hero-overlay"></div>
        <div class="container mx-auto px-6 relative z-10">
            <!-- Text Content -->
            <div class="max-w-3xl mb-12 text-center md:text-left">
                <!-- Removed the larger placeholder logo image -->
                <h1 class="text-5xl lg:text-6xl font-extrabold text-white leading-tight mb-3">Indian Railways</h1>
                <p class="inline-block text-[10px] font-extrabold tracking-wide text-dark bg-white px-2 py-1 rounded-md mb-3">SAFETY | SECURITY | PUNCTUALITY</p>

                <p class="text-lg text-gray-200 max-w-xl mx-auto md:mx-0">
                    Experience seamless journeys with RailSetu, your gateway to the Lifeline of the Nation.
                </p>
            </div>

            <!-- Search Form Block (No changes here) -->
            <!-- Book Ticket Tab -->
            <!-- Book Ticket Tab (Right Side) -->
             <!-- Book Ticket Tab (Joined with main box at top-right) -->
           


                <!-- Search Fields Container -->
                <div id="searchFormContainer" class="p-4 max-w-4xl mx-auto rounded-b-lg rounded-tr-lg shadow-lg relative z-0">

                    <!-- Dropdowns Row -->
                    <div class="flex flex-wrap gap-4 mb-5">
                        <!-- Quota Dropdown -->
                        <div class="relative flex-grow min-w-[120px]">
                            <label for="quota" class="block text-xs font-medium text-gray-600 mb-1">Quota</label>
                            <select id="quota" name="quota" class="appearance-none w-full bg-gray-50 border border-gray-300 text-gray-800 py-2 px-3 rounded-lg font-medium text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <option>GENERAL</option> <option>LADIES</option> <option>TATKAL</option> <option>PREMIUM TATKAL</option>
                            </select>
                            <svg class="absolute right-3 top-7 w-4 h-4 text-gray-500 pointer-events-none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
                        </div>
                        <!-- Class Dropdown -->
                        <div class="relative flex-grow min-w-[150px]">
                            <label for="class" class="block text-xs font-medium text-gray-600 mb-1">Class</label>
                            <select id="class" name="class" class="appearance-none w-full bg-gray-50 border border-gray-300 text-gray-800 py-2 px-3 rounded-lg font-medium text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                <option>All Classes</option> <option value="1A">1A - AC First Class</option> <option value="EC">EC - Exec. Chair Car</option> <option value="2A">2A - AC 2 Tier</option> <option value="FC">FC - First Class</option> <option value="3A">3A - AC 3 Tier</option> <option value="3E">3E - AC 3 Economy</option> <option value="CC">CC - AC Chair car</option> <option value="SL">SL - Sleeper</option> <option value="2S">2S - Second Sitting</option>
                            </select>
                             <svg class="absolute right-3 top-7 w-4 h-4 text-gray-500 pointer-events-none" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
                        </div>
                    </div>

                    <!-- Input Fields Row -->
                    <div class="grid grid-cols-1 md:grid-cols-12 gap-4 items-end">
                        <div class="md:col-span-4"> <label for="fromStation" class="block text-xs font-medium text-gray-600 mb-1">From</label> <input id="fromStation" name="fromStation" type="text" placeholder="Enter Source Station" class="w-full bg-gray-50 border border-gray-300 text-gray-800 font-medium py-2 px-3 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"> </div>
                        <div class="md:col-span-1 flex justify-center pb-2"> <button class="p-2 rounded-full bg-gray-200 text-gray-600 hover:bg-blue-100 hover:text-blue-600 transition" title="Swap stations"> <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path></svg> </button> </div>
                        <div class="md:col-span-4"> <label for="toStation" class="block text-xs font-medium text-gray-600 mb-1">To</label> <input id="toStation" name="toStation" type="text" placeholder="Enter Destination Station" class="w-full bg-gray-50 border border-gray-300 text-gray-800 font-medium py-2 px-3 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"> </div>
                        <div class="md:col-span-3"> <label for="journeyDate" class="block text-xs font-medium text-gray-600 mb-1">Date</label> <input id="journeyDate" name="journeyDate" type="date" class="w-full bg-gray-50 border border-gray-300 text-gray-800 font-medium py-2 px-3 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"> </div>
                    </div>
                    <!-- Search Button -->
                    <div class="mt-6"> <button id="searchTrainBtn" class="flex items-center justify-center w-full bg-blue-600 text-white font-bold text-base px-4 py-3 rounded-lg hover:bg-blue-700 transition shadow-md hover:shadow-lg focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"> Search Trains <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg> </button> </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Content Sections (Featured, Services, Routes) -->
     <!-- Content Sections (Featured, Services, Routes) -->
    <div class="content-section-bg">
        <div class="container mx-auto px-6 text-gray-800">
            <!-- Row 1: Featured & Essentials (Layout as before) -->
             <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-16">
                 <!-- Featured Journeys -->
                 <div class="bg-[#bfdeeb] p-6 rounded-xl shadow-lg flex flex-col md:flex-row items-center overflow-hidden border border-gray-200">
                     <div class="md:w-1/2 card-image-wrapper mb-4 md:mb-0 md:mr-6 flex-shrink-0">
                         <!-- Featured image -->
                         <img src="https://www.easemytrip.com/travel/img/himalayan-railway.jpg" alt="Scenic railway journey" class="card-image">
                     </div>
                     <div class="md:w-1/2 text-center md:text-left">
                         <h3 class="text-xl font-bold mb-2 text-blue-700">Featured Journeys</h3>
                         <p class="text-md font-semibold mb-1">Monsoon Getaway Offer!</p>
                         <p class="text-sm text-gray-600">Enjoy 30% off on First AC tickets to selected hill stations! Valid for bookings next 48 hours.</p>
                         <button onclick="location.href='#routes'" class="mt-4 bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-blue-700 transition">Explore Routes</button>
                     </div>
                 </div>
                 <!-- Travel Essentials -->
                 <div class="bg-[#bfdeeb] p-6 rounded-xl shadow-lg flex flex-col md:flex-row items-center overflow-hidden border border-gray-200">
                      <div class="md:w-1/2 text-center md:text-right order-2 md:order-1 md:mr-6">
                         <h3 class="text-xl font-bold mb-2 text-green-700">Travel Essentials</h3>
                         <p class="text-md font-semibold mb-1">High-Priority Luggage Tags!</p>
                         <p class="text-sm text-gray-600">Ensure Express Baggage Handling with our Premium Tags. Starting at just &#8377;199.</p>
                         <button onclick="location.href='#products'" class="mt-4 bg-green-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-green-700 transition">View Products</button>
                     </div>
                    <div class="md:w-1/2 card-image-wrapper order-1 md:order-2 mb-4 md:mb-0 flex-shrink-0">
                         <img src="https://www.informalnewz.com/wp-content/uploads/2024/07/50-Railways-Refund-1200x900.jpg" alt="Travel accessories" class="card-image">
                     </div>
                 </div>
             </div>

            <!-- Row 2: Popular Services (Layout as before) -->
             <h2 class="text-3xl font-extrabold text-center mb-10 text-gray-900">Popular Services</h2>
             <div class="grid grid-cols-2 md:grid-cols-4 gap-6 mb-16">
                 <a href="#" class="block bg-blue-100 rounded-xl shadow-md overflow-hidden transition transform hover:scale-105 duration-300 border hover:shadow-lg hover:border-blue-300"> <div class="card-image-wrapper"> <img src="https://media.istockphoto.com/id/1095232944/vector/finding-location-on-global-map.jpg?s=612x612&w=0&k=20&c=KnaEJaNN4oFDrLqTGuYNvdXVILep1DCpIf08O7kLUX0=" alt="Train tracking image " class="card-image"> </div> <div class="p-4 text-center"> <p class="text-md font-bold">Real-Time Train Tracking </p> <p class="text-s text-gray-500">Track Train locations live and get accurate ETAs</p> </div> </a>
                 <a href="#" class="block bg-blue-100 rounded-xl shadow-md overflow-hidden transition transform hover:scale-105 duration-300 border hover:shadow-lg hover:border-blue-300"> <div class="card-image-wrapper"> <img src="https://assets.designtemplate.io/Train-Ticket-Booking-Online-Vector-Illustration-700.webp" alt="Train timetable display" class="card-image"> </div> <div class="p-4 text-center"> <p class="text-md font-bold">Easy Booking System</p> <p class="text-s text-gray-500">Seamless and quick ticket booking with multiple payment options</p> </div> </a>
                 <a href="#" class="block bg-blue-100 rounded-xl shadow-md overflow-hidden transition transform hover:scale-105 duration-300 border hover:shadow-lg hover:border-blue-300"> <div class="card-image-wrapper"> <img src="https://www.shutterstock.com/image-vector/train-icon-logo-sign-ticket-260nw-2595988429.jpg" alt="Customer feedback icon" class="card-image"> </div> <div class="p-4 text-center"> <p class="text-md font-bold">Affordable Travel Options</p> <p class="text-s text-gray-500">Compare fares and get the best travel deals across classes</p> </div> </a>
                 <a href="#" class="block bg-blue-100 rounded-xl shadow-md overflow-hidden transition transform hover:scale-105 duration-300 border hover:shadow-lg hover:border-blue-300"> <div class="card-image-wrapper"> <img src="https://img.freepik.com/premium-vector/customer-support-illustration-concept_23152-154.jpg" alt="Lost and Found icon" class="card-image"> </div> <div class="p-4 text-center"> <p class="text-md font-bold">24/7 Customer Support</p> <p class="text-s text-gray-500">We're available round the clock to help with bookings, cancellations, and inquiries</p> </div> </a>
             </div>

            <!-- Row 3: Popular Routes (Layout as before) -->
             <h2 class="text-3xl font-extrabold Inter text-center mb-10 text-gray-900">Popular Routes</h2>
             <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                  <a href="#" class="block bg-pink-100 border border-blue-200 rounded-xl shadow-sm p-4 text-center text-gray-800 transition transform hover:scale-105 duration-300 hover:shadow-md"> <p class="text-lg font-bold text-black-800">Mumbai &rarr; Delhi</p> <p class="text-s text-blue-600 mt-1">Daily Express / 12 Trains</p> <p class="text-s text-gray-500">Avg. 16 hours</p> </a>
                  <a href="#" class="block bg-pink-100 border border-blue-200 rounded-xl shadow-sm p-4 text-center text-gray-800 transition transform hover:scale-105 duration-300 hover:shadow-md"> <p class="text-lg font-bold text-black-800">Chennai &rarr; Bengaluru</p> <p class="text-s text-blue-600 mt-1">Shatabdi / Vande Bharat</p> <p class="text-s text-gray-500">Avg. 6 hours</p> </a>
                  <a href="#" class="block bg-pink-100 border border-blue-200 rounded-xl shadow-sm p-4 text-center text-gray-800 transition transform hover:scale-105 duration-300 hover:shadow-md"> <p class="text-lg font-bold text-black-800">Durgapur &rarr; Kolkata</p> <p class="text-s text-blue-600 mt-1">Fast Passenger / Mail</p> <p class="text-s text-gray-500">Avg. 3 hours</p> </a>
                  <a href="#" class="block bg-pink-100 border border-blue-200 rounded-xl shadow-sm p-4 text-center text-gray-800 transition transform hover:scale-105 duration-300 hover:shadow-md"> <p class="text-lg font-bold text-black-800">Hyderabad &rarr; Pune</p> <p class="text-s text-blue-600 mt-1">Overnight Express</p> <p class="text-s text-gray-500">Avg. 14 hours</p> </a>
             </div>

             <!-- Why Book With RailSetu Section -->
            <div class="mt-20">
                <h2 class="text-3xl font-extrabold Inter text-center mb-10 text-gray-900">Why Book With RailSetu</h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <!-- Card 1: Confirm -->
                    <div class="bg-blue-100 rounded-xl shadow-lg border border-gray-200 p-6 flex flex-col md:flex-row items-center text-center md:text-left"> <div class="why-book-image-wrapper"> <img src="https://st.redbus.in/Images/redrail/USP%20Page/redRail_confirm.png" alt="Confirmation Illustration" class="why-book-image"> </div> <div> <p class="font-bold text-lg text-green-700">RailSetu Confirm</p> <p class="text-m text-gray-600">Confirm ticket on waitlisted trains</p> </div> </div>
                    <!-- Card 2: Alternate -->
                    <div class="bg-blue-100 rounded-xl shadow-lg border border-gray-200 p-6 flex flex-col md:flex-row items-center text-center md:text-left"> <div class="why-book-image-wrapper"> <img src="https://st.redbus.in/Images/redrail/USP%20Page/seat_guarantee.png" alt="Alternate Trip Illustration" class="why-book-image"> </div> <div> <p class="font-bold text-lg text-blue-700">Alternate Trip</p> <p class="text-m text-gray-600">On waitlisted tickets or 3X refund</p> </div> </div>
                    <!-- Card 3: Connecting -->
                    <div class="bg-blue-100 rounded-xl shadow-lg border border-gray-200 p-6 flex flex-col md:flex-row items-center text-center md:text-left"> <div class="why-book-image-wrapper"> <img src="https://st.redbus.in/Images/redrail/USP%20Page/connecting_train.png" alt="Connecting Trains Illustration" class="why-book-image"> </div> <div> <p class="font-bold text-lg text-orange-700">Connecting Trains</p> <p class="text-m text-gray-600">Connecting trains option available</p> </div> </div>
                </div>
            </div>
             <!-- === END Why Book Section === -->

        </div> <!-- End Container -->
    </div> <!-- End Content Section -->

    <!-- === NEW Customer Review Section === -->
    <div class="review-section-bg">
        <div class="container mx-auto px-6">
             <h2 class="text-3xl font-extrabold text-center mb-10 text-gray-900">What Our Customers Say</h2>
             <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                 <!-- Review Card 1 -->
                <div class="review-card">
                    <p class="text-gray-700 italic text-lg mb-4">"The best train booking experience! Super fast and easy."</p>
                    <div>
                        <p class="font-semibold text-pink-800">- Priya Sharma</p>
                        <p class="text-yellow-500 text-xl">&#9733;&#9733;&#9733;&#9733;&#9733;</p>
                    </div>
                </div>
                <!-- Review Card 2 -->
                <div class="review-card">
                    <p class="text-gray-700 italic text-lg mb-4">"Loved the confirmation feature for waitlisted tickets. Will use again!"</p>
                    <div>
                        <p class="font-semibold text-pink-800">- Rahul Verma</p>
                        <p class="text-yellow-500 text-xl">&#9733;&#9733;&#9733;&#9733;&#9733;<span class="text-gray-300"></span></p> 
                    </div>
                </div>
                <!-- Review Card 3 -->
                <div class="review-card">
                     <p class="text-gray-700 italic text-lg mb-4">"Affordable and reliable. Highly recommend RailSetu!"</p>
                     <div>
                        <p class="font-semibold text-pink-800">- Ananya Gupta</p>
                        <p class="text-yellow-500 text-xl">&#9733;&#9733;&#9733;&#9733;&#9733;</p>
                    </div>
                </div>
             </div>
        </div>
    </div>
    <!-- === END Customer Review Section === -->


    <!-- Footer -->
    <!-- Footer -->
<footer class="bg-gray-900 text-gray-400 py-6 mt-0">
  <div class="container mx-auto px-6 text-center">
    <p>&copy; 2025 RailSetu - Indian Railways Management. All rights reserved.</p>

    <div class="mt-4 space-x-6">
      <a href="#" class="footer-link text-sm hover:text-white">Privacy Policy</a>
      <a href="#" class="footer-link text-sm hover:text-white">Terms of Service</a>
      <a href="#" class="footer-link text-sm hover:text-white">Contact Us</a>
    </div>

    <!-- Social Media Icons -->
    <div class="mt-6 flex justify-center space-x-6">
      <!-- Facebook -->
      <a href="#" class="hover:text-blue-500 transition">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
          <path d="M22 12a10 10 0 1 0-11.5 9.9v-7H8v-3h2.5V9.5a3.5 3.5 0 0 1 3.7-3.9c1.1 0 2.2.2 2.2.2v2.4h-1.2c-1.2 0-1.6.8-1.6 1.6V12H18l-.5 3h-2.9v7A10 10 0 0 0 22 12z"/>
        </svg>
      </a>

      <!-- Instagram -->
      <a href="#" class="hover:text-pink-500 transition">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
          <path d="M7 2C4.2 2 2 4.2 2 7v10c0 2.8 2.2 5 5 5h10c2.8 0 5-2.2 5-5V7c0-2.8-2.2-5-5-5H7zm10 2c1.7 0 3 1.3 3 3v10c0 1.7-1.3 3-3 3H7c-1.7 0-3-1.3-3-3V7c0-1.7 1.3-3 3-3h10zm-5 3a5 5 0 1 0 0 10 5 5 0 0 0 0-10zm0 2a3 3 0 1 1 0 6 3 3 0 0 1 0-6zm4.8-.8a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
        </svg>
      </a>

      <!-- Twitter (Old logo) -->
      <a href="#" class="hover:text-sky-400 transition">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
          <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53A4.48 4.48 0 0 0 22.43.36a9.09 9.09 0 0 1-2.88 1.1A4.52 4.52 0 0 0 11 5.07a12.8 12.8 0 0 1-9.29-4.7 4.48 4.48 0 0 0 1.4 6.04A4.41 4.41 0 0 1 2 6.1v.05a4.52 4.52 0 0 0 3.6 4.43A4.48 4.48 0 0 1 2 10.3a4.53 4.53 0 0 0 4.22 3.14A9.05 9.05 0 0 1 1 18.57a12.73 12.73 0 0 0 6.92 2.02c8.3 0 12.84-6.9 12.84-12.88 0-.2 0-.4-.02-.59A9.22 9.22 0 0 0 23 3z"/>
        </svg>
      </a>

      <!-- X (new Twitter logo) -->
      <a href="#" class="hover:text-gray-300 transition">
        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
          <path d="M18.36 2H21l-7.44 8.5L22 22h-5.6l-4.35-6.13L7 22H3.64l7.86-9.06L2 2h5.64l4.03 5.71L18.36 2z"/>
        </svg>
      </a>
    </div>
  </div>
</footer>


    <!-- JavaScript for Search Button (No changes here) -->
    <script>
        // Get the search button element
        const searchButton = document.getElementById('searchTrainBtn');

        // Add event listener for click
        searchButton.addEventListener('click', function(event) {
            event.preventDefault(); // Prevent default form submission

            // --- Placeholder Functionality: Redirect to View All Trains ---
            console.log("Search button clicked. Redirecting to viewTrains (placeholder)...");
            window.location.href = 'viewTrains'; // Redirect to your ViewTrainsServlet URL pattern
        });
    </script>

</body>
</html>

