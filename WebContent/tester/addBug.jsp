<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发布Bug</title>


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

<script type="text/javascript"> 
	var editor = new UE.ui.Editor();
	editor.render("descr"); 
</script>
</head>
<body>

<div class="admin-content">
	<div class="admin-content-body">
	  <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">发布Bug</strong> / <small>填写Bug信息</small></div>
	  </div>

<div class="container" style="margin-top: 65px;">
	<!-- <div class="col-md-2"></div> -->
	<!-- <div class="col-md-12"> -->
		
	
		<form class="am-form-horizontal" id="checkForm" role="form" action="${pageContext.request.contextPath}/BugServlet?method=add" method="post">
			<div class="am-form-group am-u-md-12">
				<label for="projectId" class="am-u-md-2 am-form-label">所在项目：</label>
				<div class="am-u-md-10">
					<select class="form-control" name="projectId" id="projectId">
						<option value="0">---请选择所在项目---</option>
						<c:forEach items="${projectList}" var="item">
							<c:if test="${updateBean != null && updateBean.id == updateBean.id }">
								<option value="${item.id} " selected="selected">${item.name}</option>
							</c:if>
							<c:if test="${updateBean == null || updateBean.id != updateBean.id }">
								<option value="${item.id} ">${item.name}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="am-form-group am-u-md-12">
				<label for="title" class="am-u-md-2 am-form-label">标题：</label>
				<div class="am-u-md-10">
					<input class="am-form-field" type="text" name="title" id="title" placeholder="请输入标题" value="${updateBean.title}">
				</div>
			</div>
			<div class="am-form-group am-u-md-12">
				<label for="level" class="am-u-md-2 am-form-label">等级：</label>
				<div class="am-u-md-10">
					<select class="form-control" name="level" id="level">
						<c:if test="${updateBean.level == 1}">
							<option value="1" selected="selected">次要</option>
						</c:if>
						<c:if test="${updateBean.level != 1}">
							<option value="1">次要</option>
						</c:if>
						<c:if test="${updateBean.level == 2}">
							<option value="2" selected="selected">一般</option>
						</c:if>
						<c:if test="${updateBean.level != 2}">
							<option value="2">一般</option>
						</c:if>
						<c:if test="${updateBean.level == 3}">
							<option value="3" selected="selected">严重</option>
						</c:if>
						<c:if test="${updateBean.level != 3}">
							<option value="3">严重</option>
						</c:if>
						
					</select>
				</div>
			</div>




			<div class="am-form-group am-u-md-12">
				<label for="descr" class="am-u-md-2 am-form-label">描述:</label>
				<div class="am-u-md-10" style="width:800px;margin:20px auto 40px;">
					<textarea name="descr" id="descr">${updateBean.descr}</textarea >
	            </div>
			</div>
			
			<input type="hidden" name="id" value="${updateBean.id }" />
			<input type="hidden" name="projectId2" value="${projectId }" />
			<input type="hidden" name="level2" value="${level }" />
			<input type="hidden" name="status2" value="${status2 }" />
			<input type="hidden" name="page2" value="${page }" />
			<input type="hidden" name="userId2" value="${userId }" />


			<div class="am-form-group am-u-md-12">
				<div class="am-u-md-offset-3 am-u-md-4">
					<button type="submit" class="am-btn am-btn-primary am-btn-block">提交</button>
				</div>
			</div>

		</form>
</div>
<div class="container">
	<div class="col-md-4">
	</div>
	<div class="col-md-4">
		<c:if test='${param.status.equals("1")}'>
			<div class="am-alert am-alert-success" role="alert">添加成功</div>
		</c:if>
		
		<c:if test='${param.status.equals("2")}'>
			<div class="am-alert am-alert-success" role="alert">添加失败</div>
		</c:if>
	</div>
	<div class="col-md-4">
	</div>		
	<!-- </div> -->
	<!-- <div class="col-md-2"></div> -->
</div>


<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>


</body>
</html>