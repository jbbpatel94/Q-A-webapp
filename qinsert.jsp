<%-- 
    Document   : qinsert
    Created on : Oct 18, 2016, 7:22:56 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.util.Date,java.util.*"%>
<%
    int views=0;
    String em="";  
            Cookie c[]=request.getCookies();
        for(Cookie temp:c){
            if(temp.getName().equals("user")){
                em=temp.getValue();
                }
            }  
        if(em==null || session.getAttribute(em)==null){
            response.sendRedirect("postquestion.jsp?err=log");
        }
        else{
    try{
                       Class.forName("com.mysql.jdbc.Driver"); 
                       Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
                       PreparedStatement st=cn.prepareStatement("select MAX(sn) from question");
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

                        String code="";

                        for(int i=0;i<26;i++){
                            a.add((char)(i+65));
                        }
                        for(int i=0;i<26;i++){
                            a.add((char)(i+97));
                        }

                        Collections.shuffle(a);
                        for(int i=0;i<5;i++){
                           code+=(a.get(i));

                        }
                        code=code+n;
                       PreparedStatement st1=cn.prepareStatement("insert into question values(?,?,?,?,?,?,?,?,?)");
                       
                       st1.setInt(1,n);
                       st1.setString(2,code);
                       st1.setString(3,request.getParameter("title"));
                       st1.setString(4,request.getParameter("description"));
                       st1.setInt(5,views);
                       st1.setString(6,em);
                       st1.setString(7,d);
                       st1.setString(8,t);
                       st1.setString(9,request.getParameter("catagory"));
                       st1.executeUpdate();
                      
                       String cat=request.getParameter("catagory");
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
                       PreparedStatement st3=cn.prepareStatement("select MAX(sn) from catagory");
                       ResultSet rs3=st3.executeQuery();  
                       int m=0;
                       while(rs3.next()){
                           m=rs3.getInt(1);
                       }
                       m+=1;
                       PreparedStatement st2=cn.prepareStatement("insert into catagory values(?,?,?)");
                       
                       st2.setInt(1,m);
                       st2.setString(2,code);
                       st2.setString(3,catagory);
                       st2.executeUpdate();
                       }
                       response.sendRedirect("index.jsp");
                 }
                        
            catch(Exception e){
                       out.println(e.getMessage());
                }
        }
                   %>                         

