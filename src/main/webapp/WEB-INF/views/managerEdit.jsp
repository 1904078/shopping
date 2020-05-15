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
<div class="wrapper wrapper-content ">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form class="form-horizontal m-t" id="signupForm">
							<input id="userId" name="userId" type="hidden">
							<div class="form-group">
								<label class="col-sm-3 control-label">Name:</label>
								<div class="col-sm-8">
									<input id="name" name="name" class="form-control" type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Username：</label>
								<div class="col-sm-8">
									<input id="username" name="username" class="form-control"
										type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Password：</label>
								<div class="col-sm-8">
									<input id="password" name="password" class="form-control"
										type="password">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">department：</label>
								<div class="col-sm-8">
									<input id="deptId" name="deptId" class="hidden"> <input
										id="deptName" name="deptName" class="form-control" type="text"
										style="cursor: pointer;" onclick="openDept()"
										readonly="readonly" placeholder="department">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">E-mail：</label>
								<div class="col-sm-8">
									<input id="email" name="email" class="form-control"
										type="email">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-8 col-sm-offset-3">
									<button type="submit" class="btn btn-primary">submit</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

	</div>

</body>
</html>