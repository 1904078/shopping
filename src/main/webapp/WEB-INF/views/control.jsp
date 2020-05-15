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
    <link rel="icon" href="./favicon.png" type="image/x-icon" />
    <link rel="shortcut icon" href="./favicon.png" type="image/x-icon" />
    <link rel="bookmark" href="./favicon.png" type="image/x-icon" />    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">

    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/ajaxfileupload.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>

    <!--[if lt IE 9]>
      <script src="${cp}/js/html5shiv.min.js"></script>
      <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<jsp:include page="include/header.jsp"/>


<div class="container-fluid">
    <div class="row">

        <div class="col-sm-3 col-md-2 sidebar sidebar-1">
            <ul class="nav nav-sidebar">
                <li class="list-group-item-diy"><a href="#section1">View users<span class="sr-only">(current)</span></a></li>
                <li class="list-group-item-diy"><a href="#section2">View goods</a></li>
                <li class="list-group-item-diy"><a href="#section3">Add  goods</a></li>
            </ul>
        </div>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="col-md-12">
                <h1><a name="section1">User information</a></h1>
                <hr/>
                <table class="table table-hover center" id="userTable">
                </table>
            </div>

            <div class="col-md-12">
                <hr/>
                <h1><a name="section2">Goods information</a></h1>
                <hr/>
                <div class="col-lg-12 col-md-12 col-sm-12" id="productArea"></div>
                <br/>
            </div>

            <div class="col-md-12">
                <hr/>
                <h1><a name="section3">Add  goods</a></h1>
                <hr/>
                <div class="col-sm-offset-2 col-md-offest-2">

                    <div  class="form-horizontal">
                        <div class="form-group">
                            <label for="productName" class="col-sm-2 col-md-2 control-label">Goods name</label>
                            <div class="col-sm-6 col-md-6">
                                <input type="text" class="form-control" id="productName" placeholder="T-shirt" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productDescribe" class="col-sm-2 col-md-2 control-label">Goods description</label>
                            <div class="col-sm-6 col-md-6">
                                <textarea type="text" class="form-control" id="productDescribe" placeholder="This is a T-shirt"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="keyWord" class="col-sm-2 col-md-2 control-label">KeyWorlds</label>
                            <div class="col-sm-6 col-md-6">
                                <textarea type="text" class="form-control" id="keyWord" placeholder="T-shirt,man,leisure time"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productPrice" class="col-sm-2 col-md-2 control-label">Goods Price</label>
                            <div class="col-sm-6 col-md-6">
                                <input type="text" class="form-control" id="productPrice" placeholder="399" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productCount" class="col-sm-2 col-md-2 control-label">Goods number</label>
                            <div class="col-sm-6 col-md-6">
                                <input type="text" class="form-control" id="productCount" placeholder="100" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productType" class="col-sm-2 col-md-2 control-label">Goods Type</label>
                            <div class="col-sm-6 col-md-6">
                                <select name="productType" class="form-control" id="productType">
                                    <option value="1">Electronics</option>
                                    <option value="2">Cosmetics</option>
                                    <option value="3">Books</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productImgUpload" class="col-sm-2 col-md-2 control-label" accept="image/jpg">Goods image</label>
                            <div class="col-sm-6 col-md-6">
                                <input name="productImgUpload" type="file"  id="productImgUpload"/>
                                <p class="help-block">The size of should be 280 * 160</p>
                            </div>
                            <button class="btn btn-primary col-sm-2 col-md-2" onclick="fileUpload()">upload image</button>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-6" id="imgPreSee">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-6">
                                <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="addProduct()">Add Goods</button>
                            </div>
                        </div>
                    </div>
                    <br/>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 尾部 -->
