<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>My Tasks</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #eef2f7;
      margin: 0;
      padding: 0;
    }

    .header, .footer {
      background-color: #3b4b65;
      color: white;
      text-align: center;
      padding: 15px;
    }

    .header nav a {
      color: white;
      margin: 0 10px;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }

    .header nav a:hover {
      color: #1abc9c;
      text-decoration: underline;
    }

    .container {
      max-width: 1000px;
      margin: 60px auto;
      background-color: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      color: #2c3e50;
    }

    a {
      color: #3498db;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }

    a:hover {
      color: #2980b9;
      text-decoration: underline;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    th, td {
      border: 1px solid #ccc;
      padding: 10px;
      text-align: center;
    }

    th {
      background-color: #f0f4f8;
      color: #2c3e50;
      font-weight: 600;
    }

    select {
      padding: 6px;
      border-radius: 4px;
      border: 1px solid #ccc;
    }

    button {
      padding: 6px 12px;
      background-color: #3498db;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-weight: 600;
      transition: background-color 0.3s ease;
    }

    button:hover {
      background-color: #2980b9;
    }

    .success-message {
      color: #155724;
      background-color: #d4edda;
      padding: 10px;
      border-radius: 4px;
      margin-top: 20px;
      text-align: center;
      font-weight: 600;
    }
  </style>
</head>
<body>

<div class="header">
  <h1>Worknest</h1>
  <nav>
    <a href="${pageContext.request.contextPath}/user/tasks">My Tasks</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
  </nav>
</div>

<div class="container">
  <h2>My Tasks</h2>
  <p><a href="${pageContext.request.contextPath}/logout">Logout</a></p>

  <table>
    <tr>
      <th>ID</th>
      <th>Title</th>
      <th>Assignee</th>
      <th>Status</th>
      <th>Start</th>
      <th>Due</th>
      <th>Details</th>
    </tr>

    <c:forEach items="${tasks}" var="t">
      <tr>
        <td>${t.id}</td>
        <td>${t.title}</td>
        <td>
          <c:choose>
            <c:when test="${not empty t.assignee}">
              <c:out value="${t.assignee.username}"/>
            </c:when>
            <c:otherwise>
              Unassigned
            </c:otherwise>
          </c:choose>
        </td>
        <td>
          <form method="post" action="${pageContext.request.contextPath}/user/tasks/${t.id}/status">
            <select name="status" onchange="this.form.submit()">
              <c:forEach items="${statuses}" var="st">
                <option value="${st}" <c:if test="${t.status == st}">selected</c:if>>${st}</option>
              </c:forEach>
            </select>
          </form>
        </td>
        <td>${t.startDate}</td>
        <td>${t.dueDate}</td>
        <td><a href="${pageContext.request.contextPath}/user/tasks/${t.id}">View</a></td>
      </tr>
    </c:forEach>
  </table>

  <c:if test="${not empty message}">
    <div class="success-message">${message}</div>
  </c:if>
</div>

<div class="footer">
  <p>&copy; 2025 My Project. All rights reserved.</p>
</div>

</body>
</html>
