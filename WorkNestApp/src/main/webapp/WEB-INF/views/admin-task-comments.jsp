<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Task Comments</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Task Comments</h1>
    <p>List of all comments on tasks will be shown here.</p>
    
    <table>
        <thead>
            <tr>
                <th>Comment ID</th>
                <th>Task</th>
                <th>Comment</th>
                <th>Author</th>
            </tr>
        </thead>
        <tbody>
            <!-- Example static row -->
            <tr>
                <td>1</td>
                <td>Design Homepage</td>
                <td>Looks good! Ready for review.</td>
                <td>Admin</td>
            </tr>
            <!-- Add dynamic comments here -->
        </tbody>
    </table>
</body>
</html>
