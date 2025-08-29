<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Register</title>
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
      color: #1abc9c; /* teal */
    }

    .register-container {
      background-color: #ffffff; /* pure white */
      max-width: 400px;
      margin: 80px auto;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 6px 15px rgba(0,0,0,0.08);
    }

    h2 {
      text-align: center;
      color: #2c3e50; /* dark slate */
      margin-bottom: 25px;
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
      width: 100%;
      padding: 12px;
      margin-top: 25px;
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

    .message {
      padding: 12px;
      margin-bottom: 15px;
      border-radius: 6px;
      font-weight: 600;
      font-size: 14px;
    }

    .message.error {
      background-color: #f8d7da;
      color: #721c24;
    }

    .message.success {
      background-color: #d4edda;
      color: #155724;
    }

    .login-link {
      text-align: center;
      margin-top: 20px;
    }

    .login-link a {
      color: #2980b9;
      font-weight: 600;
      text-decoration: none;
      transition: color 0.3s ease;
    }

    .login-link a:hover {
      color: #1abc9c;
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="header">
  <h1>WorkNest</h1>
  <nav>
    <a href="${pageContext.request.contextPath}/">Home</a>
  </nav>
</div>

<div class="register-container">
  <h2>Register</h2>

  <c:if test="${not empty error}">
    <p class="message error">${error}</p>
  </c:if>

  <c:if test="${not empty success}">
    <p class="message success">${success}</p>
  </c:if>

  <form action="${pageContext.request.contextPath}/register" method="post">
    <label>Username</label>
    <input name="username" required />

    <label>Password</label>
    <input type="password" name="password" required />

    <label>Role</label>
    <select name="role">
      <option value="USER">USER</option>
      <option value="ADMIN">ADMIN</option>
    </select>

    <button type="submit">Register</button>
  </form>

  <div class="login-link">
    <p><a href="${pageContext.request.contextPath}/login">Back to Login</a></p>
  </div>
</div>

<div class="footer">
  <p>&copy; 2025 My Project. All rights reserved.</p>
</div>

</body>
</html>
