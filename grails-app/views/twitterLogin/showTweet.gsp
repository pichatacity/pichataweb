<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <title>Welcome to Pichata City</title>
    <meta name="layout" content="main" />
<body>
<p style="color:red">${flash.message}</p>
<div>
    <g:if test="${session.user}">
        <h1>Formulario</h1>
        <g:form name="tweet" action="sendTweet">
            <g:textArea name="texto" value="@renatoapaza ya esta :) #PichataCity" rows="5" cols="40"/>
            <g:submitButton name="enviar" value="Enviar Tweets" />
        </g:form>
    </g:if>
    <g:else>
        <g:link controller="twitterLogin" action="login">Signin with Twitter</g:link>
    </g:else>
</div>
</body>
</html>