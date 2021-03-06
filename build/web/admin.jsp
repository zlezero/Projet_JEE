<%-- 
    Document   : admin
    Created on : 12 mars 2019, 08:57:23
    Author     : rhardy
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.math.*" %>

<!DOCTYPE html>

<html>
    
    <%@include file="include/header.jsp" %>

    
    <%
        if (session.getAttribute("Droit") == null || !session.getAttribute("Droit").equals("Admin")) {
            response.sendRedirect("index.jsp");
        }
    %>
    <body>
        
        <div class="row mt-2">
          <div class="col-md-3"></div>
          <div class="col-md-6">
              <h1>Bienvenue sur la page d'administration</h1>           
          </div>
        </div>
   
        <table class="table table-striped">
            <thead>
              <tr>
                <th scope="col">Nombre de coups</th>
                <th scope="col">Nombre de parties</th>
              </tr>
            </thead>
            <tbody>
        <%
                double avg_coups = 0.0;
                double avg_parties = 0.0;
                int i = 0;
                
                int id [] = new int [100000];
                int nb_coups [] = new int [100000];
                
                Connection conn = null;
                Statement stmt = null;

                try {             
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                } catch(Exception e){out.print(e);}

                try {
                    String jdbc="jdbc:mysql://localhost:3306/g8";
                    String root = "g8";
                    String mdp = "g8";
                    conn = DriverManager.getConnection(jdbc,root,mdp);
                    stmt = conn.createStatement();
                } catch(Exception e){out.print(e);}

                String select_users = "SELECT id_user, nb_coups FROM parties;";

                Statement st = conn.createStatement();

                ResultSet rs = st.executeQuery(select_users);                            
                    
                HashMap<Integer, Integer> nbrPartiesCoups = new HashMap<Integer, Integer>();
                
                    while (rs.next())
                    {
                      id[i] = rs.getInt("id_user");
                      nb_coups[i] = rs.getInt("nb_coups");
                      
                      
                      if (nbrPartiesCoups.containsKey(nb_coups[i])) {
                          nbrPartiesCoups.put(nb_coups[i], nbrPartiesCoups.get(nb_coups[i])+1);
                      }
                      else {
                          nbrPartiesCoups.put(nb_coups[i], 1);
                      }     
                      
                      avg_coups += nb_coups[i];

                      i++;

                    }    

                    Iterator iterateurNbParties = nbrPartiesCoups.values().iterator();
                    Iterator iterateurNbCoups = nbrPartiesCoups.keySet().iterator();
                    int nbrParties = 0;
                    
                    while (iterateurNbParties.hasNext()) {
                        nbrParties = (Integer)iterateurNbParties.next();
                        avg_parties += nbrParties;
                        out.println("<tr>");
                        out.println("<th scope=\"row\"> " + nbrParties + "</th>");
                        out.println("<td>" + iterateurNbCoups.next() + "</td>");
                        out.println("</tr>");
                    }

                    double sum_coups = avg_parties;
                    
                    //Calcul de la moyenne
                    avg_coups = avg_coups / avg_parties;
                    
                    //Calcul de l'écart type
                    double ecartType = 0.0;
                    
                    for (int j = 0; j < i; j++) {
                        ecartType += Math.pow(Math.abs(avg_coups - nb_coups[j]),2);                
                    }
                    
                    ecartType = ecartType / sum_coups;
                    ecartType = Math.sqrt(ecartType);                    

                    st.close();
    %>    
            </tbody>
          </table>
            
            
            <%
                    
                    if(request.getParameter("moyenne") != null) {
                        DecimalFormat df2 = new DecimalFormat("###.###");         
                        out.println("La moyenne est de " + df2.format(avg_coups) + " coups par partie");
                    }
                    if(request.getParameter("ecarttype") != null) {
                        DecimalFormat df = new DecimalFormat("###.###");
                        out.println("L'écart type est de : " + df.format(ecartType));
                    }
            
            %>
            
            <form action="admin.jsp" method="post">
                <button class="btn btn-primary" type="submit" id="moyenne" name = "moyenne">Moyenne</button>            
            </form>

            <form action="admin.jsp" method="post"> 
                <button class="btn btn-primary" type="submit" id="ecart-type" name="ecarttype">Ecart-type</button>              
            </form>         

            <br/><a href="logout.jsp" class="btn btn-danger" role="button">Se déconnecter</a>         

        
    </body>
</html>
