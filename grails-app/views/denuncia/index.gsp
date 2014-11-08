<html>
    <head>
        <title>Welcome to Pichata City</title>
        <meta name="layout" content="private" />
    </head>
    <body>
    <!-- container section start -->
    <section id="container" class="">
        <h1>listado de denuncias</h1>
        <g:link controller="denuncia" action="create">Denunciar Basura</g:link>
        <div class="row">
            <div class="col-lg-12">
                <h3 class="page-header"><i class="fa fa-table"></i> Table</h3>
                <ol class="breadcrumb">
                    <li><i class="fa fa-home"></i>
                        <g:link controller="portal" action="index">Inicio</g:link>
                    </li>
                    <li><i class="fa fa-table"></i>Table</li>
                    <li><i class="fa fa-th-list"></i>Basic Table</li>
                </ol>
            </div>
        </div>

        <!--main content start-->
        <section id="main-content">
            <section class="wrapper">
                <!--main content end-->
                <div class="row">
                    <div class="col-lg-12">
                        <section class="panel">
                            <header class="panel-heading">
                                Denuncias Realizadas
                            </header>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Fecha</th>
                                        <th>Denuncia</th>
                                        <th>Localización</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${denunciasList}" var="denunciaIns" status="i">
                                        <tr>
                                            <td>${i +1}</td>
                                            <td>${denunciaIns.fechaDenuncia.fd()}</td>
                                            <td>${denunciaIns.descripcion}</td>
                                            <td>${denunciaIns.nombreLugar}</td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </div>

                        </section>
                    </div>
                </div>
            </section>
        </section>
    </section>
    </body>
</html>