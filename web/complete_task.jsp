<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DAO.TaskDAO" %>
<html>
<head>
    <title>Complete task</title>
    <link rel="icon" href="images/icon.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="css/complete_task_page.css">
    <link rel="stylesheet" type="text/css" href="css/1.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="jquery/inputmask.js"></script>
    <script src="jquery/jquery.inputmask.js"></script>
    <script src="jquery/inputmask.date.extensions.js"></script>
    <script src="js/1.js"></script>
    <script src="js/validation.js"></script>
</head>

<body>
<jsp:useBean id="TaskDAO" class="DAO.TaskDAO"/>
<jsp:useBean id="EmpDAO" class="DAO.EmpDAO"/>
<c:set value="${param.empid}" var="empid"/>
<c:set var="task" value="${TaskDAO.getTask(empid,param.taskid)}"/>
<fmt:formatDate value="${task.date}" type="both" dateStyle="medium" timeStyle="short" var="formattedDate"/>

<form method="post" action="completetask">
       <table>
           <tr>
               <th>Employee ID</th>
               <td><input name="empid" type="text" id="empid" readonly value="${empid}"/></td>

           </tr>
           <tr>
               <th>Employee name</th>
               <td><input type="text" id="empname" readonly value="${EmpDAO.getEmpName(empid)}"/></td>
           </tr>
           <tr>
               <th>&nbsp</th>
               <td>&nbsp</td>
           </tr>
           <tr>
               <th>Task ID</th>
               <td><input type="text" name="taskid" id="id" readonly value="${task.ID}"/></td>

           </tr>
           <tr>
               <th>Name</th>
               <td><input type="text" id="name" readonly value="${task.name}"/></td>
           </tr>
           <tr>
               <th>Description</th>
               <td><textarea rows="7" readonly >${task.description}</textarea></td>
           </tr>
           <tr>
               <th>Date</th>
               <td>
                   <input  type="text" class="date-cell" readonly value="${formattedDate}">
               </td>
           </tr>
           <tr>
               <th>Contacts</th>
               <td><textarea rows="7" readonly>${task.contacts}</textarea></td>
           </tr>
           <tr>
               <th>New date</th>
               <td>
                   <input  type="text" class="date-cell" id="tdate" name="newdate">
               </td>
           </tr>
           <tr>
               <td><input type="submit" value="Delay" name="action"/></td>
               <td><input type="submit" value="Finish" name="action"/></td>
           </tr>
       </table>
</form>
</body>


<%--<body>
<c:out value="${param.empid}"/>
<c:out value="${param.taskid}"/>
</body>--%>
</html>

