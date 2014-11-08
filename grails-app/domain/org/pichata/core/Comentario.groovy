package org.pichata.core

class Comentario implements Serializable {

    Long id
    String comentarioDetalle	
	Date fechaComentario
	Date fechaRegistro = new Date()
	TipoBoolean activo = TipoBoolean.SI
	
	static belongsTo = [usuario: Usuario, denuncia: Denuncia]

 	static mapping = {
        table('DAL.COMENTARIO')
        version(false)
        id(generator: "identity")
        usuario (column: 'ID_USUARIO')
        denuncia (column: 'ID_DENUNCIA')
    }

    static constraints = {    	
    	usuario(nullable: false)
    	fechaComentario(nullable: false)
    	fechaRegistro()
    	comentarioDetalle validator: { comentarioDetalle, comentario, errors ->
            if(comentarioDetalle == null || comentarioDetalle?.trim().size() == 0){
                errors.rejectValue("comentarioDetalle", 
                    "comentario.comentarioDetalle.invalid", 
                    "El Comentario es obligatorio")
                return false
            }
            
            return true
        }
    }

    def beforeSave(){
    	comentarioDetalle = comentarioDetalle ?: ''
    	fechaComentario = fechaComentario ?: new Date()
    }

    def beforeInsert(){
        beforeSave()
    }

    def beforeUpdate(){
        beforeSave()
    }

    def beforeValidate(){
        beforeSave()
    }
}
