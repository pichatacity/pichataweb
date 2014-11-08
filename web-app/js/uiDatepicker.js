/* Inicialización en español para la extensión 'UI date picker' para jQuery. */
/* Traducido por Vester (xvester@gmail.com). */
jQuery(function($){
	$.datepicker.regional['es'] = {
		closeText: 'Cerrar',
		prevText: '&#x3c;Ant',
		nextText: 'Sig&#x3e;',
		currentText: 'Hoy',
		monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
		'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
		monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun',
		'Jul','Ago','Sep','Oct','Nov','Dic'],
		dayNames: ['Domingo','Lunes','Martes','Mi&eacute;rcoles','Jueves','Viernes','S&aacute;bado'],
		dayNamesShort: ['Dom','Lun','Mar','Mi&eacute;','Juv','Vie','S&aacute;b'],
		dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','S&aacute;'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['es']);
});

/**
 * Plugin para reemplazar los selects de seleccion de fecha por el datepicker
 * de jquery-ui, lo unico que hace es ocultar los selects(solo si son 3) y al
 * seleccionar o teclear una fecha por el datepicker actualiza estos selects
 * en esta primera versión las opciones del datepicker: defaultDate, dateFormat, 
 * onSelect, tienen un tratamiento especial que se detalla a continuación:
 *  - defaultDate => SE IGNORA: es la fecha seleccionada por defecto, y esta se toma
 *                   del datepicker generado de los selects
 *  - dateFormat => por defecto el formato de fecha es dd/mm/yy y se podría modificar
 *                  si se desea
 *  - onSelect => SE IGNORA EN PRIMERA INSTANCIA: ya que es el evento que tomamos para
 *                seleccionar la fecha en los selects, y cuando este evento termina llama
 *                al evento onSelect indicado en las opciones
 * realizado por Nardhar (nardhar.mure@gmail.com)
 */
