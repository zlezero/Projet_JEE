<%-- 
    Document   : admin
    Created on : 12 mars 2019, 08:57:23
    Author     : rhardy
--%>

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
        
        <h1>Welcome Admin<h1><br/>
        <th><br/><br/>
                    
        <table class="table table-striped">
            <thead>
              <tr>
                <th scope="col">id</th>
                <th scope="col">Name</th>
                <th scope="col">Games played</th>
                <th scope="col">Score</th>
              </tr>
            </thead>
            <tbody>
        <%
            double avg_coups = 0.0;
            double avg_parties = 0.0;
            int i = 0;
            int id [] = new int [100000];
            String name [] = new String [100000];
            int nb_coups [] = new int [100000];
            int nb_parties [] = new int [100000];
             Connection conn=null;
                Statement stmt=null;
                    try{
                        Class.forName("com.mysql.jdbc.Driver").newInstance();
                    }catch(Exception e){out.print(e);}

                    try{
                        String jdbc="jdbc:mysql://localhost:3306/g8";
                        String root = "g8";
                        String mdp = "g8";
                        conn=DriverManager.getConnection(jdbc,root,mdp);
                        stmt=conn.createStatement();
                    }catch(Exception e){out.print(e);}

                    String select_users = "SELECT u.id_user, u.name, p.nb_parties, p.nb_coups FROM users u, parties p WHERE u.id_user = p.id_user;";
              
                    Statement st = conn.createStatement();
                   
                    ResultSet rs = st.executeQuery(select_users);
                                     
                    
                    while (rs.next())
                    {
                      id [i] = rs.getInt("id_user");
                      name [i] = rs.getString("name");
                      nb_parties [i] = rs.getInt("nb_parties");
                      nb_coups [i] = rs.getInt("nb_coups");
                      
                      avg_coups += nb_coups[i];
                      
                      avg_parties += nb_parties[i];
                      
                      
                      out.println("<tr>");
                      out.println("<th scope=\"row\"> " + id[i] + "</th>");
                      out.println("<td>" + name[i] + "</td>");
                      out.println("<td>" + nb_parties[i] + "</td>");
                      out.println("<td>" + nb_coups[i] + "</td>");
                      out.println("</tr>");
                      
                      i++;
                      
                    }
                    double sum_coups = avg_coups;
                    avg_coups = avg_coups/ avg_parties;
                    double ecarttype = 0.0;
                    for (int j = 0; j < i; j++) {
                        ecarttype += Math.pow(Math.abs(avg_coups - nb_coups[j]),2);
                        
                        
                    }
                    
                    ecarttype = ecarttype / sum_coups;
                    ecarttype = Math.sqrt(ecarttype);
                    

                    st.close();
    %>    
            </tbody>
          </table>
            <br/><br/>
            
            
            <%
                    
                    if(request.getParameter("moyenne") != null) {
                        DecimalFormat df2 = new DecimalFormat("###.###");
                        out.println(df2.format(avg_coups));
                    }
                    if(request.getParameter("ecarttype") != null) {
                        DecimalFormat df = new DecimalFormat("###.###");
                        out.println(df.format(ecarttype));
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