<jsp:include page="include/foot.jsp"/>
<script type="text/javascript">

    var loading = layer.load(0);
    listAllUser();
    listAllProduct();
    layer.close(loading);
    //列出所有用户
    function listAllUser() {
        var userTable = document.getElementById("userTable");
        var allUser = getAllUsers();
        userTable.innerHTML = '<tr>'+
            '<th> User ID </th>'+
            '<th> User Name</th>'+
            '<th> NickName</th>'+
            '<th> Email</th>'+
            '<th> Delete or not</th>'+
            '</tr>';
        var html = "";
        for(var i=0;i<allUser.length;i++){
            html += '<tr>'+
                '<td>'+allUser[i].id+'</td>'+
                '<td>'+allUser[i].name+'</td>'+
                '<td>'+allUser[i].nickName+'</td>'+
                '<td>'+allUser[i].email+'</td>'+
                '<td>'+
                '<button class="btn btn-primary btn-sm" type="submit" onclick="deleteUser('+allUser[i].id+')">delete</button>'+
                '</td>'+
                '</tr>';
        }
        userTable.innerHTML += html;
    }

    function getAllUsers() {
        var allUsers = "";
        var nothing = {};
        $.ajax({
            async : false, //设置同步
            type : 'POST',
            url : '${cp}/getAllUser',
            data : nothing,
            dataType : 'json',
            success : function(result) {
                if (result!=null) {
                    allUsers = result.allUsers;
                }
                else{
                    layer.alert('Query all user errors');
                }
            },
            error : function(resoult) {
                layer.alert('Query all user errors');
            }
        });
        allUsers = eval("("+allUsers+")");
        return allUsers;
    }


    function listAllProduct() {
        var productArea = document.getElementById("productArea");
        var allProduct = getAllProducts();
        var html="";
        productArea.innerHTML = '';
        for(var i=0;i<allProduct.length;i++){
            var imgURL = "${cp}/img/"+allProduct[i].imgname;
            html+='<div class="col-sm-4 col-md-4 pd-5">'+
                '<div class="boxes">'+
                '<div class="big bigimg">'+
                '<img src="'+imgURL+'">'+
                '</div>'+
                '<p class="font-styles center">'+allProduct[i].name+'</p>'+
                '<p class="pull-right">价格：'+allProduct[i].price+'</p>'+
                '<p class="pull-left">库存：'+allProduct[i].counts+'</p>'+
                '<div class = "row">'+
                '<button class="btn btn-primary delete-button" type="submit" onclick="deleteProduct('+allProduct[i].id+')">delete goods</button>'+
                '</div>'+
                '</div>'+
                '</div>';
        }
        productArea.innerHTML+=html;
    }
    //列出所有商品

    function getAllProducts() {
        var allProducts = null;
        var nothing = {};
        $.ajax({
            async : false, //设置同步
            type : 'POST',
            url : '${cp}/getAllProducts',
            data : nothing,
            dataType : 'json',
            success : function(result) {
                if (result!=null) {
                    allProducts = result.allProducts;
                }
                else{
                    layer.alert('Error querying all products');
                }
            },
            error : function(resoult) {
                layer.alert('Error querying all products');
            }
        });
        allProducts = eval("("+allProducts+")");
        return allProducts;
    }

    function deleteUser(id) {
        var user = {};
        user.id = id;
        var deleteResult = "";
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/deleteUser',
            data : user,
            dataType : 'json',
            success : function(result) {
                deleteResult = result;
            },
            error : function(result) {
                layer.alert('Query user error');
            }
        });
        layer.msg(deleteResult.message);
        listAllUser()
    }

    function deleteProduct(id) {
        var product = {};
        product.id = id;
        var deleteResult = "";
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/deleteProduct',
            data : product,
            dataType : 'json',
            success : function(result) {
                deleteResult = result;
            },
            error : function(result) {
                layer.alert('Error deleting product');
            }
        });
        layer.msg(deleteResult.message);
        listAllProduct();
    }

    function addProduct() {
        var loadings = layer.load(0);
        var product = {};
        product.name = document.getElementById("productName").value;
        product.description = document.getElementById("productDescribe").value;
        product.keyWord = document.getElementById("keyWord").value;
        product.price = document.getElementById("productPrice").value;
        product.counts = document.getElementById("productCount").value;
        product.type = document.getElementById("productType").value;
        var addResult="";
        $.ajax({
            async : false,
            type : 'POST',
            url : '${cp}/addProduct',
            data : product,
            dataType : 'json',
            success : function(result) {
                addResult = result.result;
            },
            error : function(result) {
                layer.alert('Error deleting product');
            }
        });
        if(addResult == "success") {
            fileUpload();
            layer.msg('Item added successfully', {icon: 1, time: 1000});
            layer.close(loadings)
        }
        listAllProduct();
    }

    function fileUpload() {
        var results = "";
        var name = document.getElementById("productName").value;
        $.ajaxFileUpload({
            url:'${cp}/uploadFile?name='+name,
            secureuri:false ,
            fileElementId:'productImgUpload',
            type:'POST',
            dataType : 'text',
            success: function (result){
                result = result.replace(/<pre.*?>/g, '');  //ajaxFileUpload会对服务器响应回来的text内容加上<pre style="....">text</pre>前后缀
                result = result.replace(/<PRE.*?>/g, '');
                result = result.replace("<PRE>", '');
                result = result.replace("</PRE>", '');
                result = result.replace("<pre>", '');
                result = result.replace("</pre>", '');
                result = JSON.parse(result);
                results = result.result;
                if(results == "success") {
                    layer.msg("Picture uploaded successfully", {icon: 1});
                    window.location.href = "${cp}/control";
                    var imgPreSee = document.getElementById("imgPreSee");
                    var imgSrc = '${cp}/img/'+name+'.jpg';
                    imgPreSee.innerHTML +='<img src="'+imgSrc+')" class="col-sm-12 col-md-12 col-lg-12"/>';
                }
                else {
                    layer.msg("Picture uploaded fail", {icon: 0});
                }

            },
            error: function ()
            {
                layer.alert("Upload error");
            }}
        );
    }
</script>
</body>
</html>