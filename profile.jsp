<%-- 
    Document   : index
    Created on : Oct 18, 2016, 12:05:09 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
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
        <script type="text/javascript"></script>
        <style>
           .editprofile,.changepass,.myans,.myques,.upload{
	                          display:none;	  
       }
       </style>
        <script type="text/javascript" >
       $(document).ready(function(){
                $("#profile").click(function(){
                   // var v= $(this).attr("id"); 
                   // alert(v); 
                    $(".editprofile").hide();
                    $(".profile").show();
                    $(".changepass").hide();
                    $(".upload").hide();
                    $(".myques").hide();  
                    $(".myans").hide();           
                });
                $("#editprofile").click(function(){
                   // var v= $(this).attr("id"); 
                   // alert(v); 
                    $(".editprofile").show();
                    $(".profile").hide();
                    $(".changepass").hide();
                    $(".upload").hide();
                    $(".myques").hide();  
                    $(".myans").hide();           
                });
                $("#changepass").click(function(){
                   // var v= $(this).attr("id"); 
                   // alert(v); 
                    $(".editprofile").hide();
                    $(".profile").hide();
                    $(".changepass").show();
                    $(".upload").hide();
                    $(".myques").hide();  
                    $(".myans").hide();
                });
                $("#upload").click(function(){
                   // var v= $(this).attr("id"); 
                   // alert(v); 
                    $(".editprofile").hide();
                    $(".profile").hide();
                    $(".changepass").hide();
                    $(".upload").show();
                    $(".myques").hide();  
                    $(".myans").hide();
                });
                $("#myques").click(function(){
                   // var v= $(this).attr("id"); 
                   // alert(v); 
                    $(".editprofile").hide();
                    $(".profile").hide();
                    $(".changepass").hide();
                    $(".upload").hide();
                    $(".myques").show();  
                    $(".myans").hide();
                });     
                $("#myans").click(function(){
                   // var v= $(this).attr("id"); 
                   // alert(v); 
                    $(".editprofile").hide();
                    $(".profile").hide();
                    $(".changepass").hide();
                    $(".upload").hide();
                    $(".myques").hide();  
                    $(".myans").show();
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
        if(em==null &&  session.getAttribute(em)==null){
            response.sendRedirect("index.jsp");
        }
        else{
          try{
                       Class.forName("com.mysql.jdbc.Driver"); 
                       Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
                       
                       %>
                       
       <div >
           <ul class="nav nav-tabs" style="background-color: black" >
               <li><a href="index.jsp" style="color: white"><strong>Home</strong></a></li>
               <%
                    String imgs="no";
             PreparedStatement st= cn.prepareStatement("select * from registration where email='"+em+"'");  
             ResultSet rs=st.executeQuery();  
             while(rs.next()){
    
                         imgs=rs.getString("image");
                        if(imgs.equals("no")){
                            imgs="user";
                        }
                        else if(imgs.equals("yes")){
                            imgs=rs.getString("email");
                        }
                      
                     %>
               <li style=" float: right"><a href="logout.jsp" style="color: white"><strong>Logout</strong></a></li>
               <li style=" float: right"><a href="profile.jsp" style="color: white"><strong><%=rs.getString("name")%></strong></a></li>
               <%
                   }      
               %>
               <li style=" float: right"><a href="about.jsp" style="color: white"><strong>About</strong></a></li>               
           </ul>
       </div>

       <h4 class="title" style=" font-family:verdana; color: red; padding-left:30px; padding-top:30px">Code4Geeks</h4>  
       <br/>
     

       <div class="container-fluid">
          <div class="col-sm-2">
                <br/><br/>
               
                <ul class="nav nav-stacked">
                    <li id="profile"><a href="#">Profile</a></li>
                    <li id="editprofile"><a href="#">Edit Profile</a></li>
                    <li  id="changepass"><a href="#">Change Password</a></li>
                    <li id="upload"><a href="#">Upload Profile Pic</a></li>                     
                    <li id="myques"><a href="#">Questions</a></li>
                    <li id="myans"><a href="#">Answers</a></li>
                </ul>
                </div>   
            
           
           
           
           <div class=" col-sm-10">
                                           <%           
           if(request.getParameter("missmatch")!=null){
              
             %>             
                                     <div class="alert alert-danger" >
                                       <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                          Your  Password not match .
                                      </div>     
            <%
                }
%>
               <div class="profile">
                   <div class="col-sm-2"><img src="images/<%=imgs%>.jpg" class="img img-rounded img-responsive "></div>
                   <div class="col-sm-10">
                        <h4 align="center"> Profile</h4><br/>
                            <%
                             PreparedStatement st1= cn.prepareStatement("select * from registration where email='"+em+"'");  
                             ResultSet rs1=st1.executeQuery();
                             while(rs1.next()){
                              %>
                                <table class="table table-hover" >
                                         <tr><th>Name:</th><td><%=rs1.getString("name")%></td></tr>
                                         <tr><th>Email:</th><td><%=rs1.getString("email")%></td></tr>
                               </table>
                              <%
                               }
                               %>           
                   </div>  
               </div>
                   
                   
                   <div class="editprofile">
                       <div class="col-sm-2"></div>
                       <div class="col-sm-8">
                                <% 
                                 PreparedStatement st2= cn.prepareStatement("select * from registration where email='"+em+"'");  
                                 ResultSet rs2=st2.executeQuery();
                                  while(rs2.next()){
                                   %>    
                                       <form  method="post" action="updateprofile.jsp"/> 
                                         <label>Name:</label>
                                         <input type="text" name="name" minlength="5"  value="<%=rs2.getString("name")%>"required="" class="form-control"/>
                                         <div class="row" style=" height:5px"></div>
                                         <input type="submit" style="float: right" class="btn btn-default" value="update"/>
                                      </form>
                                   <%
                                     }
                                    %>        
                       </div>
                       <div class="col-sm-2"></div>                                       
                   </div>    
                   
                   
                       
                       <div class="changepass">
                           <div class="col-sm-2"></div> 
                           <div class="col-sm-8">
                                <form method="post" action="changepassword.jsp">
                                  <label>Current Password</label>
                                  <input type="text" name="cp" placeholder="Enter Current Password" required="required" class="form-control"/>
                                  <label>New Password</label>
                                  <input type="text" name="np" placeholder="Enter New Password" minlength="8" required="required" class="form-control"/>
                                  <label>Retype Password</label>
                                  <input type="text" name="rp" placeholder="Retype New Password" minlength="8" required="required" class="form-control"/>
                                  <div class="row" style=" height:5px"></div>
                                  <input type="submit" class=" btn btn-default" style=" float: right"  value="Update Password"/>
                                </form>                               
                           </div> 
                           <div class="col-sm-2"></div>      
                       </div>
                       
                       
                       <div class="upload">
                           <div class="col-sm-2"></div>
                           <div class="col-sm-8">
                                <form class="up" method="post" ACTION="uploadpic.jsp" name="uploadForm" ENCTYPE='multipart/form-data'>
                   
                                    <label>Select Image</label>
                                        
                                    <input type="file" name="uploadImage" required="" size="40" class="form-control" style="border:1px solid black"  accept="image/*"></td>
                                        <br/>
                                                   <input type="submit" name="Submit" class="btn btn-default" style="border:1px solid black;" value="Upload">

                                </form>                               
                           </div>
                           <div class="col-sm-2"></div>
                       </div>
                       
                       
                       <div class="myques">
                          <div class="col-sm-12">
                            <table class="table table-hover">
                                <%
                                        PreparedStatement st3=cn.prepareStatement("select * from question where email='"+em+"'");
                                        ResultSet rs3=st3.executeQuery();  
                                        while(rs3.next()){  
                                          String img="no";
                                       PreparedStatement st8=cn.prepareStatement("select * from registration where email='"+rs3.getString("email")+"'");
                                       ResultSet rs8=st8.executeQuery();  
                                       while(rs8.next()){    
                                         img=rs8.getString("image");
                                        if(img.equals("no")){
                                            img="user";
                                        }
                                        else if(img.equals("yes")){
                                            img=rs3.getString("email");
                                        }
                                       }
                                             %>
                                              <tr>
                                                  <td>
                                                      <div class=" container-fluid">
                                                          <div class="col-sm-1"><img src="images/<%=img%>.jpg" class="img img-circle img-responsive " style="height:40px; width:30px" ></div>
                                                          <div class="col-sm-9">
                                                              <div class="col-sm-12"><a href="answer.jsp?code=<%=rs3.getString("qcode")%>"><%=rs3.getString(3)%></a></div>
                                                              <div class="col-sm-6">
                                                             <ul class=" nav nav-pills">
                                                      <%
                                                           String cat=rs3.getString("catagory");
                                                           List<String> list=new ArrayList<String>();
                                                           int k=0;
                                                            for(int i=0;i<cat.length();i++){
                                                              if(cat.charAt(i)==',' || i==cat.length()-1){
                                                                 if(i==cat.length()-1){
                                                                     i++;
                                                                 }
                                                                 list.add(cat.substring(k,i));
                                                                 k=i+1;
                                                             }
                                                         }
                                                          for(String catagory:list){              
                                                          %>
                                                          <li style="background-color: #cccccc"><a href="tags.jsp?tags=<%=catagory%>"><%=catagory%></a></li>
                                                             <%
                                                                }  
                                                             %>
                                                             </ul>
                                                     </div> 
                                                              <div class="col-sm-2"><%=rs3.getString("tim")%></div>
                                                              <div class="col-sm-2"><%=rs3.getString("dat")%></div>
                                                              <%
                                                              PreparedStatement st4=cn.prepareStatement("select * from registration where email='"+em+"'");
                                                                 ResultSet rs4=st4.executeQuery();  
                                                                 while(rs4.next()){  
                                                               %>
                                                               <div class="col-sm-2">Posted by <a href="#"><strong><%=rs4.getString("name")%></strong></a></div>
                                                              <%
                                                              }
                                                              %>

                                                          </div>
                                                             <div class="col-sm-2">
                                                                 <ul class="nav nav-stacked">
                                                                      <%
                                                                        PreparedStatement st5=cn.prepareStatement("SELECT COUNT(*) AS row FROM answer where qcode='"+rs3.getString("qcode")+"'");
                                                                         ResultSet rs5=st5.executeQuery();  
                                                                         int count=0;  
                                                                         while(rs5.next()){
                                                                           count = rs5.getInt("row") ;  
                                                                         }
                                                                     %>
                                                                     <li style="float:right"><a href="#"><strong><%=count%> Answers</strong></a></li>
                                                                     <li style="float:right" ><a href="#"><strong><%=rs3.getString("views")%> Views</strong></a></li>
                                                                 </ul>
                                                             </div>
                                                      </div>
                                       </td>
                                              </tr>
                                             <%
                                          }  
                                       %>
                            </table>
                            </div>
                      </div>
                            
                            
                            
                       <div class="myans">
                          <div class="col-sm-12">
                            <table class="table table-hover">
                                <%
                                        PreparedStatement st6=cn.prepareStatement("select * from question where qcode in (select qcode from answer where email='"+em+"')");
                                        ResultSet rs6=st6.executeQuery();  
                                           while(rs6.next()){  
                                            String img="no";
                                                    PreparedStatement st9=cn.prepareStatement("select * from registration where email='"+rs6.getString("email")+"'");
                                                    ResultSet rs9=st9.executeQuery();  
                                                    while(rs9.next()){    
                                                      img=rs9.getString("image");
                                                     if(img.equals("no")){
                                                         img="user";
                                                     }
                                                     else if(img.equals("yes")){
                                                         img=rs6.getString("email");
                                                     }
                                                    }
                                             %>
                                              <tr>
                                                  <td>
                                                      <div class=" container-fluid">
                                                          <div class="col-sm-1"><img src="images/<%=img%>.jpg" class="img img-circle img-responsive " style="height:40px; width:30px" ></div>
                                                          <div class="col-sm-9">
                                                              <div class="col-sm-12"><a href="answer.jsp?code=<%=rs6.getString("qcode")%>"><%=rs6.getString(3)%></a></div>
                                                              <div class="col-sm-6">
                                                             <ul class=" nav nav-pills">
                                                      <%
                                                           String cat=rs6.getString("catagory");
                                                           List<String> list=new ArrayList<String>();
                                                           int k=0;
                                                            for(int i=0;i<cat.length();i++){
                                                              if(cat.charAt(i)==',' || i==cat.length()-1){
                                                                 if(i==cat.length()-1){
                                                                     i++;
                                                                 }
                                                                 list.add(cat.substring(k,i));
                                                                 k=i+1;
                                                             }
                                                         }
                                                          for(String catagory:list){              
                                                          %>
                                                          <li style="background-color: #cccccc"><a href="tags.jsp?tags=<%=catagory%>"><%=catagory%></a></li>
                                                             <%
                                                                }  
                                                             %>
                                                             </ul>
                                                     </div> 
                                                              <div class="col-sm-2"><%=rs6.getString("tim")%></div>
                                                              <div class="col-sm-2"><%=rs6.getString("dat")%></div>
                                                              <%
                                                              PreparedStatement st7=cn.prepareStatement("select * from registration where email='"+rs6.getString("email")+"'");
                                                                 ResultSet rs7=st7.executeQuery();  
                                                                 while(rs7.next()){  
                                                               %>
                                                               <div class="col-sm-2">Posted by <a href="#"><strong><%=rs7.getString("name")%></strong></a></div>
                                                              <%
                                                              }
                                                              %>

                                                          </div>
                                                             <div class="col-sm-2">
                                                                 <ul class="nav nav-stacked">
                                                                      <%
                                                                        PreparedStatement st8=cn.prepareStatement("SELECT COUNT(*) AS row FROM answer where qcode='"+rs6.getString("qcode")+"'");
                                                                         ResultSet rs8=st8.executeQuery();  
                                                                         int count=0;  
                                                                         while(rs8.next()){
                                                                           count = rs8.getInt("row") ;  
                                                                         }
                                                                     %>
                                                                     <li style="float:right"><a href="#"><strong><%=count%> Answers</strong></a></li>
                                                                     <li style="float:right" ><a href="#"><strong><%=rs6.getString("views")%> Views</strong></a></li>
                                                                 </ul>
                                                             </div>
                                                      </div>
                                       </td>
                                              </tr>
                                             <%
                                          }  
                                       %>
                            </table>
                            </div>
                      </div>
                            
                            

           </div>
       </div>
       <br/><br/><br/>
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
                    <%  }
                   catch(Exception e){
                       out.println(e.getMessage());
                   }
                   }
                   %>
    </body>
</html>
