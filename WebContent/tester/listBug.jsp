<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bug列表</title>



<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.1.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/js/bootstrap.js"></script>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.css"/>



</head>
<body>

<div class="admin-content">
	<div class="admin-content-body">
<div class="container-fluid" style="margin-top: 30px;">
	<div class="row-fluid">
		
		<div class="col-sm-12">
			<form class="am-form-horizontal" action="${pageContext.request.contextPath}/BugServlet?method=list&to=tester_listBug" method="post">
				<div class="row-fluid">
					<div class="col-sm-2 am-form-group">
						<select class="form-control" name="level">
							<c:if test="${level == 0 }">
								<option value="0" selected="selected">所有Bug等级</option>
							</c:if>
							
							<c:if test="${level != 0 }">
								<option value="0">所有Bug等级</option>
							</c:if>
							<c:if test="${level == 1 }">
								<option value="1" selected="selected">次要</option>
							</c:if>
							
							<c:if test="${level != 1 }">
								<option value="1">次要</option>
							</c:if>
							<c:if test="${level == 2 }">
								<option value="2" selected="selected">一般</option>
							</c:if>
							
							<c:if test="${level != 2 }">
								<option value="2">一般</option>
							</c:if>
							<c:if test="${level == 3 }">
								<option value="3" selected="selected">重要</option>
							</c:if>
							
							<c:if test="${level != 3 }">
								<option value="3">重要</option>
							</c:if>
						</select>
					</div>
					<div class="col-sm-2 am-form-group">
						<select class="form-control" name="status2">
							<c:if test="${status2 == 0 }">
								<option value="0" selected="selected">所有Bug状态</option>
							</c:if>
							
							<c:if test="${status2 != 0 }">
								<option value="0">所有Bug状态</option>
							</c:if>
							
							<c:if test="${status2 == 1 }">
								<option value="1" selected="selected">未修复</option>
							</c:if>
							
							<c:if test="${status2 != 1 }">
								<option value="1">未修复</option>
							</c:if>
							
							<c:if test="${status2 == 4 }">
								<option value="4" selected="selected">已解决</option>
							</c:if>
							
							<c:if test="${status2 != 4 }">
								<option value="4">已解决</option>
							</c:if>
							
							<c:if test="${status2 == 5 }">
								<option value="5" selected="selected">已关闭</option>
							</c:if>
							
							<c:if test="${status2 != 5 }">
								<option value="5">已关闭</option>
							</c:if>
						</select>
					</div>
					<div class="col-sm-2 am-form-group">
						<select class="form-control" name="projectId">
							<c:if test="${projectId == 0 }">
								<option value="0" selected="selected">所有项目</option>
							</c:if>
							
							<c:if test="${projectId != 0 }">
								<option value="0">所有项目</option>
							</c:if>
							<c:forEach items="${projectList}" var="item">
								<c:if test="${item.id == projectId }">
									<option value="${item.id}" selected="selected">${item.name}</option>
								</c:if>
								<c:if test="${item.id != projectId }">
									<option value="${item.id}">${item.name}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="col-sm-2 am-form-group">
						<select class="form-control" name="userId">
							<c:if test="${userId == 0 }">
								<option value="0" selected="selected">所有人员</option>
							</c:if>
							
							<c:if test="${userId != 0 }">
								<option value="0">所有人员</option>
							</c:if>
							<c:forEach items="${userList}" var="item">
								<c:if test="${item.id == userId }">
									<option value="${item.id}" selected="selected">${item.name}</option>
								</c:if>
								<c:if test="${item.id != userId }">
									<option value="${item.id}">${item.name}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="col-sm-4">
						<button type="submit" class="am-btn am-btn-primary">筛选</button>
					</div>
				</div>
			</form>
		</div>
		
	</div>
</div>

