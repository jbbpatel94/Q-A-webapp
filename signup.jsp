<%-- 
    Document   : index
    Created on : Oct 18, 2016, 12:05:09 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
        <title>Sign up | Code4Geeks </title>
        <link rel="icon" type="images/png" href="images/logo2.png"/>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap.min.css">
        <script src="jquery.min.js"></script>
        <script src="bootstrap.min.js"></script>
        <script type="text/javascript" >
       $(document).ready(function(){
	   $("#forgot").click(function(){
	    $("#forgotpass").modal();
	   });
	   });

</script>
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
        if(em!=null &&  session.getAttribute(em)!=null){
           response.sendRedirect("index.jsp");
        }
        else{
        %>
       <div>
           <ul class="nav nav-tabs" style="background-color: black" >
               <li><a href="index.jsp" style="color: white" ><strong>Home</strong></a></li>
               <li style=" float: right"><a href="login.jsp" style="color: white"><strong>Login</strong></a></li>
               <li style=" float: right"><a href="signup.jsp" style="color: white"><strong>Signup</strong></a></li>
               <li style=" float: right"><a href="about.jsp" style="color: white"><strong>About</strong></a></li>
              
               
           </ul>
       </div>
       
       
       
       <h4 class="title" style=" font-family:verdana; color: red; padding-left:30px; padding-top:30px">Code4Geeks</h4>
       
       <div class="modal fade" id="forgotpass" role="dialog">
           <div class="modal-dialog">
               <div class="modal-content">
            <div class="modal-body">              
                   <form method="post" action="forgot.jsp">
                       <label>Enter Your registered Email id</label>
                       <input type="email" name="email" placeholder="info@code4geeks.org" class="form-control" required="required"> 
                       <div class="row" style="height:2px"></div>
                       <input type="submit" style="float: right" value="Submit"/>
		 </form>
                <h6 style="color:red">*Your password will be send by Email</h6> 
            </div>
        </div>
    </div>
</div>
       
       <div class="container">
       <div class=" col-sm-3"></div>
       <div class="col-sm-6">
       <div class="col-sm-12 panel panel-default" style=" padding:30px">
           
           <form action="insert.jsp" method="post">
                <label>User name</label>
                <input type="text" name="name" placeholder="Your Name" class="form-control" minlength="5" required=""/>
               <br/>
               <label>Email id</label>
               <input type="text" name="email" placeholder="info@code4geeks.org" minlength="14" class="form-control" required=""/>
               <br/>
               <label>Password</label>
               <input type="password" name="password" placeholder="************"  minlength="8" class="form-control" required=""/>
               <br/>
               <input style=" float: right" type="submit"  value="Sign up"/>
               <a id="forgot" href="#">Forgot Password?</a>
           </form>
       </div>
           <div class="col-sm-12 panel panel-default" style=" padding:15px">
               <center><h5>Already have an account ?<a href="login.jsp"> Login</a></h5></center>
           </div>
       </div>
      
       <div class=" col-sm-3"></div>
       </div>
       
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
</div>
       <%
       }
       %>
       
    </body>
</html>
