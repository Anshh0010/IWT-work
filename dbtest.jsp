<%@ page import="java.sql.*" %>
    <%@ page import="com.sms.util.DatabaseUtil" %>
        <!DOCTYPE html>
        <html>

        <body>
            <h1>Database Connection Test</h1>
            <% try { Class.forName("com.mysql.cj.jdbc.Driver"); Connection
                conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/student_management_system", "root"
                , "root" ); out.println("<p style='color:green'>Direct Connection: SUCCESS</p>");
                conn.close();
                } catch (Exception e) {
                out.println("<p style='color:red'>Direct Connection Failed: " + e.getMessage() + "</p>");
                e.printStackTrace(new java.io.PrintWriter(out));
                }

                try {
                DatabaseUtil dbUtil = DatabaseUtil.getInstance();
                Connection conn2 = dbUtil.getConnection();
                if (conn2 != null) {
                out.println("<p style='color:green'>DatabaseUtil Connection: SUCCESS</p>");
                conn2.close();
                } else {
                out.println("<p style='color:red'>DatabaseUtil Connection: FAILED (null)</p>");
                }
                } catch (Throwable e) {
                out.println("<p style='color:red'>DatabaseUtil Exception: " + e.getMessage() + "</p>");
                }
                %>
        </body>

        </html>