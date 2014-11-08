package org.pichata.core

class Usuario implements Serializable{

    Long id
    Long twitterId
    String nombre
    String usuario
    String fotoPerfil
	
	Date fechaUltimoAcceso = new Date()

	static mapping = {
        table('DAL.USUARIO')
        version(false)
        id(generator: "identity")
    }

    static constraints = {
    	twitterId(nullable: false, unique: true)
    	nombre(nullable: false)
    	usuario(nullable: false, blank: false)
    	fotoPerfil(nullable: true)
    	fechaUltimoAcceso()
    }
}