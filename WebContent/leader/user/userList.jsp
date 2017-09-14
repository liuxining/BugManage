<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>


<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">




<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.1.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/js/bootstrap.js"></script>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.css"/>



<script type="text/javascript">

	function upStat(obj){
		
		var name = obj.name;
		
		var names = name.split('#');
		
		if(names[0] == 1){
			alert("不能停用超级管理员");
			return false;
		}
		
		$.get('${pageContext.request.contextPath}/UserServlet?method=upStat&id=' + names[0] + '&status=' + names[1], function(data) {
			if(data != null && data.length > 0){
		
				var datas = data.split("#");
				if(datas[2] == 1){
					if(datas[1] == 2){
						$("#" + datas[0] + "stat").html("已停用");
						$("#" + datas[0] + "upStat").html('<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="' + datas[0] + '#3" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 启用</a>')
					}
					else{
						$("#" + datas[0] + "stat").html("正常");
						$("#" + datas[0] + "upStat").html('<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="' + datas[0] + '#2" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 停用</a>')	
					}
					$("#result").html('<div class="am-alert am-alert-success" role="alert">操作成功</div>')
				}
				else{
					$("#result").html('<div class="am-alert am-alert-danger" role="alert">操作失败</div>')
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
		<div class="col-sm-2"></div>
		<div class="col-sm-8">
			<form class="am-form am-form-horizontal" action="${pageContext.request.contextPath}/UserServlet?method=list" method="post">
				<div class="row-fluid">
					<div class="col-sm-4">
						<select name="type">

							<c:if test="${type == 0 }">
								<option value="0" selected="selected">所有人员</option>
							</c:if>
							
							<c:if test="${type != 0 }">
								<option value="0">所有人员</option>
							</c:if>

							<c:if test="${type == 1 }">
								<option value="1" selected="selected">开发人员</option>
							</c:if>
							
							<c:if test="${type != 1 }">
								<option value="1">开发人员</option>
							</c:if>
							<c:if test="${type == 2 }">
								<option value="2" selected="selected">测试人员</option>
							</c:if>
							
							<c:if test="${type != 2 }">
								<option value="2">测试人员</option>
							</c:if>
							<c:if test="${type == 3 }">
								<option value="3" selected="selected">项目经理</option>
							</c:if>
							
							<c:if test="${type != 3 }">
								<option value="3">项目经理</option>
							</c:if>

						</select>
					</div>
					<div class="col-sm-4">
						<select name="status2">

							<c:if test="${status2 == 0 }">
								<option value="0" selected="selected">所有状态</option>
							</c:if>
							
							<c:if test="${status2 != 0 }">
								<option value="0">所有状态</option>
							</c:if>

							<c:if test="${status2 == 1 }">
								<option value="1" selected="selected">审核中</option>
							</c:if>
							
							<c:if test="${status2 != 1 }">
								<option value="1">审核中</option>
							</c:if>
							<c:if test="${status2 == 2 }">
								<option value="2" selected="selected">停用</option>
							</c:if>
							
							<c:if test="${status2 != 2 }">
								<option value="2">停用</option>
							</c:if>
							<c:if test="${status2 == 3 }">
								<option value="3" selected="selected">正常</option>
							</c:if>
							
							<c:if test="${status2 != 3 }">
								<option value="3">正常</option>
							</c:if>

						</select>
					</div>
					<div class="col-sm-4">
						<button type="submit" class="am-btn am-btn-primary">提交</button>
					</div>
				</div>
			</form>
		</div>
		<div class="col-sm-2"></div>
	</div>
</div>
	
<div class="container-fluid">
	<div class="row-fluid">
	  <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户列表</strong> / <small>
			
			
				<c:if test='${type == 0 }'>
					所有人员
				</c:if>
				<c:if test='${type == 1 }'>
					开发人员
				</c:if>
				<c:if test='${type == 2 }'>
					测试人员
				</c:if>
				<c:if test='${type == 3 }'>
					项目经理
				</c:if>
				列表
			
			</small>
			</div>
	  </div>
		</div>
			<c:if test="${userList != null}">
		<div class="row-fluid">
			<table class="am-table am-table-striped am-table-hover table-main am-table-compact">
				<tr>
					<th>id</th>
					<th>工号</th>
					<th>姓名</th>
					<th>性别</th>
					<th>出生日期</th>
					<th>手机号</th>
					<th>账号类型</th>
					<th>账号状态</th>
					<th>创建日期</th>
					<th colspan="2">操作</th>
				</tr>
				<c:forEach items="${userList}" var="item">
					<tr>
						<td>${item.id}</td>
						<td><a href="${pageContext.request.contextPath}/UserServlet?method=detail&to=leader_user_userDetail&id=${item.id}">${item.num}</a></td>
						<td>${item.name}</td>
						<td>
							<c:if test="${item.sex == 1}">
								男
							</c:if>
							<c:if test="${item.sex == 2}">
								女
							</c:if>
						</td>
						<td>${item.birthDay}</td>
						<td>${item.phone}</td>
						<td>
							<c:if test="${item.type == 1}">
								开发人员
							</c:if>
							<c:if test="${item.type == 2}">
								测试人员
							</c:if>
							<c:if test="${item.type == 3}">
								项目经理
							</c:if>
						</td>

						<td id="${item.id}stat">
							<c:if test="${item.status == 0 || item.status == 1}">
								审核中
							</c:if>
							<c:if test="${item.status == 2}">
								已停用
							</c:if>
							<c:if test="${item.status == 3}">
								正常
							</c:if>
						</td>

						

						<td>${item.createDate}</td>



						<td>
							<div class="am-btn-toolbar">
			                    <div class="am-btn-group am-btn-group-xs">
			                      <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/UserServlet?method=toUpdate&optr=admin&id=${item.id}&type=${type}&status2=${status2}&page=${page}"><span class="am-icon-pencil-square-o"></span> 编辑</a>

			                     <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${pageContext.request.contextPath}/UserServlet?method=delete&id=${item.id}&type=${type}&status2=${status2}&page=${page}" onclick="return confirm('确定删除吗？')"><span class="am-icon-trash-o"></span> 删除</a>
			                    </div>
			                   </div>
			                  </td>
						<td id="${item.id}upStat">
							<div class="am-btn-toolbar">
			                    <div class="am-btn-group am-btn-group-xs">
								<c:if test="${item.status == 0 || item.status == 1}">
									<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="${item.id}#3" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 通过</a>
			               
								</c:if>
			               
								<c:if test="${item.status == 2}">
									<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="${item.id}#3" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 启用</a>
			               
								</c:if>

								<c:if test="${item.status == 3}">
									<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="${item.id}#2" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 停用</a>
			               
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
						
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row-fluid">
				<div class="col-md-3"></div>
				<div class="col-md-6" id="result">
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
						<div class="am-alert am-alert-danger" role="alert">无权操作超级管理员</div>
					</c:if>
				</div>
				<div class="col-md-3"></div>
			</div>
			
			
		</div>
	</c:if>
	</div>
</div>
</div>
</div>
<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>

</body>
</html>