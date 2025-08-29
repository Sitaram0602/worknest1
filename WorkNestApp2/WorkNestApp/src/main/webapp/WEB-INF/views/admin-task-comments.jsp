<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Task Comments</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f9fafb; /* lighter background */
      margin: 0;
      padding: 0;
    }

    .header, .footer {
      background-color: #3b4b65; /* softer navy */
      color: #ecf0f1; /* light gray */
      text-align: center;
      padding: 15px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .header nav a {
      color: #ecf0f1;
      margin: 0 12px;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }

    .header nav a:hover {
      color: #1abc9c; /* fresh teal on hover */
    }

    .container {
      max-width: 800px;
      margin: 60px auto;
      background-color: #ffffff; /* pure white container */
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 6px 15px rgba(0,0,0,0.08);
    }

    h2 {
      text-align: center;
      color: #2c3e50; /* dark slate */
      margin-bottom: 25px;
    }

    a {
      color: #2980b9; /* calm blue */
      text-decoration: none;
      font-weight: 600;
    }

    a:hover {
      text-decoration: underline;
      color: #1abc9c; /* teal on hover */
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      font-size: 15px;
      color: #2c3e50;
    }

    th {
      background-color: #ecf0f1; /* light gray */
      color: #2c3e50;
      padding: 12px;
      border: 1px solid #bdc3c7; /* lighter border */
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    td {
      padding: 10px;
      border: 1px solid #bdc3c7;
      text-align: center;
    }

    .footer p {
      margin: 0;
      font-size: 14px;
      color: #ecf0f1;
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
  <h2>Task Comments</h2>
  <p><a href="${pageContext.request.contextPath}/admin/dashboard">Back</a></p>

  <table>
    <tr>
      <th>#</th>
      <th>Author</th>
      <th>Comment</th>
      <th>At</th>
    </tr>
    <c:forEach items="${comments}" var="cmt" varStatus="vs">
      <tr>
        <td>${vs.index + 1}</td>
        <td>${cmt.author.username}</td>
        <td>${cmt.content}</td>
        <td>${cmt.createdAt}</td>
      </tr>
    </c:forEach>
  </table>
</div>

<div class="footer">
  <p>&copy; 2025 My Project. All rights reserved.</p>
</div>

</body>
</html>
