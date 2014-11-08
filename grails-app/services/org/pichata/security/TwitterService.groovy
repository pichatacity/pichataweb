package org.pichata.security

import twitter4j.Twitter
import twitter4j.TwitterFactory
import twitter4j.User
import twitter4j.auth.AccessToken
import twitter4j.auth.RequestToken

class TwitterService {

    static transactional = false
    static scope = 'session'

    Twitter twitter
    RequestToken requestToken

    def grailsApplication

    String authenticate(String returnUrl) {
        twitter = new TwitterFactory().getInstance()
        twitter.setOAuthConsumer(grailsApplication.config.consumerKey, grailsApplication.config.consumerSecret)
        requestToken = twitter.getOAuthRequestToken(returnUrl)

        return requestToken.getAuthenticationURL()
    }

    User verifyCredentials(String oauth_verifier) {
        AccessToken accessToken = twitter.getOAuthAccessToken(requestToken, oauth_verifier)
        
        return twitter.verifyCredentials()
    }
}