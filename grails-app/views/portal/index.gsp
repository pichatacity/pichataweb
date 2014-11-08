<%--
  Created by IntelliJ IDEA.
  User: rapaza
  Date: 7/11/14
  Time: 9:11
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Welcome to Clean Zone</title>
    <meta name="layout" content="private" />
</head>
<body>
<section id="container" class="">
    * <g:link controller="denuncia" action="create">Denunciar Basura</g:link>
    * <g:link controller="localizacion" action="mapa">Ver Mapas</g:link>
    * <g:link controller="portal" action="login">Iniciar session</g:link>
</section>
    <g:render template="/tagApp/timeLine"/>
</body>
</html>