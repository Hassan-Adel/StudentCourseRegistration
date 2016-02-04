<%-- 
    Document   : selectCourses
    Created on : Nov 11, 2015, 11:48:28 AM
    Author     : Hasan
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.sql.*"%>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Available Courses</title>
    </head>
    <body>
        <h1>Select the subjects you would like to enroll in below: </h1>
        
        <%
            String url = "jdbc:mysql://localhost:3306/miniuniversity";
            String user = "root";
            String password = "lollol";
            String query = "Select * from Course";
            Connection Con = DriverManager.getConnection(url, user, password);
            Statement Stmt = Con.createStatement();
            ResultSet RS = Stmt.executeQuery(query);
            
            String [] alreadyRegistered = (String [])session.getAttribute("alreadyRegistered");
            //out.print(alreadyRegistered.length);
            
            %><form action="reviewCourses.jsp" method="post"><%
            
                while(RS.next()){
                    String tempName = RS.getString("Name");
                    String tempCrsCode = RS.getString("CrsCode");
                    String tempCourse = tempCrsCode+"-"+tempName;
                    
                    if(!Arrays.asList(alreadyRegistered).contains(tempCrsCode)){
            
                        %><input type="checkbox" name="course" value= <%=tempCourse%> ><% 
                        out.println(tempCourse);
                        %><br><%
                    }
                }
            %><br><input type="submit" value="Done!"><%
            %></form><%
               
        %>
            
    </body>
</html>
