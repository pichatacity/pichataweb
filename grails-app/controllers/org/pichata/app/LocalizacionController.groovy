package org.pichata.app

import org.pichata.core.Clasificacion

class LocalizacionController {

    def index() {
        redirect(action: 'mapa')
    }

    def mapa(){
        def clasificacionList = Clasificacion.list().sort{it.fechaRegistro}

        def mapaPuntosList = []
        if(clasificacionList.size() > 0){

        }

        return [clasificacionList: clasificacionList]
    }

    def obtenerMapa(){
        def pars= []

        redirect(action: 'mapa', params: pars)
    }

    def create(){
        def clasificacionList = Clasificacion.list().sort{it.fechaRegistro}

        return [clasificacionList: clasificacionList]
    }
}
