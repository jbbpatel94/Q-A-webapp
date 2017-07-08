<%-- 
    Document   : search
    Created on : Oct 18, 2016, 4:03:04 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">      
    </head>
    <body>
        <%
        String s=request.getParameter("v");
        if(s==null){
            response.sendRedirect("index.jsp");
        }
        else{
       try{
                       Class.forName("com.mysql.jdbc.Driver"); 
                       Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
                       
                      
                        PreparedStatement st=cn.prepareStatement("select * from question where  catagory LIKE'%"+s+"%' or description LIKE'%"+s+"%' or title LIKE'%"+s+"%' or qcode in (select qcode from answer where answer LIKE'%"+s+"%')");
                       ResultSet rs=st.executeQuery();    
                       while(rs.next()){ 

                       String img="no";
                       PreparedStatement st10=cn.prepareStatement("select * from registration where email='"+rs.getString("email")+"'");
                       ResultSet rs10=st10.executeQuery();  
                       while(rs10.next()){    
                         img=rs10.getString("image");
                        if(img.equals("no")){
                            img="user";
                        }
                        else if(img.equals("yes")){
                            img=rs.getString("email");
                        }
                       }
                         %>
                                <div class="container">
           <div class="col-sm-1"></div>
           <div class="col-sm-10">
           <table class="table table-hover">
 
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
     
           </table>
           </div>
           <div class="col-sm-1"></div>
       </div>
                  <%   }


                         
                     }
                   catch(Exception e){
                       out.println(e.getMessage());
                   }
            }
                   %>
    </body>
</html>
