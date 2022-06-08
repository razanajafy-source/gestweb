<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.*" %> 


<% 
    try{
        String numi = request.getParameter("id");
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
        pst = con.prepareStatement("delete from materiel where num_mat = ?");
        pst.setString(1, numi);
        pst.executeUpdate();  
        
        %>
        
        <script>
            window.location.replace("mat.jsp");       
       </script>
       <%
           }catch (Exception e) {
            
                                JOptionPane.showMessageDialog(null, "Imposible");
%>
        
        <script>
            window.location.replace("mat.jsp");       
       </script>
       <%
                            }
       %>
