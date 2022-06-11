<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 
<% 
    
    if(request.getParameter("submit")!=null)
    {
        String num = request.getParameter("numint");
        String nom = request.getParameter("nom");
        String tx = request.getParameter("taux");
        try {
                Connection con;
                PreparedStatement pst;
                ResultSet rs;

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                pst = con.prepareStatement("update intervenant set nom = ?,tho = ? where num_int = ?");
                pst.setString(1, nom);
                pst.setString(2, tx);
                pst.setString(3, num);
                pst.executeUpdate();
                //JOptionPane.showMessageDialog(null, "save");
                
            }catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Le numero intervenant est immodifiable");
            }
              %> 
        <script>   
            window.location.replace("inter.jsp");       
        </script> 
     
    <%             
    }

%>

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
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                          <li class="nav-item">
                            <a class="nav-link" href="entre.jsp">ENTRETIEN</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link active alert-link" href="inter.jsp">INTERVENANT</a>
                          </li>
                          <li class="nav-item">
                            <a class="nav-link" href="mat.jsp">MATERIEL</a>
                          </li>
                        </ul>
                        <form class="d-flex" role="search">
                          <input class="form-control me-2" name="find" id="find" type="search" placeholder="Search" aria-label="Search">
                        </form>
                      </div>
                    </div>
                  </nav>
                    </div>
            </div>
            <div class="card" style="width: 24rem; height: 30rem">
            <img src="../img/img_metier_I1401.jpg" class="card-img-top" alt="Metier">
            <div class="card-body">
              <h5 class="card-title">Intervenant</h5>
              <form method="POST" action="#">
                  <%   
                        try {
                        
                            Connection con;
                            PreparedStatement pst;
                            ResultSet rs;
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                            String numi = request.getParameter("id");
                            pst = con.prepareStatement("select * from intervenant where num_int = ?");
                            pst.setString(1, numi);
                            rs = pst.executeQuery();
                            while(rs.next())
                            {

                                %>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="numint" value="<%= rs.getString("num_int")%>" required id="floatingInput" placeholder="N° intervenant">
                        <label for="floatingInput">N° intervenant</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="nom" value="<%= rs.getString("nom")%>" required id="floatingInput" placeholder="Nom">
                       <label for="floatingInput">Nom intervenant</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="number" class="form-control" name="taux" value="<%= rs.getString("tho")%>" required id="floatingInput" placeholder="Heures">
                       <label for="floatingPassword">Taux horaire</label>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-10 offset-sm-2">
                        </div>
                    </div>
                        <% 
                            }
                                }catch (Exception e) {
            
                                JOptionPane.showMessageDialog(null, e);
                            }
                            %> 
                  <button type="submit" value="submit" name="submit" id="submit" class="btn btn-primary"><span><img src="../img/edit.png" width="25" height="height" alt="alt"/></span> Modifier</button>
                </form>
            </div>
            </div>
            <div class="col-sm-8">
                <table  class="table" id="tb" >
                    <thead>
                        <tr>
                            <th class="table-success" scope="col">N° intervenant</th>
                            <th class="table-success" scope="col">Nom Intervenant</th>
                            <th class="table-success" scope="col">Taux Horaire</th>
                            <th class="table-success" scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%   
                            Connection con;
                            PreparedStatement pst;
                            ResultSet rs;
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                            String query = "select * from intervenant";
                            Statement st = con.createStatement();
                            rs =  st.executeQuery(query);
                            while(rs.next())
                            {
                               String numi = rs.getString("num_int");
                        %>
                        <tr id="tr">
                            <td><a href="pres.jsp"><%=rs.getString("num_int") %></a></td>
                            <td><%=rs.getString("nom") %></td>
                            <td><%=rs.getString("tho") %></td>
                            <td>
                                <a href="upint.jsp?id=<%=numi%>"><span><img src="../img/edit.png" width="25" height="height" alt="alt"/></span></a>
                                <a href="delint.jsp?id=<%=numi%>"><span><img src="../img/trash.png" width="25" height="height" alt="alt"/></span></a>
                            </td>
                        </tr> 
                        <%

                          }
                         %>  
                    </tbody>
                </table>

            </div>

            
        </div>
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../bootstrap/jquery-3.5.1.min.js" type="text/javascript"></script>
     <script type="text/javascript">
      $(document).ready(function(){
        $("#find").on("keyup", function(){
          var value = $(this).val().toLowerCase();
          $("#tb #tr").filter(function(){
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
          });
        });
      });
    </script>     </body>
</html>