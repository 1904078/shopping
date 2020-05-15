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
    <link href="${cp}/css/style.css" rel="stylesheet">
    <link rel="icon" href="./favicon.png" type="image/x-icon" />
    <link rel="shortcut icon" href="./favicon.png" type="image/x-icon" />
    <link rel="bookmark" href="./favicon.png" type="image/x-icon" />

    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script src="${cp}/js/html5shiv.min.js"></script>
    <script src="${cp}/js/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${cp}/main">MyShop </a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

            <ul class="nav navbar-nav navbar-right">
                <c:if test="${empty currentUser}">
                    <li><a href="${cp}/register" methods="post">Register</a></li>
                    <li><a href="${cp}/login" methods="post">Login</a></li>
                </c:if>
                <c:if test="${not empty currentUser}">
                    <c:if test="${currentUser.role == 1}">
                        <li><a href="${cp}/control" methods="post">Console</a></li>
                    </c:if>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                ${currentUser.nickName}
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <c:if test="${currentUser.name != 'admin'}">
	                            <li><a href="${cp}/shopping_car">Welcome to the shopping cart</a></li>
                             </c:if>
                            	<li><a href="${cp}/shopping_record">Order status</a></li>
                            <c:if test="${currentUser.role == 1}">
                                <li><a href="${cp}/shopping_handle">Process order</a></li>
                            </c:if>
                            <c:if test="${currentUser.name == 'admin'}">
                             	<li><a href="${cp}/manager">Commodity management</a></li>
	                            <li><a href="${cp}/salelist">Sales record</a></li>
                            </c:if>
                            <li role="separator" class="divider"></li>
                            <li><a href="${cp}/amend_info">Personal data</a></li>
                            <li><a href="${cp}/doLogout">Sign out</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>

            <div class="navbar-form navbar-right hidden">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="数据库" id="searchKeyWord"/>
                </div>
                <button class="btn btn-default" onclick="searchProduct();">查找商品</button>
            </div>
        </div>
    </div>
</nav>
<script type="text/javascript">
    function searchProduct() {
        var search = {};
        search.searchKeyWord = document.getElementById("searchKeyWord").value;
        var searchResult = "";
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/searchPre',
            data : search,
            dataType : 'json',
            success : function(result) {
                searchResult = result.result;
            },
            error : function(result) {
                layer.alert('查询错误');
            }
        });
        if(searchResult == "success")
            window.location.href = "${cp}/search";
    }
</script>

</body>
</html>