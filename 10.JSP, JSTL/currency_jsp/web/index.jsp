<%--
  Created by IntelliJ IDEA.
  User: KimAnh
  Date: 9/25/2020
  Time: 10:50 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Currency_JSP</title>
  </head>
  <body>
  <form action="/convert.jsp" method="post">
    <label>Rate: </label><br/>
    <input type="text" name="rate" placeholder="RATE" value="23000"/><br/>
    <label>USD: </label><br/>
    <input type="text" name="usd" placeholder="USD" value="0"/><br/>
    <input type = "submit" id = "submit" value = "Converter"/>
  </form>
  </body>
</html>
