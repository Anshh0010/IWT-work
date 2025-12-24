package com.sms.servlet;

import com.sms.dao.AttendanceDAO;
import com.sms.model.AttendanceStats;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * DefaultersServlet - Display attendance defaulters (< 75%)
 * UNIQUE FEATURE: Attendance Defaulter List
 */
@WebServlet("/admin/defaulters")
public class DefaultersServlet extends HttpServlet {
    
    private AttendanceDAO attendanceDAO;
    
    @Override
    public void init() throws ServletException {
        attendanceDAO = new AttendanceDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get defaulters list
            List<AttendanceStats> defaulters = attendanceDAO.getDefaulters();
            request.setAttribute("defaulters", defaulters);
            
            // Forward to defaulters page
            request.getRequestDispatcher("/admin/defaulters-report.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load defaulters: " + e.getMessage());
            request.getRequestDispatcher("/admin/defaulters-report.jsp").forward(request, response);
        }
    }
}
