<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Creative - Bootstrap 3 Responsive Admin Template">
    <meta name="author" content="GeeksLabs">
    <meta name="keyword" content="Creative, Dashboard, Admin, Template, Theme, Bootstrap, Responsive, Retina, Minimal">
    <link rel="shortcut icon" href="img/favicon.png">

    <title>Login Pichat City</title>

    <!-- Bootstrap CSS -->
    <link href="${resource(dir:'css',file:'bootstrap.min.css')}" rel="stylesheet">
    <!-- bootstrap theme -->
    <link href="${resource(dir:'css',file:'bootstrap-theme.css')}" rel="stylesheet">
    <!--external css-->
    <!-- font icon -->
    <link href="${resource(dir:'css',file:'elegant-icons-style.css')}" rel="stylesheet" />
    <link href="${resource(dir:'css',file:'font-awesome.min.css')}" rel="stylesheet" />


    <!-- Custom styles -->
    <link href="${resource(dir:'css',file:'style.css')}" rel="stylesheet">
    <link href="${resource(dir:'css',file:'style-responsive.css')}" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->

</head>

<body class="login-img3-body">

<div class="container">

    <form class="login-form" action="index.html">
        <div class="login-wrap">
            <p class="login-img"><i class="icon_lock_alt"></i></p>
 %{--           <div class="input-group">
                <span class="input-group-addon"><i class="icon_profile"></i></span>
                <input type="text" class="form-control" placeholder="Username" autofocus>
            </div>
            <div class="input-group">
                <span class="input-group-addon"><i class="icon_key_alt"></i></span>
                <input type="password" class="form-control" placeholder="Password">
            </div>
            <label class="checkbox">
                <input type="checkbox" value="remember-me"> Remember me
                <span class="pull-right"> <a href="#"> Forgot Password?</a></span>
            </label>
            <button class="btn btn-primary btn-lg btn-block" type="submit">Login</button>
            <button class="btn btn-info btn-lg btn-block" type="submit">Signup</button>--}%
         <g:link controller="twitterLogin" action="login" class="btn btn-info btn-lg btn-bloc">
             Signin with Twitter
         </g:link>

        </div>
    </form>

</div>


</body>
</html>

