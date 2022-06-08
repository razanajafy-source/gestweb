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
        pst = con.prepareStatement("delete from intervenant where num_int = ? ");
        pst.setString(1, numi);
        pst.executeUpdate();  
        
        %>
        
        <script>
            window.location.replace("inter.jsp");       
       </script>
       <%
           }catch (Exception e) {
            
                                JOptionPane.showMessageDialog(null, "Imposible");
 %>
        
        <script>
            window.location.replace("inter.jsp");       
       </script>
       <%
                            }
       %>
