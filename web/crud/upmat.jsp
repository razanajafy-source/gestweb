<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<% 
    if(request.getParameter("submit")!=null)
    {
        String num = request.getParameter("numat");
        String des = request.getParameter("des");
        String car = request.getParameter("car");
        String et = request.getParameter("etat");
        try {
                Connection con;
                PreparedStatement pst;
                ResultSet rs;

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                pst = con.prepareStatement("update materiel set num_mat = ?,des = ?,car = ?,etat = ? where num_mat = ?");
                pst.setString(1, num);
                pst.setString(2, des);
                pst.setString(3, car);
                pst.setString(4, et);
                pst.setString(5, num);
                pst.executeUpdate();
                //JOptionPane.showMessageDialog(null, "save");
                
            }catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Le numero materiel est immodifiable");
            }
              %> 
        <script>   
            window.location.replace("mat.jsp");       
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
                                    <a class="nav-link" href="inter.jsp">INTERVENANT</a>
                                  </li>
                                  <li class="nav-item">
                                    <a class="nav-link active alert-link" href="mat.jsp">MATERIEL</a>
                                  </li>
                                </ul>
                                <form class="d-flex" role="search">
                                  <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                                  <button class="btn btn-outline-success" type="submit">Search</button>
                                </form>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
            <div class="card" style="width: 22rem; height: 25rem">
            <img src="../img/sécurite-informatique.jpeg" class="card-img-top" alt="Metier">
            <div class="card-body">
              <h5 class="card-title">Materiel</h5>
              <form method="POST" action="#">
                   <%   
                        try {
                        
                            Connection con;
                            PreparedStatement pst;
                            ResultSet rs;
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                            String numa = request.getParameter("id");
                            pst = con.prepareStatement("select * from materiel where num_mat = ?");
                            pst.setString(1, numa);
                            rs = pst.executeQuery();
                            while(rs.next())
                            {

                                %>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="numat"  value="<%= rs.getString("num_mat")%>" id="floatingInput" placeholder="num" required >
                        <label for="floatingInput">N° materiel</label>
                    </div>
                    <div class="form-floating mb-3">
                       <input type="text" class="form-control" name="des"  value="<%= rs.getString("des")%>" id="floatingInput" placeholder="des" required >
                       <label for="floatingInput">Design</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="car"  value="<%= rs.getString("car")%>" id="floatingInput" placeholder="car" required >
                       <label for="floatingPassword">Caracteristique</label>
                    </div>
                    <div class="form-label">
                        <select name="etat" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
                            <option selected Disabled><%= rs.getString("etat")%></option>
                            <option>Bon</option>
                            <option>Mauvais</option>
                            <option>Abimee</option>
                      </select>
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
                  <button type="submit" value="submit" name="submit" id="submit" class="btn btn-primary">Ajouter</button>
                </form>
            </div>
            </div>
            <div class="col-sm-8">
                <table  class="table" >
                    <thead>
                        <tr>
                            <th class="table-success" scope="col">N°Materiel</th>
                            <th class="table-success" scope="col">Design</th>
                            <th class="table-success" scope="col">Caracteristique</th>
                            <th class="table-success" scope="col">Etat</th>
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
                            String query = "select * from materiel";
                            Statement st = con.createStatement();
                            rs =  st.executeQuery(query);
                            while(rs.next())
                            {
                               String numi = rs.getString("num_mat");
                        %>
                        <tr>
                            <td><%=rs.getString("num_mat") %></td>
                            <td><%=rs.getString("des") %></td>
                            <td><%=rs.getString("car") %></td>
                            <td><%=rs.getString("etat") %></td>
                            <td>
                                <a href="upmat.jsp?id=<%=numi%>"><span><img src="../img/edit.png" width="25" height="height"/></span></a>
                                <a href="delmat.jsp?id=<%=numi%>"><span><img src="../img/trash.png" width="25" height="height"/></span></a>
                            </td>
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
