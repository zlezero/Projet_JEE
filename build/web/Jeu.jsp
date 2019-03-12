<%-- 
    Document   : Jeu
    Created on : 12 mars 2019, 10:14:59
    Author     : tvathonn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <%@include file="include/header.jsp" %>
    
    <%
    
    if (request.getParameter("nbrParties") != null) {
        
        try {
            if (Integer.valueOf(request.getParameter("nbrParties")) >= 5 && Integer.valueOf(request.getParameter("nbrParties")) <= 10) {   
                out.print("ok");
            } else { response.sendRedirect("User.jsp?erreur"); }
        } catch (Exception e) {response.sendRedirect("User.jsp?erreur"); }  
        
    } else { response.sendRedirect("User.jsp?erreur"); }
    
    
    
    %>
    
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
