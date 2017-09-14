<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>

<link rel="icon" type="image/png" href="assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="assets/css/admin.css">


<script src="${pageContext.request.contextPath}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap-theme.min.css"> 

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.css"/>
<script type="text/javascript">
	


	if(window != top){
		top.location.href = location.href;
	}
</script>



</head>
<body>
<div class="admin-content" style="margin-top: 200px;">
	<div class="admin-content-body">
	  <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户登录</strong> / <small>填写登录信息</small></div>
	  </div>

	  <hr/>
			
		<div class="col-sm-4"></div>
		<div class="col-sm-4">
		<div class="am-g">
		<form class="am-form am-form-horizontal" role="form" id="checkForm" action="${pageContext.request.contextPath}/UserServlet?method=login" method="post">
			<div class="am-form-group">
				<label for="num" class="am-u-sm-3 am-form-label">工号</label>
				<div class="am-u-sm-9">
					<input class="form-control" type="text" name="num" id="num" placeholder="请输入工号">
				</div>
				
			</div>
			<div class="am-form-group">
				<label for="password" class="am-u-sm-3 am-form-label">密码</label>
				<div class="am-u-sm-9">
					<input class="form-control" type="password" name="password" id="password" placeholder="请输入密码">
				</div>

			</div>
			<div class="am-form-group">
				<label for="type" class="am-u-sm-3 am-form-label">登录类型</label>
				<div class="am-u-sm-9">
					<select id="type" name="type" class="am-form-control">
						<option value="1" selected="selected">开发人员</option>
						<option value="2">测试人员</option>
						<option value="3">项目经理</option>
					</select>
				</div>

			</div>

			<div>
				<div class="col-md-9"></div> 
				<div class="col-md-3"> 
					<a href="register.jsp">注册账号</a> 
				</div>
			</div> 
			<div class="am-form-group">
				<div class="col-md-3"></div> 
				<div class="col-md-9"> 
					<button type="submit" class="am-btn am-btn-primary">登录</button>
				</div>
			</div> 

		</form>
		<c:if test="${param.status.equals('1')}">
			<div class="am-alert am-alert-danger" role="alert">用户名不存在</div>
		</c:if>
		<c:if test="${param.status.equals('2')}">
			<div class="am-alert am-alert-danger" role="alert">密码错误</div>
		</c:if>
		<c:if test="${param.status.equals('3')}">
			<div class="am-alert am-alert-danger" role="alert">登录类型与用户类型不匹配</div>
		</c:if>
		<c:if test="${param.status.equals('4')}">
			<div class="am-alert am-alert-success" role="alert">注销成功</div>
		</c:if>
		<c:if test="${param.status.equals('5')}">
			<div class="am-alert am-alert-danger" role="alert">请登录</div>
		</c:if>
		<c:if test="${param.status.equals('6')}">
			<div class="am-alert am-alert-danger" role="alert">没有权限访问指定页面</div>
		</c:if>
		<c:if test="${param.status.equals('7')}">
			<div class="am-alert am-alert-success" role="alert">注册成功</div>
		</c:if>
		<c:if test="${param.status.equals('8')}">
			<div class="am-alert am-alert-danger" role="alert">注册失败</div>
		</c:if>
		</div>
		</div>
		<div class="col-sm-4"></div>
		</div>
	</div>
<script src="static/js/jquery-1.12.1.js"></script>
<script src="assets/js/amazeui.min.js"></script>
<script src="assets/js/app.js"></script>

</body>
</html>