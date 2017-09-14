<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bug详情</title>


<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">


<style type="text/css">
	.toshow {display:block;}
</style>
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


<script type="text/javascript">
	function showNext(page){
		var pass = $("#pass").val();
		$.getJSON('${pageContext.request.contextPath}/HandleBugServlet', {'method': 'testerBugDetailHandleBugList','bugId':'${bugBean.id}','page':page,'pass':pass}, function(json, textStatus) {
					var content = "<tr><th>id</th><th>提交人员</th><th>提交时Bug等级</th><th>修复信息</th><th>修复日期</th><th>是否通过</th></tr>";
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
							content += item.date + '</td><td>';
							if(item.pass == 1){
								content += '审核中';
							}
							else if(item.pass == 2){
								content += '未通过';
							}
							else{
								content += '通过';
							}
							content += '</td></tr>';


							
						});
					$("#debugDiv").css('display', 'block');
					$("#debugTable").empty();
					$("#debugTable").html(content);
					$("#pageDiv").html(json.pageMsg);
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
<div class="container-fluid" style="overflow: auto;">
	<div class="row-fluid">
			<div class="am-cf am-padding am-padding-bottom-0">
	        	<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">Bug</strong> / <small>详情</small></div>
	      </div>
		</div>
	<div class="row-fluid">
		
		<table class="am-table am-table-striped am-table-hover table-main am-table-compact">
			<tr>
				<th>编号</th>
				<th>标题</th>
				<th>等级</th>
				<th>状态</th>
				<th>创建者</th>
				
				<th>所属项目</th>
				<th>创建日期</th>
			</tr>
			<tr>
				<td>${bugBean.id}</td>
				<td>${bugBean.title}</td>
				<c:if test="${bugBean.level == 1}">
					<td>次要</td>
				</c:if>
				<c:if test="${bugBean.level == 2}">
					<td>一般</td>
				</c:if>
				<c:if test="${bugBean.level == 3}">
					<td>严重</td>
				</c:if>
				<c:if test="${bugBean.status == 1}">
					<td>未修复</td>
				</c:if>
				<c:if test="${bugBean.status == 2}">
					<td>待审核</td>
				</c:if>
				<c:if test="${bugBean.status == 3}">
					<td>未通过</td>
				</c:if>
				<c:if test="${bugBean.status == 4}">
					<td>已解决</td>
				</c:if>
				<c:if test="${bugBean.status == 5}">
					<td>已关闭</td>
				</c:if>
				
				<td>${bugBean.userBean.name}</td>
				<td>${bugBean.projectBean.name}</td>
				<td>${bugBean.createDate}</td>
				
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
	</div>

<!-- 		<div class="row-fluid" id="descrDiv" style="display:none;">
			 <article>
				<h5>描述</h5>
	        	 ${bugBean.descr}
		 	</article>
		</div> -->
		<div class="container">
			<div class="row-fluid">
				<form class="am-form-horizontal" action="${pageContext.request.contextPath}/HandleBugServlet?method=handleBug" method="post">
					<div class="am-form-group">
						<label for="descr" class="col-md-2 am-form-label">修复：</label>
						<div class="col-md-10" style="width:800px;margin:20px auto 40px;">
							<textarea name="descr" id="descr">${updateBean.descr }</textarea >
			            </div>
					</div>
					
					<input type="hidden" name="bugId" value="${bugBean.id }" />
					<input type="hidden" name="level" value="${bugBean.level }" />
					<input type="hidden" name="status" value="${bugBean.status }" />
					<input type="hidden" name="bugId2" value="${bugId }" />
					<input type="hidden" name="pass2" value="${pass }" />
					<input type="hidden" name="page2" value="${page }" />
					<input type="hidden" name="userId2" value="${userId }" />
					<input type="hidden" name="id" value="${updateBean.id }" />
		
		
					<div class="am-form-group">
						<div class="col-md-offset-3 col-md-3">
							<button type="submit" class="am-btn am-btn-primary am-btn-block">提交</button>
						</div>
					</div>
						
					
					
				</form>
			</div>
		</div>
		<div class="container">
			<div class="row-fluid">
				<c:if test='${param.status.equals("1")}'>
					<div class="am-alert am-alert-success" role="alert">添加成功</div>
				</c:if>
				<c:if test='${param.status.equals("2")}'>
					<div class="am-alert am-alert-success" role="alert">添加失败</div>
				</c:if>
			</div>
		</div>
		
		<div class="container">
		
			<div class="col-sm-3">
				<select class="form-control" name="pass" id="pass">
					<c:if test="${pass == 0 }">
						<option value="0" selected="selected">所有状态</option>
					</c:if>
					
					<c:if test="${pass != 0 }">
						<option value="0">所有状态</option>
					</c:if>
					<c:if test="${pass == 1 }">
						<option value="1" selected="selected">未审核</option>
					</c:if>
					
					<c:if test="${pass != 1 }">
						<option value="1">未审核</option>
					</c:if>
					<c:if test="${pass == 2 }">
						<option value="2" selected="selected">未通过</option>
					</c:if>
					
					<c:if test="${pass != 2 }">
						<option value="2">未通过</option>
					</c:if>
					<c:if test="${pass == 3 }">
						<option value="3" selected="selected">通过</option>
					</c:if>
					
					<c:if test="${pass != 3 }">
						<option value="3">通过</option>
					</c:if>
				</select>
			</div>
			<div class="col-md-3">
				<button type="button" class="am-btn am-btn-primary" onclick="showNext(0)">查看修复提交记录</button>
			</div>
			<div class="col-md-3"></div>
	</div>
	<div class="container" id="debugDiv" style="display: none;">
		<div class="row-fluid">
			<div class="am-cf am-padding am-padding-bottom-0">
	        	<div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">解决方案</strong> / <small>列表</small></div>
	      </div>
		</div>
		
		


		<div class="row-fluid">
			<table class="am-table am-table-striped am-table-hover table-main am-table-compact" id="debugTable">

			</table>
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
</div>
<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>

</body>
</html>