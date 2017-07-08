<%-- 
    Document   : updateprofile
    Created on : Oct 2, 2016, 5:05:26 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<%
    String em=null;
    Cookie c[]=request.getCookies();
      for(Cookie temp:c){
          if(temp.getName().equals("user")){
              em=temp.getValue();
          }
      }
      if(em==null || session.getAttribute(em)==null){
          response.sendRedirect("index.jsp");
           }
      else{
       try{
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
               Statement st=cn.createStatement();
               st.execute("update registration set name='"+request.getParameter("name")+"' where email='"+em+"'");                                                 
               cn.close();
               response.sendRedirect("profile.jsp");
        }
      catch(Exception e){
        out.println(e.getMessage());
    }
      }
    %>
