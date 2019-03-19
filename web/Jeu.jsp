<%-- 
    Document   : Jeu
    Created on : 12 mars 2019, 10:14:59
    Author     : tvathonn
--%>

<%@page import="Classes.Joueur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    
    <%@include file="include/header.jsp" %>
    
    <%
        
    Connection conn = null;
    Statement stmt = null;
                
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
    }
    catch(Exception e){out.print(e);}

    try {
        String jdbc="jdbc:mysql://localhost:3306/g8";
        String root= "g8";
        String mdp = "g8";
        conn = DriverManager.getConnection(jdbc, root, mdp);
        stmt = conn.createStatement();
    } catch(Exception e){out.print(e);}
            
    Joueur joueur = new Joueur(0, 5);
    
    if (session.getAttribute("Droit") == null || !session.getAttribute("Droit").equals("User")) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    if (request.getParameter("nbrParties") != null) {
        
       try {
            if (Integer.valueOf(request.getParameter("nbrParties")) >= 5 && Integer.valueOf(request.getParameter("nbrParties")) <= 10) {   
                
                joueur = new Joueur(1, Integer.valueOf(request.getParameter("nbrParties")));
                joueur.jouer();
                
                String ins = "INSERT INTO parties(id_user, nb_coups) VALUES (?,?)";   
                PreparedStatement ps;
                
                for (int i = 0; i!= joueur.getNbrParties(); i++) {  
                    ps = conn.prepareStatement(ins);
                    ps.setInt(1, joueur.getIdJoueur());
                    ps.setInt(2, joueur.getPartie(i).getNbrCoups());
                    ps.executeUpdate();
                }
                        
            } else { response.sendRedirect("User.jsp?erreur"); return; }
       } catch (Exception e) {response.sendRedirect("User.jsp?erreur"); return; }   
        
    } else { response.sendRedirect("User.jsp?erreur"); return; }
    
    
    
    %>
    
    <body>
        <h1>Résultat du jeu</h1>
        
        <table class="table table-striped">
            
            <thead>
              <tr>
                <th scope="col">Partie</th>
                <th scope="col">Nombre de coups</th>
              </tr>
            </thead>
                    
            <tbody>
                <%
                     
                    for (int i = 0; i!= joueur.getNbrParties(); i++) {          
                        out.println("<tr>");
                        out.println("<th scope=\"row\"> " + (i + 1) + "</th>");
                        out.println("<td>" + joueur.getPartie(i).getNbrCoups() + "</td>");
                        out.println("</tr>");
                    }
 
                %>
            </tbody>
            
        </table>
            
        <% 
        
        out.print("<p>Il y a eu " + joueur.getNbrPartiesSup20Coups() + " parties qui se sont jouées en plus de 20 coups.</p>");
        out.print("<p>La moyenne est de " + ( (double)((double)joueur.getNbrCoupTotal() / (double)joueur.getNbrParties()) ) + " coups par parties.</p>");
        
        %>
        
        <a href="logout.jsp" class="btn btn-danger">Se déconnecter</a>
    </body>
</html>
