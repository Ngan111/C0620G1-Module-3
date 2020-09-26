<%--
  Created by IntelliJ IDEA.
  User: KimAnh
  Date: 9/25/2020
  Time: 3:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        #image{
            height: 60px;
            width: 60px;
        }
    </style>
</head>
<body>
<table border="1" style="color: darkgreen">
    <tr>
        <th>Name</th>
        <th>Date of birth</th>
        <th>Address</th>
        <th>Images</th>
    </tr>
<c:forEach var="customer" items="${customer_list}">
    <tr>
        <td>${customer.name}</td>
        <td><c:out value="${customer.date_of_birth}"></c:out></td>
        <td>${customer.address}</td>
        <td><img id="image" src= "${customer.images}"></td>
    </tr>
</c:forEach>
</table>
<br><br>
</body>
</html>