(function( $ ){
    var methods = {
        init: function (options) {
            var settings = {
                // deberia hacer merge con las opciones del datepicker
                dateFormat: 'dd/mm/yy',
                preventKeystrokes: false,
            };
            if ( options ) {
                settings = $.extend( settings, options );
                if (settings['onSelect'] != null) {
                    settings['onSelect2'] = settings['onSelect'];
                    delete settings['onSelect'];
                }
            }
            this.data('uiDatepickerSettings', settings);
            var tempthis = this;
            return this.each(function() {
                var $input = $(this);
                var isinit = $input.data('uiDatepicker');
                if (!isinit) {
                    var name = $input.attr('name');
                    var $selects = $input.siblings('select[name^="'+name+'_"], span[class^="hm_sep"]');
                    
                    var $select_year = $input.siblings('select[name^="'+name+'_year"]');
                    var $select_month = $input.siblings('select[name^="'+name+'_month"]');
                    var $select_day = $input.siblings('select[name^="'+name+'_day"]');
                    var $select_hour = $input.siblings('select[name^="'+name+'_hour"]');
                    var $span_hm_sep = $input.siblings('span[class^="hm_sep"]');
                    var $select_minute = $input.siblings('select[name^="'+name+'_minute"]');
                    var valor = '';
                    
                    var value_year = $select_year.val();
                    var value_month = $select_month.val();
                    if (isNaN(parseInt(value_month))) {
                        value_month = 1;
                    }
                    var value_day = $select_day.val();
                    if (isNaN(parseInt(value_day))) {
                        value_day = 1;
                    }
                    
                    if ($select_day.length == 0) {
                        settings['dateFormat'] = 'mm/yy';
                        settings['monthNames'] = $.datepicker._defaults.monthNamesShort;
                    } else {
                        settings['dateFormat'] = 'dd/mm/yy';
                    }
                    
                    // fecha por defecto
                    if (!isNaN(parseInt(value_year)) && !isNaN(parseInt(value_month)) && !isNaN(parseInt(value_day))) {
                        var fecha = new Date(value_year, value_month - 1, value_day);
                        valor = $.datepicker.formatDate( settings.dateFormat, fecha );
                        settings['defaultDate'] = fecha;
                    }
                    // intervalo valido de fechas
                    settings['yearRange'] = $select_year.find('option[value!="null"]:first').val() + ':' + $select_year.find('option[value!="null"]:last').val();
                    if (settings.minDate == undefined) {
                        settings['minDate'] = new Date($select_year.find('option[value!="null"]:first').val(), 0, 1);
                    }
                    if (settings.maxDate == undefined) {
                        settings['maxDate'] = new Date($select_year.find('option[value!="null"]:last').val(), 11, 31);
                    }
                    
                    if ($select_day.length) {
                        var $picker = $('<input type="text" class="uiDatepicker span9" name="'+name+'_datepicker" value="'+valor +'" placeholder="dd/mm/aaaa" />');
                        var $container = $('<div class="input-append input-append-datepicker"></div>')
                        $container.append($picker);
                        var $buttonClick = $('<button class="btn" type="button"><i class="icon-calendar"></i></button>');
                        $container.append($buttonClick);
                        $input.before($container);
                        // evento de seleccion
                        settings['onSelect'] = function(dateText, inst) {
                            $select_year.val(inst.currentYear);
                            $select_month.val(inst.currentMonth + 1);
                            $select_day.val(inst.currentDay);
                            // e invoca el evento onSelect2 (si hubiera)
                            if (settings.onSelect2 != null) {
                                settings.onSelect2.call(this, dateText, inst);
                            }
                        }
                        $picker.datepicker(settings);
                        if (settings.preventKeystrokes) {
                            $picker.keypress(function() {
                                return false;
                            });
                        } else {
                            $picker.focusout(function() {
                                var fec = $picker.datepicker('getDate');
                                $select_year.val(fec.getFullYear());
                                $select_month.val(fec.getMonth() + 1);
                                $select_day.val(fec.getDate());
                            });
                        }
                        $select_year.hide();
                        $select_month.hide();
                        $select_day.hide();
                        // guarda un hidden
                        $input.data('uiDatepicker', true);
                        // y prepara que habra con el boton
                        $buttonClick.click(function() {
                            if ($picker.datepicker('widget').is(':visible')) {
                                $picker.datepicker('hide');
                            } else {
                                $picker.datepicker('show');
                            }
                            return false;
                        });
                    } else if ($select_month.length) {
                        // si no hay dia pero si mes renderea el monthpicker
                        var $picker = $('<input type="text" class="uiDatepicker span6" name="'+name+'_datepicker" value="'+valor +'" placeholder="mm/aaaa" />');
                        var $container = $('<div class="input-append"></div>')
                        $container.append($picker);
                        var $buttonClick = $('<button class="btn" type="button"><i class="icon-calendar"></i></button>');
                        $container.append($buttonClick);
                        $input.before($container);
                        settings['onSelect'] = function(dateText, inst) {
                            $select_year.val(inst.currentYear);
                            $select_month.val(inst.currentMonth + 1);
                            // e invoca el evento onSelect2 (si hubiera)
                            if (settings.onSelect2 != null) {
                                settings.onSelect2.call(this, dateText, inst);
                            }
                        }
                        $picker.monthpicker(settings);
                        if (settings.preventKeystrokes) {
                            $picker.keypress(function() {
                                return false;
                            });
                        } else {
                            $picker.focusout(function() {
                                var fec = $picker.monthpicker('getDate');
                                $select_year.val(fec.getFullYear());
                                $select_month.val(fec.getMonth() + 1);
                            });
                        }
                        $select_year.hide();
                        $select_month.hide();
                        // y prepara que habra con el boton
                        $buttonClick.click(function() {
                            if ($picker.monthpicker('widget').is(':visible')) {
                                $picker.monthpicker('hide');
                            } else {
                                $picker.monthpicker('show');
                            }
                            return false;
                        });
                    }
                    // para la hora
                    if ($select_minute.length) {
                        // crea un nuevo select de hora y minutos combinado siempre y cuando los minutos no sean mas detallados que 10
                        var $option_hours = $select_hour.find('option[value!="null"]');
                        var $option_minutes = $select_minute.find('option[value!="null"]');
                        var $select_hourminute = $('<select name="'+name+'_timepicker" class="span2"></select>');
                        // hora por defecto
                        var valor_hora = '00_00'
                        if (!isNaN(parseInt($select_hour.val())) && !isNaN(parseInt($select_minute.val()))) {
                            valor_hora = $select_hour.val() + '_' + $select_minute.val();
                        }
                        $option_hours.each(function(i, el) {
                            var hora = $(el).val();
                            $option_minutes.each(function(k, ele) {
                                var minuto = $(ele).val();
                                var selected_valor_hora = hora + '_' + minuto == valor_hora ? ' selected="selected"' : ''
                                $select_hourminute.append('<option value="'+hora + '_' + minuto+'"'+ selected_valor_hora +'>'+hora + ':' + minuto+'</option>');
                            });
                        });
                        $select_hourminute.change(function() {
                            var hm = $(this).val().split('_');
                            $select_hour.val(hm[0]);
                            $select_minute.val(hm[1]);
                        });
                        $input.before('&nbsp;');
                        $input.before($select_hourminute);
                        $select_year.hide();
                        $select_month.hide();
                        $select_day.hide();
                        $span_hm_sep.hide();
                        $select_hour.hide();
                        $select_minute.hide();
                    } else if ($select_hour.length) {
                        // complementa el select de hora con los minutos
                        $select_hour.attr('class', 'span2').find('option[value!="null"]').each(function(i, el) {
                            $(el).html($(el).html() + ':00');
                        });
                        $select_year.hide();
                        $select_month.hide();
                        $select_day.hide();
                        $span_hm_sep.hide();
                    }
                }
            });
        },
        destroy: function (options) {
            return this.each(function() {
                var $input = $(this);
                var $selects = $input.siblings('select[name^="'+name+'_"]');
                if ($selects.length > 2) {
                    var $picker = $input.siblings('input[name^="'+name+'_datepicker"]');
                    $picker.datepicker('destroy').remove();
                    $selects.show();
                }
            });
        },
        setValue: function(value, settings) {
            var settings = this.data('uiDatepickerSettings');
            var fecha = $.datepicker.parseDate(settings.dateFormat, value);
            return this.each(function(i, el) {
                var $input = $(el);
                var name = $input.attr('name');
                $input.next('select[name^="'+name+'_day"]').val(fecha.getDate());
                $input.next('select[name^="'+name+'_month"]').val(fecha.getMonth()+1);
                $input.next('select[name^="'+name+'_year"]').val(fecha.getYear()+1900);
                $.datepicker.formatDate( settings.dateFormat, fecha )
                $input.prev('.uiDatepicker').datepicker('setDate',value);
            });
        }
    }
    $.fn.uiDatepicker = function(method) {
        if ( methods[method] ) {
            return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
            return methods.init.apply( this, arguments );
        } else {
            $.error( 'Method ' +  method + ' does not exist on jQuery.uiDatepicker' );
        }
    };
})( jQuery );
