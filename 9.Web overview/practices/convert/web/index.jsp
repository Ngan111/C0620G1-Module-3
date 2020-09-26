<%--
  Created by IntelliJ IDEA.
  User: KimAnh
  Date: 9/25/2020
  Time: 8:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Convert currency</title>
  </head>
  <body>
  <form action="/convert" method="post">
    <label>Rate: </label><br/>
    <input type="text" name="rate" placeholder="rate" value="0"/><br/>
    <label>USD: </label><br/>
    <input type="text" name="usd" placeholder="USD" value="0"/><br/>
    <input type = "submit" value = "Converter"/>
  </form>
  </body>
</html>
