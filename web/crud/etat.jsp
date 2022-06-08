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
                                <ul class="navbar-nav me-auto mb-4 mb-lg-0">
                                    <li class="nav-item" >
                                        <h2 style="text-align: center">Etat des prestations</h2>
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
            
            <div class="col-sm-8" style="padding-left: 80px">
                <div>
                    <table class="table">
                        <thead>
                        <%
                            String dt = request.getParameter("dt");
                            Connection con;
                            ResultSet rs;
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                            String query = "SELECT DISTINCT DATE_FORMAT(date,'%Y') AS datent FROM `entretien`WHERE DATE_FORMAT(date,'%Y')='"+dt+"'";
                            Statement st = con.createStatement();
                            rs =  st.executeQuery(query);
                            while(rs.next())
                            {
                        %>
                          <tr>
                            <th scope="col">ANNEE </th>
                            <td>
                                 <%=rs.getString("datent") %>
                            </td>
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
                            <th class="table-success" scope="col">N°Intervenant</th>
                            <th class="table-success" scope="col">Nom</th>
                            <th class="table-success" scope="col">Prestation</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            String qu = "SELECT intervenant.num_int,nom,tho ,DATE_FORMAT(date,'%Y') AS datent , SUM(nbh)*tho AS mon FROM intervenant,entretien WHERE intervenant.num_int = entretien.num_int and DATE_FORMAT(date,'%Y')='"+dt+"' GROUP BY num_int ";
                        rs =  st.executeQuery(qu);
                         while(rs.next())
                            {
                        %>
                        <tr>
                            <td><%=rs.getString("num_int") %></td>
                            <td><%=rs.getString("nom") %></td>
                            <td><%=rs.getString("mon") %></td>
                        </tr>
                        
                        <%
                          }

                         %> 
                    </tbody>
                </table>

            </div>
            
        </div>
        
    </body>
</html>
