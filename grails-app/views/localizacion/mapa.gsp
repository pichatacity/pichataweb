<%--
  Created by IntelliJ IDEA.
  User: rapaza
  Date: 7/11/14
  Time: 9:23
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Welcome to Clean Zone</title>
    <meta name="layout" content="private" />
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyASm3CwaK9qtcZEWYa-iQwHaGi3gcosAJc&sensor=false"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            mostrarMapa();
        });

        function mostrarMapa() {
            console.log('cargar mapa');

            //definimos el punto central en el mapa
            google.maps.visualRefresh = true;
            var puntoInicial = new google.maps.LatLng(-16,-68);

            var mapOptions = {
                zoom: 17,
                center: puntoInicial,
                mapTypeControl: false,
                navigationControlOptions: {
                    style: google.maps.NavigationControlStyle.SMALL
                },
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            //creamos el mapa
            var map = new google.maps.Map(document.getElementById("map-container"), mapOptions);

            //esto son los datos de los puntos de interes en JSON, que bien podría venir de un servicio Rest, una base de datos, o cualquier otro origen de datos.

            var data = ${mapaPuntosJSON} ;

            //Ahora recorremos los datos y uno a uno vamos estableciendo los puntos sobre el mapa.
            $.each(data, function (i, item) {
                console.log(item);
                var punto = new google.maps.LatLng(item.Long, item.Lat);

                var marker = new google.maps.Marker({
                    'position': punto,
                    'map': map,
                    'title': item.PuntoDeInteres
                });

                //ponemos los marcadores de diferentes colores según el tipo de punto turistico de que se trate.
                if (item.tipo == "PAPEL")
                    marker.setIcon('http://maps.google.com/mapfiles/ms/icons/blue-dot.png');
                else if (item.tipo == "BOTELLA")
                    marker.setIcon('http://maps.google.com/mapfiles/ms/icons/green-dot.png');
                else if (item.tipo == "VIDRIO")
                    marker.setIcon('http://maps.google.com/mapfiles/ms/icons/yellow-dot.png');
                else
                    marker.setIcon('http://maps.google.com/mapfiles/ms/icons/red-dot.png');


                //añadimos informacion adicional sobre el punto en question, que se nos mostrará al hacer click sobre este.
                var infowindow = new google.maps.InfoWindow({
                    content: "<div class='infoDiv'><h2>" + item.PuntoDeInteres + "</h2>" + "<h3>" + item.tipo + "</h3>" + "<div><h4> " + item.Descripcion + "</h4></div></div>"
                });

                google.maps.event.addListener(marker, 'click', function () {
                    infowindow.open(map, marker);
                });

            })
        }
    </script>
    <style>
        #map-container { height: 450px }
    </style>
</head>
<body>

<section id="main-content">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><i class="fa fa-home"></i>
                    <g:link controller="portal" action="index">Inicio</g:link>
                </li>
                <li><i class="fa fa-table"></i>Puntos de Reciclaje</li>
            </ol>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <section class="panel">
                <div class="panel-body">
                    <g:form action="obtenerMapa" class="form-inline" method="post" role="form">
                        <div class="form-group">
                            <label class="sr-only">Clasificación</label>
                            <g:select class="form-control input-m m-bot15"
                                      name="clasificacion" from="${clasificacionList}"
                                      noSelection="['': '--- TODOS ---']"
                                      value="${clasificacionIns.id}"
                                      optionValue="nombre" optionKey="id">
                            </g:select>

                        </div>
                        <div class="form-group">
                            <g:submitButton name="Cargar" class="btn btn-primary">Cargar</g:submitButton>
                        </div>
                        <div class="form-group">
                            <g:link controller="localizacion" action="create">Adicionar</g:link>
                        </div>
                    </g:form>
                </div>
                <div class="panel-body">
                    <div id="map-container"></div>
               </div>
            </section>
        </div>
    </div>
</body>
</html>