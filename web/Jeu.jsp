<%-- 
    Document   : Jeu
    Created on : 12 mars 2019, 10:14:59
    Author     : tvathonn
--%>

<%@page import="Classes.Joueur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <%@include file="include/header.jsp" %>
    
    <%
        
    if (session.getAttribute("Droit") == null || !session.getAttribute("Droit").equals("User")) {
        response.sendRedirect("index.jsp");
    }
    
    if (request.getParameter("nbrParties") != null) {
        
        try {
            if (Integer.valueOf(request.getParameter("nbrParties")) >= 5 && Integer.valueOf(request.getParameter("nbrParties")) <= 10) {   
                
                Joueur joueur = new Joueur(0, Integer.valueOf(request.getParameter("nbrParties")));
                joueur.jouer();                    

                for (int i = 0; i!= joueur.getNbrParties(); i++) {
                    out.println("Partie " + i + " : " + joueur.getPartie(i).getNbrCoups() + "</br>");
                }
                
            } else { response.sendRedirect("User.jsp?erreur"); }
       } catch (Exception e) {response.sendRedirect("User.jsp?erreur"); }  
        
    } else { response.sendRedirect("User.jsp?erreur"); }
    
    
    
    %>
    
    <body>
        <h1>Résultat du jeu</h1>
        <a href="logout.jsp" class="btn btn-danger">Se déconnecter</a>
    </body>
</html>
