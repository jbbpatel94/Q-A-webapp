<%-- 
    Document   : insert
    Created on : Oct 2, 2016, 8:27:22 PM
    Author     : JP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,java.util.Properties,java.util.*,javax.mail.Message,javax.mail.MessagingException,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeMessage"%>
<%
        String em=request.getParameter("email");
	
        if(em==null){
           response.sendRedirect("login.jsp");
        }
        else{
		final String username = "info@code4geeks.org";
		final String password = "15071994";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "false");
		props.put("mail.smtp.host", "code4geeks.org");
		props.put("mail.smtp.port", "25");

		Session sess = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });
	
	
 
    try{
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root",""); 
              PreparedStatement st= cn.prepareStatement("select * from registration where email='"+em+"'");  
             ResultSet rs=st.executeQuery();  
             String pass="";
             while(rs.next()){   
                pass=rs.getString("password");
             }             
               Message message = new MimeMessage(sess);
			message.setFrom(new InternetAddress("info@code4geeks.org"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(em));
			message.setSubject("Welcome to code4geeks.org ");
			String link = "You Password is: "+pass;
			String mssg = "Dear ,"+request.getParameter("name")+ "\n\n"+link;
			message.setText(mssg);

			Transport.send(message);
 
              
              
              response.sendRedirect("login.jsp?pass=sent");
              }
    catch(Exception e){
        out.println(e.getMessage());
        e.printStackTrace();
    }
    
        }
    %>
