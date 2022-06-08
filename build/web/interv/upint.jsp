<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<% 
    if(request.getParameter("submit")!=null)
    {
        String num = request.getParameter("numint");
        String nom = request.getParameter("nomint");
        String tx = request.getParameter("taux");
        try {
                Connection con;
                PreparedStatement pst;
                ResultSet rs;

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                pst = con.prepareStatement("update intervenant set num_int = ?,nom = ?,tho= ? where num_int = ?");
                pst.setString(1, num);
                pst.setString(2, nom);
                pst.setString(3, tx);
                pst.setString(4, num);
                pst.executeUpdate();
                //JOptionPane.showMessageDialog(null, "save");
                
            }catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
            }
              %> 
        <script>   
            window.location.replace("index.jsp");       
        </script> 
     
    <%             
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title> 
        
         <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        
        
        
    </head>
    <body>
        <h1>Student Update</h1>
        
        
        <div class="card">
            <div class="card-body  ">
                <form  method="POST" action="#" >
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
                                <div>
                                    <label class="form-label">Student Name</label>
                                    <input type="text" class="form-control" placeholder="Student Name" name="numint" value="<%= rs.getString("num_int")%>"  id="numint" required >
                                </div>

                                <div>
                                    <label class="form-label">Course</label>
                                    <input type="text" class="form-control" placeholder="Course" name="nomint" value="<%= rs.getString("nom")%>" id="nomint" required >
                                </div>

                                <div>
                                    <label class="form-label">Fee</label>
                                    <input type="text" class="form-control" placeholder="Fee" name="taux" id="taux" value="<%= rs.getString("tho")%>" required >
                                </div>

                            <% 
                            }
                                }catch (Exception e) {
            
                                JOptionPane.showMessageDialog(null, e);
                            }
                            %> 
                         </br>
                         
                     <div>
                         <input type="submit" id="submit" value="submit" name="submit" class="btn btn-info">
                         <input type="reset" id="reset" value="reset" name="reset" class="btn btn-warning">
                     </div>  
                         <div align="right">
                             <p><a href="index.jsp">Click Back</a></p>
                         </div>
  
                </form>
              </div>
            </div>          
  
    </body>
</html>
