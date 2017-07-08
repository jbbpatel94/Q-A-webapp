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
        <title>Post | Code4Geeks </title>
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap.min.css">
        <script src="jquery.min.js"></script>
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
        <script src="bootstrap.min.js"></script>
        <script type="text/javascript">
            
            $(document).ready(function(){
                $("#search").keyup(function(){
                      var v= $(this).val();
                     //alert(v);
                     $.post("search.jsp",{v:v},function(data){
                         $("#sss").html(data);
                         
                     });
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
       try{
                       Class.forName("com.mysql.jdbc.Driver"); 
                       Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
                       
                       %>
                       
       <div>
           <ul class="nav nav-tabs" style="background-color: black" >
               <li><a href="index.jsp" style="color: white" ><strong>Home</strong></a></li>
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
       <div id="sss"></div>
       
       <div class="container">
       <div class=" col-sm-2"></div>
        <div class="col-sm-8">
                       <%
              if(em==null || session.getAttribute(em)==null){
                  %>
                  <h6>Please <a href="login.jsp">Login </a>or <a href="signup.jsp">Signup</a> before post</h6>
                  <%
           }
           %>
           <h4 style=" color:  #00cc99">Post Question</h4>
       <div class="panel panel-default" style=" padding:25px">
           <script src="http://js.nicedit.com/nicEdit-latest.js" type="text/javascript"></script>
           <script type="text/javascript">bkLib.onDomLoaded(nicEditors.allTextAreas);</script>
           
           <form action="qinsert.jsp" method="post">
               <label>Title</label>
               <input type="text" name="title" class="form-control" placeholder="Enter Question" minlength="10" required=""/>
               <br/>
               <label>Related to</label>
               <input type="text" name="catagory" placeholder="C,C++,Java,PHP,Spring,html etc." minlength="1" class="form-control" id="tags_3" required=""/>
               <br/>
               <label>Description</label>
               <textarea name="description" class=" form-control" placeholder="Enter Question description" minlength="10" cols="10" rows="6" ></textarea>
               <br/>
               <input type="submit"  value="Post"/>
           </form>
       </div>
       </div>
       
       <div class=" col-sm-2"></div>
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

                   %>
    </body>
</html>
