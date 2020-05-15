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
        <h1 class="title center">Register</h1>
        <br/>
        <div class="col-sm-offset-2 col-md-offest-2">

            <div  class="form-horizontal">
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 col-md-2 control-label">User name</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="inputUserName" placeholder="input data"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 col-md-2 control-label">Email</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="email" class="form-control" id="inputEmail" placeholder=""/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputNickname" class="col-sm-2 col-md-2 control-label">Nickname</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="inputNickname" placeholder="Nickname" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 col-md-2 control-label">Password</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="password" class="form-control" id="inputPassword" placeholder="Password" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPhoneNumber" class="col-sm-2 col-md-2 control-label">Phone number</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="inputPhoneNumber" placeholder="Phone number" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="man" class="col-sm-2 col-md-2 control-label">Gender</label>
                    <div class="col-sm-6 col-md-6">
                        <label class="radio-inline">
                            <input type="radio" id="man" value="option1"> male
                        </label>
                        <label class="radio-inline">
                            <input type="radio" id="woman" value="option2"> female
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="birthday" class="col-sm-2 col-md-2 control-label">Date of birth</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="birthday" placeholder="" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="postcodes" class="col-sm-2 col-md-2 control-label">Postcode</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="postcodes" placeholder="" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="address" class="col-sm-2 col-md-2 control-label">Address</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="address" placeholder="Address" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-6">
                        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="startRegister()">Register</button>
                    </div>
                </div>
            </div>
            <br/>
        </div>
    </div>


    <jsp:include page="include/foot.jsp"/>
    <script type="text/javascript">
        function startRegister() {
            var loading = layer.load(0);
            var user = {};
            user.userName = document.getElementById("inputUserName").value;
            user.email = document.getElementById("inputEmail").value;
            user.nickName = document.getElementById("inputNickname").value;
            user.password = document.getElementById("inputPassword").value;
            user.phoneNumber = document.getElementById("inputPhoneNumber").value;
            user.birthday = document.getElementById("birthday").value;
            user.postNumber = document.getElementById("postcodes").value;
            user.address = document.getElementById("address").value;
            user.sex = 0;
            if(document.getElementById("woman").checked)
                user.sex = 1;
            if(user.userName == ''){
                layer.msg('User name cannot be empty',{icon:2});
                return;
            }
            else if(user.userName.length >= 12){
                layer.msg('User name cannot be longer than 12 characters',{icon:2});
                return;
            }
            if(user.nickName == ''){
                layer.msg('Nickname cannot be empty',{icon:2});
                return;
            }
            else if(user.nickName.length >= 15){
                layer.msg('User name cannot be longer than 15 characters',{icon:2});
                return;
            }
            else if(user.password == ''){
                layer.msg('Password cannot be empty',{icon:2});
                return;
            }
            else if(user.password.length>= 20){
                layer.msg('Password cannot be longer than 20 characters',{icon:2});
                return;
            }
            var registerResult = null;
            $.ajax({
                async : false,
                type : 'POST',
                url : '${cp}/doRegister',
                data : user,
                dataType : 'json',
                success : function(result) {
                    registerResult = result.result;
                },
                error : function(result) {
                    layer.alert('Query user error');
                }
            });
            if(registerResult == 'success'){
                layer.close(loading);
                layer.msg('Success',{icon:1});
                window.location.href="${cp}/login";
            }
            else if(registerResult == 'nameExist'){
                layer.close(loading);
                layer.msg('This user name is already used！',{icon:2});
            }
            else if(registerResult == 'emailExist'){
                layer.close(loading);
                layer.msg('This user name has been registered！',{icon:2});
            }
            else if(registerResult == 'fail'){
                layer.close(loading);
                layer.msg('Server exception',{icon:2});
            }
        }
    </script>
  </body>
</html>