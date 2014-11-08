package org.pichata.core

class Denuncia  implements Serializable{

    Long id
    String descripcion
    String direccion
    BigDecimal latitud
    BigDecimal longitud

	Date fechaDenuncia
	Date fechaRegistro = new Date()
	TipoBoolean activo = TipoBoolean.SI
	
	static belongsTo = [usuario: Usuario, clasificacion: Clasificacion]

    //static hasMany = [localizaciones: Localizacion]

	static mapping = {
        table('DAL.DENUNCIA')
        version(false)
        id(generator: "identity")
        usuario (column: 'ID_USUARIO')
        clasificacion(column: 'ID_CLASIFICACION')
    }

    static constraints = {    	
    	usuario(nullable: false)
    	fechaDenuncia(nullable: false)
    	fechaRegistro()
        activo()
    	descripcion validator: { descripcion, denuncia, errors ->
            if(descripcion == null || descripcion?.trim().size() == 0){
                errors.rejectValue("descripcion", 
                    "denuncia.descripcion.invalid", 
                    "La Descripción es obligatorio")
                return false
            }
            
            return true
        }
    }

    def beforeSave(){
    	descripcion = descripcion ?: ''
    	fechaDenuncia = fechaDenuncia ?: new Date()
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
