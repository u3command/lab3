<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Subtask</title>
    <link rel="icon" href="../images/icon.png" type="image/png">
</head>
<body>
<c:set var="taskid" value="${param.taskid}"/>
<c:set var="st_id" value="${param.stid}"/>
<div class="task-form">
    <jsp:useBean id="emp" class="emp.Employee" scope="session"/>
    <c:set var="task" value="${emp.journalManager.getSubtask(taskid,st_id)}"/>
    <fmt:formatDate value="${task.date}" type="both" dateStyle="medium" timeStyle="short" var="formattedDate"/>
        <table>
            <tr>
                <th>Task ID</th>
                <td><input type="text" value="${taskid}" disabled name="taskid" readonly/></td>
            </tr>
            <tr>
                <th>ID</th>
                <td><input type="text" value="${st_id}" disabled name="stid" readonly/></td>
            </tr>
            <tr>
                <th>Name</th>
                <td><input name="name" type="text" value="${task.name}" readonly/></td>
            </tr>
            <tr>
                <th>Description</th>
                <td><textarea name="desc" rows="7" readonly>${task.description}</textarea></td>
            </tr>
            <tr>
                <th>Date</th>
                <td><input name="date" type="text" class="date-cell"  value="${formattedDate}" readonly/></td>
            </tr>
            <tr>
                <th>Contacts</th>
                <td><textarea name="desc" rows="7" readonly>${task.contacts}</textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="button" value="OK"/>
                </td>
            </tr>
        </table>
</div>
</body>
</html>