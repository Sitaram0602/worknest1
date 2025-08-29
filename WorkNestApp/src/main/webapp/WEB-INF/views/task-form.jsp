<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
    <title>Create Task</title>
</head>
<body>
    <h2>Create Task</h2>

    <form:form modelAttribute="task" method="post" action="${pageContext.request.contextPath}/tasks/save">
        <label>Title:</label><br/>
        <form:input path="title" /><br/><br/>

        <label>Description:</label><br/>
        <form:textarea path="description" rows="5" cols="30" /><br/><br/>

        <input type="submit" value="Save Task" />
    </form:form>
</body>
</html>
