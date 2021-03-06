<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/manage/commons/taglibs.jsp"%>
<script src="${vendorsBase}/bootstrap-table/bootstrap-table.min.js"></script>
<script
	src="${vendorsBase}/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<script
	src="${vendorsBase}/bootstrap-table/extensions/treegrid/bootstrap-table-treegrid.js"></script>
<script src="${vendorsBase}/treeGrid/jquery.treegrid.js"></script>
<script
	src="${vendorsBase }/bootstrap-validator/js/bootstrapValidator.min.js"></script>
<script
	src="${vendorsBase }/bootstrap-treeview/bootstrap-treeview.min.js"></script>
<script type="text/javascript">
	var $table = $('#resourcesGrid');
	$(function() {
		/*数据列表*/
		$table.bootstrapTable({
			url : '${ctx}/resources',
			height : $(window).height(),
			striped : true,
			toolbar : '#toolbar',
			search : true,
			showColumns : true,
			height : '100%',
			showRefresh : true,
			showToggle : true,
			//sidePagination: 'server',
			idField : 'id',
			columns : [ {
				field : 'ck',
				checkbox : true
			}, {
				field : 'id',
				title : '资源编号',
				align : 'center'
			}, {
				field : 'title',
				title : '资源名称',
				align : 'center'
			}, {
				field : 'url',
				title : '资源地址',
				align : 'center'
			}, {
				field : 'icon',
				title : 'icon',
				align : 'center'
			}, {
				field : 'state',
				title : '状态',
				align : 'center'
			}, {
				field : 'seq',
				title : '排序',
				align : 'center'
			} ],
			treeShowField : 'title',
			parentIdField : 'pid',
			onLoadSuccess : function(data) {
				console.log(data);
				//jquery.treegrid.js
				$table.treegrid({
					initialState : 'collapsed',
					treeColumn : 2,
					expanderExpandedClass : 'glyphicon glyphicon-minus',
					expanderCollapsedClass : 'glyphicon glyphicon-plus',
					onChange : function() {
						$table.bootstrapTable('resetWidth');
					}
				});
			}
		});
		/*表单验证操作*/
		$('form').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				title : {
					message : '资源名称验证失败',
					validators : {
						notEmpty : {
							message : '资源名称不能为空'
						}
					}
				}
			}
		});
		/*下拉树型结构*/
		$.ajax({
			type : "Post",
			url : "${ctx}/resources?op=treeView&id=0",
			dataType : "json",
			success : function(result) {
				$('#treeview').treeview({
					data : result, // 数据源
					//showCheckbox : true, //是否显示复选框
					highlightSelected : true, //是否高亮选中
					//nodeIcon: 'glyphicon glyphicon-user',    //节点上的图标
					//nodeIcon : 'glyphicon glyphicon-globe',
					emptyIcon : '', //没有子节点的节点图标
					multiSelect : false, //多选
					levels : 1,
					onNodeChecked : function(event, data) {
						//alert(data.id);
					},
					onNodeSelected : function(event, data) {
						$("#pid").empty();
						$("#pid").append("<option value='"+data.id+"'>"+data.text+"</option>");
						$("#treeview").hide();
					}
				});
			},
			error : function() {
				alert("树形结构加载失败！")
			}
		});
		//结束 
		//触发文本框事件
		$("#pid").click(function() {
			$("#treeview").show();
		});
		//失去焦点的时候
		$("#treeview").blur(function(){
			$("#treeview").hide();
		});
		//结束 
	});

	// 格式化类型
	/*  function typeFormatter(value, row, index) {
	   if (value === 'menu') {
	     return '菜单';
	   }
	   if (value === 'button') {
	     return '按钮';
	   }
	   if (value === 'api') {
	     return '接口';
	   }
	   return '-';
	 } */

	// 格式化状态
	/* function statusFormatter(value, row, index) {
	  if (value === 1) {
	    return '<span class="label label-success">正常</span>';
	  } else {
	    return '<span class="label label-default">锁定</span>';
	  } 
	}*/
</script>
