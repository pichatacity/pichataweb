
<!-- map -->
<section id="section-map" class="clearfix">
    <div id="map"></div>
</section>

 <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>
<!--
<script type="text/javascript"
      src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCRrbPQBE9q2ma7rwPErrHAMRSHvLWgREw&sensor=true">
</script>
-->

 <script type="text/javascript">
 	function success(position) {
		var coords = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
		  
		var mapOptions = {
		    zoom: 17,
		    center: coords,
		    mapTypeControl: false,
		    navigationControlOptions: {
		    	style: google.maps.NavigationControlStyle.SMALL
		    },
		    mapTypeId: google.maps.MapTypeId.ROADMAP
		};

		var mapElement = document.getElementById('map');
		var map = new google.maps.Map(mapElement, mapOptions);       

		var marker = new google.maps.Marker({
		    position: map.getCenter(),
		    map: map,
		    title:"You are here!",
            draggable: true
		});

        google.maps.event.addListener(marker, 'dragend', function(event){
            //placeMarker(event.LatLng);
            //console.log(event.latLng);
            console.log(marker.getPosition());
        });
	};

    var placeMarker = function (location){
        console.log(location);
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
</script>



%{--
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
                    //console.log(results[0].formatted_address);
                    $('#lugar').text(results[0].formatted_address);
                    $('#ubicacion').val(results[0].formatted_address);
                    /*
                     infowindow.setContent('<div id="info_window"><strong>Geolocation :</strong> <span id="geocodedAddress">' + results[0].formatted_address + '</span><br/><strong>Latitude :</strong> ' + Math.round(position.coords.latitude*1000000)/1000000 + ' | <strong>Longitude :</strong> ' + Math.round(position.coords.longitude*1000000)/1000000 + '<br/><br/><span id="altitude"><button type="button" class="btn btn-primary" onclick="getElevation()">Get Altitude</button></span>' + bookmark() + '</div>');
                     document.getElementById("latitude").value=position.coords.latitude;
                     document.getElementById("longitude").value=position.coords.longitude;
                     document.getElementById("address").value=results[0].formatted_address;
                     bookUp(results[0].formatted_address, position.coords.latitude, position.coords.longitude);
                     infowindow.open(map, marker);
                     */
                }
            } else {
                console.log('No resolved address');
                /*
                 infowindow.setContent('<div id="info_window"><strong>Geolocation :</strong> <span id="geocodedAddress">' + 'No resolved address' + '</span><br/><strong>Latitude :</strong> ' + Math.round(position.coords.latitude*1000000)/1000000 + ' | <strong>Longitude :</strong> ' + Math.round(position.coords.longitude*1000000)/1000000 + '<br/><br/><span id="altitude"><button type="button" class="btn btn-primary" onclick="getElevation()">Get Altitude</button></span>' + bookmark() + '</div>');
                 document.getElementById("latitude").value=position.coords.latitude;
                 document.getElementById("longitude").value=position.coords.longitude;
                 document.getElementById("address").value="No resolved address";
                 bookUp("No resolved address", position.coords.latitude, position.coords.longitude);
                 infowindow.open(map, marker);
                 */
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
                    //console.log('Calle/Avenida: ',results[0].address_components[0].long_name);
                    //console.log('Zona/Barrio: ',results[0].address_components[1].long_name);
                    //console.log('Ciudad: ',results[0].address_components[2].long_name);
                    //console.log('Departamento: ', results[0].address_components[3].long_name);
                    //console.log('Pais:', results[0].address_components[4].long_name);
                }
            } else {
                console.log('No resolved address');
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
        var mapElement = document.getElementById('map');
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
</div>--}%
