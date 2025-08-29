<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Task Details</title>
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
      max-width: 800px;
      margin: 60px auto;
      background-color: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    h2, h3, h4 {
      text-align: center;
      color: #2c3e50;
      margin-bottom: 20px;
    }
    a {
      color: #3498db;
      text-decoration: none;
      font-weight: 600;
    }
    a:hover {
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
    }
    textarea {
      width: 100%;
      padding: 10px;
      margin-top: 10px;
      box-sizing: border-box;
      border: 1px solid #ccc;
      border-radius: 6px;
      resize: vertical;
      font-size: 14px;
      font-family: 'Segoe UI', sans-serif;
    }
    button {
      margin-top: 12px;
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
    <a href="${pageContext.request.contextPath}/user/tasks">My Tasks</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
  </nav>
</div>

<div class="container">
  <h2>Task Details</h2>
  <p><a href="${pageContext.request.contextPath}/user/tasks">← Back to My Tasks</a></p>

  <h3>Comments</h3>
  <table>
    <tr>
      <th>Author</th>
      <th>Content</th>
      <th>Created At</th>
    </tr>
    <c:forEach items="${comments}" var="c">
      <tr>
        <td>${c.author.username}</td>
        <td>${c.content}</td>
        <td>${c.createdAt}</td>
      </tr>
    </c:forEach>
  </table>

  <h4>Add Comment</h4>
  <form action="${pageContext.request.contextPath}/user/tasks/${taskId}/comments" method="post">
    <textarea name="content" rows="3" required></textarea><br/>
    <button type="submit">Add Comment</button>
  </form>
</div>

<div class="footer">
  <p>&copy; 2025 My Project. All rights reserved.</p>
</div>

</body>
</html>
