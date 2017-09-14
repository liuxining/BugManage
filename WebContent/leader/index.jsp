<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>主页</title>

<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">

</head>
<body>
  <!-- content start -->
  <div class="admin-content">
    <div class="admin-content-body">
      <div class="am-cf am-padding">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">首页</strong> / <small>统计汇总</small></div>
      </div>

      <ul class="am-avg-sm-1 am-avg-md-4 am-margin am-padding am-text-center admin-content-list ">
        <li><a href="${pageContext.request.contextPath}/ProjectServlet?method=list&to=leader_listProject" target="mainAction" class="am-text-success"><span class="am-icon-btn am-icon-file-text"></span><br/>项目数量<br/>${projectCountc}</a></li>
        <li><a href="${pageContext.request.contextPath}/BugServlet?method=list&to=tester_listBug" target="mainAction" class="am-text-warning"><span class="am-icon-btn am-icon-briefcase"></span><br/>Bug数量<br/>${bugCountc}</a></li>
        <li><a href="${pageContext.request.contextPath}/HandleBugServlet?method=leaderListHandleBugList&to=listHandleBug" target="mainAction" class="am-text-danger"><span class="am-icon-btn am-icon-recycle"></span><br/>解决方案数量<br/>${handleBugCountc}</a></li>
        <li><a href="${pageContext.request.contextPath}/UserServlet?method=list&type=0" target="mainAction" class="am-text-secondary"><span class="am-icon-btn am-icon-user-md"></span><br/>用户数量<br/>${userCountc}</a></li>
      </ul>

      <div class="am-g">
        <div class="am-u-sm-12">
          <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">最新发布的项目</strong> / <small>列表</small></div>
          </div>
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
            <tr>
              <th>ID</th><th>项目名</th><th>语言</th><th>状态</th><th>Bug总数量</th><th>已解决的Bug数量</th><th>已关闭的Bug数量</th><th>解决方案数量</th><th>已通过的解决方案数量</th>
            </tr>
            </thead>
            <tbody>

				<c:forEach items="${projectListc}" var="item">
					<tr>
						<td>${item.id}</td>
						<td>${item.name}</td>
						<td>
							<c:if test="${item.type == 1}">
								Java
							</c:if>
							<c:if test="${item.type == 2}">
								C++
							</c:if>
							<c:if test="${item.type == 3}">
								PHP
							</c:if>
						</td>
						<td>
							<c:if test="${item.status == 1}">
								未进行
							</c:if>
							<c:if test="${item.status == 2}">
								进行中
							</c:if>
							<c:if test="${item.status == 3}">
								已完成
							</c:if>
						</td>
						<td>${item.bugCount}</td>
						<td>${item.bugFinCount}</td>
						<td>${item.bugCloseCount}</td>
						<td>${item.handleBugCount}</td>
						<td>${item.handleBugPassCount}</td>
						

					</tr>
				</c:forEach>

            </tbody>
          </table>
        </div>
      </div>

      <div class="am-g">
        <div class="am-u-sm-6">
          <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户</strong> / <small>统计汇总</small></div>
          </div>
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
            <tr>
              <th>用户类型</th><th>总人数</th><th>正常</th><th>停用</th><th>待审核</th>
            </tr>
            </thead>
            <tbody>
				<tr><td>项目经理</td><td>${userLeaderCountc}</td><td>${userLeader3Countc}</td><td>${userLeader2Countc}</td><td>${userLeader1Countc}</td></tr>
				<tr><td>测试人员</td><td>${userTesterCountc}</td><td>${userTester3Countc}</td><td>${userTester2Countc}</td><td>${userTester1Countc}</td></tr>
				<tr><td>开发人员</td><td>${userProgrammerCountc}</td><td>${userProgrammer3Countc}</td><td>${userProgrammer2Countc}</td><td>${userProgrammer1Countc}</td></tr>
				<tr><td>总计</td><td>${userCountc}</td><td>${user3Countc}</td><td>${user2Countc}</td><td>${user1Countc}</td></tr>

            </tbody>
          </table>
        </div>

        <div class="am-u-sm-6">
          <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">项目</strong> / <small>统计汇总</small></div>
          </div>
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
            <tr>
              <th>项目总数</th><th>未开始</th><th>正在进行</th><th>已完成</th>
            </tr>
            </thead>
            <tbody>
				<tr><td>${projectCountc}</td><td>${project1Countc}</td><td>${project2Countc}</td><td>${project3Countc}</td></tr>

            </tbody>
          </table>
          
          <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">Bug</strong> / <small>统计汇总</small></div>
          </div>
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
            <tr>
              <th>Bug总数</th><th>未解决</th><th>已解决</th><th>已关闭</th>
            </tr>
            </thead>
            <tbody>
				<tr><td>${bugCountc}</td><td>${bug1Countc}</td><td>${bug4Countc}</td><td>${bug5Countc}</td></tr>

            </tbody>
          </table>


          <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">解决方案</strong> / <small>统计汇总</small></div>
          </div>
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
            <tr>
              <th>解决方案总数</th><th>未审核</th><th>未通过</th><th>通过</th>
            </tr>
            </thead>
            <tbody>
				<tr><td>${handleBugCountc}</td><td>${handleBug1Countc}</td><td>${handleBug2Countc}</td><td>${handleBug3Countc}</td></tr>

            </tbody>
          </table>
        </div>
      </div>


  </div>
 </div>
  <!-- content end -->
</body>
</html>