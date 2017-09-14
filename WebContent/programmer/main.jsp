<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>开发人员主页</title>
</head>
<frameset rows="58px,*" frameborder="no">
	<frame src="${pageContext.request.contextPath}/top.jsp"/>
	<frameset cols="300px,*">
		<frame src="${pageContext.request.contextPath}/programmer/left.jsp"/>
		<frame src="${pageContext.request.contextPath }/programmer/index.jsp" name="mainAction"/>
	</frameset>
</frameset>
</html>