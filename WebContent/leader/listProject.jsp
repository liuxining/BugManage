<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>



<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">


<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.1.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/js/bootstrap.js"></script>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.css"/>




</head>
<body style="margin-top: 20px;">

<div class="admin-content">
	<div class="admin-content-body">
<div class="container-fluid">
	<div class="row-fluid">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<form class="am-form am-form-horizontal" action="${pageContext.request.contextPath}/ProjectServlet?method=list&to=leader_listProject" method="post">
				<div class="row-fluid">
					<div class="col-sm-3">
						<select name="type">
							<c:if test="${type == 0 }">
								<option value="0" selected="selected">所有语言</option>
							</c:if>
							
							<c:if test="${type != 0 }">
								<option value="0">所有语言</option>
							</c:if>
							
							<c:if test="${type == 1 }">
								<option value="1" selected="selected">Java</option>
							</c:if>
							
							<c:if test="${type != 1 }">
								<option value="1">Java</option>
							</c:if>
							
							<c:if test="${type == 2 }">
								<option value="2" selected="selected">C++</option>
							</c:if>
							
							<c:if test="${type != 2 }">
								<option value="2">C++</option>
							</c:if>
							
							<c:if test="${type == 3 }">
								<option value="3" selected="selected">PHP</option>
							</c:if>
							
							<c:if test="${type != 3 }">
								<option value="3">PHP</option>
							</c:if>
							
						</select>
					</div>
					<div class="col-sm-3 am-form-group">
						<select name="status2">
							<c:if test="${status2 == 0 }">
								<option value="0" selected="selected">所有状态</option>
							</c:if>
							
							<c:if test="${status2 != 0 }">
								<option value="0">所有状态</option>
							</c:if>
							
							<c:if test="${status2 == 1 }">
								<option value="1" selected="selected">未开始</option>
							</c:if>
							
							<c:if test="${status2 != 1 }">
								<option value="1">未开始</option>
							</c:if>
							
							<c:if test="${status2 == 2 }">
								<option value="2" selected="selected">进行中</option>
							</c:if>
							
							<c:if test="${status2 != 2 }">
								<option value="2">进行中</option>
							</c:if>
							
							<c:if test="${status2 == 3 }">
								<option value="3" selected="selected">已完成</option>
							</c:if>
							
							<c:if test="${status2 != 3 }">
								<option value="3">已完成</option>
							</c:if>
							
						</select>
					</div>
					<div class="col-sm-3 am-form-group">
						<select name="userId">
							<c:if test="${userId == 0 }">
								<option value="0" selected="selected">所有人员</option>
							</c:if>						
							<c:if test="${userId != 0 }">
								<option value="0">所有人员</option>
							</c:if>						
							<c:forEach items="${userList }" var="item">
								<c:if test="${userId == item.id }">
									<option value="${item.id }" selected="selected">${item.name }</option>
								</c:if>
								<c:if test="${userId != item.id }">
									<option value="${item.id }">${item.name }</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="col-sm-3">
						<button type="submit" class="am-btn am-btn-primary">筛选</button>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-2"></div>
	</div>
</div>

<div class="container-fluid">
	  <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">项目</strong> / <small>列表</small></div>
	  </div>

	<div class="row-fluid">
		<table class="am-table am-table-striped am-table-hover table-main am-table-compact">
			<tr>
				<td>编号</td>
				<td>名称</td>
				<td>类型</td>
				<td>状态</td>
				<td>发布人</td>
				<td>创建日期</td>

				<td>操作</td>
			</tr>
			<c:forEach items="${projectList}" var="item">
				<tr>
					<td>${item.id}</td>
					<td><a href="${pageContext.request.contextPath}/ProjectServlet?method=detail&id=${item.id}">${item.name}</a></td>
					<c:if test="${item.type == 1}">
						<td>Java</td>
					</c:if>
					<c:if test="${item.type == 2}">
						<td>C++</td>
					</c:if>
					<c:if test="${item.type == 3}">
						<td>PHP</td>
					</c:if>
					<c:if test="${item.status == 1}">
						<td>未进行</td>
					</c:if>
					<c:if test="${item.status == 2}">
						<td>进行中</td>
					</c:if>
					<c:if test="${item.status == 3}">
						<td>已完成</td>
					</c:if>
					<td>${item.userBean.name }</td>
					<td>${item.createDate}</td>
					<td>
					<div class="am-btn-toolbar">
	                    <div class="am-btn-group am-btn-group-xs">
	                      <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/ProjectServlet?method=toUpdate&id=${item.id}&type=${type}&status2=${status2}&userId=${userId}&page=${page}"><span class="am-icon-pencil-square-o"></span> 编辑</a>
	               
   	                      <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${pageContext.request.contextPath}/ProjectServlet?method=delete&id=${item.id}&type=${type}&status2=${status2}&userId=${userId}&page=${page}" onclick="return confirm('确定删除吗？')"><span class="am-icon-trash-o"></span> 删除</a>
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
		
		</div>
		<div class="row-fluid">
			<div class="col-md-4"></div>
			<div class="col-md-4">
			
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
			</div>
			<div class="col-md-4"></div>
		</div>
</div>
</div>
</div>

<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>

</body>
</html>