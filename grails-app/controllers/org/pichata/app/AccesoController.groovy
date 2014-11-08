package org.pichata.app

import org.pichata.core.Usuario

class AccesoController {
	def twitterService
    def grailsApplication

    def appName = grails.util.Metadata.current.'app.name'

    def index() { }

    def login = {
    	def baseURL =  "${grailsApplication.config.app.baseURL}/${appName}"
        redirect url: twitterService.authenticate("${baseURL}/acceso/callback")
    }

    def callback = {
        if (params.denied) {
            flash.message = "Permiso denegado"

        } else {
            Usuario usuarioIns = checkTwitterUser(twitterService.verifyCredentials(params.oauth_verifier))

            SessionService.getInstancia().setUsuario(usuarioIns)

        }
        redirect(controller: 'portal', action: 'index')
    }
}
