/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Hasan
 */
@WebServlet(urlPatterns = {"/filterCourses"})
public class filterCourses extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession(true);
            String studSSN = session.getAttribute("studSSN").toString();

            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/miniuniversity";
            String user = "root";
            String password = "lollol";
            String query = "Select * from Registered where SSN = "+studSSN;
            Connection Con = DriverManager.getConnection(url, user, password);
            Statement Stmt = Con.createStatement();
            ResultSet RS = Stmt.executeQuery(query);

            ArrayList <String> alreadyRegistered = new ArrayList <> ();

            while(RS.next()){
                String tempSSN = RS.getString("SSN");
                if(tempSSN.equals(studSSN))
                    alreadyRegistered.add(RS.getString("CrsCode"));
            }
            
            String[] alreadyRegistered1 = new String[alreadyRegistered.size()];
            alreadyRegistered1 = alreadyRegistered.toArray(alreadyRegistered1);

            session.setAttribute("alreadyRegistered", alreadyRegistered1);
            
            response.sendRedirect("selectCourses.jsp");
            
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(filterCourses.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
