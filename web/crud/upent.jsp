<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %> 

<% 
    if(request.getParameter("submit")!=null)
    {
        String numa = request.getParameter("numat");
        String numi = request.getParameter("numint");
        String dat = request.getParameter("date");
        String hr = request.getParameter("nbh");
        try {
                Connection con;
                PreparedStatement pst;
                ResultSet rs;

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
                pst = con.prepareStatement("update entretien set num_mat = ?, num_int = ?, date = ?, nbh = ? where num_mat = ? and num_int = ?");
                pst.setString(1, numa);
                pst.setString(2, numi);
                pst.setString(3, dat);
                pst.setString(4, hr);
                pst.setString(5, numa);
                pst.setString(6, numi);
                pst.executeUpdate();
                //JOptionPane.showMessageDialog(null, "save");
                
            }catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
            }
              %> 
        <script>   
            window.location.replace("entre.jsp");       
        </script> 
     
    <%             
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title> 
        
         <link href="../bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        
        
        
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
                            String numa = request.getParameter("id1");
                            pst = con.prepareStatement("select * from entretien where num_mat = ? and num_int = ?");
                            pst.setString(1, numa);
                            pst.setString(2, numi);
                            rs = pst.executeQuery();
                            while(rs.next())
                            {

                                %>
                                <div>
                                    <label class="form-label">N° materiel</label>
                                    <input type="text" class="form-control"  name="numat" value="<%= rs.getString("num_mat")%>" required Disabled >
                                </div>

                                <div>
                                    <label class="form-label">N° Intervenant</label>
                                    <input type="text" class="form-control"  name="numint" value="<%= rs.getString("num_int")%>" required Disabled >
                                </div>

                                <div>
                                    <label class="form-label">Date</label>
                                    <input type="text" class="form-control" name="date" id="taux" value="<%= rs.getString("date")%>" required >
                                </div>
                                <div>
                                    <label class="form-label">Heures</label>
                                    <input type="text" class="form-control" name="nbh" id="taux" value="<%= rs.getString("nbh")%>" required >
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
