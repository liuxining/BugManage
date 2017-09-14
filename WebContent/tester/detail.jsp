<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bug详情</title>

<style type="text/css">
	.toshow {display:block;}
</style>

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





<script type="text/javascript">

	
	function showNext(page){
		var pass = $("#pass").val();
		
		var userId = $("#userId").val();
			$.getJSON('${pageContext.request.contextPath}/HandleBugServlet', {'method': 'testerBugDetailHandleBugList','bugId':'${bugBean.id}','pass':pass,'userId':userId,'page':page}, function(json, textStatus) {
					var content = "<tr><th>id</th><th>提交人员</th><th>提交时Bug等级</th><th>修复信息</th><th>修复日期</th><th>是否通过</th><th>审核</th></tr>";
					$.each(json.handleBug, function(index, item) {
							content += '<tr><td>' + item.id + '</td><td>';
							 content += item.userBean.name + '</td><td>';
							 if(item.level == 1){
								content += '次要';
							}
							else if(item.level == 2){
								content += '一般';
							}
							else{
								content += '严重';
							}
							content += '</td><td>' + item.descr + '</td><td>';
							content += item.date + '</td><td id="' + item.id + '">';
							if(item.pass == 1){
								content += '审核中';
							}
							else if(item.pass == 2){
								content += '未通过';
							}
							else{
								content += '通过';
							}
							content += '</td><td>';
							content += '<a href="#" class="am-btn am-btn-default am-btn-xs am-hide-sm-only" name="' + item.id + '#3" onclick="shenHe(this)"><span class="am-icon-check-square"></span> 接受</a><a href="#" class="am-btn am-btn-default am-btn-xs am-hide-sm-only" name="' + item.id + '#2" onclick="shenHe(this)"><span class="am-icon-ban"></span> 拒绝</a></td></tr>';

							
						});
					$("#debugDiv").css('display', 'block');
					$("#debugTable").empty();
					$("#debugTable").html(content);
					$("#pageDiv").html(json.pageMsg);
			});

			

	}	
	
	function shenHe(obj){
		var msg = obj.name;
		var str = msg.split('#');
		
		$.get('${pageContext.request.contextPath}/HandleBugServlet?method=shenHe&id=' + str[0] + '&pass=' + str[1], function(data) {
			if(str[1] == 2){
				$("#" + str[0]).html('未通过');
			}
			else{
				$("#" + str[0]).html('通过');	
			}
		});
	}

	function handleBug(obj){
		var name = obj.name;
		var id = ${bugBean.id};
		$.get('${pageContext.request.contextPath}/BugServlet?method=handleBug&id=${bugBean.id}&status=' + name, function(data) {
			if(data != null && data.length > 0){
				datas = data.split('#');
				if(datas[1] == 1){
					if(datas[0] == 4){
						$("#result").html('<div class="am-alert am-alert-success">解决成功</div>');
						$("#" + id).html("已解决");
					}
					else{
						$("#result").html('<div class="am-alert am-alert-success">关闭成功</div>');
						$("#" + id).html("已关闭");
					}
				}
				else{
					if(datas[0] == 4){
						$("#result").html('<div class="am-alert am-alert-success">解决失败</div>');
					}
					else{
						$("#result").html('<div class="am-alert am-alert-success">关闭失败</div>');	
					}	
				}
			}
		});
	}




	function toggleShow(){
		var display = $("#descrDiv").css('display');
		if(display == 'none'){
			$("#descrDiv").css('display','block');
			$("#descrCtrl").html("隐藏详细描述")
		}
		else{
			$("#descrDiv").css('display','none');
			$("#descrCtrl").html("查看详细描述")	
		}
	}	


	
</script>




</head>
<body>


<div class="admin-content">
	<div class="admin-content-body">
