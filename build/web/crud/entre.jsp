<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 
<% 

    if(request.getParameter("submit")!=null)
    {
        String numi = request.getParameter("numint");
        String numa = request.getParameter("numat");
        String dt = request.getParameter("date");
        String hr = request.getParameter("nbh");
       
        try {
                Connection con;
                PreparedStatement pst;
                ResultSet rs;

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                String requet = "insert into entretien(num_int, num_mat, date, nbh) values(?,?,?,?)";
                pst = con.prepareStatement(requet);
                pst.setString(1, numi);
                pst.setString(2, numa);
                pst.setString(3, dt);
                pst.setString(4, hr);
                pst.execute();
                //JOptionPane.showMessageDialog(null, "save");
                
            }catch (Exception e) {
            
            JOptionPane.showMessageDialog(null, "L'entretien est exist deja");
            }
    }else{
        
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
                                    <a class="nav-link active alert-link" href="entre.jsp">ENTRETIEN</a>
                                  </li>
                                  <li class="nav-item">
                                    <a class="nav-link" href="inter.jsp">INTERVENANT</a>
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
            <img src="../img/Maintenance-informatique-préventive.jpg" class="card-img-top" alt="Metier">
            <div class="card-body">
              <h5 class="card-title">Intervenant</h5>
              <form method="POST" action="#">
                   <div class="form-label">
                        <label class="form-label">N°Intervenant</label>
                        <select name="numint" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                        <%  
                        try {
                              Connection con;
                              PreparedStatement pst;
                              ResultSet rs;

                              Class.forName("com.mysql.cj.jdbc.Driver");
                              con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                              String sql1 = "select * from intervenant";
                              pst = con.prepareStatement(sql1);
                              rs = pst.executeQuery();

                              while(rs.next()){
                                %>
                                 <option><%= rs.getString("num_int")%></option>
                                <%
                              }
                          }catch (Exception e) {

                              JOptionPane.showMessageDialog(null, e);
                          }
                        %>
                   
                        </select>
                    </div>
                    <div class="form-label">
                        <label class="form-label">N°Materiel</label>
                        <select name="numat" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                        <%  
                        try {
                              Connection con;
                              PreparedStatement pst;
                              ResultSet rs;

                              Class.forName("com.mysql.cj.jdbc.Driver");
                              con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                              String sql1 = "select * from materiel";
                              pst = con.prepareStatement(sql1);
                              rs = pst.executeQuery();

                              while(rs.next()){
                                %>
                                 <option><%=rs.getString("num_mat")%></option>
                                <%
                              }
                          }catch (Exception e) {

                              JOptionPane.showMessageDialog(null, e);
                          }
                        %>
                   
                        </select>
                    </div>
                    <div class="form-floating mb-3">
                       <input type="date" class="form-control" name="date" id="floatingInput" placeholder="Nom">
                       <label for="floatingInput">Date</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="number" class="form-control" name="nbh" id="floatingInput" placeholder="heure">
                       <label for="floatingPassword">Nbr Heures</label>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-10 offset-sm-2">
                        </div>
                    </div>

                  <button type="submit" value="submit" name="submit" id="submit" class="btn btn-primary">Ajouter</button>
                </form>
            </div>
            </div>
            <div class="col-sm-8">
                <table  class="table" id="tb" >
                    <thead>
                        <tr>
                            <th class="table-success" scope="col">N°Intervenant</th>
                            <th class="table-success" scope="col">Nom</th>
                            <th class="table-success" scope="col">N°Materiel</th>
                            <th class="table-success" scope="col">Date</th>
                            <th class="table-success" scope="col">Heures</th>
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
                            String query = "select * from entretien,intervenant where intervenant.num_int=entretien.num_int";
                            Statement st = con.createStatement();
                            rs =  st.executeQuery(query);
                            while(rs.next())
                            {
                               String numi = rs.getString("num_int");
                               String numa = rs.getString("num_mat");
                               String datent = rs.getString("date");
                        %>
                        <tr id="tr">
                            <td><%=rs.getString("num_int") %></td>
                            <td><%=rs.getString("nom") %></td>
                            <td><%=rs.getString("num_mat") %></td>
                            <td><%=rs.getString("date") %></td>
                            <td><%=rs.getString("nbh") %></td>
                            <td><a href="delent.jsp?id=<%=numi%>&&id1=<%=numa%>&&id2=<%=datent%>"><span><img src="../img/trash.png" width="25"/></span></a></td>
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
    </script>    
    </body>
</html>
