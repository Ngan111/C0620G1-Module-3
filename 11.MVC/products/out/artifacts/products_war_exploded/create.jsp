<%--
  Created by IntelliJ IDEA.
  User: KimAnh
  Date: 9/28/2020
  Time: 4:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>create products</title>
</head>
<body>
<a href="/productList">Back to product list</a>
<p style="color: darkgreen">${message}</p>
<form method="post" action="/productList">
<input type="hidden" name="actionUser" value="create/">
    <p>Name: </p>
        <input type="text" name="productName"/>
    <p>Price:</p>
        <input type="text" name="price"/>
    <p>Description:</p>
    <input type="text" name="description"/>
    <p>Manufacturer: </p>
    <input type="text" name="manufacturer"/>
    <tr>
        <td><input type="submit" value="create"></td>
    </tr>
</form>
</body>
</html>
