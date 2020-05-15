<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Myshop</title>
    <title>Myshop</title>
    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/bootstrap-table.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">
    <link rel="icon" href="./favicon.png" type="image/x-icon" />
    <link rel="shortcut icon" href="./favicon.png" type="image/x-icon" />
    <link rel="bookmark" href="./favicon.png" type="image/x-icon" />
    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap-table.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script src="${cp}/js/html5shiv.min.js"></script>
    <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>

	<jsp:include page="include/header.jsp"/>

<div class="container-fluid bigHead">
    <div class="row">
        <div class="col-sm-10  col-md-10 col-sm-offset-1 col-md-offset-1">
            <div class="">
                <h3>Commodity  order record</h3>
            </div>
			<div class="ibox-body">
				<table id="exampleTable" data-mobile-responsive="true">
				</table>
			</div>
        </div>
    </div>
</div>
<!-- 尾部 -->
<jsp:include page="include/foot.jsp"/>

<script type="text/javascript">

    $(function() {
	var products = null;
	initTable();					
	})
    
function initTable(){
    var $table = $('#exampleTable')
    getTreeData();
 	$table.bootstrapTable({data: products,
		columns : [
			{
				checkbox : true
			},
			{
				field : 'userId',
				title : 'userIds'
			},
			{
				field : 'productId',
				title : 'productId'
			},
			{
				field : 'time',
				title : 'time'
			},
			{
				field : 'orderStatus',
				title : 'status'
			},
			{
				field : 'productPrice',
				title : 'price'
			}]});   	
    }
function getTreeData() {
	$.ajax({
		type : "GET",
		async: false,
		url : "${cp}/manager/getSaleList",
		success : function(data) {
			products = JSON.parse(data.allProducts);
		}
	});
}

function add() {

	layer.open({
		type : 2,
		title : 'Add item',
		maxmin : true,
		shadeClose : false, 	
		area : [ '900px', '520px' ],
		content :'${cp}/manager/add'
	});
}

function addfile(name) {

	layer.open({
		type : 2,
		title : 'add user',
		maxmin : true,
		shadeClose : false, 	
		area : [ '900px', '520px' ],
		content :'${cp}/manager/img?name'+name
	});
}


function remove(i) {
	layer.confirm("confirm delete '" + i + "'data?", {
		btn : [ 'confirm', 'cancel' ]

	}, function() {
		$.ajax({
			type : 'POST',
			data : {
				"id" :i
			},
			url : '${cp}/manager/deleteProduct',
			success : function(r) {
				parent.layer.msg("success");
				window.location.reload();
				if (r.code == 0) {
					layer.msg(r.msg);
					reLoad();
				} else {
					layer.msg(r.msg);
				}
			}
		});
	}, function() {});
}

function batchRemove() {
	var rows = $('#exampleTable').bootstrapTable('getSelections');
	if (rows.length == 0) {
		layer.msg("please choose recode");
		return;
	}
	if (rows.length != 1) {
		layer.msg("Only one row of data can be selected");
		return;
	}
	layer.confirm("confirm delete'" + rows.length + "'data?", {
		btn : [ 'confirm', 'cancel' ]

	}, function() {
		var ids = new Array();

		$.each(rows, function(i, row) {
			ids[i] = row['id'];
		});
		$.ajax({
			type : 'POST',
			data : {
				"id" :rows[0]['id']
			},
			url : '${cp}/manager/deleteProduct',
			success : function(r) {
				parent.layer.msg("success");
				window.location.reload();
				if (r.code == 0) {
					layer.msg(r.msg);
					reLoad();
				} else {
					layer.msg(r.msg);
				}
			}
		});
	}, function() {});
}
</script>
</body>
</html>