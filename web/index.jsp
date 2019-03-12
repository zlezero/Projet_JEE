<%-- 
    Document   : Exercice16
    Created on : 26 févr. 2019, 09:58:58
    Author     : tvathonn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    
    <%@include file="include/header.jsp" %>
    
    <body>
        
        <%
            boolean erreur = false;
            
            if (request.getParameter("id") != null && request.getParameter("pwd") != null) {
                
                Connection conn=null;
                Statement stmt=null;
                
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
                
                try {
                    String login = request.getParameter("id");
                    String  pwd = request.getParameter("pwd");
                    
                   String sel="SELECT id_user, permission from users WHERE name = ? AND password = ?";
                    PreparedStatement st = conn.prepareStatement(sel);
                    st.setString(1, login);
                    st.setString(2, pwd);
                    ResultSet res = st.executeQuery();
                    
                    while (res.next()) {
                        if (res.getString("permission").equals("Admin")) {
                            session.setAttribute("Droit", "Admin");
                            session.setAttribute("Id", res.getString("id_user"));
                            response.sendRedirect("Admin.jsp");
                        }
                        else if (res.getString("permission").equals("User")) {
                            session.setAttribute("Droit", "User");
                            session.setAttribute("Id", res.getString("id_user"));
                            response.sendRedirect("Jeu.jsp");
                        }
                    }
                    
                    erreur = true;
                    
                } catch(Exception e) {out.print("Erreur lors de la connexion : " + e); }

            }
            
            
        %>
        
       
        
        <div class="row mt-2">
          <div class="col-md-3"></div>
          <div class="col-md-6">
            <h1>Se connecter</h1>
            <h3>Thomas Vathonne - Raphael Hardy</h3>
            <% if (erreur == true) { 
                out.print("ERREUR LORS DE LA CONNEXION !");              
              }
            %>
            <hr>
          </div>
        </div>

        <form class="form-group" action="index.jsp" method="post">

            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                  <label for="id">Identifiant :</label>
                  <input type="text" class="form-control" id="id" name="id" placeholder="Identifiant" required>
                </div>
            </div>

          <div class="row mt-2">
            <div class="col-md-3"></div>
            <div class="col-md-6">
              <label for="pwd">Mot de passe :</label>
              <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Mot de passe" required>
            </div>
          </div>
            
          <div class="row mt-2">
            <div class="col-md-3"></div>
            <div class="col-md-6">
              <button type="submit" class="btn btn-success"> <i class="fa fa-sign-in"></i> Se connecter</button>
            </div>
          </div>
            
        </form>
    </body>
</html>
