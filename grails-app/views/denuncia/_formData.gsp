<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('input[value="date.struct"]').uiDatepicker();
    });
    var geocoder;
    var marker = null;
    var map;

    function success(position) {
        var coords = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        $('#latitud').val(position.coords.latitude);
        $('#longitud').val(position.coords.longitude);

        google.maps.visualRefresh = true;
        geocoder = new google.maps.Geocoder();
        geocoder.geocode({'latLng': coords}, function(results, status) {
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
        console.log(location);

        geocoder.geocode({'latLng': location}, function(results, status){
            console.log(results[0]);
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

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(success, errors);
    } else {
        alert('Oops! Tu navegador no soporta geolocalización. Bájate Chrome, que es gratis!');
    }

    //--

    var cambiarUbicacion = function(){
        // $('#myModal').modal('show')
        var coords = new google.maps.LatLng($('#latitud').val(), $('#longitud').val());
        google.maps.visualRefresh = true;
        var mapOptions = {
            zoom: 17,
            center: coords,
            mapTypeControl: false,
            navigationControlOptions: {
                style: google.maps.NavigationControlStyle.SMALL
            },
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var mapElement = document.getElementById('mapModal');
        map = new google.maps.Map(mapElement, mapOptions);


        //map.setCenter(coords);
        if (marker != null) marker.setMap(null);


        marker = new google.maps.Marker({
            position: coords,
            map: map,
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
            //position:['center',100],
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
        if(typeof map =="undefined") return;
        var center = map.getCenter();
        google.maps.event.trigger(map, "resize");
        map.setCenter(center);
    }
</script>

<div class="row">
    <div class="col-12">
        <section class="panel">
            <header class="panel-heading">
                Formulario de Denuncias
            </header>
            <div class="panel-body">
                <div class="form">
                    <form class="form-validate form-horizontal" id="feedback_form" method="get" action="">
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
                                <g:hiddenField name="ubicacion" value="" />
                                <g:hiddenField name="latitud" value="0" />
                                <g:hiddenField name="longitud" value="0" />
                                <a href="#" onclick="cambiarUbicacion()">Cambiar</a>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="fechaDenuncia" class="control-label">Fecha</label>
                            <div class="controls">
                                <g:datePicker name="fechaDenuncia" value="${new Date()}" precision="day" />
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <button class="btn btn-primary" type="submit">Enviar</button>
                                <g:link controller="denuncia" class="btn btn-default" action="index">Cancelar</g:link>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </section>
    </div>
</div>