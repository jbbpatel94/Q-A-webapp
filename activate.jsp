<%-- 
    Document   : activate
    Created on : Oct 19, 2016, 3:17:02 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    String em=request.getParameter("email");
    String cd=request.getParameter("code");
    
    try{
        Class.forName("com.mysql.jdbc.Driver"); 
        Connection cn = DriverManager.getConnection("jdbc:mysql:3306//localhost/code4gee_programming","code4gee_jbbpate","15/may/2015");
        Statement st=cn.createStatement();
        st.execute("update registration set status='activated' where email='"+em+"' AND code='"+cd+"'");
        response.sendRedirect("/?verify=success");
                       
        
    }
    catch(Exception e){
        out.println(e.getMessage());
    }
%>