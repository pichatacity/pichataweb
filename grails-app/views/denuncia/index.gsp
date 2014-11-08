<html>
    <head>
        <title>Welcome to Pichata City</title>
        <meta name="layout" content="private" />
    </head>
    <body>
    <!-- container section start -->
    <section id="container" class="">
        * <g:link controller="denuncia" action="create">Denunciar Basura</g:link>
        * <g:link controller="localizacion" action="mapa">Ver Mapas</g:link>
        <div class="row">
            <div class="col-lg-12">
                <ol class="breadcrumb">
                    <li><i class="fa fa-home"></i>
                        <g:link controller="portal" action="index">Inicio</g:link>
                    </li>
                    <li><i class="fa fa-table"></i>Mis Denuncias</li>
                </ol>
            </div>
        </div>

        <!--main content start-->
        <g:render template="/tagApp/timeLine"/>
    </section>
    </body>
</html>