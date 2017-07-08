<%-- 
    Document   : index
    Created on : Oct 18, 2016, 12:05:09 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
        <title>Home | Code4Geeks </title>
        <link rel="icon" type="images/png" href="images/logo2.png"/>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap.min.css">
        <script src="jquery.min.js"></script>
        <script src="bootstrap.min.js"></script>
    </head>
    <body>
       <br/>
       <%
           
        String em=null;
        Cookie c[]=request.getCookies();
        for(Cookie temp:c){
            if(temp.getName().equals("user")){
                em=temp.getValue();
                }
            }           
       try{
                       Class.forName("com.mysql.jdbc.Driver"); 
                       Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
                       
                       %>
                       
       <div>
           <ul class="nav nav-tabs" style="background-color: black" >
               <li><a href="index.jsp" style="color: white"><strong>Home</strong></a></li>
               <%
        if(em!=null &&  session.getAttribute(em)!=null){
             PreparedStatement st= cn.prepareStatement("select * from registration where email='"+em+"'");  
             ResultSet rs=st.executeQuery();  
             while(rs.next()){
              
                     %>
               <li style=" float: right"><a href="logout.jsp" style="color: white"><strong>Logout</strong></a></li>
               <li style=" float: right"><a href="profile.jsp" style="color: white"><strong><%=rs.getString("name")%></strong></a></li>
               <%
                   }
            }
        else{
               %>
               <li style=" float: right"><a href="login.jsp" style="color: white"><strong>Login</strong></a></li>
               <li style=" float: right"><a href="signup.jsp" style="color: white"><strong>Signup</strong></a></li>
             <%
             }
             %>  
               <li style=" float: right"><a href="about.jsp" style="color: white"><strong>About</strong></a></li>
     
               
           </ul>
       </div>
       
       
       
       <h4 class="title" style=" font-family:verdana; color: red; padding-left:30px; padding-top:30px">Code4Geeks</h4>
       
       <br/>
       <div class="container-fluid">
            <div  class="col-sm-6"  style="border-style: groove; border-radius:10px;border-color: #cccc00;border-width: thin">
                <div class="col-sm-4">
                    <h4 align="center">Jaisa Ram Patel</h4>
                    <img src="images\2.jpg" class="img img-circle img-responsive" style='height:200px;width:200px'/>   
                </div>
                <div class="col-sm-8"><br>
                    <div>How many times were you frustrated while looking out for a good collection of programming/algorithm/interview 
                questions? What did you expect and what did you get? This portal has been created to provide well written, well
                thought and well explained solutions for selected questions.</div>
                    <br/>
                    <table style=" color: #2bba72">
                        <tr><td>Email: jbbpatel94@gmail.com</td></tr>
                        <tr><td>+91 9660798468</td></tr>
                    </table>
                </div>
            </div>
            <div  class="col-sm-2"></div>
            <div  class="col-sm-4" style="border-style: groove; border-radius:10px;border-color: #cccc00;border-width: thin">
                <h3 align="center" style="">Contact us</h3>
                <form method="post" action="#">
                    <input type="text" name="name" placeholder="Enter Your Name" required="" class=" form-control"/><div class="row" style="height:5px"></div>
                    <input type="number" name="mobile" placeholder="Enter Your Mobile No." required="" class=" form-control" /><div class="row" style="height:5px"></div>
                    <input type="email" name="email" placeholder="Enter Your email id" required="" class=" form-control" /><div class="row" style="height:5px"></div>
                    <textarea name="message" required="" placeholder="Enter Message" class=" form-control"></textarea><div class="row" style="height:5px"></div>
                    <input type="submit" value="Submit" style=" float:  right" class="btn btn-default"/>
                </form>
            </div>
       </div><br><br><br/><br/>
           <div class = "panel panel-footer" style="background-color: #333333">
   
   <div class = "panel-body">
      
       <div class="col-sm-4" align="center" style=" color: white">Follow us on<br/>
        <a href="https://www.facebook.com/code4geeksorg-1216494815089611/"><i class="fa fa-facebook-square" style="font-size:40px;color: blue"></i></a>
        <a href="https://www.linkedin.com/company/code4geeks.org?report%2Esuccess=KJ_KkFGTDCfMt-A7wV3Fn9Yvgwr02Kd6AZHGx4bQCDiP6-2rfP2oxyVoEQiPrcAQ7Bf"><i class="fa fa-linkedin-square" style="font-size:40px;color:#286090"></i></a>
        <a href="http://www.google.com"> <i class="fa fa-google-plus-square" style="font-size:40px;color: red"></i></a>
        <a href="http://www.google.com"> <i class="fa fa-twitter-square" style="font-size:40px;color: #79c9ec"></i></a>
       </div>
       
       <div class="col-sm-4" align="center" style=" color: white"><a href="team.jsp" style=" color: white">Our Team</a> | <a href="index.jsp" style=" color: white">Home</a><br/><a href="about.jsp" style=" color: white">Contact Us</a></div>
       <div class="col-sm-4" align="center">
           <i class="fa fa-copyright" style="font-size:20px;color: white">code4geeks.org </i>
           
       </div>
   </div>
</div>s
                  
                    <%  }
                   catch(Exception e){
                       out.println(e.getMessage());
                   }

                   %>
    </body>
</html>
