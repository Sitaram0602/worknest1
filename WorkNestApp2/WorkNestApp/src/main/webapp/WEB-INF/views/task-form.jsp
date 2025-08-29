<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Create Task</title>
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
      max-width: 600px;
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
    }

    a:hover {
      text-decoration: underline;
    }

    label {
      display: block;
      margin-top: 15px;
      color: #34495e;
    }

    input, select, textarea {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      box-sizing: border-box;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-family: 'Segoe UI', sans-serif;
      font-size: 14px;
    }

    button {
      margin-top: 20px;
      padding: 12px 24px;
      background-color: #3498db;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 600;
      font-size: 15px;
      transition: background-color 0.3s ease;
    }

    button:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>

<div class="header">
  <h1>WorkNest</h1>
  <nav>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
  </nav>
</div>

<div class="container">
  <h2>Allocate Task</h2>
  <p><a href="${pageContext.request.contextPath}/admin/dashboard">Back</a></p>

  <form action="${pageContext.request.contextPath}/admin/tasks" method="post">
    <label>Title</label>
    <input name="title" required />

    <label>Description</label>
    <textarea name="description" rows="4"></textarea>

    <label>Start Date</label>
    <input type="date" name="startDate" required />

    <label>Due Date</label>
    <input type="date" name="dueDate" required />

    <label>Assign To</label>
    <select name="assigneeId" required>
      <c:forEach items="${users}" var="u">
        <option value="${u.id}">${u.username} (${u.role})</option>
      </c:forEach>
    </select>

    <button type="submit">Create</button>
  </form>
</div>

<div class="footer">
  <p>&copy; 2025 My Project. All rights reserved.</p>
</div>

</body>
</html>
