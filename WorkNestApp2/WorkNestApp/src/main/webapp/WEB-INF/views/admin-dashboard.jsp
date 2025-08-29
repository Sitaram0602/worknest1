<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Admin Dashboard</title>
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
      max-width: 1000px;
      margin: 40px auto;
      background-color: #ffffff; /* pure white for container */
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 6px 15px rgba(0,0,0,0.08);
    }

    h2 {
      color: #2c3e50; /* dark slate */
      text-align: center;
      margin-bottom: 25px;
    }
    
    h3 {
      color: #34495e; /* slightly lighter than h2 */
      margin-bottom: 15px;
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

    .message {
      padding: 12px 15px;
      margin-bottom: 15px;
      border-radius: 6px;
      font-weight: 600;
      font-size: 14px;
    }

    #flashMsg {
      font-weight: bold;
    }

    .message.success {
      background-color: #dff0d8;
      color: #3c763d;
      border: 1px solid #d6e9c6;
    }

    .message.error {
      background-color: #f2dede;
      color: #a94442;
      border: 1px solid #ebccd1;
    }

    ul {
      list-style: none;
      padding-left: 0;
      font-size: 16px;
      color: #34495e;
    }

    ul li {
      margin-bottom: 6px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      font-size: 15px;
      color: #2c3e50;
    }

    table, th, td {
      border: 1px solid #bdc3c7; /* lighter border */
    }

    th {
      background-color: #ecf0f1; /* light gray */
      color: #2c3e50;
      padding: 12px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.05em;
    }

    td {
      padding: 10px;
      text-align: center;
    }

    select {
      padding: 6px 10px;
      border-radius: 6px;
      border: 1px solid #bdc3c7;
      background-color: #f8f9fa;
      font-weight: 600;
      color: #34495e;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    select:hover {
      background-color: #e1e8eb;
    }

    .button-link {
      background-color: #1abc9c; /* teal */
      color: white;
      padding: 7px 16px;
      border-radius: 6px;
      text-decoration: none;
      display: inline-block;
      font-weight: 600;
      transition: background-color 0.3s ease;
    }

    .button-link:hover {
      background-color: #16a085;
    }
  </style>
</head>
<body>

<div class="header">
  <h1>WorkNest</h1>
  <nav>
    <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
    <a href="${pageContext.request.contextPath}/admin/tasks/new">Allocate Task</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
  </nav>
</div>

<div class="container">
  <h2>Admin Dashboard</h2>

  <c:if test="${not empty successMessage}">
    <div class="message success" id="flashMsg">${successMessage}</div>
  </c:if>
  <c:if test="${not empty errorMessage}">
    <div class="message error" id="flashMsg">${errorMessage}</div>
  </c:if>

  <h3>Task Status</h3>
  <ul>
    <li>Pending: ${counts['PENDING']}</li>
    <li>In Progress: ${counts['IN_PROGRESS']}</li>
    <li>Completed: ${counts['COMPLETED']}</li>
    <li>Delayed: ${counts['DELAYED']}</li>
  </ul>

  <h3>All Tasks</h3>
  <table>
    <tr>
      <th>ID</th>
      <th>Title</th>
      <th>Assignee</th>
      <th>Status</th>
      <th>Start</th>
      <th>Due</th>
      <th>Comments</th>
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
          <form action="${pageContext.request.contextPath}/admin/tasks/${t.id}/status" method="post">
            <select name="status" onchange="this.form.submit()">
              <option value="PENDING"     <c:if test="${t.status == 'PENDING'}">selected</c:if>>Pending</option>
              <option value="IN_PROGRESS" <c:if test="${t.status == 'IN_PROGRESS'}">selected</c:if>>In Progress</option>
              <option value="COMPLETED"   <c:if test="${t.status == 'COMPLETED'}">selected</c:if>>Completed</option>
              <option value="DELAYED"     <c:if test="${t.status == 'DELAYED'}">selected</c:if>>Delayed</option>
            </select>
          </form>
        </td>
        <td>${t.startDate}</td>
        <td>${t.dueDate}</td>
        <td><a class="button-link" href="${pageContext.request.contextPath}/admin/tasks/${t.id}/comments">View</a></td>
      </tr>
    </c:forEach>
  </table>
</div>

<div class="footer">
  <p>&copy; 2025 My Project. All rights reserved.</p>
</div>

<script>
  setTimeout(() => {
    const msg = document.getElementById("flashMsg");
    if (msg) msg.style.display = "none";
  }, 4000);
</script>

</body>
</html>
