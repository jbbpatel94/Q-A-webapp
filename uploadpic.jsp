    <%-- 
        Document   : uploadpic
        Created on : Oct 21, 2016, 10:08:51 PM
        Author     : JP
    --%>

    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <%@ page import="java.io.*,java.sql.*" %>
    <%
        String em="";  
            Cookie c[]=request.getCookies();
        for(Cookie temp:c){
            if(temp.getName().equals("user")){
                em=temp.getValue();
                }
            }  
        if(em==null || session.getAttribute(em)==null){
            response.sendRedirect("index.jsp?err=log");
        } 
        
    String contentType = request.getContentType();
    System.out.println("Content type is :: " + contentType);
    String imageSave=null;
    byte dataBytes[]=null;
    String saveFile=null;
    if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))
    {
    DataInputStream in = new DataInputStream(request.getInputStream());
    int formDataLength = request.getContentLength();
    dataBytes = new byte[formDataLength];
    int byteRead = 0;
    int totalBytesRead = 0;
    while (totalBytesRead < formDataLength)
    {
    byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
    totalBytesRead += byteRead;
    }
    String file = new String(dataBytes);
    /*saveFile = file.substring(file.indexOf("filename=\"") + 10);
    saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
    saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));*/
    saveFile=em+".jpg";
    // out.print(dataBytes);
    int lastIndex = contentType.lastIndexOf("=");
    String boundary = contentType.substring(lastIndex + 1, contentType.length());
    // out.println(boundary);
    int pos;
    pos = file.indexOf("filename=\"");
    pos = file.indexOf("\n", pos) + 1;
    pos = file.indexOf("\n", pos) + 1;
    pos = file.indexOf("\n", pos) + 1;
    int boundaryLocation = file.indexOf(boundary, pos) - 4;
    int startPos = ((file.substring(0, pos)).getBytes()).length;
    int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
    try
    {
    FileOutputStream fileOut = new FileOutputStream(request.getRealPath("/")+"/images/"+saveFile);

    // fileOut.write(dataBytes);
    fileOut.write(dataBytes, startPos, (endPos - startPos));
    fileOut.flush();
    fileOut.close();
    imageSave="Success";
    
                       Class.forName("com.mysql.jdbc.Driver"); 
                       Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/code4geeks","root","");
                       PreparedStatement st2=cn.prepareStatement("update registration set image=? where email='"+em+"'");
                       st2.setString(1,"yes");
                       st2.executeUpdate(); 
                      
    response.sendRedirect("profile.jsp");
    
    }
    catch (Exception e)
    {
        out.println(e.getMessage());
    System.err.println ("Error writing to file");
    imageSave="Failure";
    }
    }
%>
