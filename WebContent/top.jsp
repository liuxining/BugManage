<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    

<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">

<header class="am-topbar am-topbar-inverse admin-header">
  <div class="am-topbar-brand">
    <strong>Bug管理系统</strong> <small>
		<c:if test="${loginUserBean.type == 1}">
			开发人员
		</c:if>
		<c:if test="${loginUserBean.type == 2}">
			测试人员
		</c:if>
		<c:if test="${loginUserBean.type == 3}">
			项目经理
		</c:if>


    主页</small>
  </div>

  <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>

  <div class="am-collapse am-topbar-collapse" id="topbar-collapse">

    <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
      <li><a href="${pageContext.request.contextPath}/UserServlet?method=detail&to=userInfo&id=${loginUserBean.id}" target="mainAction"><span class="am-icon-envelope-o"></span> 个人信息 <span></span></a></li>
      <li><a href="${pageContext.request.contextPath}/UserServlet?method=detail&to=userInfo&id=${loginUserBean.id}" target="mainAction"><span class="am-icon-envelope-o"></span> ${loginUserBean.name}</a></li>
      <li><a href="${pageContext.request.contextPath}/UserServlet?method=logout" target="_top"><span class="am-icon-power-off"></span> 退出</a></li>
      
    </ul>
  </div>
</header>
<script src="${pageContext.request.contextPath }/static/js/jquery-1.12.1.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>

