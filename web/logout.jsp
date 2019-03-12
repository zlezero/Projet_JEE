<%-- 
    Document   : logout
    Created on : 12 mars 2019, 09:34:58
    Author     : tvathonn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deconnexion</title>
    </head>
    <body>
        <% session.invalidate(); response.sendRedirect("index.jsp"); %>
    </body>
</html>
