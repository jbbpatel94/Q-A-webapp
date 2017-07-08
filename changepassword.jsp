<%-- 
    Document   : changepass
    Created on : Oct 3, 2016, 12:44:16 AM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    Cookie c[] = request.getCookies();
              String em="";
                  for(int i=0;i<c.length;i++){
                            if(c[i].getName().equals("user")){
                                em=c[i].getValue();
                                }
                          }
                           
     if(em==null || session.getAttribute(em)==null){
          response.sendRedirect("index.jsp");
           }
    else{
        if(request.getParameter("cp")==null || request.getParameter("np")==null || request.getParameter("rp")==null ){
            response.sendRedirect("profile.jsp?err=1");
        }
      else{
           String cp=request.getParameter("cp");
            String np=request.getParameter("np");
            String rp=request.getParameter("rp");
            if(rp.equals(np)){
                try{
                    Class.forName("com.mysql.jdbc.Driver"); 
                    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root","");
                    Statement st=cn.createStatement();
                   
                    ResultSet rs=st.executeQuery("select * from registration where email='"+em+"' AND password='"+cp+"'");
                    int flag=0;
                    while(rs.next()){
                      flag=1;  
                      break;
                    }
                    if(flag==1){
                        st.execute("update registration set password='"+np+"' where email='"+em+"'");
                        response.sendRedirect("profile.jsp?success=1");
                    }
                    else{
                        response.sendRedirect("profile.jsp?Invailid=1");
                    } 
                }
             
                catch(Exception e){
                 out.println(e.getMessage());   
                }
            }    
         else{
             response.sendRedirect("profile.jsp?missmatch=1");   
            }
        }
    }    
    
    %>
