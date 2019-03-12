<%-- 
    Document   : Jeu
    Created on : 12 mars 2019, 09:36:21
    Author     : tvathonn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <%@include file="include/header.jsp" %>
    
    <% 
    
    
    if (session.getAttribute("Droit") == null || !session.getAttribute("Droit").equals("User")) {
        response.sendRedirect("index.jsp");
    }
    
    %>
    
    <body>
        
        <form class="form-group" action="Jeu.jsp" method="post">              
            
            <div class="row mt-2">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <h1>Options de la partie</h1>
                    <hr>
                </div>
            </div>
            
            <div class="row mt-2">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                  <label for="nbrParties">Nombre de parties (Entre 5 et 10) :</label>
                  <input type="number" class="form-control" id="nbrParties" name="nbrParties" placeholder="Nombre de parties" min="5" max="10" required>
                </div>
            </div>
            
            <div class="row mt-2">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                  <button type="submit" class="btn btn-success"> <i class="fa fa-sign-in"></i> Jouer</button>
                  <a href="logout.jsp" class="btn btn-danger">Se déconnecter</a>
                </div>
            </div>
            
        </form>
        
    </body>
    
</html>
