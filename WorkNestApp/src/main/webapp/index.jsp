<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to WorkNest</title>
</head>
<body>

    <h1>Welcome to WorkNest</h1>
    <p>Your smart task management system</p>

    <p>
        <a href="${pageContext.request.contextPath}/login">Login</a> |
        <a href="${pageContext.request.contextPath}/register">Register</a>
    </p>

</body>
</html>
