<%--
  Created by IntelliJ IDEA.
  User: Dylan
  Date: 2022/5/12
  Time: 16:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
<%--引入标签库--%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%--引入jquery--%>
<%--  web路径
  不以/相对路径,找资源,以当前资源路径为基准,经常容易出问题
  以/开始的相对路径,找资源,以服务器的路径为标准(http://localhost:8080)
  http://localhost:8080/ssm_crud
  --%>
    <script type="javascript" src="${APP_PATH}/static/js/jquery3.5.0min.js"></script>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
</head>
<body>
<%--使用bootstrap搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--   两个按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-success btn-sm">增加
               <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button>
            <button class="btn btn-danger btn-sm">删除
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></button>
        </div>
    </div>
    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>sex</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.sex=="man"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.dept.deptName}</th>
                        <th>
                            <button class="btn btn-success btn-sm">增加
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            </button>
                            <button class="btn btn-danger btn-sm">删除
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            </button>
                        </th>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>
    <%--显示分页--%>
    <div class="row">
        <div class="col-md-6">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li><a href="${APP_PATH}/emps?pageNum=${1}">首页</a></li>
                <c:if test="${pageInfo.hasPreviousPage}">
                    <li>
                        <a href="${APP_PATH}/emps?pageNum=${pageInfo.pageNum-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num==pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                    <c:if test="${page_Num!=pageInfo.pageNum}">
                        <li><a href="${APP_PATH}/emps?pageNum=${page_Num}">${page_Num}</a></li>
                    </c:if>
                </c:forEach>
                <c:if test="${pageInfo.hasNextPage}">
                    <li>
                        <a href="href="${APP_PATH}/emps?pageNum=${pageInfo.pageNum+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>

                <li><a href="${APP_PATH}/emps?pageNum=${pageInfo.pages}">末页</a></li>
            </ul>
        </nav>
        </div>
        <div class="col-md-6">
            当前处在${pageInfo.pageNum}页.共${pageInfo.pages}页,${pageInfo.total}记录数
        </div>
    </div>
</div>
</body>
</html>
