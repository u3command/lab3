<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Task</title>
    <link rel="icon" href="images/icon.png" type="image/png">
    <link rel="stylesheet" type="text/css" href="css/task_page.css">
    <link rel="stylesheet" type="text/css" href="css/1.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="jquery/inputmask.js"></script>
    <script src="jquery/jquery.inputmask.js"></script>
    <script src="jquery/inputmask.date.extensions.js"></script>
    <script src="jquery/jquery.tablesorter.js"></script>
    <link rel="stylesheet" href="css/style.css" type="text/css"/>
    <script src="js/1.js"></script>
    <script src="js/validation.js"></script>

</head>
<body>
<jsp:useBean id="emp" class="emp.Employee" scope="session"/>
<jsp:useBean id="constants" class="utils.Constants"/>
<c:set var="taskid" value="${param.taskid}"/>
<div class="task-form">
    <c:set var="task" value="${emp.journalManager.get(taskid)}"/>
    <fmt:formatDate value="${task.date}" pattern="dd.MM.yyyy HH:mm" var="formattedDate"/>
    <c:set var="isCompleted" value="${task.status==constants.COMPLETED || task.status==constants.CANCELLED}" scope="session"/>
    <c:set var="isEditable" value="${task.cr_id==emp.ID}" scope="page"/>
        <c:choose>
            <c:when test="${isCompleted==true}">
                <c:if test="${param.pt_id != null}">
                    <fmt:formatDate value="${emp.journalManager.get(param.pt_id).date}" pattern="dd.MM.yyyy HH:mm" var="formattedDate1"/>
                    <label for="pt_id">Parent task ID</label>
                    <input type="text" readonly value="${task.pt_id}" name="pt_id" id="pt_id"/>

                    <label for="task-date">Parent task date</label>
                    <input class="date-cell" type="text" id="task-date" readonly value="${formattedDate1}"/>
                </c:if>
                <label for="exec">Executor</label>
                <c:if test="${emp.ID==task.ex_id}">
                    <input type="text" readonly value="Me" id="exec"/>
                </c:if>
                <c:forEach items="${emp.emps}" var="e">
                    <c:if test="${e.ID==task.ex_id}">
                        <input type="text" readonly value="${e.name}" id="exec" />
                    </c:if>
                </c:forEach>
                <label for="creator">Creator</label>
                <input type="text" id="creator" readonly value="${emp.getName(task.cr_id)}"/>

                <label for="taskid">ID</label>
                <input id="taskid" type="text" value="${taskid}" readonly name="taskid"/>
                <label for="name">Name</label>
                <input name="name" id="name" type="text" value="${task.name}" readonly/>

                <label for="desc">Description</label>
                <textarea name="desc" id="desc" rows="5" readonly>${task.description}</textarea>
                <label for="tdate">Date</label>
                <input readonly name="date" type="text" class="date-cell"  id="tdate" value="${formattedDate}"/>

                <label for="contacts">Contacts</label>
                <textarea name="contacts" id="contacts" rows="5" readonly>${task.contacts}</textarea>


                <label for="priority">Priority</label>
                    <c:if test="${task.priority == constants.LOW}">
                        <input id="priority" type="text" value="Low" readonly/>
                    </c:if>
                    <c:if test="${task.priority == constants.MEDIUM}">
                        <input id="priority" type="text" value="Medium" readonly/>
                    </c:if>
                    <c:if test="${task.priority == constants.HIGH}">
                        <input id="priority" type="text" value="High" readonly/>
                    </c:if>

                <label for="status">Status</label>
                <input id="status" name="status" type="text" value="${task.fullStatus}" readonly/>

            </c:when>

            <c:otherwise>
            <form method="post" action="savetask" id="update-task-form">
                <c:if test="${param.pt_id != null}">
                    <fmt:formatDate value="${emp.journalManager.get(param.pt_id).date}" pattern="dd.MM.yyyy HH:mm" var="formattedDate1"/>
                    <label for="pt_id">Parent task ID</label>
                    <input type="text" readonly value="${task.pt_id}" name="pt_id" id="pt_id"/>

                    <label for="task-date">Parent task date</label>
                    <input class="date-cell" type="text" id="task-date" readonly value="${formattedDate1}"/>
                </c:if>
                <label for="exec">Executor</label>
                <c:choose>
                    <c:when test="${emp.ID!=task.cr_id}">
                        <c:if test="${emp.ID==task.ex_id}">
                            <input type="text" readonly value="Me" id="exec"/>
                        </c:if>
                        <c:if test="${emp.ID!=task.ex_id}">
                            <c:forEach items="${emp.emps}" var="e">
                                <c:if test="${e.ID==task.ex_id}">
                                    <input type="text" readonly value="${e.name}" id="exec" />
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <select name="ex_id" id="exec">
                            <c:if test="${emp.ID==task.ex_id}">
                                <option value="${emp.ID}" selected>Me</option>
                            </c:if>
                            <c:if test="${emp.ID !=task.ex_id}">
                                <option value="${emp.ID}" >Me</option>
                            </c:if>
                            <c:forEach items="${emp.emps}" var="e">

                                <c:if test="${e.ID==task.ex_id}">
                                    <option value="${e.ID}" selected>${e.name}</option>
                                </c:if>
                                <c:if test="${e.ID !=task.ex_id}">
                                    <option value="${e.ID}">${e.name}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </c:otherwise>
                </c:choose>

                <label for="creator">Creator</label>
                <input type="text" id="creator" readonly value="${emp.getName(task.cr_id)}"/>

                <label for="taskid">ID</label>
                <input id="taskid" type="text" value="${taskid}" readonly name="taskid"/>

                <label for="name">Name</label>
                <c:choose>
                   <c:when test="${emp.ID!=task.cr_id}">
                       <input name="name" id="name" type="text" value="${task.name}" readonly/>
                   </c:when>
                    <c:otherwise>
                        <input name="name" id="name" type="text" value="${task.name}"/>
                        <label id="name-error" class="error" hidden >Name should not be empty</label>
                    </c:otherwise>
                </c:choose>


                <label for="desc">Description</label>
                <textarea name="desc" id="desc" rows="5">${task.description}</textarea>


                <label for="tdate">Date</label>
                <input name="date" type="text" class="date-cell"  id="tdate" value="${formattedDate}"/>
                <label id="date-error" class="error" hidden>Please enter correct date</label>
                <br/>
                <label for="contacts">Contacts</label>
                <textarea name="contacts" id="contacts" rows="5">${task.contacts}</textarea>

                <label for="priority">Priority</label>
                    <select name="priority" id="priority">
                        <c:if test="${task.priority == constants.LOW}">
                            <option value="${constants.LOW}" selected>Low</option>
                            <option value="${constants.MEDIUM}">Medium</option>
                            <option value="${constants.HIGH}">High</option>
                        </c:if>
                        <c:if test="${task.priority == constants.MEDIUM}">
                            <option value="${constants.LOW}" >Low</option>
                            <option value="${constants.MEDIUM}" selected>Medium</option>
                            <option value="${constants.HIGH}">High</option>
                        </c:if>
                        <c:if test="${task.priority == constants.HIGH}">
                            <option value="${constants.LOW}" >Low</option>
                            <option value="${constants.MEDIUM}">Medium</option>
                            <option value="${constants.HIGH}" selected>High</option>
                        </c:if>
                    </select>

                <label for="status">Status</label>
                <c:choose>
                    <c:when test="${emp.ID!=task.ex_id}">
                        <input id="status" name="status" type="text" value="${task.fullStatus}" readonly/>
                    </c:when>
                    <c:otherwise>
                        <select name="status" id="status">
                            <c:if test="${task.status == constants.NEW}">
                                <option value="${constants.NEW}" selected>New</option>
                                <option value="${constants.PERFORMING}">In progress</option>
                            </c:if>
                            <c:if test="${task.status == constants.PERFORMING}">
                                <option value="${constants.NEW}">New</option>
                                <option value="${constants.PERFORMING}" selected>In progress</option>
                            </c:if>
                        </select>
                    </c:otherwise>
                </c:choose>
                <input type="submit" value="Save" name="update"/>
                </form>
                <c:if test="${emp.ID==task.ex_id}">
                    <form action="completetask" method="post" class="last-cell">
                        <input type="text" name="taskid" hidden readonly value="${taskid}"/>
                        <input type="submit" value="Complete" name="update"/>
                    </form>
                </c:if>
                <c:if test="${emp.ID==task.cr_id}">
                    <form action="savetask" method="post">
                        <input type="text" name="taskid" hidden readonly value="${taskid}"/>
                        <input type="submit" value="Cancel" name="update"/>
                    </form>
                </c:if>
            </c:otherwise>
        </c:choose>
