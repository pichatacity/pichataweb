<%@ page import="org.pichata.security.SessionService" %>

<html>
<head>
    <!-- BASICS -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <meta name="description" content="">
    <title>Pichat City</title>
    <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="${resource(dir:'css',file:'bootstrap.min.css')}" rel="stylesheet">
    <!-- bootstrap theme -->
    <link href="${resource(dir:'css',file:'bootstrap-theme.css')}" rel="stylesheet">
    <!--external css-->
    <!-- font icon -->
    <link href="${resource(dir:'css',file:'elegant-icons-style.css')}" rel="stylesheet" />
    <link href="${resource(dir:'css',file:'font-awesome.min.css')}" rel="stylesheet" />
    <!-- full calendar css-->

    <link href="${resource(dir:'assets/fullcalendar',file:'fullcalendar/bootstrap-fullcalendar.css')}" rel="stylesheet" />
    <link href="${resource(dir:'assets/fullcalendar',file:'fullcalendar/fullcalendar.css')}" rel="stylesheet" />

    <!-- easy pie chart-->
    <link href="${resource(dir:'assets/jquery-easy-pie-chart',file:'jquery.easy-pie-chart.css')}" rel="stylesheet" type="text/css" media="screen"/>
    <!-- owl carousel -->
    <link rel="stylesheet" href="${resource(dir:'css',file:'owl.carousel.css')}" type="text/css">
    <link href="${resource(dir:'css',file:'jquery-jvectormap-1.2.2.css')}" rel="stylesheet">

    <!-- Custom styles -->
    <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}">
    <link href="${resource(dir:'css',file:'widgets.css')}" rel="stylesheet">
    <link href="${resource(dir:'css',file:'style.css')}" rel="stylesheet">
    <link href="${resource(dir:'css',file:'style-responsive.css')}" rel="stylesheet" />
    <link href="${resource(dir:'css',file:'xcharts.min.css')}" rel=" stylesheet">
    <link href="${resource(dir:'css',file:'jquery-ui-1.10.4.min.css')}" rel="stylesheet">
    <r:use modules="jquery,bootstrap, jquery-nicescroll, jquery-scrollTo" />
    <r:layoutResources />
    <g:layoutHead/>
</head>
<body>
    <!-- container section start -->
    <section id="container" class="">
        <header class="header dark-bg">
            <div class="toggle-nav">
                <div class="icon-reorder tooltips" data-original-title="Toggle Navigation" data-placement="bottom"></div>
            </div>

            <!--logo start-->
            <a href="index.html" class="logo">Pichat <span class="lite">City</span></a>

            <div class="nav search-row" id="top_menu">
                <!--  search form start -->
                <ul class="nav top-menu">
                    <li>
                        <form class="navbar-form">
                            <input class="form-control" placeholder="Search" type="text">
                        </form>
                    </li>
                </ul>
                <!--  search form end -->
            </div>
            <g:set var="usuarioIns" value="${SessionService.getInstancia().getUsuario()}"/>

            <pichataSec:isLoggedIn>

                <div class="top-nav notification-row">
                <!-- notificatoin dropdown start-->
                <ul class="nav pull-right top-menu">

                <!-- task notificatoin start -->
                <li id="task_notificatoin_bar" class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <i class="icon-task-l"></i>
                        <span class="badge bg-important">6</span>
                    </a>
                    <ul class="dropdown-menu extended tasks-bar">
                        <div class="notify-arrow notify-arrow-blue"></div>
                        <li>
                            <a href="#">
                                <div class="task-info">
                                    <div class="desc">Logo Designing</div>
                                    <div class="percent">78%</div>
                                </div>
                                <div class="progress progress-striped">
                                    <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="78" aria-valuemin="0" aria-valuemax="100" style="width: 78%">
                                        <span class="sr-only">78% Complete (danger)</span>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <div class="task-info">
                                    <div class="desc">Mobile App</div>
                                    <div class="percent">50%</div>
                                </div>
                                <div class="progress progress-striped active">
                                    <div class="progress-bar"  role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 50%">
                                        <span class="sr-only">50% Complete</span>
                                    </div>
                                </div>

                            </a>
                        </li>
                        <li class="external">
                            <a href="#">See All Tasks</a>
                        </li>
                    </ul>
                </li>
                <!-- task notificatoin end -->

                    <!-- user login dropdown start-->
                    <li class="dropdown">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="profile-ava">
                                <g:img uri="${usuarioIns.fotoPerfil}"/>
                            </span>
                            <span class="username">${usuarioIns.nombre}</span>
                            <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu extended logout">
                            <div class="log-arrow-up"></div>
                            <li class="eborder-top">
                                <a href="#"><i class="icon_profile"></i> Mi Perfil</a>
                            </li>
                            <li>
                                <a href="#"><i class="icon_clock_alt"></i> Timeline</a>
                            </li>
                            <li>
                                <g:link action="logout" controller="twitterLogin"><i class="icon_key_alt"></i> Salir</g:link>
                            </li>
                        </ul>
                    </li>
                <!-- user login dropdown end -->
                </ul>
                <!-- notificatoin dropdown end-->
                </div>
            </pichataSec:isLoggedIn>
        </header>

    <!--main content start-->
        <section id="main-content">
            <section class="wrapper">
                <g:layoutBody />
            </section>
        </section>
        <g:render template="/footer"/>
    </section>
    <!-- container section start -->
</body>
</html>