package org.pichata.app

import org.pichata.core.Clasificacion
import org.pichata.core.ClasificacionCodigo
import org.pichata.core.Denuncia
import org.pichata.core.Localizacion
import grails.converters.JSON
import org.pichata.security.SessionService

class LocalizacionController {

    def redesSocialesService
    def index() {
        redirect(action: 'mapa')
    }

    def mapa(){
        def clasificacionList = Clasificacion.list().sort{it.fechaRegistro}
        def mapaPuntosList = []
        def clasificacionIns = new Clasificacion()
        if(params.clasificacionId){
            clasificacionIns = Clasificacion.get(params.clasificacionId)
            mapaPuntosList = Localizacion.createCriteria().listDistinct {
                eq('clasificacion', clasificacionIns)
            }.collect {
                [
                    tipo          : it.clasificacion.nombre,
                    puntoDeInteres: it.nombre,
                    descripcion   : it.descripcion,
                    ubicacion     : it.direccion,
                    longitud      : it.longitud,
                    latitud       : it.latitud
                ]
            }
        }else{
            //Obtenemos todos los puntos de reciclaje
            mapaPuntosList = Localizacion.list().collect {
                [
                    tipo          : it.clasificacion.codigo,
                    puntoDeInteres: it.nombre,
                    descripcion   : it.descripcion,
                    ubicacion     : it.direccion,
                    longitud      : it.longitud,
                    latitud       : it.latitud
                ]
            }
        }

        return [clasificacionList: clasificacionList, clasificacionIns: clasificacionIns, mapaPuntosJSON: mapaPuntosList.encodeAsJSON()]
    }

    def obtenerMapa(){
        def pars= [clasificacionId: params.clasificacion]

        redirect(action: 'mapa', params: pars)
    }

    def create(){
        def clasificacionList = Clasificacion.list().sort{it.fechaRegistro}

        return [clasificacionList: clasificacionList]
    }
    def save(){
        println params
        def localizacionIns = new Localizacion()
        def clasificacionIns = Clasificacion.get(params.clasificacion)

        localizacionIns.clasificacion = clasificacionIns
        localizacionIns.nombre = params.nombre
        localizacionIns.descripcion = params.descripcion
        localizacionIns.direccion = params.direccion
        localizacionIns.longitud = params.longitud.toBigDecimal()
        localizacionIns.latitud = params.latitud.toBigDecimal()

        if(localizacionIns.validate() && localizacionIns.save()){
            def pars = [
                    mensaje :  "Se incorporo un nuevo punto de reciclaje ${localizacionIns.nombre}, en la siguiente dirección ${localizacionIns.direccion}",
                    longitud: localizacionIns.longitud,
                    latitud : localizacionIns.latitud
            ]
            redesSocialesService.enviarTwitter(pars)
            redirect(action: 'mapa')
            return
        }
        localizacionIns.errors.allErrors.each {
            println message(error: it)
        }
        def clasificacionList = Clasificacion.list().sort{it.fechaRegistro}

        render(view: 'index', model:[clasificacionList: clasificacionList])
        //fechaDenuncia_year:2014, fechaDenuncia_month:11, fechaDenuncia_datepicker:03/11/2014, latitud:-16.5044649, descripcion:Basura en al esquina boqueron, fechaDenuncia:Mon Nov 03 00:00:00 BOT 2014, longitud:-68.1421996, fechaDenuncia_day:3, action:save, controller:denuncia
    }

}