</div>
<div id="menu-container">
        <div class="actions">
            <c:if test="${isCompleted!=true}" >
                <a href="newtask.jsp?pt_id=${taskid}">+ New subtask</a>
            </c:if>
            <br/>
            <label id="message" hidden>You don't have subtasks.</label>
        </div>

        <div id="table-container">

            <c:set var="b" value="${emp.ID == task.cr_id}" scope="page"/>
            <c:set var="tasks" value="${emp.journalManager.getSubtasks(taskid)}"/>
            <table id="tasks" class="tablesorter">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Executor</th>
                    <th class="noSort">Action</th>
                </tr>
                </thead>
               <tbody>
               <c:forEach var="task" items="${tasks}">
                   <tr>
                       <td>${task.ID}</td>
                       <td><a href="task.jsp?taskid=${task.ID}&pt_id=${taskid}" target="_blank">${task.name}</a> </td>
                       <td>
                           <fmt:formatDate type="both" dateStyle="medium" timeStyle="short" value="${task.date}"/>
                       </td>
                       <td>${task.fullStatus}</td>
                       <c:if test="${emp.ID != task.ex_id}">
                           <td>
                               <a href="emp.jsp?id=${task.ex_id}">${emp.getEmp(task.ex_id).name}</a>
                           </td>
                       </c:if>
                       <c:if test="${emp.ID == task.ex_id}">
                           <td>Me</td>
                       </c:if>
                       <c:if test="${b==true}">
                           <td class="last-cell">
                               <form action="deletetask"  id="delete-form" method="post">
                                   <button  class="delete-button" type="submit" name="id" value="${task.ID}"></button>
                               </form>
                               <form action="copytask" method="post">
                                   <button  class="copy-button" type="submit" name="id" value="${task.ID}"></button>
                               </form>
                           </td>
                       </c:if>
                       <c:if test="${b==false}">
                           <td class="last-cell">
                               <form action="copytask" method="post">
                                   <button  class="copy-button" type="submit" name="id" value="${task.ID}"></button>
                               </form>
                           </td>
                       </c:if>

                   </tr>
               </c:forEach>
               </tbody>

            </table>
        </div>
</div>
</body>
</html>