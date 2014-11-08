<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <title>Welcome to Pichata City</title>
    <meta name="layout" content="main" />
<body>
 <section id="header" class="appear">  
<p style="color:red">${flash.message}</p>

<div>
    <g:if test="${session.user}">
        <img src="${session.user.fotoPerfil}">
        <br />
        Bienvenido: <strong>${session.user.nombre}</strong> - (@${session.user.usuario})
        <br />
        <g:link action="logout">Salir</g:link>
        <br />
        <g:link action="showTweet">Realizar reconocimiento</g:link>
    </g:if>
    <g:else>
        <g:link controller="twitterLogin" action="login">Signin with Twitter</g:link>
    </g:else>
</div>
</section>
</body>
</html>