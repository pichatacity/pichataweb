package org.pichata.core

class Clasificacion {

    Long id
    String nombre
    String codigo
	Date fechaRegistro = new Date()
	TipoBoolean activo = TipoBoolean.SI
	
	static mapping = {
        table('DAL.CLASIFICACION')
        version(false)
        id(generator: "identity")
    }

    static constraints = {
    	nombre(nullable: false)
        codigo(nullable: false)
    	fechaRegistro()
    }
}