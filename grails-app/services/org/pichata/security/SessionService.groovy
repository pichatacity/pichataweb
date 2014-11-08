package org.pichata.security

import javax.servlet.http.HttpSession
import org.springframework.web.context.request.RequestContextHolder

import org.pichata.core.Usuario


class SessionService {

    static transactional = false

    private static SessionService instancia = new SessionService();

    /**
     *
     * @return SessionService
     */
    static public SessionService getInstancia(){
        return instancia
    }

    public Object clone() throws CloneNotSupportedException {
        throw new CloneNotSupportedException();
    }

    private SessionService(){}

    /**
     * @return session
     */
    private HttpSession getSession() {
        return RequestContextHolder.currentRequestAttributes().getSession()
    }

    public void finalize(){
        getSession().finalize()
    }

    /**
     *
     * @return Usuario
     */
    final public Usuario getUsuario() {
        getSession().usuario
    }

    /**
     *
     * @param usuario Usuario
     */
    final public void setUsuario(Usuario usuario) {
        getSession().usuario = usuario
    }

  
    /**
     *
     * @return Date
     */
    final public Date getFechaSession() {
        getSession().fechaSession
    }
}