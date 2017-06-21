<%--
    Created by mingfei.net@gmail.com
    6/15/17 14:08
    https://github.com/thu/JavaEE_Library/
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script>
        $(function () {
            $('#username').blur(function () {
                $.ajax({
                    url: 'user',
                    data: {'action': 'isUsernameExist', 'username': $('#username').val()},
                    success: function (data) {
                        console.log(data);
                        if (data == 'true') {
                            $('span').text('用户名已经存在');
                        } else {
                            $('span').text('用户名可以使用');
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>
<h1>注册</h1>
<hr>
<form action="user" method="post">
    <input type="hidden" name="action" value="register">
    <input id="username" type="text" name="username" placeholder="用户名"><span></span><br>
    <input type="password" name="password" placeholder="密码"><br>
    <input type="submit" value="注册">
</form>
${requestScope.message}
</body>
</html>
