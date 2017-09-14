<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册</title> 


<link rel="icon" type="image/png" href="assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="assets/css/admin.css">





<script type="text/javascript">
	function checkDup(){
		var inputNum = $("#num").val();

		$.get('${pageContext.request.contextPath}/UserServlet?method=checkDup&num=' + inputNum, function(data) {
			if(data != null && data.length > 0){
				if(data == "0"){

					$("#msg").html('<div class="am-alert am-alert-success" role="alert">工号可用</div>');
					$("#submitBtn").removeAttr('disabled');
				}
				else{
					$("#msg").html('<div class="am-alert am-alert-danger" role="alert">工号不可用</div>');
					$("#submitBtn").attr({
						"disabled": true
					});
				}
			}
		});
	}
</script>




</head>
<body>


<div class="admin-content">
	<div class="admin-content-body">
	  <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">注册用户</strong> / <small>填写个人信息</small></div>
	  </div>

	  <hr/>


          <form class="am-form am-form-horizontal" id="checkForm" role="form" action="${pageContext.request.contextPath}/UserServlet?method=register" method="post">
           <!--  <div class="row-fluid">
            	<div class="col-md-4"></div>
            	<div class="col-md-4" id="msg"></div>
            	<div class="col-md-4"></div>
            </div> -->
            <div class="am-form-group">
              <label for="num" class="am-u-sm-3 am-form-label">工号</label>
              <div class="am-u-sm-6">
                <input type="text" class="am-form-field" id="num" name="num" placeholder="工号" value="${updateBean.num }" onchange="checkDup()">
              </div>
              <div class="am-u-sm-3" id="msg"></div>
            </div>

            <div class="am-form-group">
              <label for="password" class="am-u-sm-3 am-form-label">密码</label>
              <div class="am-u-sm-6">
                <input type="password" id="password" name="password" placeholder="密码">
              </div>
              <div class="am-u-sm-3"></div> 
            </div>

            <div class="am-form-group">
              <label for="password2" class="am-u-sm-3 am-form-label">确认密码</label>
              <div class="am-u-sm-6">
                <input type="password" id="password2" name="password2" placeholder="确认密码">
              </div>
              <div class="am-u-sm-3"></div> 
            </div>


			<div class="am-form-group">
				<label for="type" class="am-u-sm-3 am-form-label">账号类型</label>
				<div class="am-u-sm-6">
					<c:if test='${updateBean != null && optr.equals("user")}'>
						<input type="hidden" name="type" value="${updateBean.type }"/>
						<c:if test="${updateBean.type == 1}">
							开发人员
						</c:if>
						<c:if test="${updateBean.type == 2}">
							测试人员
						</c:if>
						<c:if test="${updateBean.type == 3}">
							项目经理
						</c:if>
					</c:if>
					<c:if test='${updateBean == null || optr.equals("admin")}'>
						<select id="type" name="type" class="am-form-control">
						
								
							<c:if test="${updateBean.type == 1}">
								<option value="1" selected="selected">开发人员</option>
							</c:if>
							<c:if test="${updateBean.type != 1}">
								<option value="1">开发人员</option>
							</c:if>
							<c:if test="${updateBean.type == 2}">
								<option value="2" selected="selected">测试人员</option>
							</c:if>
							<c:if test="${updateBean.type != 2}">
								<option value="2">测试人员</option>
							</c:if>
							<c:if test="${updateBean.type == 3}">
								<option value="3" selected="selected">项目经理</option>
							</c:if>
							<c:if test="${updateBean.type != 3}">
								<option value="3">项目经理</option>
							</c:if>
						
						
							
						</select>
					</c:if>
				</div>
				<div class="am-u-sm-3"></div> 
			</div>

			<div class="am-form-group">
				<label for="name" class="am-u-sm-3 am-form-label">姓名</label>
				<div class="am-u-sm-6">
					<input type="text" name="name" id="name" placeholder="请输入姓名" value="${updateBean.name}">
				</div>
				<div class="am-u-sm-3"></div> 
			</div>


			<div class="am-form-group">
				<label for="birthDay" class="am-u-sm-3 am-form-label">出生日期</label>
				<div class="am-u-sm-6">
	                <div class="am-form-group am-form-icon">
	                  <i class="am-icon-calendar"></i>
	                  <input type="date" class="am-form-field am-input-sm" id="birthDay" name="birthDay" placeholder="出生日期" value="${updateBean.birthDay }">
	                </div>
				</div>
				<div class="am-u-sm-3"></div> 
			</div>			

			<div class="am-form-group">
				<label for="phone" class="am-u-sm-3 am-form-label">手机号</label>
				<div class="am-u-sm-6">
					<input type="text" name="phone" id="phone" placeholder="请输入手机号" value="${updateBean.phone}">
				</div>
				<div class="am-u-sm-3"></div> 
			</div>

			<div class="am-form-group">
	            <div class="am-u-sm-3 am-text-right">性别</div>
	            <div class="am-u-sm-6">
	              <div class="am-btn-group" data-am-button>
	                <label class="am-btn am-btn-default am-btn-xs">
	                  <c:if test="${updateBean == null || updateBean.sex == 1 }">
	                  	<input type="radio" value="1" name="sex" id="option1" checked="checked"> 男
	                  </c:if>
	                  <c:if test="${updateBean != null && updateBean.sex != 1 }">
	                  	<input type="radio" value="1" name="sex" id="option1"> 男
	                  </c:if>
	                </label>
	                <label class="am-btn am-btn-default am-btn-xs">
	                  <c:if test="${updateBean != null && updateBean.sex == 2 }">
	                  	<input type="radio" value="2" name="sex" id="option2" checked="checked"> 女
	                  </c:if>
	                  <c:if test="${updateBean.sex != 2 }">
	                  	<input type="radio" value="2" name="sex" id="option2"> 女
	                  </c:if>
	                </label>
	                
	              </div>
	            </div>
	            <div class="am-u-sm-3"></div> 
			</div>


			<div class="am-form-group">
				<label for="phone" class="am-u-sm-3 am-form-label"></label>
				<div class="am-u-sm-6">
					<c:if test="${updateBean == null && param.optr == null }">
						<a href="login.jsp">已有账号，点此登录</a> 
					</c:if>				
				</div>
				<div class="am-u-sm-3"></div> 
			</div>
			
			<input type="hidden" name="id" value="${updateBean.id }"/>
			<input type="hidden" name="optr" value="${param.optr }">
			<input type="hidden" name="type2" value="${type }">
			<input type="hidden" name="status2" value="${status2 }">
			<input type="hidden" name="page2" value="${page }">
			
			
			
			<div class="am-form-group">
				<div class="am-u-sm-6 am-u-sm-push-3">
					<button type="submit" class="am-btn am-btn-primary" disabled="disabled" id="submitBtn">提交</button>
					
				</div>
			</div>







           </form>

			<div class="am-u-sm-9 am-u-sm-push-3">
				<c:if test="${param.status.equals('3')}">
					<div class="am-alert am-alert-danger" role="alert">添加成功</div>
				</c:if>
				<c:if test="${param.status.equals('8')}">
					<div class="am-alert am-alert-danger" role="alert">注册失败</div>
				</c:if>
			</div>
          </div>
         </div>
<script src="static/js/jquery-1.12.1.js"></script>
<script src="assets/js/amazeui.min.js"></script>
<script src="assets/js/app.js"></script>

<script src="${pageContext.request.contextPath}/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/my.js"></script>

</body>
</html>