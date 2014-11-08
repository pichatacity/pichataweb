package org.pichata.security

class ControlService {

    static transactional = false

    static scope = 'prototype'


    static public boolean isLoggedIn(){
        return SessionService.getInstancia()?.getUsuario()? true: false
    }

    static public boolean isNotLoggedIn(){
        return SessionService.getInstancia().equals(null) || SessionService.getInstancia().getUsuario().equals(null)
    }
    

}
