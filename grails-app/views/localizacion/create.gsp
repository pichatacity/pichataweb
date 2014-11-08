<html>
<head>
    <title>Welcome to Clean Zone</title>
    <meta name="layout" content="private" />
    <r:use modules="uiDatepicker" />
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
  <script src="http://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7/html5shiv.js"></script>
  <script src="http://cdnjs.cloudflare.com/ajax/libs/respond.js/1.3.0/respond.js"></script>
<![endif]-->
    <script type="text/javascript">
        $(document).ready(function() {
              if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(iniciarMapa, errors);
            } else {
                alert('Oops! Tu navegador no soporta geolocalización. Bájate Chrome, que es gratis!');
            }

        });
        var geocoder;

        function iniciarMapa(position) {
            var puntoInicial = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            $('#latitud').val(position.coords.latitude);
            $('#longitud').val(position.coords.longitude);

            //google.maps.visualRefresh = true;
            geocoder = new google.maps.Geocoder();
            definirUbicacion(puntoInicial);
            /*
             geocoder.geocode({'latLng': puntoInicial}, function(results, status) {
             if (status == google.maps.GeocoderStatus.OK) {
             if (results[0]) {
             $('#lugar').text(results[0].formatted_address);
             $('#direccion').val(results[0].formatted_address);
             }
             } else {
             $('#lugar').text('No se pudo obtener la dirección');
             $('#direccion').val('No se pudo obtener la dirección');
             }
             });*/
        };

        var definirUbicacion = function ($puntoInicial){
            geocoder.geocode({'latLng': $puntoInicial}, function(results, status){
                //console.log(results[0]);
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[0]) {
                        //console.log(results[0].formatted_address);
                        $('#lugar').text(results[0].formatted_address);
                        $('#direccion').val(results[0].formatted_address);
                    }
                } else {
                    $('#lugar').text('No se pudo obtener la dirección');
                    $('#direccion').val('No se pudo obtener la dirección');
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
    </script>
    <style>
    #map-container { height: 450px }
    </style>
</head>
<body>
<g:form action="save" name="formDenuncia">
    <div class="row">
        <div class="col-12">
            <section class="panel">
                <header class="panel-heading">
                    Formulario de REgistro Nuevo Punto de Reciclaje
                </header>
                <div class="panel-body">
                    <div class="form">
                        <g:form class="form-horizontal" id="feedback_form" method="post" action="save">
                            <div class="form-group">
                                <label class="control-label col-lg-2">Clasificación</label>
                                <div class="col-lg-10">
                                    <g:select class="form-control input-lg m-bot15"
                                              name="clasificacion" from="${clasificacionList}"
                                              optionValue="nombre" optionKey="id">
                                    </g:select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label for="nombre" class="control-label">Nombre<span class="required">*</span></label>
                                <div class="controls">
                                    <input type="text" value="" class="cp1 form-control" required="true" id="nombre" name="nombre">
                                </div>
                            </div>
                            <div class="control-group">
                                <label for="descripcion" class="control-label">Descripción<span class="required">*</span></label>
                                <div class="controls">
                                    <textarea class="form-control " id="descripcion" name="descripcion" required></textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Ubicación</label>
                                <div class="controls">
                                    <span id="lugar"></span>
                                    <g:hiddenField name="direccion" value="" />
                                    <g:hiddenField name="latitud" value="0" />
                                    <g:hiddenField name="longitud" value="0" />

                                    <a class="openmodal" href="#mapmodals" role="button" data-toggle="modal">
                                        Cambiar
                                    </a>
                                </div>
                            </div>
                            <div class="control-group">
                                <button class="btn btn-primary" type="submit">Enviar</button>
                                &nbsp;
                                <g:link controller="localizacion" action="mapa" class="btn btn-default">Cancelar</g:link>
                            </div>
                        </g:form>
                    </div>
                </div>
            </section>
        </div>
    </div>
</g:form>

<!-- Modals -->
<div class="modal fade" id="mapmodals">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="title_id"></h4>
            </div>
            <div class="modal-body">
                <div id="map-container"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="close" data-dismiss="modal">Cerrar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Include all compiled plugins (below), or include individual files as needed -->
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script>
    function mostrarMapa(latitud,longitud,titulo){
        var puntoInicial = new google.maps.LatLng(latitud, longitud);
        //var puntoInicial = new google.maps.LatLng(var_lati,var_long);
        /*
         var mapOptions = {
         zoom: 16,
         mapTypeControl: false,
         center:puntoInicial,
         panControl:false,
         rotateControl:false,
         streetViewControl: false,
         mapTypeId: google.maps.MapTypeId.ROADMAP
         };
         */
        var mapOptions = {
            zoom: 17,
            center: puntoInicial,
            mapTypeControl: false,
            navigationControlOptions: {
                style: google.maps.NavigationControlStyle.SMALL
            },
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var var_map = new google.maps.Map(document.getElementById("map-container"), mapOptions);

        var var_marker = new google.maps.Marker({
            position: puntoInicial,
            map: var_map,
            title:titulo,
            maxWidth: 200,
            maxHeight: 200
        });

        google.maps.event.addListener(var_marker, 'dragend', function(event){
            definirUbicacion(var_marker.getPosition());
        });

        $('#mapmodals').on('shown.bs.modal', function () {
            google.maps.event.trigger(var_map, "resize");
            var_map.setCenter(puntoInicial);
        });
    }
    $(document).on("click", ".openmodal", function () {
        //var puntoInicial = new google.maps.LatLng($('#latitud').val(), $('#longitud').val());
        mostrarMapa($('#latitud').val(), $('#longitud').val(),"Mi Ubicación Actual");

        $(".modal-header #title_id").html( 'Mi Ubicación Actual');
        $('#mapmodals').modal('show');
    });
</script>
</body>
</html>