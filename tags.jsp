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

    </head>
    <body>
       <br/>
       <%
           String tags=request.getParameter("tags");
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

                        PreparedStatement st10=cn.prepareStatement("select * from catagory where catagory=? ");              
                        st10.setString(1, tags);
                        ResultSet rs10 = st10.executeQuery();
                        int flag5=0;
                        while(rs10.next()){
                        flag5=1;
                        }
                        if(flag5==0){
                            response.sendRedirect("index.jsp");
                        }
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
               <div class="row" style="height:20px"></div>
               <div class="container-fluid">
                   
                   <div class="col-sm-1"><div class="title" style=" font-family:verdana; color:red; font-size:25px">Code4Geeks</div></div>
                   <div class="col-sm-1"></div>
                   <div class="col-sm-6"></div>
                   <div class="col-sm-3"></div>
                   <div class="col-sm-1"><div style=" padding-right:20px"><a href="postquestion.jsp" style=" float: right" class="btn btn-warning">Post Question</a></div></div>
                   
               </div>
               
       
    
       <br/>
       <hr/>
      
       
       <div class="container">
           <div class="col-sm-1"></div>
           <div class="col-sm-10">
           <table class="table table-hover">
               
               <%
                   
                     
                       PreparedStatement st=cn.prepareStatement("select * from question where qcode in (select qcode from catagory where catagory='"+tags+"')");
                       ResultSet rs=st.executeQuery();  
                       while(rs.next()){  
                       String img="no";
                       PreparedStatement st6=cn.prepareStatement("select * from registration where email='"+rs.getString("email")+"'");
                       ResultSet rs6=st6.executeQuery();  
                       while(rs6.next()){    
                         img=rs6.getString("image");
                        if(img.equals("no")){
                            img="user";
                        }
                        else if(img.equals("yes")){
                            img=rs.getString("email");
                        }
                       }
                            %>
                             <tr>
                                 <td>
                                     <div class=" container-fluid">
                                         <div class="col-sm-1"><img src="images/<%=img%>.jpg" class="img img-circle img-responsive " style="height:40px; width:30px" ></div>
                                         <div class="col-sm-9">
                                             <div class="col-sm-12"><a href="answer.jsp?code=<%=rs.getString("qcode")%>"><%=rs.getString(3)%></a></div>
                                             <div class="col-sm-6">
                                            <ul class=" nav nav-pills">
                                     <%
                                         String cat=rs.getString("catagory");
                                        List<String> list=new ArrayList<String>();
                                        int k=0;
                                        for(int i=0;i<cat.length();i++){
                                            if(cat.charAt(i)==',' || i==cat.length()-1){
                                                if(i==cat.length()-1)
                                                    i++;
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
                                             <div class="col-sm-2"><%=rs.getString("tim")%></div>
                                             <div class="col-sm-2"><%=rs.getString("dat")%></div>
                                             <%
                                             PreparedStatement st2=cn.prepareStatement("select * from registration where email='"+rs.getString("email")+"'");
                                                ResultSet rs2=st2.executeQuery();  
                                                while(rs2.next()){  
                                              %>
                                              <div class="col-sm-2">Posted by <a href="#"><strong><%=rs2.getString("name")%></strong></a></div>
                                             <%
                                             }
                                             %>
                                             
                                         </div>
                                            <div class="col-sm-2">
                                                <ul class="nav nav-stacked">
                                                     <%
                                                       PreparedStatement st1=cn.prepareStatement("SELECT COUNT(*) AS row FROM answer where qcode='"+rs.getString("qcode")+"'");
                                                        ResultSet rs1=st1.executeQuery();  
                                                        int count=0;  
                                                        while(rs1.next()){
                                                          count = rs1.getInt("row") ;  
                                                        }
                                                    %>
                                                    <li style="float:right"><a href="#"><strong><%=count%> Answers</strong></a></li>
                                                    <li style="float:right" ><a href="#"><strong><%=rs.getString("views")%> Views</strong></a></li>
                                                    
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
           <div class="col-sm-1"></div>
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
                   catch(Exception e){
                       out.println(e.getMessage());
                   }

                   %>
    </body>
</html>
