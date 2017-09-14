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
        <li><a href="${pageContext.request.contextPath}/BugServlet?method=list&to=tester_listBug" target="mainAction" class="am-text-warning"><span class="am-icon-btn am-icon-briefcase"></span><br/>未解决的Bug数量<br/>${bugNoFinCountc}</a></li>
        <li><a href="${pageContext.request.contextPath}/HandleBugServlet?method=leaderListHandleBugList&to=leader_listHandleBug" target="mainAction" class="am-text-danger"><span class="am-icon-btn am-icon-recycle"></span><br/>解决方案总数量<br/>${handleBugCountc}</a></li>
        <li><a href="${pageContext.request.contextPath}/HandleBugServlet?method=leaderListHandleBugList&to=leader_listHandleBug" target="mainAction" class="am-text-danger"><span class="am-icon-btn am-icon-recycle"></span><br/>我的解决方案总数量<br/>${handleBugMyCountc}</a></li>
        <li><a href="${pageContext.request.contextPath}/HandleBugServlet?method=leaderListHandleBugList&to=leader_listHandleBug" target="mainAction" class="am-text-danger"><span class="am-icon-btn am-icon-recycle"></span><br/>我的解决方案通过的数量<br/>${handleBugMy3Countc}</a></li>
      </ul>

      <div class="am-g">
        <div class="am-u-sm-12">
          <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">最新的解决方案</strong> / <small>列表</small></div>
          </div>
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
            <tr>
              <th>ID</th><th>BugId</th><th>Bug标题</th><th>解决方案提交人</th><th>提交信息</th><th>是否通过</th>
            </tr>
            </thead>
            <tbody>

				<c:forEach items="${handleBugListc}" var="item">
					<tr>
						<td>${item.id}</td>
						<td>${item.bugBean.id}</td>
						<td>${item.bugBean.title}</td>
						<td>${item.userBean.name}</td>
						<td>${item.descr}</td>
						<td>
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
						

					</tr>
				</c:forEach>

            </tbody>
          </table>
        </div>
      </div>

      <div class="am-g">  
        <div class="am-u-sm-6">
          <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">解决方案</strong> / <small>统计汇总</small></div>
          </div>
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
              <tr>
                <th>解决方案总数</th><th>审核中</th><th>未通过</th><th>通过</th>
              </tr>
            </thead>
            <tbody>
              <tr><td>${handleBugCountc}</td><td>${handleBug1Countc}</td><td>${handleBug2Countc}</td><td>${handleBug3Countc}</td></tr>
            </tbody>
          </table>
        </div>
        <div class="am-u-sm-6">
          <div class="am-cf am-padding">
          <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">我的解决方案</strong> / <small>统计汇总</small></div>
        </div>
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
              <tr>
                <th>我的解决方案总数</th><th>审核中</th><th>未通过</th><th>通过</th>
              </tr>
            </thead>
            <tbody>
              <tr><td>${handleBugMyCountc}</td><td>${handleBugMy1Countc}</td><td>${handleBugMy2Countc}</td><td>${handleBugMy3Countc}</td></tr>
            </tbody>
          </table>
        </div>
      </div>


  </div>
 </div>
  <!-- content end -->
</body>
</html>