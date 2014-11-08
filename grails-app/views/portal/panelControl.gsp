<html>
    <head>
        <title>Welcome to Pichata City</title>
        <meta name="layout" content="private" />
    </head>
<body>
<br><br>
   * <g:link controller="denuncia" action="create">Denunciar Basura</g:link>
   * <g:link controller="localizacion" action="mapa">Ver Mapas</g:link>
<br><br>
<div class="row">
    <div class="col-lg-12">
        <section class="panel">
            <header class="panel-heading tab-bg-info">
                <li class="active">
                    <a data-toggle="tab" href="#recent-activity">
                        <i class="icon-home"></i>
                        Actividad diaria
                    </a>
                </li>
            </header>
            <div class="panel-body">
                <div class="tab-content">
                    <div id="recent-activity" class="tab-pane active">
                        <div class="profile-activity">
                            <g:each in="${denunciasList}" var="denunciaIns" status="i">
                                <div class="act-time">
                                    <div class="activity-body act-in">
                                        <span class="arrow"></span>
                                        <div class="text">
                                            <a href="#" class="activity-img">
                                                <g:img uri="${denunciaIns.usuario.fotoPerfil}"/>
                                            </a>
                                            <p class="attribution">
                                                <a href="#">@${denunciaIns.usuario.usuario}</a> ${denunciaIns.fechaDenuncia.fd()}</p>
                                            <p>${denunciaIns.descripcion}</p>
                                        </div>
                                    </div>
                                </div>
                            </g:each>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

</body>
</html>