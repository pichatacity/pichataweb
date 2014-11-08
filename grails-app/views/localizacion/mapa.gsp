<%--
  Created by IntelliJ IDEA.
  User: rapaza
  Date: 7/11/14
  Time: 9:23
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Welcome to Pichata City</title>
    <meta name="layout" content="main" />

    <script src="https://maps.googleapis.com/maps/api/js?sensor=false" type="text/javascript"></script>

</head>
<body>
<script type="text/javascript">
    $(document).ready(function () {
        mostrarMapa();
    });

    function mostrarMapa() {
        console.log('cargar mapa');

        //definimos el punto central en el mapa
        google.maps.visualRefresh = true;
        var puntoInicial = new google.maps.LatLng(37.388308, -5.995510);

        var mapOptions = {
            zoom: 14,
            center: puntoInicial,
            mapTypeId: google.maps.MapTypeId.G_NORMAL_MAP
        };
        //creamos el mapa
        var map = new google.maps.Map(document.getElementById("capa-mapa"), mapOptions);

        //esto son los datos de los puntos de interes en JSON, que bien podría venir de un servicio Rest, una base de datos, o cualquier otro origen de datos.
        var data = [
            { "Id": 1, "tipo": "Monumento", "PuntoDeInteres": "Torre del Oro", "Descripcion": "La Torre del Oro de Sevilla es una torre albarrana situada en el margen izquierdo del río Guadalquivir, junto a la plaza de toros de la Real Maestranza.", "Long": "37.382446", "Lat": "-5.996472" },
            { "Id": 2, "tipo": "Restaurante", "PuntoDeInteres": "La mia tana", "Descripcion": "Pizza, pasta y risotto en un restaurante italiano decorado con originales cuadros que se salen del lienzo", "Long": "37.390723", "Lat": "-5.991137" },
            { "Id": 3, "tipo": "Interes turistico", "PuntoDeInteres": "Plaza de España", "Descripcion": "La plaza de España de Sevilla es un gran espacio abierto monumental rodeado por un edificio semicircular de estilo regionalista.", "Long": "37.377059", "Lat": "-5.987319" },
            { "Id": 4, "tipo": "Monumento", "PuntoDeInteres": "Catedral de Sevilla", "Descripcion": "es la catedral gótica cristiana con mayor superficie del mundo. La Unesco la declaró en 1987, junto al Real Alcázar y el Archivo de Indias, Patrimonio de la Humanidad 2 y, el 25 de julio de 2010, Bien de Valor Universal Excepcional.", "Long": "37.385839", "Lat": "-5.993128" }
        ];

        /*
         var lineSymbol = {
         path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW
         };

         var lineCoordinates = [
         new google.maps.LatLng(37.382446, -5.996472),
         new google.maps.LatLng(37.385839, -5.993128)
         ];

         var line = new google.maps.Polyline({
         path: lineCoordinates,
         icons: [{
         icon: lineSymbol,
         offset: '100%'
         }],
         map: map
         });

         lineCoordinates = [
         new google.maps.LatLng(37.385839, -5.993128),
         new google.maps.LatLng(37.390723, -5.991137)
         ];

         line = new google.maps.Polyline({
         path: lineCoordinates,
         icons: [{
         icon: lineSymbol,
         offset: '100%'
         }],
         map: map
         });

         lineCoordinates = [
         new google.maps.LatLng(37.390723, -5.991137),
         new google.maps.LatLng(37.377059, -5.987319)

         ];

         line = new google.maps.Polyline({
         path: lineCoordinates,
         icons: [{
         icon: lineSymbol,
         offset: '100%'
         }],
         map: map
         });
         */

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
            if (item.tipo == "Monumento")
                marker.setIcon('http://maps.google.com/mapfiles/ms/icons/blue-dot.png');
            else if (item.tipo == "Restaurante")
                marker.setIcon('http://maps.google.com/mapfiles/ms/icons/green-dot.png');
            else if (item.tipo == "Interes turistico")
                marker.setIcon('http://maps.google.com/mapfiles/ms/icons/red-dot.png');
            else
                marker.setIcon('http://maps.google.com/mapfiles/ms/icons/yellow-dot.png')


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
<section id="main-content">
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
    <section class="wrapper">
        <section class="panel">
            <header class="panel-heading">
                <g:form action="obtenerMapa" class="form-horizontal" method="post">
                    <div class="form-group">
                        <label class="control-label col-lg-2">Clasificación</label>
                        <div class="col-lg-10">
                            <g:select class="form-control input-lg m-bot15"
                                      name="clasificación" from="${clasificacionList}"
                                      optionValue="nombre" optionKey="id">
                            </g:select>

                            <g:submitButton name="Cargar" class="btn btn-primary">Cargar</g:submitButton>
                        </div>
                    </div>
                </g:form>
                <g:link controller="localizacion" action="create">Adicionar</g:link>
            </header>
            <div class="panel-body">
                mapa aqui

            </div>
        </section>
    </section>
</section>
<div id="capa-mapa"></div>
</body>
</html>