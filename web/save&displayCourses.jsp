<%-- 
    Document   : displayCourses
    Created on : Nov 14, 2015, 2:55:22 PM
    Author     : Hasan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%Class.forName("com.mysql.jdbc.Driver"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Success!</title>
    </head>
    <body>
        <h1>You're now enrolled in the following courses:</h1>
        <%
            String url = "jdbc:mysql://localhost:3306/miniuniversity";
            String user = "root";
            String password = "lollol";
            Connection Con = DriverManager.getConnection(url, user, password);
            Statement Stmt = Con.createStatement();
            
            String studSSN = session.getAttribute("studSSN").toString();
            String [] coursesArray = (String [])session.getAttribute("coursesArray");
            int size = coursesArray.length;
            
            for(int i=0; i<size; i++){
                String [] course = coursesArray[i].split("-");
                String query = "Insert Into Registered VALUES("+studSSN+ ", '" +course[0]+ "', 'Fall' , '2015')";

                Stmt.executeUpdate(query);
            }
            
            String query1 = "Select * from Registered where SSN = "+studSSN;
            ResultSet RS1 = Stmt.executeQuery(query1);
            
            while(RS1.next()){
                String tempCrsCode = RS1.getString("CrsCode");
                out.print(tempCrsCode+"-");
                String query2 = "Select Name from Course where CrsCode = '"+tempCrsCode+"'";
                Statement Stmt1 = Con.createStatement();
                ResultSet RS2 = Stmt1.executeQuery(query2);
                while(RS2.next()){
                    out.print(RS2.getString("Name"));
                }
                %><br><%
            }
        %>
    </body>
</html>
