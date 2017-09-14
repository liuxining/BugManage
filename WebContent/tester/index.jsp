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
        <li><a href="#" class="am-text-success"><span class="am-icon-btn am-icon-file-text"></span><br/>进行中的项目<br/>${projectNoFinCountc}</a></li>
        <li><a href="#" class="am-text-warning"><span class="am-icon-btn am-icon-briefcase"></span><br/>Bug总数量<br/>${bugCountc}</a></li>
        <li><a href="#" class="am-text-danger"><span class="am-icon-btn am-icon-recycle"></span><br/>已解决的Bug数量<br/>${bugFinCountc}</a></li>
        <li><a href="#" class="am-text-secondary"><span class="am-icon-btn am-icon-user-md"></span><br/>解决方案总数量<br/>${handleBugCountc}</a></li>
      </ul>


      <div class="am-g">
        <div class="am-u-sm-12">
          <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">最新发布的Bug</strong> / <small>列表</small></div>
          </div>
          <table class="am-table am-table-bd am-table-striped admin-content-table">
            <thead>
            <tr>
              <th>ID</th><th>Bug标题</th><th>等级</th><th>状态</th><th>所属项目</th><th>发布人</th><th>解决方案数量</th><th>已通过的解决方案数量</th>
            </tr>
            </thead>
            <tbody>

				<c:forEach items="${bugListc}" var="item">
					<tr>
						<td>${item.id}</td>
						<td>${item.title}</td>
						<td>
							<c:if test="${item.level == 1}">
								次要
							</c:if>
							<c:if test="${item.level == 2}">
								一般
							</c:if>
							<c:if test="${item.level == 3}">
								严重
							</c:if>
						</td>
						<td>
							<c:if test="${item.status == 1}">
								未修复
							</c:if>
							<c:if test="${item.status == 2}">
								待审核
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
						<td>${item.projectBean.name}</td>
						<td>${item.userBean.name}</td>
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
      	</div>
		<div class="am-u-sm-6">
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