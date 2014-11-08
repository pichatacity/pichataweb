package org.pichata.util

import org.pichata.security.ControlService

class SecTagLib {

	static namespace = "pichataSec"

 	def isLoggedIn = { attrs, body ->
        def content = ""
        if(ControlService.isLoggedIn()){
            content+= body()
        }
        out << content
    }

    def isNotLoggedIn = { attrs, body ->
        def content = ""
        if(ControlService.isNotLoggedIn()){
            content+= body()
        }
        out << content
    }
}
