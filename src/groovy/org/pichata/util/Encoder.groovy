package org.pichata.util

class Encoder {

    final static String passwordCompletion = "valem0-vRx28?m)zCl.1Qk0=cmP958!)c1n\$IOl2&Tz%"

    static String encode(String cadena) {
        //message.encodeAsSHA256()
        //(message + message.reverse() + 'valem0-vRx28?m)zCl.1Qk0=cmP958!)c1n$IOl2&Tz%').encodeAsSHA256()
        return cadena.bytes.encodeBase64().toString()
    }
    
    static String decode(String cadena) {
        return cadena.decodeBase64().toString()
    }

    static String encodePassword(String cadena) {
        return cadena.bytes.encodeBase64().toString()
        //return (cadena+cadena.reverse()+passwordCompletion).bytes.encodeBase64().toString()
    }

    static String decodePassword(String cadena) {
        return cadena.decodeBase64().toString()
        //def decoded = cadena.decodeBase64().toString()
        //return decoded.substring(0, decoded.indexOf(passwordCompletion))
    }

}