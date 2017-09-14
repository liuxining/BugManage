<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>解决方案列表</title>



<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.1.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/js/bootstrap.js"></script>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.css"/>


<script type="text/javascript">
	
	function shenHe(obj){
		var msg = obj.name;
		var str = msg.split('#');
	//	alert(msg);
		$.get('${pageContext.request.contextPath}/HandleBugServlet?method=shenHe&id=' + str[0] + '&pass=' + str[1], function(data) {
			if(data != null && data.length > 0){
				//alert(data);
				if(data == 2){
					$("#" + str[0]).html('未通过');
				}
				else{
					$("#" + str[0]).html('通过');	
				}
			}
		});
	}
</script>

</head>
<body>



<div class="admin-content">
	<div class="admin-content-body">
<div class="container-fluid">
	<div class="row-fluid">
		
		<div class="col-md-12">
			<form class="am-form am-form-horizontal" action="${pageContext.request.contextPath}/HandleBugServlet?method=leaderListHandleBugList&to=listHandleBug" method="post">
				<div class="row-fluid">
					<div class="col-sm-3">
						<select name="bugId">
							<c:if test="${bugId == 0 }">
								<option value="0" selected="selected">所有Bug</option>
							</c:if>
							
							<c:if test="${bugId != 0 }">
								<option value="0">所有Bug</option>
							</c:if>
							<c:forEach items="${bugList}" var="item">
								<c:if test="${item.id == bugId }">
									<option value="${item.id}" selected="selected">${item.title}</option>
								</c:if>
								<c:if test="${item.id != bugId }">
									<option value="${item.id}">${item.title}</option>
								</c:if>
							</c:forEach>

						</select>
					</div>
					<div class="col-sm-3">
						<select name="pass">
							<c:if test="${pass == 0 }">
								<option value="0" selected="selected">所有状态</option>
							</c:if>
							
							<c:if test="${pass != 0 }">
								<option value="0">所有状态</option>
							</c:if>
							<c:if test="${pass == 1 }">
								<option value="1" selected="selected">未审核</option>
							</c:if>
							
							<c:if test="${pass != 1 }">
								<option value="1">未审核</option>
							</c:if>
							<c:if test="${pass == 2 }">
								<option value="2" selected="selected">未通过</option>
							</c:if>
							
							<c:if test="${pass != 2 }">
								<option value="2">未通过</option>
							</c:if>
							<c:if test="${pass == 3 }">
								<option value="3" selected="selected">通过</option>
							</c:if>
							
							<c:if test="${pass != 3 }">
								<option value="3">通过</option>
							</c:if>
						</select>
					</div>
					<div class="col-sm-3">
						<select name="userId">
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
					
					<div class="col-sm-3">
						<button type="submit" class="am-btn am-btn-primary">筛选</button>
					</div>
				</div>
			</form>
		</div>
		
	</div>
</div>

<div class="container-fluid">
	<div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">解决方案</strong> / <small>列表</small></div>
	  </div>
	<div class="row-fluid">
		<table class="am-table am-table-striped am-table-hover table-main am-table-compact">
			<tr>
				<th>编号</th>
				<th>Bug编号</th>
				<th>Bug标题</th>
				<th>Bug等级</th>
				<th>Bug状态</th>
				
				<th>提交者</th>
				<th>提交信息</th>
				<th>是否通过</th>
				<th>提交日期</th>
				<th colspan="3">操作</th>
			</tr>
			<c:forEach items="${handleBugList}" var="item">
				<tr>
					<td>${item.id}</td>
					<td>${item.bugId}</td>
					<td>${item.bugBean.title}</td>
					<td>
						<c:if test="${item.level == 1}">
							次要
						</c:if>
						<c:if test="${item.level == 2}">
							一般
						</c:if>
						<c:if test="${item.level == 3}">
							重要
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
					<td>${item.descr}</td>
					<td id="${item.id}">
						<c:if test="${item.pass == 1}">
							审核中
						</c:if>
						<c:if test="${item.pass == 2}">
							未通过
						</c:if>
						<c:if test="${item.pass == 3}">
							通过
						</c:if>

					</td>
					<td>${item.date}</td>
<!-- 					<td><a href="${pageContext.request.contextPath}/BugServlet?method=toUpdate&id=${item.id}">修改</a></td>
					 -->
<!-- 					<td>
						<c:if test="${item.status == 5 }">
							<a href="${pageContext.request.contextPath}/BugServlet?method=upStat&id=${item.id}&status=1">重新开启</a>
						</c:if>
						<c:if test="${item.status == 4 }">
							<a href="${pageContext.request.contextPath}/BugServlet?method=upStat&id=${item.id}&status=4">重新修复</a>
						</c:if>
						<c:if test="${item.status != 5 && item.status != 4 }">
							<a href="${pageContext.request.contextPath}/BugServlet?method=upStat&id=${item.id}&status=5" onclick="return confirm('确定关闭吗？')">关闭</a>
						</c:if>
					</td> -->
					

					<td>

					<div class="am-btn-toolbar">
	                    <div class="am-btn-group am-btn-group-xs">
	               

	               		<c:if test="${loginUserBean.type == 1 && item.userId == loginUserBean.id}">


							 <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/HandleBugServlet?method=toUpdate&id=${item.id}&bugId=${bugId}&pass=${pass}&userId=${loginUserBean.id}&page=${page}"><span class="am-icon-pencil-square-o"></span> 编辑</a>


							 <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${pageContext.request.contextPath}/HandleBugServlet?method=leaderListHandleBugDelete&id=${item.id}&bugId=${bugId}&pass=${pass}&userId=${userId}&page=${page}" onclick="return confirm('确定删除吗？')"><span class="am-icon-trash-o"></span> 删除</a>

	               		</c:if>

	               		<c:if test="${loginUserBean.type != 1}">



	               
   	                      <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${pageContext.request.contextPath}/HandleBugServlet?method=leaderListHandleBugDelete&id=${item.id}&bugId=${bugId}&pass=${pass}&userId=${userId}&page=${page}&to=listHandleBug" onclick="return confirm('确定删除吗？')"><span class="am-icon-trash-o"></span> 删除</a>


							<a href="#" class="am-btn am-btn-default am-btn-xs am-hide-sm-only" name="${item.id}#3" onclick="shenHe(this)"><span class="am-icon-check-square"></span> 接受</a>
							<a href="#" class="am-btn am-btn-default am-btn-xs am-hide-sm-only" name="${item.id }#2" onclick="shenHe(this)"><span class="am-icon-ban"></span> 拒绝</a>
						</c:if>

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