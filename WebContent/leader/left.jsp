<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>



<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">




<!-- 导入jQuery文件 -->
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.12.1.js"></script>




</head>
<body style="margin-top: 0px;">


  <!-- sidebar start -->
 <!-- <div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar"> -->
<div class="admin-content">
    <div class="admin-content-body">
      <ul class="am-list admin-sidebar-list">
        <li><a href="${pageContext.request.contextPath }/CollectServlet?method=toLeaderIndex&to=leader_index" target="mainAction"><span class="am-icon-home"></span> 首页</a></li>
        <li class="admin-parent">
          <a class="am-cf" data-am-collapse="{target: '#collapse-nav'}"><span class="am-icon-bug"></span> 项目管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
          <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav">
            <li><a href="addProject.jsp" class="am-cf" target="mainAction"><span class="am-icon-upload"></span> 发布项目<span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
            <li><a href="${pageContext.request.contextPath}/ProjectServlet?method=list&to=leader_listProject" target="mainAction"><span class="am-icon-puzzle-piece"></span> 查看所有项目</a></li>
            
          </ul>
        </li>
        <li><a href="${pageContext.request.contextPath}/BugServlet?method=list&to=tester_listBug" target="mainAction"><span class="am-icon-table"></span> 查看Bug</a></li>

        <li><a href="${pageContext.request.contextPath}/HandleBugServlet?method=leaderListHandleBugList&to=listHandleBug" target="mainAction"><span class="am-icon-table"></span> 查看解决方案</a></li>

        <li class="admin-parent">
          <a class="am-cf" data-am-collapse="{target: '#collapse-nav2'}"><span class="am-icon-user"></span> 人员管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
          <ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav2">
            <li><a href="../register.jsp?optr=admin" class="am-cf" target="mainAction"><span class="am-icon-user-plus"></span> 添加人员<span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
            <li><a href="${pageContext.request.contextPath}/UserServlet?method=list&type=0" target="mainAction"><span class="am-icon-list"></span> 查看所有人员</a></li>

            <li><a href="${pageContext.request.contextPath}/UserServlet?method=list&type=0&status2=1" target="mainAction"><span class="am-icon-puzzle-piece"></span> 审核人员</a></li>
            
          </ul>
        </li>


        <li><a href="${pageContext.request.contextPath}/UserServlet?method=detail&to=userInfo&id=${loginUserBean.id}" target="mainAction"><span class="am-icon-table"></span> 个人信息</a></li>
        
        <li><a href="${pageContext.request.contextPath}/UserServlet?method=logout" target="_top"><span class="am-icon-sign-out"></span> 注销</a></li>
      </ul>

      


   </div>
  </div>
  <!-- sidebar end -->
<script src="${pageContext.request.contextPath }/static/js/jquery-1.12.1.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>


</body>
</html>