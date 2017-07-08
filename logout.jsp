<%-- 
    Document   : logout
    Created on : Sep 22, 2016, 10:48:29 AM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
            Cookie ct=new Cookie("user","");
                ct.setMaxAge(0);
                response.addCookie(ct);
                response.sendRedirect("index.jsp");
            %>
