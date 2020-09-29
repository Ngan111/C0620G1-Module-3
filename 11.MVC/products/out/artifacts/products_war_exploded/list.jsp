<%--
  Created by IntelliJ IDEA.
  User: KimAnh
  Date: 9/28/2020
  Time: 5:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<html>
<head>
    <title>Product list</title>
</head>
<body>
<a href="/productList?actionUser=create">Create products</a>
<h1>Product</h1>
<table>
    <tr>
        <td>ID</td>
        <td>Name</td>
        <td>Price</td>
        <td>Description</td>
        <td>Manufacturer</td>
    </tr>
<c:forEach  var="product" items = '${abcList}'>
    <tr>
        <td>${product.getId()}</td>
        <td>${product.getName()}</td>
        <td>${product.getPrice()}</td>
        <td>${product.getDescription()}</td>
        <td>${product.getManufacturer()}</td>
    </tr>
</c:forEach>
</table>
</body>
</html>
