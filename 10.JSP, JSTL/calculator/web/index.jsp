<%--
  Created by IntelliJ IDEA.
  User: KimAnh
  Date: 9/25/2020
  Time: 5:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  <h1>Simple calculation</h1>

  <form action="/calculator" method="get">
    <fieldset>
      <legend>Calculator</legend>
      <label for="f_operand">First operand</label>
      <input type="text" id="f_operand" name="f_operand"><br><br>
      <td>Operator</td>
      <td>
        <select name ="Operator">
          <option value="+">Addition</option>
          <option value="-">Subtraction</option>
          <option value="*">Multiplication</option>
          <option value="+">Division</option>
        </select>
      </td>
      <label for="s_operand">Second operand</label>
      <input type="text" id="s_operand" name="s_operand"><br><br>
      <input type="submit" value="Calculate">
    </fieldset>
  </form>

  </body>
</html>
