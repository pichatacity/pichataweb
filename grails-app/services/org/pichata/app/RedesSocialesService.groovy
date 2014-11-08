package org.pichata.app

import twitter4j.GeoLocation
import twitter4j.Status
import twitter4j.StatusUpdate
import twitter4j.Twitter
import twitter4j.TwitterException
import twitter4j.TwitterFactory
import twitter4j.auth.AccessToken

class RedesSocialesService {
    //Definicion de variable par acceder a las configuraciones de la app
    def grailsApplication

    /**
     * Método que actualiza el estado en twitter
     * @param params
     * @return
     */
    def enviarTwitter(params) {
        def mensaje = params.mensaje.trim()

        def  twitterFactory = new TwitterFactory()
        Twitter twitter = twitterFactory.getInstance()

        twitter.setOAuthConsumer(grailsApplication.config.consumerKey, grailsApplication.config.consumerSecret)
        twitter.setOAuthAccessToken(new AccessToken(grailsApplication.config.accessToken, grailsApplication.config.accessTokenSecret))
        StatusUpdate statusUpdate = new StatusUpdate(mensaje)

        GeoLocation geoLocation = new GeoLocation()
        geoLocation.latitude = params.latitud.toBigDecimal()
        geoLocation.longitude = params.longitud.toBigDecimal()
        //double latitude, double longitude
        statusUpdate.location = geoLocation

        try {
            Status status = twitter.updateStatus(statusUpdate)
            //println "...status: " + status
        } catch (TwitterException e) {
            e.printStackTrace()
        }
    }
}
