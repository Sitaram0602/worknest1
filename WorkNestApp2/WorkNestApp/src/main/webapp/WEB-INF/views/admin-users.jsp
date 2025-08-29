<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Manage Users</title>
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
      color: #1abc9c; /* teal on hover */
    }

    .container {
      max-width: 800px;
      margin: 60px auto;
      background-color: #ffffff; /* pure white */
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 6px 15px rgba(0,0,0,0.08);
    }

    h2, h3 {
      text-align: center;
      color: #2c3e50; /* dark slate */
      margin-bottom: 20px;
    }

    a {
      color: #2980b9; /* darker blue */
      text-decoration: none;
      font-weight: 600;
      transition: color 0.3s ease;
    }

    a:hover {
      color: #1abc9c; /* teal */
      text-decoration: underline;
    }

    table {
      border-collapse: collapse;
      width: 100%;
      margin: 20px 0;
      font-size: 15px;
    }

    th, td {
      border: 1px solid #dfe6e9;
      padding: 12px;
      text-align: center;
      color: #34495e;
    }

    th {
      background-color: #ecf0f1; /* lighter gray */
      font-weight: 700;
    }

    label {
      display: block;
      margin-top: 15px;
      color: #34495e;
      font-weight: 600;
    }

    input, select {
      width: 100%;
      padding: 10px;
      margin-top: 6px;
      box-sizing: border-box;
      border: 1px solid #bdc3c7; /* soft border */
      border-radius: 6px;
      font-size: 15px;
      transition: border-color 0.3s ease;
    }

    input:focus, select:focus {
      border-color: #1abc9c; /* teal focus */
      outline: none;
    }

    button {
      margin-top: 20px;
      padding: 12px 25px;
      background-color: #2980b9;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 600;
      font-size: 16px;
      transition: background-color 0.3s ease;
    }

    button:hover {
      background-color: #1abc9c;
    }

    .error {
      color: #721c24;
      background-color: #f8d7da;
      padding: 12px;
      border-radius: 6px;
      margin-bottom: 15px;
      font-weight: 600;
      font-size: 14px;
    }

    .success {
      color: #155724;
      background-color: #d4edda;
      padding: 12px;
      border-radius: 6px;
      margin-bottom: 15px;
      font-weight: 600;
      font-size: 14px;
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
  <h2>Manage Users</h2>
  <p><a href="${pageContext.request.contextPath}/admin/dashboard">Back to Dashboard</a></p>

  <c:if test="${not empty error}">
    <p class="error">${error}</p>
  </c:if>
  <c:if test="${not empty successMessage}">
    <p class="success">${successMessage}</p>
  </c:if>

  <table>
    <tr>
      <th>ID</th>
      <th>Username</th>
      <th>Role</th>
      <th>Action</th>
    </tr>
    <c:forEach items="${users}" var="u">
      <tr>
        <td>${u.id}</td>
        <td>${u.username}</td>
        <td>${u.role}</td>
        <td>
          <form action="${pageContext.request.contextPath}/admin/users/${u.id}/delete" method="post" style="display:inline">
            <button type="submit" onclick="return confirm('Delete user?')">Delete</button>
          </form>
        </td>
      </tr>
    </c:forEach>
  </table>

  <h3>Add New User</h3>
  <form action="${pageContext.request.contextPath}/admin/users" method="post">
    <label>Username:</label>
    <input name="username" value="${newUser.username}" required />

    <label>Password:</label>
    <input type="password" name="password" required />

    <label>Role:</label>
    <select name="role">
      <option value="USER">USER</option>
      <option value="ADMIN">ADMIN</option>
    </select>

    <button type="submit">Add User</button>
  </form>
</div>

<div class="footer">
  <p>&copy; 2025 My Project. All rights reserved.</p>
</div>

</body>
</html>
