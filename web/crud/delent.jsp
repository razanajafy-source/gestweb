<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.*" %> 


<% 
    try{
        String numi = request.getParameter("id");
        String numa = request.getParameter("id1");
        String dat = request.getParameter("id2");
        Connection con;
        PreparedStatement pst;
        ResultSet rs;
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
        pst = con.prepareStatement("delete from entretien where num_int = ? and num_mat = ? and date = ?");
         pst.setString(1, numi);
         pst.setString(2, numa);
         pst.setString(3, dat);
        pst.executeUpdate();  
        
        %>
        
        <script>
            alert("Record Deletee");
            window.location.replace("entre.jsp");       
       </script>
       <%
           }catch (Exception e) {
            
                                JOptionPane.showMessageDialog(null, e);
                            }
       %>