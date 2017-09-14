<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加项目</title>

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
<div class="row-fluid" style="margin-top: 20px;">
	<!-- <div class="col-md-2"></div> -->
	<div class="col-md-10">
		<div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">发布项目</strong> / <small>填写项目信息</small></div>
	  </div>
	  
	  	<hr>
		
	
		<form class="am-form am-form-horizontal" role="form" action="${pageContext.request.contextPath}/ProjectServlet?method=add" method="post">
			<div class="am-form-group">

				<label for="name" class="col-md-3 am-form-label">项目名称</label>
				<div class="col-md-9">
					<input class="am-form-field" type="text" name="name" id="name" placeholder="请输入项目名称" value="${updateBean.name}">
				</div>
			</div>
			<div class="am-form-group">

				<label for="status" class="col-md-3 am-form-label">状态</label>
				<div class="col-md-9">
					<select id="status" name="status">
						<c:if test="${updateBean.status == 1}">
							<option value="1" selected="selected">未进行</option>
						</c:if>
						<c:if test="${updateBean.status != 1}">
							<option value="1">未进行</option>
						</c:if>
						<c:if test="${updateBean.status == 2}">
							<option value="2" selected="selected">进行中</option>
						</c:if>
						<c:if test="${updateBean.status != 2}">
							<option value="2">进行中</option>
						</c:if>
						<c:if test="${updateBean.status == 3}">
							<option value="3" selected="selected">已完成</option>
						</c:if>
						<c:if test="${updateBean.status != 3}">
							<option value="3">已完成</option>
						</c:if>
					</select>
				</div>
			</div>

			<div class="am-form-group">

				<label for="type" class="col-md-3 am-form-label">类型</label>
				<div class="col-md-9">
					<select id="type" name="type">
						<c:if test="${updateBean.type == 1}">
							<option value="1" selected="selected">Java</option>
						</c:if>
						<c:if test="${updateBean.type != 1}">
							<option value="1">Java</option>
						</c:if>
						<c:if test="${updateBean.type == 2}">
							<option value="2" selected="selected">C++</option>
						</c:if>
						<c:if test="${updateBean.type != 2}">
							<option value="2">C++</option>
						</c:if>
						<c:if test="${updateBean.type == 3}">
							<option value="3" selected="selected">PHP</option>
						</c:if>
						<c:if test="${updateBean.type != 3}">
							<option value="3">PHP</option>
						</c:if>
					</select>
				</div>
			</div>

			<div class="am-form-group">
				<label for="descr" class="am-u-md-2 am-form-label">描述:</label>
				<div class="am-u-md-10" style="width:800px;margin:20px auto 40px;">
					<textarea name="descr" id="descr">${updateBean.descr}</textarea >
	            </div>
			</div>
			
			<input type="hidden" name="id" value="${updateBean.id}" />
			<input type="hidden" name="type2" value="${type}" />
			<input type="hidden" name="status2" value="${status2}" />
			<input type="hidden" name="userId2" value="${userId}" />
			<input type="hidden" name="page2" value="${page}" />

			<div class="am-form-group">
				<div class="col-md-offset-3 col-md-9">
					<button type="submit" class="am-btn am-btn-primary am-btn-block">添加</button>
				</div>
			</div>

		</form>

		<c:if test='${param.status.equals("1")}'>
			<div class="am-alert am-alert-success" role="alert">添加成功</div>
		</c:if>
		<c:if test='${param.status.equals("2")}'>
			<div class="am-alert am-alert-success" role="alert">添加失败</div>
		</c:if>
		

	</div>
	<div class="col-md-3"></div>
</div>
</div>
</div>
<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>

</body>
</html>