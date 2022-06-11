<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%@page import="fram.ConexionBD"%>
 
<%
Gson gsonObj = new Gson();
Map<Object,Object,Object> map = null;
List<Map<Object,Object,Object>> list = new ArrayList<Map<Object,Object,Object>>();
String dataPoints = null;

    Connection con;
    PreparedStatement ps;
    ResultSet rs;  
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion","root","333");
    String xVal

    ResultSet resultSet = statement.executeQuery("SELECT COUNT(etat) AS etatg FROM `materiel` GROUP BY etat");

   


%>
 
<!DOCTYPE HTML>
<html>
<head>
    <title>Graph</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../css/bootstrap.css"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../css/jquery.min.js"/>
    <link rel="stylesheet" href="../css/style.css"/>
    <style>
            .titre {
              background-color:grey;
              color: white;
              font-family: snap itc;
              width: 100%;
              text-align: center;
              padding: 2%;
            }
            body{
              background-color:#EEE8AA;
              
            }
            .forme{
                background-color: #87CEFA;
            }
            .active{
               border-radius: 30%;
            }
            #ohatry:hover{
                text-decoration: none;
            }
           
        </style>
    
    </head>
<body>
    <div class="container">
        <div class="row justify-content-center">
                <div class="titre">
                    <h1 style="">GESTION DES PRETS BANCAIRES</h1>
                </div> 
                <div class="row">
                    <a class="col-sm-2" href="Client.jsp" style="background-color: grey">
                        <img src="../css/icon.png" alt="icons" style="width:110%;height:90%; border-radius: 30%; padding-top: 2%"/>
                    </a>
                </div>
                
            </div> 
        <br>
        <div class="row">
            <div class="col-sm-4 forme" >
                <table border="2" class="table">
                    <thead>
                        <tr>
                            <th>Banque</th>
                            <th>Chiffre d'affaire</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                             while(resultSet.next()){
                            xVal = resultSet.getString("etatg");
                            map = new HashMap<Object,Object,Object>();
                            map.put("x",xVal);
                            list.add(map);
                            dataPoints = gsonObj.toJson(list);
                        %>    
                        <tr>
                            <td><%= xVal %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

            </div>
            <div>
                <div id="chartContainer" style="height: 500px; width: 100%;"></div>
            </div>
        </div>
        <br>
         <%@include file="Footer.jsp" %>
    </div>
    
    <script src="../css/canvasjs.min.js"></script>
    <script type="text/javascript">
        window.onload = function() { 
            <% if(dataPoints != null) { %>
            var chart = new CanvasJS.Chart("chartContainer", {
                    animationEnabled: true,
                    exportEnabled: true,
                    responsive: true,
                    title: {
                            text: "Cambert récapitulant les chiffres d'afaires des banques "
                    },
                    data: [{
                            type: "pie", //change type to bar, line, area, pie, etc
                            dataPoints: <%out.print(dataPoints);%>
                    }]
            });
            chart.render();
            <% } %> 
        }
    </script>
</body>
</html> 