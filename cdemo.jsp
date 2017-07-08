<%-- 
    Document   : cdemo
    Created on : Sep 30, 2016, 10:10:31 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, javax.sql.*"%>
<%
    String em=null;
    String pass=null;
    if(request.getParameter("email")==null || request.getParameter("password")==null){
    response.sendRedirect("index.jsp");
        
    }
    else{
         em=request.getParameter("email");
         pass=request.getParameter("password");
        try{
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
            
            
            PreparedStatement st= cn.prepareStatement("select * from registration where email=? AND password=? AND status=?"); 
            st.setString(1, em);
            st.setString(2, pass);
            st.setString(3, "activated");
            ResultSet rs=st.executeQuery();  
            int flag=0;
            while(rs.next()){
               flag=1;
               break;
            }  
            PreparedStatement st1= cn.prepareStatement("select * from registration where email=? AND password=? AND status=?"); 
            st1.setString(1, em);
            st1.setString(2, pass);
            st1.setString(3, "pending");
            ResultSet rs1=st1.executeQuery();
            int status=0;
            while(rs1.next()){
                status=1;
                break;
            }
            if(flag==1){
               Cookie c=new Cookie("user",em);
               c.setMaxAge(60*60);
               response.addCookie(c);
               session.setAttribute(em,pass);
               session.setMaxInactiveInterval(60*60);
               response.sendRedirect("index.jsp");
            } 
           else if(status==1){
               response.sendRedirect("login.jsp?vr=not verified");
           }
            else{
               response.sendRedirect("login.jsp?mismatch=1");
            }
            cn.close();  
            
        }
        catch(Exception e){
            out.println(e.getMessage());
        }
    }
    %>

