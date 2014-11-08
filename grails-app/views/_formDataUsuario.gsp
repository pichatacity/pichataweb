<%@ page import="org.pichata.security.SessionService" %>
<g:set var="usuarioIns" value="${SessionService.getInstancia().getUsuario()}"/>
<pichataSec:isLoggedIn>
    <g:img uri="${usuarioIns.fotoPerfil}"/>
    <br />
    Bienvenido: <strong>${usuarioIns.nombre}</strong>
    - (@${usuarioIns.usuario})
    <br />
    <g:link action="logout" controller="twitterLogin">Salir</g:link>
</pichataSec:isLoggedIn>
