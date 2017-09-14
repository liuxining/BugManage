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
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/js/bootstrap.js"></script>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.css"/>





<script type="text/javascript">
	function showNext(page){
			var level = $("#level").val();
			var status2 = $("#status2").val();
			$.getJSON('${pageContext.request.contextPath}/BugServlet', {"method": 'list','projectId':'${projectBean.id}',"level":level,"status2":status2,"respType":"typeJson","page":page}, function(json, textStatus) {
					 var content = '<tr><td>编号</td><td>标题</td><td>等级</td><td>状态</td><td>提交人员</td><td>创建日期</td></tr>';
						
					 	$.each(json.bugBean, function(index, item) {
							
					 	
						 	content += '<tr><td>' + item.id + '</td><td>';
						 	content += '<a href="${pageContext.request.contextPath}/BugServlet?method=detail&id=' + item.id + '&to=tester_detail">' + item.title + '</a></td><td>';
							if(item.level == 1){
								content += '次要';
							}
							else if(item.level == 2){
								content += '一般';
							}
							else{
								content += '严重';
							}
							content += '</td><td>';
							if(item.status == 1){
								content += '未修复';
							}
							else if(item.status == 2){
								content += '待审核';
							}
							else if(item.status == 3){
								content += '未通过';
							}
							else if(item.status == 4){
								content += '已解决';
							}
							else{
								content += '已关闭';
							}
							content += '</td><td>' + item.userBean.name;
							content += '</td><td>' + item.createDate;
							content += '</td></tr>';
					 	});
 						$("#bugListTable").empty();
						$("#bugListDiv").css('display', 'block');
						$("#bugListTable").html(content);
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
<div class="container-fluid">
	  <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">项目详情</strong> / <small>信息</small></div>
	  </div>
	<div class="row-fluid">
		<table class="am-table am-table-striped am-table-hover table-main am-table-compact">
			<tr>
				
				<th>编号</th>
				<th>名称</th>
				<th>类型</th>
				<th>状态</th>
				<th>已发布的Bug总数</th>
				<th>已解决的Bug总数</th>
				<th>解决方案总数</th>
				<th>通过的解决方案总数</th>
				<th>创建日期</th>

				<th>操作</th>
			</tr>
			<tr>
				<td>${projectBean.id}</td>
				<td>${projectBean.name}</td>
				<c:if test="${projectBean.type == 1}">
					<td>Java</td>
				</c:if>
				<c:if test="${projectBean.type == 2}">
					<td>C++</td>
				</c:if>
				<c:if test="${projectBean.type == 3}">
					<td>PHP</td>
				</c:if>
				<c:if test="${projectBean.status == 1}">
					<td>未进行</td>
				</c:if>
				<c:if test="${projectBean.status == 2}">
					<td>进行中</td>
				</c:if>
				<c:if test="${projectBean.status == 3}">
					<td>已完成</td>
				</c:if>
				<td>${bugCount}</td>
				<td>${bugFinCount}</td>
				<td>${handleBugCount}</td>
				<td>${handleBugPassCount}</td>
				<td>${projectBean.createDate}</td>
				<td>
					<div class="am-btn-toolbar">
	                    <div class="am-btn-group am-btn-group-xs">
	                      <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/ProjectServlet?method=toUpdate&id=${projectBean.id}"><span class="am-icon-pencil-square-o"></span> 编辑</a>
	                
						  <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${pageContext.request.contextPath}/ProjectServlet?method=delete&id=${projectBean.id}" onclick="return confirm('确定删除吗？')"><span class="am-icon-trash-o"></span> 删除</a>
	                    </div>
                 	</div>

				</td>
				
			</tr>

		</table>

		<hr>


		<div class="container">
			<div class="row-fluid">
				<div class="col-md-2">
					<button type="button" class="am-btn am-btn-primary am-btn-block" id="descrCtrl" onclick="toggleShow()">显示详细描述</button>
				</div>
				<div class="col-md-10" id="descrDiv" style="display:none;">
					<article>
						<h5>描述</h5>
			        	 ${projectBean.descr}
				 	</article>
				</div>
				
			</div>
		</div>

		<hr>
		
		
		<button type="button" class="am-btn am-btn-primary" onclick="showNext(0)">查看该项目已发布的Bug</button>
	</div>
	<div class="row-fluid" id="bugListDiv" style="display: none;">
		 <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">Bug</strong> / <small>列表</small></div>
	  </div>

		<div class="row-fluid">
			<div class="col-sm-3">
				<select class="form-control" name="level" id="level">
					<c:if test="${level == 0 }">
						<option value="0" selected="selected">所有Bug等级</option>
					</c:if>
					<c:if test="${level != 0 }">
						<option value="0">所有Bug等级</option>
					</c:if>
					<c:if test="${level == 1 }">
						<option value="1" selected="selected">次要</option>
					</c:if>
					<c:if test="${level != 1 }">
						<option value="1">次要</option>
					</c:if>
					<c:if test="${level == 2 }">
						<option value="2" selected="selected">一般</option>
					</c:if>
					<c:if test="${level != 2 }">
						<option value="2">一般</option>
					</c:if>
					<c:if test="${level == 3 }">
						<option value="3" selected="selected">严重</option>
					</c:if>
					<c:if test="${level != 3 }">
						<option value="3">严重</option>
					</c:if>
				</select>
			</div>
			<div class="col-sm-3">
				<select class="form-control" name="status2" id="status2">
					<c:if test="${status2 == 0 }">
						<option value="0" selected="selected">所有Bug状态</option>
					</c:if>
					<c:if test="${status2 != 0 }">
						<option value="0">所有Bug状态</option>
					</c:if>
					<c:if test="${status2 == 1 }">
						<option value="1" selected="selected">未修复</option>
					</c:if>
					<c:if test="${status2 != 1 }">
						<option value="1">未修复</option>
					</c:if>
					<c:if test="${status2 == 2 }">
						<option value="4" selected="selected">已解决</option>
					</c:if>
					<c:if test="${status2 != 2 }">
						<option value="4">已解决</option>
					</c:if>
					<c:if test="${status2 == 3 }">
						<option value="5" selected="selected">已关闭</option>
					</c:if>
					<c:if test="${status2 != 3 }">
						<option value="5">已关闭</option>
					</c:if>
					
				</select>
			</div>
			<div class="col-sm-3">
				<button type="button" class="am-btn am-btn-primary" onclick="showNext(0)">筛选</button>
			</div>
		</div>

		<div class="row-fluid">
			<table class="am-table am-table-striped am-table-hover table-main am-table-compact" id="bugListTable">
				
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
</div></div>
<script src="${pageContext.request.contextPath }/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/app.js"></script>


</body>
</html>