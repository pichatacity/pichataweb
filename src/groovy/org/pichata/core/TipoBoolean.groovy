package org.pichata.core

public enum TipoBoolean {

    SI(true, 'Si'),
    NO(false, 'No')

    Boolean value
    String name

    static constraints = {
    }

    TipoBoolean(Boolean value, String name) {
        this.value = value
        this.name = name
    }

    static list = {
        return [SI, NO]
    }

    def TipoBoolean cambiar(){
        return value? TipoBoolean.NO: TipoBoolean.SI
    }

    static TipoBoolean enumObject(String str){
        return str.toString().toUpperCase()=="SI"? TipoBoolean.SI: TipoBoolean.NO
    }

}