<div class="container-fluid">
	<div class="row-fluid">
		<div class="am-cf am-padding am-padding-bottom-0">
        	<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">发布的Bug</strong> / <small>列表</small></div>
      </div>
	</div>
	<div class="row-fluid">
		<table class="am-table am-table-striped am-table-hover table-main am-table-compact">
			<tr>
				<th>编号</th>
				<th>标题</th>
				<th>等级</th>
				<th>状态</th>
				<th>创建者</th>
				<th>所属项目</th>
				<th>创建日期</th>
				<th>操作</th>
			</tr>
			<c:forEach items="${bugList}" var="item">
				<tr>
					<td>${item.id}</td>
					<td><a href="${pageContext.request.contextPath}/BugServlet?method=detail&to=tester_detail&id=${item.id}">${item.title}</a></td>
					<td>
						<c:if test="${item.level == 1}">
							次要
						</c:if>
						<c:if test="${item.level == 2}">
							一般
						</c:if>
						<c:if test="${item.level == 3}">
							严重
						</c:if>
					</td>
					<td>
						<c:if test="${item.status == 1}">
							未修复
						</c:if>
						<c:if test="${item.status == 2}">
							<a href="${pageContext.request.contextPath}/BugServlet?method=detail&to=tester_detail&id=${item.id}">待审核</a>
						</c:if>
						<c:if test="${item.status == 3}">
							未通过
						</c:if>
						<c:if test="${item.status == 4}">
							已解决
						</c:if>
						<c:if test="${item.status == 5}">
							已关闭
						</c:if>
					</td>
					<td>${item.userBean.name}</td>
					<td>${item.projectBean.name}</td>
					<td>${item.createDate}</td>

					

					<td>
					<div class="am-btn-toolbar">
	                    <div class="am-btn-group am-btn-group-xs">
	                      <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/BugServlet?method=toUpdate&id=${item.id}&projectId=${projectId}&level=${level}&status2=${status2}&page=${page}&userId=${userId}"><span class="am-icon-pencil-square-o"></span> 编辑</a>
	                      


						<c:if test="${item.status == 5 }">
							<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/BugServlet?method=upStat&id=${item.id}&status=1&projectId=${projectId}&level=${level}&status2=${status2}&page=${page}&userId=${userId}">重新开启</a>
						</c:if>
						<c:if test="${item.status == 4 }">
							<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/BugServlet?method=upStat&id=${item.id}&status=1&projectId=${projectId}&level=${level}&status2=${status2}&page=${page}&userId=${userId}">重新修复</a>
						</c:if>
						<c:if test="${item.status != 5 && item.status != 4 }">
							<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/BugServlet?method=upStat&id=${item.id}&status=5&projectId=${projectId}&level=${level}&status2=${status2}&page=${page}&userId=${userId}" onclick="return confirm('确定关闭吗？')">关闭</a>
						</c:if>


	                      <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${pageContext.request.contextPath}/BugServlet?method=delete&id=${item.id}&projectId=${projectId}&level=${level}&status2=${status2}&page=${page}&userId=${userId}" onclick="return confirm('确定删除吗？')"><span class="am-icon-trash-o"></span> 删除</a>
	                    </div>
                 	</div>
					</td>

					
				</tr>
			</c:forEach>
		</table>
		
		<div class="row-fluid">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div>
					${pageMsg }
					<%-- <util:page pagingBean="${pagingBean}" /> --%>
				</div>
			</div>
			<div class="col-md-3"></div>
		</div>
		
		<div class="row-fluid">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<c:if test='${param.status.equals("1")}'>
					<div class="am-alert am-alert-success" role="alert">修改成功</div>
				</c:if>
				
				<c:if test='${param.status.equals("2")}'>
					<div class="am-alert am-alert-danger" role="alert">修改失败</div>
				</c:if>
				
				<c:if test='${param.status.equals("3")}'>
					<div class="am-alert am-alert-success" role="alert">删除成功</div>
				</c:if>
				<c:if test='${param.status.equals("4")}'>
					<div class="am-alert am-alert-danger" role="alert">删除失败</div>
				</c:if>
				
				<c:if test='${param.status.equals("5")}'>
					<div class="am-alert am-alert-success" role="alert">关闭成功</div>
				</c:if>
				<c:if test='${param.status.equals("6")}'>
					<div class="am-alert am-alert-danger" role="alert">关闭失败</div>
				</c:if>
				<c:if test='${param.status.equals("7")}'>
					<div class="am-alert am-alert-success" role="alert">重新开启成功</div>
				</c:if>
				<c:if test='${param.status.equals("8")}'>
					<div class="am-alert am-alert-danger" role="alert">重新开启失败</div>
				</c:if>
				
				<c:if test='${param.status.equals("9")}'>
					<div class="am-alert am-alert-success" role="alert">设置重新修复成功</div>
				</c:if>
				<c:if test='${param.status.equals("10")}'>
					<div class="am-alert am-alert-danger" role="alert">设置重新修复失败</div>
				</c:if>
				
				
			</div>
			<div class="col-md-3"></div>
		</div>
		
		
		
		
		
	</div>
</div>
</div>
</div>
<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>


</body>
</html>