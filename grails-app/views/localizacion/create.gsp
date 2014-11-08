
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Welcome to Pichata City</title>
    <meta name="layout" content="private" />
    <meta name="google-site-verification" content="J2oqHmYjzeBS0TNTdqPqXTzWdMdlY_FZTF3EmR__kfc" />
    <r:use modules="uiDatepicker" />
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('input[value="date.struct"]').uiDatepicker();

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(mostrarMapa, errors);
            } else {
                alert('Oops! Tu navegador no soporta geolocalización. Bájate Chrome, que es gratis!');
            }
        });
        var geocoder;
        var marker = null;
        var mapModal;

        function mostrarMapa(position) {
            var puntoInicial = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            $('#latitud').val(position.coords.latitude);
            $('#longitud').val(position.coords.longitude);

            //google.maps.visualRefresh = true;
            geocoder = new google.maps.Geocoder();
            geocoder.geocode({'latLng': puntoInicial}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[0]) {
                        $('#lugar').text(results[0].formatted_address);
                        $('#ubicacion').val(results[0].formatted_address);
                    }
                } else {
                    $('#lugar').text('No se pudo obtener la dirección');
                    $('#ubicacion').val('No se pudo obtener la dirección');
                }
            });
        };

        var placeMarker = function (location){
            //console.log(location);

            geocoder.geocode({'latLng': location}, function(results, status){
                //console.log(results[0]);
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[0]) {
                        //console.log(results[0].formatted_address);
                        $('#lugar').text(results[0].formatted_address);
                        $('#ubicacion').val(results[0].formatted_address);
                    }
                } else {
                    $('#lugar').text('No se pudo obtener la dirección');
                    $('#ubicacion').val('No se pudo obtener la dirección');
                }
            })
            $('#latitud').val(location.lat());
            $('#longitud').val(location.lng());
        };

        function errors (err) {
            if (err.code == 0) {
                alert("Oops! Algo ha salido mal");
            }
            if (err.code == 1) {
                alert("Oops! No has aceptado compartir tu posición");
            }
            if (err.code == 2) {
                alert("Oops! No se puede obtener la posición actual");
            }
            if (err.code == 3) {
                alert("Oops! Hemos superado el tiempo de espera");
            }
        };

        //--

        var ubicacionPunto = function(){
            var puntoInicial = new google.maps.LatLng($('#latitud').val(), $('#longitud').val());
            //google.maps.visualRefresh = true;
            var mapOptions = {
                zoom: 17,
                center: puntoInicial,
                mapTypeControl: false,
                navigationControlOptions: {
                    style: google.maps.NavigationControlStyle.SMALL
                },
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var mapElement = document.getElementById('mapaModalReciclaje');
            mapModal = new google.maps.Map(mapElement, mapOptions);


            //map.setCenter(puntoInicial);
            if (marker != null) marker.setMap(null);


            marker = new google.maps.Marker({
                position: puntoInicial,
                map: mapModal,
                title:"Tu estas aqui",
                draggable: true
            });

            google.maps.event.addListener(marker, 'dragend', function(event){
                placeMarker(marker.getPosition());
            });
            google.maps.event.addDomListener(window, "resize", resizingMap());

            $( "#myModal" ).dialog({
                height:'auto',
                width: '90%',
                resizable:false,
                modal:true,
                buttons: {
                    'Aceptar': function() {
                        //$(this).dialog('destroy');
                        $(this).dialog('close');
                    }
                }
            });
        };

        function resizingMap() {
            if(typeof mapModal =="undefined") return;
            var center = mapModal.getCenter();
            google.maps.event.trigger(mapModal, "resize");
            mapModal.setCenter(center);
        }
    </script>
</head>
<body>
<p>Hola mundo</p>
<g:form action="save" name="formDenuncia">
    <div class="row">
        <div class="col-12">
            <section class="panel">
                <header class="panel-heading">
                    Formulario de Denuncias
                </header>
                <div class="panel-body">
                    <div class="form">
                        <form class="form-validate form-horizontal" id="feedback_form" method="get" action="">
                            <div class="form-group">
                                <label class="control-label col-lg-2">Clasificación</label>
                                <div class="col-lg-10">
                                    <g:select class="form-control input-lg m-bot15"
                                              name="clasificación" from="${clasificacionList}"
                                              optionValue="nombre" optionKey="id">
                                    </g:select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="descripcion" class="control-label col-lg-2">Descripción<span class="required">*</span></label>
                                <div class="col-lg-10">
                                    <textarea class="form-control " id="descripcion" name="descripcion" required></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-2">Ubicación</label>
                                <div class="col-lg-10">
                                    <span id="lugar"></span>
                                    <g:hiddenField name="ubicacion" value="" />
                                    <g:hiddenField name="latitud" value="0" />
                                    <g:hiddenField name="longitud" value="0" />
                                    <a href="#" onclick="ubicacionPunto()">Cambiar</a>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fechaDenuncia" class="control-label col-lg-2">Fecha</label>
                                <div class="col-lg-10">
                                    <g:datePicker name="fechaDenuncia" value="${new Date()}" precision="day" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-10">
                                    <button class="btn btn-primary" type="submit">Enviar</button>
                                    <g:link controller="localizacion" class="btn btn-default" action="mapa">Cancelar</g:link>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
            </section>
        </div>
    </div>
</g:form>
<div id="myModal" style="display: none;">
    <div id="mapaModalReciclaje"></div>
</div>
</body>
</html>
