<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
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
</head>
<body>
<div class="wrapper wrapper-content ">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" id="signupForm" method="post"  enctype="multipart/form-data">
							<div class="form-group">
								<label class="col-sm-3 control-label">Commodity name:</label>
								<div class="col-sm-8">
									<input id="name" name="name" class="form-control" type="text">
									<input id="keyWord" name="keyWord" class="form-control" type="hidden" value="">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Product Description:</label>
								<div class="col-sm-8">
									<input id="description" name="description" class="form-control"
										type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Price:</label>
								<div class="col-sm-8">
									<input id="price" name="price" class="form-control"
										type="">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-3 control-label">Quantity:</label>
								<div class="col-sm-8">
									<input id="counts" name="counts" class="form-control"
										type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-3 control-label">Commodity classification:</label>
								<div class="col-sm-8">
									<select class="form-control" id="type" name="type" >
								      <option value="1">Electronics</option>
								      <option value="2">Cosmetics</option>
								      <option value="3">Books</option>
								    </select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-3 control-label">Product image:</label>
								 <div class="col-sm-4">
	                                <input id="file" name="file" type="file">
	                            </div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-8 col-sm-offset-3">
									<button type="submit" class="btn btn-primary" onclick="save()">Submit</button>
								</div>
							</div>
							
							
							<div class="form-group">
								<div class="col-sm-8 col-sm-offset-3">
									<button type="submit" class="btn btn-primary" onclick="saveimg()">Upload file</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	function save() {
		$("#keyWord").val($("#name").val());
		$.ajax({
			cache : true,
			type : "POST",
			url : "${cp}/manager/addProduct",
			data : $('#signupForm').serialize(),
			async : false,
			error : function(request) {
				parent.layer.alert("Network Timeout");
			},
			success : function(data) {
				if (data.result == "success") {
					parent.layer.msg("Operation successful");
					window.location.reload();
				} else {
					parent.layer.alert("Operation failed");
				}

			}
		});

	}
	function saveimg() {
		$.ajax({
			cache : true,
			type : "POST",
			url : "${cp}/manager/uploadFile",
			data : $('#signupForm').serialize(),
			async : false,
			error : function(request) {
				parent.layer.alert("Network Timeout");
			},
			success : function(data) {
				if (data.result == "success") {
					parent.layer.msg("Operation successful");
					window.location.reload();
				} else {
					parent.layer.alert("Operation failed");
				}

			}
		});

	}
	function validateRule() {
		var icon = "<i class='fa fa-times-circle'></i> ";
		$("#signupForm").validate({
			rules : {
				name : {
					required : true
				}
			},
			messages : {
				name : {
					required : icon + "Enter name"
				}
			}
		})
	}
	</script>

</body>
</html>