package org.pichata.app

import org.pichata.core.Denuncia
import org.pichata.core.TipoBoolean
import org.pichata.security.SessionService

class PortalController {

    def index() {
       //println " --usuario ${SessionService.getInstancia().getUsuario().nombre}"
        if(SessionService.getInstancia().getUsuario()){
           redirect(action:  'panelControl')
        }
    }

    def login(){
        /*
        if(SessionService.getInstancia().getUsuario()){
            println "redirecc al panel de control"
            redirect(action: "panelControl")
        }else{
            println " Login twitter"
            redirect(controller: 'twitterLogin', action: "login")
        }
        */
    }

    def panelControl(){
        def denunciasList = Denuncia.createCriteria().listDistinct {
            eq('activo', TipoBoolean.SI)
            order('fechaDenuncia', 'asc')
        }

        return [denunciasList: denunciasList]

    }
}
