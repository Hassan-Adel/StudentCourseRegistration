<%-- 
    Document   : reviewCourses
    Created on : Nov 14, 2015, 2:24:28 PM
    Author     : Hasan
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Selected Courses</title>
    </head>
    <body>
        <h1>You Selected: </h1>
        <%
            if(request.getContentLength() > 0){
                String [] courses = request.getParameterValues("course");
                int size = courses.length;
                if(size > 0){
                    session.setAttribute("coursesArray", courses);

                    %><form action="save&displayCourses.jsp" method="post"><%

                        for(int i=0; i<size; i++){
                            out.println(courses[i]);
                        %><br><%
                        }

                    %><br><input type="submit" name="proceed" value="Agree & Proceed"><%
                        %><button type="submit" formaction="selectCourses.jsp">Back</button><br><%
                    %></form><%
                }
            }
            else{
                response.sendRedirect("selectCourses.jsp");
            }
        %>
    </body>
</html>
