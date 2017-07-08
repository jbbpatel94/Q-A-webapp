<%-- 
    Document   : ainsert
    Created on : Oct 18, 2016, 11:37:55 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.util.Date,java.util.*"%>

<%
        String qcode=request.getParameter("code");
        String em=null;
        Cookie c[]=request.getCookies();
        for(Cookie temp:c){
            if(temp.getName().equals("user")){
                em=temp.getValue();
                }
            }  
        if(em==null || session.getAttribute(em)==null){
            response.sendRedirect("answer.jsp?code="+qcode +"&err=log");
        }
        else{
        try{
             Class.forName("com.mysql.jdbc.Driver"); 
             Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
             PreparedStatement st=cn.prepareStatement("select MAX(sn) from answer");
                ResultSet rs=st.executeQuery();  
                int n=0;
                while(rs.next()){
                    n=rs.getInt(1);
                }
                n=n+1;         
                       
                java.util.Date dat =new java.util.Date();
                String s=dat.toString();
                String d=s.substring(8,10)+"/"+s.substring(4,7)+"/"+s.substring(24,28);
                String t=s.substring(10,19);
                // Wed Oct 05 01:05:52 IST 2016
                List a= new ArrayList();
                a.clear();

                String acode="";

                for(int i=0;i<26;i++){
                    a.add((char)(i+65));
                }
                for(int i=0;i<26;i++){
                    a.add((char)(i+97));
                }

                Collections.shuffle(a);
                for(int i=0;i<5;i++){
                   acode+=(a.get(i));

                }
                acode=acode+n;
               String k="<br>";
               PreparedStatement st2=cn.prepareStatement("select * from question where qcode=? ");              
               st2.setString(1, qcode);
               ResultSet rs2 = st2.executeQuery();
               int flag5=0;
               while(rs2.next()){
               flag5=1;
               }
               if(flag5==0){
                   response.sendRedirect("index.jsp");
               }
               if(request.getParameter("answer").equals(k)){
                  response.sendRedirect("answer.jsp?code="+qcode);  
                }
                else{
                PreparedStatement st1=cn.prepareStatement("insert into answer values(?,?,?,?,?,?,?)");
                st1.setInt(1,n);
                st1.setString(2,qcode);
                st1.setString(3,acode);
                st1.setString(4,request.getParameter("answer"));
                st1.setString(5,em);
                st1.setString(6,d);
                st1.setString(7,t);
                st1.executeUpdate();
                response.sendRedirect("answer.jsp?code="+qcode);
                }
       }
       catch(Exception e){
           out.println(e.getMessage());
       }
        }

%>
