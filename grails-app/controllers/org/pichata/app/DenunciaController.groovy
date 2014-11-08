package org.pichata.app

import org.pichata.core.Clasificacion
import org.pichata.core.ClasificacionCodigo
import org.pichata.core.Denuncia
import org.pichata.core.TipoBoolean
import org.pichata.security.SessionService

class DenunciaController {

    def redesSocialesService

    def index() {
        if(!SessionService.getInstancia().getUsuario()){
            redirect(controller: 'portal', action:  'login')
        }

        def denunciasList = Denuncia.createCriteria().listDistinct {
            eq('activo', TipoBoolean.SI)
            order('fechaDenuncia', 'asc')
        }

        return [denunciasList: denunciasList]
    }

    def create (){
        if(!SessionService.getInstancia().getUsuario()){
            redirect(controller: 'portal', action:  'login')
        }

        def denunciasList = Denuncia.createCriteria().listDistinct {
            eq('activo', TipoBoolean.SI)
            order('fechaDenuncia', 'asc')
        }

        return [denunciasList: denunciasList]
    }

    def save(){
    	//println params
    	def denunciaIns = new Denuncia()
        def clasificacionIns = Clasificacion.findByCodigo(ClasificacionCodigo.BASURA)
        def usuarioIns = SessionService.getInstancia().getUsuario()

        println "Usuario: ${usuarioIns.usuario}"

        denunciaIns.descripcion = params.descripcion
    	denunciaIns.fechaDenuncia = params.fechaDenuncia
    	denunciaIns.usuario = usuarioIns
    	denunciaIns.clasificacion = clasificacionIns
        denunciaIns.longitud = params.longitud.toBigDecimal()
        denunciaIns.latitud = params.latitud.toBigDecimal()
        denunciaIns.nombreLugar = params.ubicacion

    	if(denunciaIns.validate() && denunciaIns.save()){
            def pars = [
                mensaje :  denunciaIns.descripcion,
                longitud: denunciaIns.longitud,
                latitud : denunciaIns.latitud
            ]
            redesSocialesService.enviarTwitter(pars)
    		redirect(action: 'index')
    		return
    	}
    	denunciaIns.errors.allErrors.each {
            println message(error: it)
        }

        render(view: 'index', model:[])
    	//fechaDenuncia_year:2014, fechaDenuncia_month:11, fechaDenuncia_datepicker:03/11/2014, latitud:-16.5044649, descripcion:Basura en al esquina boqueron, fechaDenuncia:Mon Nov 03 00:00:00 BOT 2014, longitud:-68.1421996, fechaDenuncia_day:3, action:save, controller:denuncia
    }
}
