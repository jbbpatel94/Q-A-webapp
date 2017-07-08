<%-- 
    Document   : insert
    Created on : Oct 2, 2016, 8:27:22 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%
    String em=request.getParameter("email");
    try{
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
              PreparedStatement st=cn.prepareStatement("select * from registration where email='"+em+"'");
                ResultSet rs=st.executeQuery();  
                int flag=0;
                while(rs.next()){
                   flag=1;
                }
             
            if(flag==1){
               response.sendRedirect("signup.jsp?email=already");
               }
            else{
                List a= new ArrayList();
                a.clear();
                String code="";
                for(int i=0;i<26;i++){
                    a.add((char)(i+65));
                }
                for(int i=0;i<26;i++){
                    a.add((char)(i+97));
                }
                for(int i=0;i<10;i++){
                    a.add(i);
                }
                Collections.shuffle(a);
                for(int i=0;i<10;i++){
                   code+=(a.get(i));
                }
                PreparedStatement st1=cn.prepareStatement("select MAX(sn) from registration");
                ResultSet rs1=st1.executeQuery();  
                int n=0;
                while(rs1.next()){
                    n=rs1.getInt(1);
                }
                n=n+1;
                code=code+n;
                PreparedStatement st2=cn.prepareStatement("insert into registration values(?,?,?,?,?,?,?)");
                st2.setInt(1,n);
                st2.setString(2,request.getParameter("name"));
                st2.setString(3,request.getParameter("email"));
                st2.setString(4,request.getParameter("password"));
                st2.setString(5,"pending");
                st2.setString(6,code);
                st2.setString(7,"no");
                st2.executeUpdate();
                response.sendRedirect("login.jsp?rsuccess=rsuccess");
              }
              cn.close();
        
    }
    catch(Exception e){
        out.println(e.getMessage());
    }
    %>
