package org.pichata.security
        
import twitter4j.Status
import twitter4j.StatusUpdate
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory
import twitter4j.User;
import twitter4j.auth.AccessToken;

import org.pichata.core.Usuario

class TwitterLoginController {

    def twitterService
    def grailsApplication

    def appName = grails.util.Metadata.current.'app.name'
    //TODO revisar la URL cuando se lleve a producción
    //def baseURL = Holders.config.grails.serverURL ?: "http://localhost:${System.getProperty('server.port', '8080')}/${appName}"
    
    def index() {
        if(SessionService.getInstancia().getUsuario()){
            
            redirect(controller: 'portal', action: "panelControl")
        }else{
             redirect(action: "login")
        }
    }

    def login = {
    	def baseURL =  "${grailsApplication.config.app.baseURL}/${appName}"
        redirect url: twitterService.authenticate("${baseURL}/twitterLogin/callback")
    }

    def callback = {
        if (params.denied) {
            flash.message = "Permiso denegado"

        } else {
            Usuario usuarioIns = checkTwitterUser(twitterService.verifyCredentials(params.oauth_verifier))

            SessionService.getInstancia().setUsuario(usuarioIns)

        }
        redirect(controller: 'denuncia', action: 'index')
        //redirect(controller: 'portal', action: 'index')
    }

    private checkTwitterUser(User twitterUser) {
        //println " ***** twitterUser.id: ${twitterUser.id}"
        Usuario usuarioIns = Usuario.findByTwitterId(twitterUser.id)

        if (!usuarioIns) {
            usuarioIns = new Usuario(twitterId: twitterUser.id)
        }

        usuarioIns.nombre = twitterUser.name
        usuarioIns.usuario = twitterUser.screenName
        usuarioIns.fotoPerfil = twitterUser.profileImageURL.toString()

        usuarioIns.save()
    }

    def logout = {
        session.invalidate()

        redirect(action: 'index')
    }

    def showTweet(){

    }

    def sendTweet(params){
        def texto = params.texto?.trim()
        TwitterFactory twitterFactory = new TwitterFactory()
        Twitter twitter = twitterFactory.getInstance()
        twitter.setOAuthConsumer(grailsApplication.config.consumerKey, grailsApplication.config.consumerSecret)
        twitter.setOAuthAccessToken(new AccessToken(grailsApplication.config.accessToken, grailsApplication.config.accessTokenSecret))
        StatusUpdate statusUpdate = new StatusUpdate(texto)

        try {
            Status status = twitter.updateStatus(statusUpdate)
            //println "...status: " + status
        } catch (TwitterException e) {
            e.printStackTrace()
        }

        //Se deberia redireccionar a un controlador
        redirect(action: 'index')
    }

    def sessionClean = {
        SessionService.getInstancia().setUsuario(null)
    }
}