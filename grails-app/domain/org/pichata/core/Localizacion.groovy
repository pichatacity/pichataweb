package org.pichata.core

class Localizacion implements Serializable {

    Long id
    String nombre
    String detalle
    BigDecimal latitud
    BigDecimal longitud
	Date fechaRegistro = new Date()
	TipoBoolean activo = TipoBoolean.SI
	
	static belongsTo = [clasificacion: Clasificacion]

 	static mapping = {
        table('DAL.LOCALIZZACION')
        version(false)
        id(generator: "identity")
        clasificacion (column: 'ID_CLASIFICACION')
    }

    static constraints = {
    	clasificacion(nullable: false)
    	fechaRegistro()
    	nombre()
    	detalle()
    }
}