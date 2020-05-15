<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>goods detail</title>
      <link rel="icon" href="./favicon.png" type="image/x-icon" />
      <link rel="shortcut icon" href="./favicon.png" type="image/x-icon" />
      <link rel="bookmark" href="./favicon.png" type="image/x-icon" />
      <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
      <link href="${cp}/css/style.css" rel="stylesheet">

      <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
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
            <div class="col-sm-1 col-md-1"></div>
            <div class="col-sm-10 col-md-10">
                <h1>${productDetail.name}</h1>
                <hr/>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-1 col-md-1"></div>
            <div class="col-sm-5 col-md-5">
                <img class="detail-img" src="${cp}/img/${productDetail.imgname}">
            </div>
            <div class="col-sm-5 col-md-5 detail-x">
                <table class="table table-striped">
                    <tr>
                        <th>Commodity name</th>
                        <td>${productDetail.name}</td>
                    </tr>
                    <tr>
                        <th>Price</th>
                        <td>${productDetail.price}</td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td>${productDetail.description}</td>
                    </tr>
                    <tr>
                        <th>Type</th>
                        <td>${productDetail.type}</td>
                    </tr>
                    <tr>
                        <th>Inventory</th>
                        <td>${productDetail.counts}</td>
                    </tr>
                    <tr>
                        <th>Quantity</th>
                        <td>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-default" onclick="subCounts()">-</button>
                                <button id="productCounts" type="button" class="btn btn-default">1</button>
                                <button type="button" class="btn btn-default" onclick="addCounts(1)">+</button>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="row">
                    <div class="col-sm-1 col-md-1 col-lg-1"></div>
                    <button class="btn btn-danger btn-lg col-sm-4 col-md-4 col-lg-4" onclick="addToShoppingCar(${productDetailId})">Add to Cart</button>
                    <div class="col-sm-2 col-md-2 col-lg-2"></div>
                    <button  class="btn btn-danger btn-lg col-sm-4 col-md-4 col-lg-4" onclick="buyConfirm(${productDetailId})">Purchase</button>

                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-1 col-md-1 col-lg-1"></div>
            <div class="col-sm-10 col-md-10 col-lg-10">
                <hr class="division"/>
                <table class="table evaluationTable" border="0" id="evaluation">
                </table>
                <hr/>
                <div id="inputArea"></div>
            </div>
            <div class = "hidden"> 
                        <c:if test="${empty currentUser}">
            	<input id="currentUserId" name="currentUserId" class="form-control"	type="text">
            </c:if>
            
             <c:if test="${not empty currentUser}">
         		<input id="currentUserId" name="currentUserId" value="${currentUser.id}" class="form-control"	type="text">
             </c:if>
            </div>
        </div>
    </div>

  <script type="text/javascript">
      listEvaluations();

      function addToShoppingCar(productId) {
          judgeIsLogin();
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          var shoppingCar = {};
          shoppingCar.userId = $("#currentUserId").val();
          shoppingCar.productId = productId;
          shoppingCar.counts = counts;
          var addResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/addShoppingCar',
              data : shoppingCar,
              dataType : 'json',
              success : function(result) {
                  addResult = result.result;
              },
              error : function(result) {
                  layer.alert('Query error');
              }
          });
          if(addResult == "success") {
              layer.confirm('go to cart？', {icon: 1, title:'add success',btn:['go to cart','continue']},
                      function(){
                          window.location.href = "${cp}/shopping_car";
                      },
                      function(index){
                        layer.close(index);}
              );
          }
      }

      function judgeIsLogin() {
    	  var currentUserId = $("#currentUserId").val();
          if(currentUserId == null || currentUserId === undefined || currentUserId ===""){
              window.location.href = "${cp}/login";
          }
      }

      function subCounts() {
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          if(counts>=2)
              counts--;
          productCounts.innerHTML = counts;
      }

      function addCounts() {
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          if(counts<${productDetail.counts}){
              counts++;
          }
          
          
          productCounts.innerHTML = counts;
      }

      function buyConfirm(productId) {
          judgeIsLogin();
          var address = getUserAddress($("#currentUserId").val());
          var phoneNumber = getUserPhoneNumber($("#currentUserId").val());
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          var product = getProductById(productId);
          var html = '<div class="col-sm-1 col-md-1 col-lg-1"></div>'+
                  '<div class="col-sm-10 col-md-10 col-lg-10">'+
                  '<table class="table confirm-margin">'+
                  '<tr>'+
                  '<th>Commodity name：</th>'+
                  '<td>'+product.name+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Price：</th>'+
                  '<td>'+product.price+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Quantity：</th>'+
                  '<td>'+counts+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Total Amount：</th>'+
                  '<td>'+counts*product.price+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>address：</th>'+
                  '<td>'+address+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Phone number：</th>'+
                  '<td>'+phoneNumber+'</td>'+
                  '</tr>'+
                  '</table>'+
                  '<div class="row">'+
                  '<div class="col-sm-4 col-md-4 col-lg-4"></div>'+
                  '<button class="btn btn-danger col-sm-4 col-md-4 col-lg-4" onclick="addToShoppingRecords('+productId+')">Confirm purchase</button>'+
                  '</div>'+
                  '</div>';
          layer.open({
              type:1,
              title:'Confirm order：',
              content:html,
              area:['650px','350px'],
          });
      }

      function getProductById(id) {
          var productResult = "";
          var product = {};
          product.id = id;
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/getProductById',
              data : product,
              dataType : 'json',
              success : function(result) {
                  productResult = result.result;
              },
              error : function(result) {
                  layer.alert('Query error');
              }
          });
          productResult = JSON.parse(productResult);
          return productResult;
      }

      function getUserAddress(id) {
          var address = "";
          var user = {};
          user.id = id;
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/getUserAddressAndPhoneNumber',
              data : user,
              dataType : 'json',
              success : function(result) {
                  address = result.address;
              },
              error : function(result) {
                  layer.alert('Query error');
              }
          });
          return address;
      }

      function getUserPhoneNumber(id) {
          var phoneNumber = "";
          var user = {};
          user.id = id;
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/getUserAddressAndPhoneNumber',
              data : user,
              dataType : 'json',
              success : function(result) {
                  phoneNumber = result.phoneNumber;
              },
              error : function(result) {
                  layer.alert('Query error');
              }
          });
          return phoneNumber;
      }

      function addToShoppingRecords(productId) {

    	  var currentUserId = $("#currentUserId").val();
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          var shoppingRecord = {};
          shoppingRecord.userId = currentUserId;
          shoppingRecord.productId = productId;
          shoppingRecord.counts = counts;
          var buyResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/addShoppingRecord',
              data : shoppingRecord,
              dataType : 'json',
              success : function(result) {
                  buyResult = result.result;
              },
              error : function(result) {
                  layer.alert('Purchase error');
              }
          });
          if(buyResult === "success") {
              layer.confirm('Go Order status？', {icon: 1, title:'Purchase Success',btn:['Go Order','continue Purchase']},
                      function(){
                          window.location.href = "${cp}/shopping_record";
                      },
                      function(index){
                          layer.close(index);}
              );
          }
          else if(buyResult === "unEnough"){
              layer.alert("Lack of inventory, failed to purchase")
          }
      }

      function listEvaluations() {
          var evaluations = getEvaluations();
          var evaluationTable = document.getElementById("evaluation");
          var html = "";
          for(var i=0;i<evaluations.length;i++){
              var user = getUserById(evaluations[i].userId);
              html+='<tr>'+
                      '<th>'+user.nickName+'</th>'+
                      '<td>'+evaluations[i].content+'</td>'+
                      '</tr>';
          }
          evaluationTable.innerHTML += html;

          if("${currentUser}"!=="" && getUserProductRecord() === "true"){
              var inputArea = document.getElementById("inputArea");
              html= '<div class="col-sm-12 col-md-12 col-lg-12">'+
                      '<textarea class="form-control" rows="4" id="evaluationText"></textarea>'+
                      '</div>'+
                      '<div class="col-sm-12 col-md-12 col-lg-12">'+
                      '<div class="col-sm-4 col-md-4 col-lg-4"></div>'+
                      '<button class="btn btn-primary btn-lg evaluationButton col-sm-4 col-md-4 col-lg-4" onclick="addToEvaluation()">evaluate</button>'+
                      '</div>';
              inputArea.innerHTML +=html;
          }

      }

      function getUserProductRecord() {
    	  
          var results = "";
          var product = {};
    	  var currentUserId = $("#currentUserId").val();
          product.userId = currentUserId;
          product.productId = ${productDetailId};
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/getUserProductRecord',
              data : product,
              dataType : 'json',
              success : function(result) {
                  results = result.result;
              },
              error : function(result) {
                  layer.alert('Query error');
              }
          });
          return results;
      }

      function getEvaluations() {
          var evaluations = "";
          var product = {};
          product.productId = "${productDetailId}";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/getShoppingEvaluations',
              data : product,
              dataType : 'json',
              success : function(result) {
                  evaluations = result.result;
              },
              error : function(result) {
                  layer.alert('Query error');
              }
          });
          evaluations = eval("("+evaluations+")");
          return evaluations;
      }

      function getUserById(id) {
          var userResult = "";
          var user = {};
          user.id = id;
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/getUserById',
              data : user,
              dataType : 'json',
              success : function(result) {
                  userResult = result.result;
              },
              error : function(result) {
                  layer.alert('Query error');
              }
          });
          userResult = JSON.parse(userResult);
          return userResult;
      }

      function addToEvaluation() {
    	  
          var inputText = document.getElementById("evaluationText").value;
          var evaluation = {};

    	  var currentUserId = $("#currentUserId").val();
          evaluation.userId = currentUserId;
          evaluation.productId = "${productDetailId}";
          evaluation.content = inputText;
          var addResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/addShoppingEvaluation',
              data : evaluation,
              dataType : 'json',
              success : function(result) {
                  addResult = result.result;
              },
              error : function(result) {
                  layer.alert('Query error');
              }
          });
          if(addResult = "success"){
              layer.msg("Evaluation of success",{icon:1});
              window.location.href = "${cp}/product_detail";
          }
      }

  </script>
  

    <jsp:include page="include/foot.jsp"/>
  </body>
</html>