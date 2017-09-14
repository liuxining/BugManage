$().ready(function(){
	//自定义验证规则
	/*
	 * 参数依次为（验证方法名，验证规则函数，验证未通过的提示信息）
	 */
	
	//自定义工号验证
	$.validator.addMethod("num",function(value,element){
		// var emailReg = /.*@.*\.?.*?\.(com|cn)$/;//email的正则表达式，任意字符@任意字符.非贪婪模式匹配字符  以.com|cn结尾
		var numReg = /[0-9]{4,9}/;//手机号的正则表达式，^[1]以1开始，后为[34578]中的一个，再后接9个0-9之间的数
		return this.optional(element) || (numReg.test(value))//optional用于验证该element是否为可选的，如果为可选的则直接返回true,否则用正则表达式测试该元素的value值，
	},"请正确填写您的工号");
	
	
	//自定义手机号格式验证
	$.validator.addMethod("phone",function(value,element){
		var phoneReg = /^[1][34578][0-9]{9}/;//手机号的正则表达式，^[1]以1开始，后为[34578]中的一个，再后接9个0-9之间的数
		return this.optional(element) || (phoneReg.test(value))//optional用于验证该element是否为可选的，如果为可选的则直接返回true,否则用正则表达式测试该元素的value值，
	},"请正确填写您的手机号");
	
	
	//自定义用户名密码格式验证
	$.validator.addMethod("userpwd",function(value,element){
		var usernameReg = /^[a-zA-Z0-9_][a-zA-Z0-9_]{3,9}$/;//用户名的正则表达式，^[a-zA-Z0-9_]代表以字母或数字或下划线开始，[a-zA-Z0-9_]{3,9}$代表后面为3-9个字母或数字或下划线，并以字母或数字或下划线结尾
		return this.optional(element) || (usernameReg.test(value))
	},"请正确填写您的用户名/密码");
	//为表单设置验证规则
	$("#checkForm").validate({
		errorElement:'span',//验证错误将错误信息放在span标签
		errorClass:'help-block',//错误信息标签的class
		focusInvalid:false,//设置为通过的表单元素不获得焦点
		rules:{
			// codeCheck:{
			// 	required:true,//必填
			// 	equalTo:"#checkCode"//需要与id为checkCode的元素的值相等
			// },
			password2:{
				required:true,//必填
				equalTo:"#password"//需要与id为inputPassword的元素的值相等
			},
			num:{
				required:true,
				num:true//需要通过自定义的验证方法usernp
			},
			password:{
				required:true,
				userpwd:true
			},
			

			name:{
				required:true,
				rangelength:[2,15]//需要验证长度为2-15之间
			},
			title:{
				required:true,
				rangelength:[2,30]//需要验证长度为2-15之间
			},
			projectId:{
				min:1,//最小值为1
			},
			age:{
				required:true,//验证是否为整数
				digits:true,//验证是否为整数
				min:1,//最小值为0
				max:150
			},
			phone:{
				required:true,
				phone:true
			},
			
			descr:{
				required:true,
			},
			
		},
		//自定义验证未通过的提示语句
		messages:{
			age:{
				required:"请填写年龄",
				digits:"年龄必须为整数",
				min:"最小为1",
				max:"最大为150"
			},
			password:{
				required : "密码为空",
				userpwd:"密码格式不正确，4-10位数字/字母/下划线"
			},
			password2:{
				required : "确认密码为空",
				equalTo:"两次输入不一致"
			},
			phone:{
				required:"请输入手机号",
				phone:"请输入正确的手机号"
			},
			name:{
				required: "请输入姓名",
				rangelength: "姓名必须为2-30个字符"
			},
			title:{
				required:"请输入标题",
				rangelength:"标题必须为2-30个字符"//需要验证长度为2-15之间
			},
			projectId: {
				min:"请选择项目",
			},
			num:{
				required : "请输入工号",
				num:"工号必须为4-9位数字"
			},
			
			
			descr: {
				required: "请输入描述",
			}			
		},
		//为未通过的元素添加css特效，即未通过的元素都会调用此方法
		higelight:function(element){
			$(element).closest('.form-group').addClass('has-error');//获得element的最近的class为form-group的祖先元素，并为祖先元素添加名为has-error的class
		},
		
		//验证通过的元素会调用此方法
		success:function(label){
			//获得label的最近的class为form-group的祖先元素，并为祖先元素删除名为has-error的class
			label.closest('.form-group').removeClass('has-error');
			//删除该元素
			label.remove();
		},
		//定义将错误标签放到哪里
		errorPlacement:function(error,element){
			element.parent('div').append(error);	//追加到错误标签的父元素
		}
		
	});
	
});
