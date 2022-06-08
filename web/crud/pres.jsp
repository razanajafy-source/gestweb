<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 
                        

<!DOCTYPE html>
<html>
    <head>
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
    </head>
    <body  >
        <div class="row">
            <div>
                <div class="shadow mb-3 bg-body">
                    <nav class="navbar navbar-expand-sm bg-info">
                        <div class="container-fluid">
                                <img src="../img/quest-ce-que-audit-informatique--scaled.jpeg" alt="icon" style="width: 70px"/>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav me-auto mb-5 mb-lg-0">
                                  <li class="nav-item">
                                      <h2>Etat de la liste des interventions</h2>
                                  </li>
                                </ul>
                                <form class="d-flex" role="search">
                                    <button class="btn btn-outline-success" type="submit"><a href="inter.jsp">Retour</a></button>
                                </form>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
            <div class="card" style="width: 25rem; height: 30rem">
            <img src="../img/reparationordinateur.jpg" class="card-img-top" alt="Metier">
            <div class="card-body">
              <h5 class="card-title">ETAT DES PRESTATIONS</h5>
              <div style="width: 200PX">

                    <%
                        String numi = request.getParameter("id");
                        Connection con;
                        ResultSet rs;
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                        String query = "SELECT DISTINCT DATE_FORMAT(date,'%Y') AS datent FROM `entretien`";
                        Statement st = con.createStatement();
                        rs =  st.executeQuery(query);
                        while(rs.next())
                        {
                            String dat = rs.getString("datent");

                    %>
                          <button class="btn btn-outline-light" ><a href="etat.jsp?dt=<%=dat%>"><%=rs.getString("datent") %></a></button>

                   <%

                          }
                         %>  
                </div>
            </div>
            </div>
            <div class="col-sm-8">
                <div>
                    
                    
                    <table class="table">
                        <thead>
                        <%
                            
                            String rq = "SELECT DISTINCT intervenant.num_int,nom,tho ,DATE_FORMAT(date,'%Y') AS datent FROM intervenant,entretien WHERE intervenant.num_int=entretien.num_int and intervenant.num_int='"+numi+"' group by num_int";
                            rs =  st.executeQuery(rq);
                            while(rs.next())
                            {
                        %>
                          <tr>
                            <th scope="col">N°Intervenant: </th>
                            <td><%=rs.getString("num_int") %> </td>
                          </tr>
                          <tr>
                            <th scope="col">Nom: </th>
                            <td><%=rs.getString("nom") %> </td>
                          </tr>
                          <tr>
                            <th scope="col">Taux</th>
                            <td ><%=rs.getString("tho") %></td>
                          </tr>
                          <tr>
                            <th scope="col">ANNEE</th>
                            <td><%=rs.getString("datent") %></td>
                          </tr>
                          
                        <%

                          }
                         %>  
                        </thead>
                       
                      </table>

                </div>
                <table  class="table" >
                    <thead>
                        <tr>
                            <th class="table-success" scope="col">N°Materiel</th>
                            <th class="table-success" scope="col">Design</th>
                            <th class="table-success" scope="col">Heures</th>
                            <th class="table-success" scope="col">Montant</th>
                            <th class="table-success" scope="col">Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String rqt = "SELECT * , nbh*tho AS mon  FROM intervenant,materiel,entretien WHERE intervenant.num_int=entretien.num_int AND entretien.num_mat=materiel.num_mat and intervenant.num_int='"+numi+"'";
                            rs =  st.executeQuery(rqt);
                            while(rs.next())
                            {
                        %>
                        <tr>
                            <td><%=rs.getString("num_mat") %></td>
                            <td><%=rs.getString("des") %></td>
                            <td><%=rs.getString("nbh") %></td>
                            <td><%=rs.getString("mon") %></td>
                            <td><%=rs.getString("date") %></td>
                        </tr> 
                        
                        <%

                          }
                         %> 
                    </tbody>
                    <tfoot>
                        
                        <%
                            String rqt1 = "SELECT * , nbh*tho AS mon , SUM(nbh*tho) AS mt FROM intervenant,entretien WHERE intervenant.num_int=entretien.num_int AND  intervenant.num_int='"+numi+"'";
                            rs =  st.executeQuery(rqt1);
                            while(rs.next())
                            {
                        %>
                        <tr>
                            <td>Montant Total :</td>
                            <td><%=rs.getString("mt") %> ar</td>
                        </tr> 
                        
                        <%

                          }
                         %> 
                    </tfoot>
                </table>

            </div>
            
        </div>
        
    </body>
</html>
