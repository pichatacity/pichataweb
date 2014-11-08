package org.pichata.util

/**
 * Created by YPFB Systems Development Team.
 *
 * @author : yrodriguez
 * @date   : Fri Jul 15 15:21:02 BOT 2011
 */
class StringService {

    static transactional = true

    static public String normalize(Integer numero, Integer digitos){
        return String.format("%0"+digitos.toString()+"d", numero)
/*
        String result = ""
        def base = Math.pow(10, digitos-1)
        while(base>numero){
            result+= 0
            base/= 10
        }
        result+= numero.toString()
        return result
*/
    }

}