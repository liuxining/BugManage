<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户详细信息</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath }/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/amazeui.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/admin.css">


<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.1.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/js/bootstrap.js"></script>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap-3.3.5-dist/css/bootstrap.css"/>




<script type="text/javascript">

	function upStat(obj){
		
		var name = obj.name;
		
		var names = name.split('#');
		$.get('${pageContext.request.contextPath}/UserServlet?method=upStat&id=' + names[0] + '&status=' + names[1], function(data) {
			if(data != null && data.length > 0){
		
				var datas = data.split("#");
				if(datas[2] == 1){
					if(datas[1] == 2){
						$("#" + data[0] + "stat").html("已停用");
						$("#" + data[0] + "upStat").html('<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="' + datas[0] + '#3" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 启用</a>')
					}
					else{
						$("#" + data[0] + "stat").html("正常");
						$("#" + data[0] + "upStat").html('<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="' + datas[0] + '#2" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 停用</a>')	
					}
					$("#result").html('<div class="am-alert am-alert-success" role="alert">操作成功</div>')
				}
				else{
					$("#result").html('<div class="am-alert am-alert-danger" role="alert">操作失败</div>')
				}
			}
		});
	}
</script>

</head>
<body>

<div class="admin-content">
	<div class="admin-content-body">
<div class="container-fluid">
	
	  <div class="am-cf am-padding am-padding-bottom-0">
	    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户信息</strong> / <small>详细</small></div>
	  </div>

	<div class="row-fluid">
		<table class="am-table am-table-striped am-table-hover table-main am-table-compact">
			<tr>
				<th>工号</th>
				<th>姓名</th>
				<th>性别</th>
				<th>出生日期</th>
				<th>手机号</th>
				<th>账号类型</th>
				<th>账号状态</th>
				<th>创建日期</th>
				<th colspan="2">操作</th>
			</tr>
			<tr>
				<td>${userBean.num}</td>
				<td>${userBean.name}</td>
				<td>
					<c:if test="${userBean.sex == 1}">
						男
					</c:if>
					<c:if test="${userBean.sex == 2}">
						女
					</c:if>
				</td>
				<td>${userBean.birthDay}</td>
				<td>${userBean.phone}</td>
				<td>
					<c:if test="${userBean.type == 1}">
						开发人员
					</c:if>
					<c:if test="${userBean.type == 2}">
						测试人员
					</c:if>
					<c:if test="${userBean.type == 3}">
						项目经理
					</c:if>
				</td>
				<td id="${item.id}stat">
					<c:if test="${item.status == 0 || item.status == 1}">
						审核中
					</c:if>
					<c:if test="${item.status == 2}">
						已停用
					</c:if>
					<c:if test="${item.status == 3}">
						正常
					</c:if>
				</td>
				<td>${userBean.createDate}</td>	

				
						<td>
							<div class="am-btn-toolbar">
			                    <div class="am-btn-group am-btn-group-xs">
			                      <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${pageContext.request.contextPath}/UserServlet?method=toUpdate&optr=admin&id=${item.id}&type=${type}&status2=${status2}&page=${page}"><span class="am-icon-pencil-square-o"></span> 编辑</a>

			                     <a class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" href="${pageContext.request.contextPath}/UserServlet?method=delete&id=${item.id}&type=${type}&status2=${status2}&page=${page}" onclick="return confirm('确定删除吗？')"><span class="am-icon-trash-o"></span> 删除</a>
			                    </div>
			                   </div>
			                  </td>
						<td id="${item.id}upStat">
							<div class="am-btn-toolbar">
			                    <div class="am-btn-group am-btn-group-xs">
								<c:if test="${item.status == 0 || item.status == 1}">
									<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="${item.id}#3" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 通过</a>
			               
								</c:if>
			               
								<c:if test="${item.status == 2}">
									<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="${item.id}#3" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 启用</a>
			               
								</c:if>

								<c:if test="${item.status == 3}">
									<a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="#" name="${item.id}#2" onclick="upStat(this)"><span class="am-icon-pencil-square-o"></span> 停用</a>
			               
								</c:if>
			               



			                    </div>
			                   </div>
						</td>



			</tr>

		</table>



		<c:if test="${userBean.type == 3}">

		  <div class="am-cf am-padding am-padding-bottom-0">
		    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户创建的项目</strong> / <small>列表</small></div>
		  </div>
			
			<div class="row-fluid">

				<form class="am-form am-form-horizontal" action="${pageContext.request.contextPath}/UserServlet?method=detail&to=leader_user_userDetail" method="post">
					
					<input type="hidden" name="id" value="${userBean.id}">

					
					<div class="col-sm-3">
						<select class="form-control" name="type">
							<c:if test="${type == 0 }">
								<option value="0" selected="selected">所有语言</option>
							</c:if>
							
							<c:if test="${type != 0 }">
								<option value="0">所有语言</option>
							</c:if>
							
							<c:if test="${type == 1 }">
								<option value="1" selected="selected">Java</option>
							</c:if>
							
							<c:if test="${type != 1 }">
								<option value="1">Java</option>
							</c:if>
							
							<c:if test="${type == 2 }">
								<option value="2" selected="selected">C++</option>
							</c:if>
							
							<c:if test="${type != 2 }">
								<option value="2">C++</option>
							</c:if>
							
							<c:if test="${type == 3 }">
								<option value="3" selected="selected">PHP</option>
							</c:if>
							
							<c:if test="${type != 3 }">
								<option value="3">PHP</option>
							</c:if>
						</select>
					</div>
					<div class="col-sm-3">
						<select class="form-control" name="status2">
							<c:if test="${status2 == 0 }">
								<option value="0" selected="selected">所有状态</option>
							</c:if>
							
							<c:if test="${status2 != 0 }">
								<option value="0">所有状态</option>
							</c:if>
							
							<c:if test="${status2 == 1 }">
								<option value="1" selected="selected">未开始</option>
							</c:if>
							
							<c:if test="${status2 != 1 }">
								<option value="1">未开始</option>
							</c:if>
							
							<c:if test="${status2 == 2 }">
								<option value="2" selected="selected">进行中</option>
							</c:if>
							
							<c:if test="${status2 != 2 }">
								<option value="2">进行中</option>
							</c:if>
							
							<c:if test="${status2 == 3 }">
								<option value="3" selected="selected">已完成</option>
							</c:if>
							
							<c:if test="${status2 != 3 }">
								<option value="3">已完成</option>
							</c:if>
						</select>
					</div>
					<div class="col-sm-3">
						<button type="submit" class="am-btn am-btn-primary">筛选</button>
					</div>
				</form>
			</div>



			<div class="row-fluid">
				<table class="am-table am-table-striped am-table-hover table-main am-table-compact" id="bugList">
					<c:if test="${projectList != null}">
						<tr>
							<td>编号</td>
							<td>名称</td>
							<td>类型</td>
							<td>状态</td>
							<td>创建日期</td>

							<!-- <td colspan="2">操作</td> -->
						</tr>
						<c:forEach items="${projectList}" var="item">
							<tr>
								<td>${item.id}</td>
								<td><a href="${pageContext.request.contextPath}/ProjectServlet?method=detail&id=${item.id}">${item.name}</a></td>
								<c:if test="${item.type == 1}">
									<td>Java</td>
								</c:if>
								<c:if test="${item.type == 2}">
									<td>C++</td>
								</c:if>
								<c:if test="${item.type == 3}">
									<td>PHP</td>
								</c:if>
								<c:if test="${item.status == 1}">
									<td>未进行</td>
								</c:if>
								<c:if test="${item.status == 2}">
									<td>进行中</td>
								</c:if>
								<c:if test="${item.status == 3}">
									<td>已完成</td>
								</c:if>
								<td>${item.createDate}</td>
								<%-- <td><a href="${pageContext.request.contextPath}/ProjectServlet?method=toUpdate&id=${item.id}">修改</a></td>

								<td><a href="${pageContext.request.contextPath}/ProjectServlet?method=delete&id=${item.id}" onclick="return confirm('确定删除吗？')">删除</a></td>
 --%>
					
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${projectList == null}">
						<div class="row-fluid">
							<div class="col-md-4"></div>
							<div class="col-md-4">
								<div class="am-alert am-alert-danger" role="alert">无</div>
							</div>
							<div class="col-md-4"></div>
						</div>
					</c:if>
				</table>
			</div>
		</c:if>




		<c:if test="${userBean.type == 2}">

		  <div class="am-cf am-padding am-padding-bottom-0">
		    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户提交的Bug</strong> / <small>列表</small></div>
		  </div>
			
			<div class="row-fluid">

				<form class="form-horizontal" action="${pageContext.request.contextPath}/UserServlet?method=detail&to=leader_user_userDetail" method="post">
					
					<input type="hidden" name="id" value="${userBean.id}">

					
					<div class="col-sm-3">
						<select class="form-control" name="level">
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
								<option value="3" selected="selected">重要</option>
							</c:if>
							
							<c:if test="${level != 3 }">
								<option value="3">重要</option>
							</c:if>
						</select>
					</div>
					<div class="col-sm-3">
						<select class="form-control" name="status2">
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
							
							<c:if test="${status2 == 4 }">
								<option value="4" selected="selected">已解决</option>
							</c:if>
							
							<c:if test="${status2 != 4 }">
								<option value="4">已解决</option>
							</c:if>
							
							<c:if test="${status2 == 5 }">
								<option value="5" selected="selected">已关闭</option>
							</c:if>
							
							<c:if test="${status2 != 5 }">
								<option value="5">已关闭</option>
							</c:if>
						</select>
					</div>
					<div class="col-sm-3">
						<select class="form-control" name="projectId">
							<c:if test="${projectId == 0 }">
								<option value="0" selected="selected">所有项目</option>
							</c:if>
							
							<c:if test="${projectId != 0 }">
								<option value="0">所有项目</option>
							</c:if>
							<c:forEach items="${projectList}" var="item">
								<c:if test="${item.id == projectId }">
									<option value="${item.id}" selected="selected">${item.name}</option>
								</c:if>
								<c:if test="${item.id != projectId }">
									<option value="${item.id}">${item.name}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="col-sm-3">
						<button type="submit" class="am-btn am-btn-primary">筛选</button>
					</div>
				</form>
			</div>



			<div class="row-fluid">
				<table class="am-table am-table-striped am-table-hover table-main am-table-compact" id="bugList">
					<c:if test="${bugList != null}">
						<tr>
							<th>BugId</th>
							<th>标题</th>
							<th>等级</th>
							<th>状态</th>
							<th>所属项目</th>
							<th>提交日期</th>
							<!-- <th>操作</th> -->
						</tr>
						<c:forEach items="${bugList}" var="item">
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
								<td>${item.createDate}</td>
								<%-- <td><a href="${pageContext.request.contextPath}/BugServlet?method=toUpdate&id=${item.id}">修改</a></td>
				
								<td><a href="${pageContext.request.contextPath}/BugServlet?method=delete&id=${item.id}" onclick="return confirm('确定删除吗？')">删除</a></td>
				 --%>				
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${bugList == null}">
						<div class="row-fluid">
							<div class="col-md-4"></div>
							<div class="col-md-4">
								<div class="am-alert am-alert-danger" role="alert">空</div>
							</div>
							<div class="col-md-4"></div>
						</div>
					</c:if>
				</table>
			</div>
		</c:if>

		<c:if test="${userBean.type == 1}">

		  <div class="am-cf am-padding am-padding-bottom-0">
		    <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">用户提交的解决方案</strong> / <small>列表</small></div>
		  </div>

			<div class="row-fluid">

				<form class="form-horizontal" action="${pageContext.request.contextPath}/UserServlet?method=detail&to=leader_user_userDetail" method="post">
					<input type="hidden" name="id" value="${userBean.id}"/>
				
					<div class="col-sm-3">
						<select class="form-control" name="level">
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
								<option value="3" selected="selected">重要</option>
							</c:if>
							
							<c:if test="${level != 3 }">
								<option value="3">重要</option>
							</c:if>
						</select>
					</div>

					<div class="col-sm-3">
						<button type="submit" class="am-btn am-btn-primary">筛选</button>
					</div>
				</form>
			</div>

			<div class="row-fluid">

				<form class="form-horizontal" action="${pageContext.request.contextPath}/UserServlet?method=detail&to=leader_user_userDetail" method="post">
					<input type="hidden" name="id" value="${userBean.id}"/>

					<div class="col-sm-3">
						<select class="form-control" name="bugId">
							<c:if test="${bugId == 0 }">
								<option value="0" selected="selected">所有Bug</option>
							</c:if>
							
							<c:if test="${bugId != 0 }">
								<option value="0">所有Bug</option>
							</c:if>
							<c:forEach items="${bugList}" var="item">
								<c:if test="${item.id == bugId }">
									<option value="${item.id}" selected="selected">${item.title}</option>
								</c:if>
								<c:if test="${item.id != bugId }">
									<option value="${item.id}">${item.title}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="col-sm-3">
						<button type="submit" class="am-btn am-btn-primary">筛选</button>
					</div>
				</form>
			</div>


			


			<div class="row-fluid">
				<table class="am-table am-table-striped am-table-hover table-main am-table-compact">
					<c:if test="${handleBugList != null}">
						<tr>
							<th>id</th>
							<th>BugId</th>
							<th>Bug标题</th>
							<th>Bug状态</th>
							<th>Bug等级</th>
							
							<th>解决方案</th>
							<th>提交日期</th>
							<th>是否通过</th>
							
							
						</tr>
						<c:forEach items="${handleBugList}" var="item">
							<tr>
								<td>${item.id}</td>
								<td>${item.bugBean.id}</td>
								<td>${item.bugBean.title}</td>
								<td>
									<c:if test="${item.status == 1}">
										未修复
									</c:if>
									<c:if test="${item.status == 2}">
										<a href="${pageContext.request.contextPath}/BugServlet?method=detail&to=tester_detail&id=${item.id}">待审核</a>
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
									${item.descr}
								</td>
								<td>
									${item.date}
								</td>
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
					</c:if>
					<c:if test="${handleBugList == null}">
						<div class="row-fluid">
							<div class="col-md-4"></div>
							<div class="col-md-4">
								<div class="am-alert am-alert-danger" role="alert">无</div>
							</div>
							<div class="col-md-4"></div>
						</div>
					</c:if>
				</table>
			</div>
		</c:if>

		<div class="row-fluid">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div>
					${pageMsg }
					<%-- <util:page pagingBean="${pagingBean}" /> --%>
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