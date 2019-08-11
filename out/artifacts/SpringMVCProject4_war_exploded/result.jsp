<%--
  Created by IntelliJ IDEA.
  User: 12558
  Date: 09/08/2019
  Time: 14:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="fm"%>
<html>
<head>
    <title>result.jsp</title>
</head>
<body>
    <h1>result.jsp----------------</h1>
    <fm:form modelAttribute="user" action="${pageContext.request.contextPath}/update2">
        姓名：<fm:input path="username"/><br>
        年龄：<fm:input path="age"/><br>
        性别：<fm:radiobutton path="gender" value="0" label="男"/>
              <fm:radiobutton path="gender" value="1" label="女"/><br>
        爱好：<fm:checkboxes path="hobby" items="${allhobbys}"/>
        <input type="submit" value="修改">
    </fm:form>
</body>
</html>
