<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人信息</title>


<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">



<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.1.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap-theme.min.css"> 

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.css"/>


<link href="${pageContext.request.contextPath}/static/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet"> 
<script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/ueditor.config.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/ueditor.all.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/lang/zh-cn/zh-cn.js"></script> 

</head>
<body>
<div class="admin-content">
	<div class="admin-content-body">
<div class="container-fluid">
	
	  <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">个人基本信息</strong> / <small>个人信息</small></div>
	  </div>

	<div class="row-fluid">
		<table class="table table-striped">
			<tr>
				<th>工号</th>
				<th>姓名</th>
				<th>性别</th>
				<th>出生日期</th>
				<th>手机号</th>
				<th>账号类型</th>
				<th>创建日期</th>
			</tr>
			<tr>
				<td>${userBean.num}</td>
				<td>${userBean.name}</td>
				<td>
					<c:if test="${userBean.sex == 1}">
						男
					</c:if>
					<c:if test="${userBean.sex == 2}">
						女
					</c:if>
				</td>
				<td>${userBean.birthDay}</td>
				<td>${userBean.phone}</td>
				<td>
					<c:if test="${userBean.type == 1}">
						开发人员
					</c:if>
					<c:if test="${userBean.type == 2}">
						测试人员
					</c:if>
					<c:if test="${userBean.type == 3}">
						项目经理
					</c:if>
				</td>
				<td>${userBean.createDate}</td>	
			</tr>

		</table>
		<div class="row-fluid">
			<div class="col-md-8"></div>
			<div class="col-md-4">
				<button type="button" data-toggle="modal" data-target="#myModal" class="am-btn am-btn-primary">修改个人信息</button>
				
			</div>
				
		</div>

		<div class="row-fluid">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<c:if test="${param.status.equals('1')}"> 
					<div class="am-alert am-alert-success" role="alert">
						修改成功
					</div>
				</c:if>
			</div>
			<div class="col-md-4"></div>
				
		</div>
		
	</div>

</div>


	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel">
						修改个人信息
					</h4>
				</div>
				<div class="modal-body">
				
				
					<form class="am-form-horizontal" action="${pageContext.request.contextPath}/UserServlet?method=register&optr=user&to=tester_userInfo" method="post" id="checkForm">
						<div class="am-form-group">
							<label class="col-md-3 am-form-label" for="phone">手机号</label>
							<div class="col-md-9">
								<input class="am-form-field" name="phone" id="phone" type="text" id="account" placeholder="手机号" value="${userBean.phone }"/>
				            </div>
				        </div>
						<div class="am-form-group">
							<label class="col-md-3 am-form-label" for="name">姓名</label>
							<div class="col-md-9">
								<input type="text" name="name" class="am-form-field" id="name" placeholder="姓名" value="${userBean.name }">
						    </div>
						</div>

						<div class="am-form-group">
							<label for="birthDay" class="col-md-3 am-form-label">出生日期</label>
							<div class="col-md-9">
				                <div class="am-form-group am-form-icon">
				                  <i class="am-icon-calendar"></i>
				                  <input type="date" class="am-form-field am-input-sm" name="birthDay" placeholder="出生日期">
				                </div>
							</div>
							 
						</div>

						<div class="am-form-group">
							<label class="col-md-3 am-form-label" for="password">新密码</label>
							<div class="col-md-9">
								<input type="password" name="password" class="am-form-field" id="password" placeholder="Password">
						    </div>
						</div>
						<div class="am-form-group">
							<label class="col-md-3 am-form-label" for="password2">确认密码</label>
							<div class="col-md-9">
								<input type="password" name="password2" class="am-form-field" id="password2" placeholder="Password">
						    </div>
						</div>

							
						<input type="hidden" id="id" name="id" value="${userBean.id }">

						<div class="modal-footer">
							<button type="button" class="am-btn am-btn-default" data-dismiss="modal">关闭
							</button>
							<button type="submit" class="am-btn am-btn-primary">
								提交更改
							</button>
						</div>
					</form>
								
				</div>
				
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>






</div>
</div>
<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>

</body>
</html>