<div class="container-fluid">
	  <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">Bug详情</strong> / <small>信息</small></div>
	  </div>

	<div class="row-fluid">
		
		<table class="am-table am-table-striped am-table-hover table-main am-table-compact">
			<tr>
				<th>编号</th>
				<th>标题</th>
				<th>等级</th>
				<th>状态</th>
				<th>创建者</th>
				<th>解决方案数量</th>
				<th>通过的解决方案数量</th>
				<th>未通过的解决方案数量</th>
				<th>待审核的解决方案数量</th>
				<th>所属项目</th>
				<th>创建日期</th>
				<th>操作</th>
			</tr>
			<tr>
				<td>${bugBean.id}</td>
				<td>${bugBean.title}</td>
				<td>
					<c:if test="${bugBean.level == 1}">
						次要
					</c:if>
					<c:if test="${bugBean.level == 2}">
						一般
					</c:if>
					<c:if test="${bugBean.level == 3}">
						严重
					</c:if>
				</td>
				<td id="${bugBean.id}">
				<c:if test="${bugBean.status == 1}">
					未修复
				</c:if>
				<c:if test="${bugBean.status == 2}">
					待审核
				</c:if>
				<c:if test="${bugBean.status == 3}">
					未通过
				</c:if>
				<c:if test="${bugBean.status == 4}">
					已解决
				</c:if>
				<c:if test="${bugBean.status == 5}">
					已关闭
				</c:if>
				
				</td>
				
				<td>${bugBean.userBean.name}</td>
				<td>${handleBugCount}</td>
				<td>${handleBug3Count}</td>
				<td>${handleBug2Count}</td>
				<td>${handleBug1Count}</td>
				<td>${bugBean.projectBean.name}</td>
				<td>${bugBean.createDate}</td>
				<td>
					<div class="am-btn-toolbar">
	                    <div class="am-btn-group am-btn-group-xs">
	                      <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/BugServlet?method=toUpdate&id=${bugBean.id}"><span class="am-icon-pencil-square-o"></span> 编辑</a>
	               
						<a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${pageContext.request.contextPath}/BugServlet?method=delete&id=${bugBean.id}" onclick="return confirm('确定删除吗？')"><span class="am-icon-trash-o"></span> 删除</a>
						
						<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="4" onclick="handleBug(this)"><span class="am-icon-square-o"></span> 解决</a>
			
						<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="5" onclick="handleBug(this)"><span class="am-icon-square-o"></span> 关闭</a>


						</div>
					</div>
				</td>
				
			</tr>
			
				
		</table>
		<div class="container">
			<div class="row-fluid">
				<div class="col-md-2">
					<button type="button" class="am-btn am-btn-primary am-btn-block" id="descrCtrl" onclick="toggleShow()">显示详细描述</button>
				</div>
				<div class="col-md-10" id="descrDiv" style="display:none;">
					<article>
						<h5>描述</h5>
			        	 ${bugBean.descr}
				 	</article>
				</div>
				
			</div>
		</div>
		<hr>
		
		<div class="container">
			<div class="col-md-4">

				<button type="button" class="am-btn am-btn-primary" onclick="showNext(0)">查看修复提交记录</button>			
				
			</div>
			<div class="col-md-4" id="result">
				
			</div>

			<div class="col-md-4">
				
			</div>

			

		</div>

		
	</div>
	
</div>


<div class="container-fluid">
	<hr>
<div id="debugDiv" style="display: none;">
	<div class="container-fluid">
			
			<div class="row-fluid">
				<div class="col-sm-3">
					<select name="pass" id="pass" class="form-control">
						<option value="0">全部</option>
						<option value="1">审核中</option>
						<option value="2">未通过</option>
						<option value="3">通过</option>
					</select>
				</div>
				<div class="col-sm-3">
					<select name="userId" id="userId" class="form-control">
						<option value="0">所有人员</option>
						<c:forEach items="${userList }" var="item">
							<option value="${item.id }">${item.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-sm-3">
					<button type="button" class="am-btn am-btn-primary am-btn-block" onclick="showNext(0)">提交</button>
				</div>
				<div class="col-sm-3"></div>
			</div>
	</div>
		
	<hr>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="am-cf am-padding am-padding-bottom-0">
	        	<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">解决方案</strong> / <small>列表</small></div>
	      </div>
		</div>
			
	
	
			<div class="row-fluid">
				<table class="am-table am-table-striped am-table-hover table-main am-table-compact" id="debugTable">
	
				</table>
			</div>
	</div>
	
	
	
	
	
	<div class="row-fluid">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<div id="pageDiv">
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>

</div>
</div>
</div>

<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>


	

</body>
</html>