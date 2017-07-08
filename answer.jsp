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
        <link rel="stylesheet" type="text/css" href="./example_files/jquery.tagsinput.css">
 
  <script type="text/javascript" src="./example_files/jquery.tagsinput.js"></script>
  <!-- To test using the original jQuery.autocomplete, uncomment the following -->
  <!--
  <script type='text/javascript' src='http://xoxco.com/x/tagsinput/jquery-autocomplete/jquery.autocomplete.min.js'></script>
  <link rel="stylesheet" type="text/css" href="http://xoxco.com/x/tagsinput/jquery-autocomplete/jquery.autocomplete.css" />
  -->
  <script type="text/javascript" src="./example_files/jquery-ui.min.js"></script>
  <link rel="stylesheet" type="text/css" href="./example_files/jquery-ui.css">


  <script type="text/javascript">

    function onAddTag(tag) {
      alert("Added a tag: " + tag);
    }
    function onRemoveTag(tag) {
      alert("Removed a tag: " + tag);
    }

    function onChangeTag(input,tag) {
      alert("Changed a tag: " + tag);
    }

    $(function() {

      $('#tags_3').tagsInput({
        width: 'auto',

        //autocomplete_url:'test/fake_plaintext_endpoint.html' //jquery.autocomplete (not jquery ui)
        autocomplete_url:'test/fake_json_endpoint.html' // jquery ui autocomplete requires a json endpoint
      });


// Uncomment this line to see the callback functions in action
//			$('input.tags').tagsInput({onAddTag:onAddTag,onRemoveTag:onRemoveTag,onChange: onChangeTag});

// Uncomment this line to see an input with no interface for adding new tags.
//			$('input.tags').tagsInput({interactive:false});
    });

     
        </script>
         <script type="text/javascript">
         $(document).ready(function(){
	   $("#forgot").click(function(){
             //var v= $(this).attr("id"); 
                 //   alert(v);
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
         String code=request.getParameter("code");
         if(code==null){
             response.sendRedirect("index.jsp");
         }
         else{
       try{
                       Class.forName("com.mysql.jdbc.Driver"); 
                       Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
                    PreparedStatement st20=cn.prepareStatement("select * from question where qcode=? ");              
                    st20.setString(1, code);
                    ResultSet rs20 = st20.executeQuery();
                    int flag5=0;
                    while(rs20.next()){
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
       <div class="container-fluid">
           <div class="col-sm-1"></div>
           <div class="col-sm-10">
          
               <%
                       int views=0;
                       PreparedStatement st1=cn.prepareStatement("select * from question where qcode='"+code+"'");
                       ResultSet rs1=st1.executeQuery();  
                       while(rs1.next()){
                       views=rs1.getInt("views");
                       }
                         views=views+1;      
                              
                       PreparedStatement st2=cn.prepareStatement("update question set views=? where qcode='"+code+"'");
                       st2.setInt(1,views);
                       st2.executeUpdate(); 
                       PreparedStatement st=cn.prepareStatement("select * from question where qcode='"+code+"'");
                       ResultSet rs=st.executeQuery();  
                       while(rs.next()){  

                       String img="no";
                       PreparedStatement st8=cn.prepareStatement("select * from registration where email='"+rs.getString("email")+"'");
                       ResultSet rs8=st8.executeQuery();  
                       while(rs8.next()){    
                         img=rs8.getString("image");
                        if(img.equals("no")){
                            img="user";
                        }
                        else if(img.equals("yes")){
                            img=rs.getString("email");
                        }
                       }
                            %>

                                     <div class=" container-fluid">
                                         <div class="col-sm-1"><img src="images/<%=img%>.jpg" class="img img-rounded img-responsive " style="height:50px; width:50px" ></div>
                                         <div class="col-sm-9">
                                             <div class="col-sm-12" style="font-size:22px"><strong><%=rs.getString(3)%></strong></div>
                                             <div class="co-sm-12">&nbsp;&nbsp;&nbsp;&nbsp;<%=rs.getString("description")%></div>
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
                                             PreparedStatement st4=cn.prepareStatement("select * from registration where email='"+rs.getString("email")+"'");
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
                                                       PreparedStatement st3=cn.prepareStatement("SELECT COUNT(*) AS row FROM answer where qcode='"+rs.getString("qcode")+"'");
                                                        ResultSet rs3=st3.executeQuery();  
                                                        int count=0;  
                                                        while(rs3.next()){
                                                          count = rs3.getInt("row") ;  
                                                        }
                                                    %>
                                                    <li style="float:right"><a href="#"><strong><%=count%> Answer</strong></a></li>
                                                    <li style="float:right" ><a href="#"><strong><%=rs.getString("views")%> Views</strong></a></li>
                                                    
                                                </ul>
                                            </div>
                                           
                                     </div>


                            <%
                         }  
                      %>

           </div>          
           <div class="col-sm-1"></div>
       </div>
         <br/>
           
           <div class="container-fluid">
               <div class="col-sm-1"></div>
               <div class="col-sm-10">
                   <h4 style="padding-left:20px"><strong>Answer</strong></h4>
                   <table class="table table-hover">
                     <%
                       PreparedStatement st5=cn.prepareStatement("select * from answer where qcode='"+code+"'");
                       ResultSet rs5=st5.executeQuery();  
                       while(rs5.next()){
                           

                       String img="no";
                       PreparedStatement st10=cn.prepareStatement("select * from registration where email='"+rs5.getString("email")+"'");
                       ResultSet rs10=st10.executeQuery();  
                       while(rs10.next()){    
                         img=rs10.getString("image");
                        if(img.equals("no")){
                            img="user";
                        }
                        else if(img.equals("yes")){
                            img=rs5.getString("email");
                        }
                       }
                     %>  
                             <tr>
                                 <td>
                                     <div class="col-sm-1"><img src="images/<%=img%>.jpg" class="img img-circle img-responsive " style="height:40px; width:30px" ></div>
                                     <div class="col-sm-8"><%=rs5.getString("answer")%></div> 
                                             <%
                                             PreparedStatement st6=cn.prepareStatement("select * from registration where email='"+rs5.getString("email")+"'");
                                                ResultSet rs6=st6.executeQuery();  
                                                while(rs6.next()){  
                                              %>
                                              <div class="col-sm-1">Ans by <a href="#"><strong><%=rs6.getString("name")%></strong></a></div>
                                             <%
                                             }
                                             %>
                                     <div class="col-sm-1"><%=rs5.getString("tim")%></div>
                                             <div class="col-sm-1"><%=rs5.getString("dat")%></div>
                                 </td>
                             </tr>                                     
                     <%
                     }
                     %>
                   </table>  
               </div>
               <div class="col-sm-1"></div>              
           </div>
           
           
           
           
           <br/><br/>
           
           <div class=" container-fluid">
              <div class="col-sm-1"></div>
              <div class="col-sm-10">
                  <script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
           <script type="text/javascript">bkLib.onDomLoaded(nicEditors.allTextAreas);</script>
           <%
             /*if(em==null || session.getAttribute(em)==null){
                 
           }*/
           
           if(request.getParameter("err")!=null && (em==null || session.getAttribute(em)==null)){
              
             %>             
                                     <div class="alert alert-danger" >
                                       <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                          Please <a href="login.jsp">Login </a>or <a href="signup.jsp">Signup</a> before post.
                                      </div>
     
            <%
                }
           %>
           
           <form action="ainsert.jsp?code=<%=code%>" method="post">
               <label>Post Answer</label>
               <textarea class=" form-control" name="answer"  minlength="1" ></textarea>
               <br/>
               <input type="submit" id="forgot" value="Post" style="float:right"/>
           </form>
           </div>
              <div class="col-sm-1"></div>
        </div>
           
<br/>
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
