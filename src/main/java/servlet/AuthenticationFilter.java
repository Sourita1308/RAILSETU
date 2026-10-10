package servlet; // Matches your folder structure

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class AuthenticationFilter implements Filter {

    // Set of paths that DO NOT require login
    private final Set<String> allowedPaths = new HashSet<>(Arrays.asList(
        "/login.jsp",    // Login page itself
        "/login",        // Login servlet action
        "/signup.jsp",   // Signup page itself
        "/signup",       // Signup servlet action
        "/index.jsp",    // Allow homepage (since it was renamed from .html)
        "/",             // Allow root context path (defaults to index.jsp)
        "/account.html", // === ADDED: Allow access to the account required page ===
        "/forgot-password.jsp",
        "/forgot-password"
    ));

    // Prefixes for static resources that DON'T require login
    private final String[] staticResourcePrefixes = {
        "/css/",
        "/images/",
        "/js/" // Add others if needed (like /fonts/)
    };


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // This method is called once when the filter is first loaded.
        System.out.println("AuthenticationFilter initialized.");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // This method is called for EVERY request that matches the filter mapping in web.xml

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false); // false = don't create a new session if one doesn't exist

        String requestURI = httpRequest.getRequestURI(); // e.g., /RailwayManagement/viewTrains
        String contextPath = httpRequest.getContextPath(); // e.g., /RailwayManagement
        String pathWithinApp = requestURI.substring(contextPath.length()); // e.g., /viewTrains

        // Check if user is logged in (we assume "userId" is stored in session upon successful login)
        boolean loggedIn = (session != null && session.getAttribute("userId") != null);

        // Check if the requested path is one of the explicitly allowed public paths
        boolean isAllowedPath = allowedPaths.contains(pathWithinApp);

        // Check if the requested path starts with any static resource prefix (e.g., /css/style.css)
        boolean isStaticResource = false;
        for (String prefix : staticResourcePrefixes) {
            if (pathWithinApp.startsWith(prefix)) {
                isStaticResource = true;
                break;
            }
        }

        // --- Main Filter Logic ---
        // Allow the request to proceed if:
        // 1. The user IS logged in (session has userId)
        // OR
        // 2. The requested path is in our allowed list (login, signup, home, account page)
        // OR
        // 3. The request is for a static resource (css, images, js)
        if (loggedIn || isAllowedPath || isStaticResource) {
            // Let the request continue to its intended destination (servlet or JSP)
            // System.out.println("Allowing request for: " + pathWithinApp); // Debug line
            chain.doFilter(request, response);
        } else {
            // User is NOT logged in AND is trying to access a protected resource.
            System.out.println("User not logged in. Redirecting to account required page from protected path: " + pathWithinApp);

            // === REDIRECT UPDATED ===
            // Redirect the user to your custom account information page
            httpResponse.sendRedirect(contextPath + "/account.html");
        }
    }

    @Override
    public void destroy() {
        // This method is called once when the server shuts down or undeploys the app.
        System.out.println("AuthenticationFilter destroyed.");
    }
}

