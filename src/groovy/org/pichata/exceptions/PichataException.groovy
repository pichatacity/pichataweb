
package org.pichata.exceptions

import org.codehaus.groovy.grails.exceptions.GrailsException
import org.codehaus.groovy.grails.exceptions.SourceCodeAware

/**
 * Exception class for PichataException exceptions in Grails Framework.
 *
 */
class PichataException extends GrailsException implements SourceCodeAware{

    private static final long serialVersionUID = -198308091715L;

    private String fileName;

    private Integer lineNumber = 0;

    public String getFileName() {
        return fileName;
    }

    public int getLineNumber() {
        return lineNumber;
    }

    public void setLocalizedMessage(String message){
        this.detailMessage = message
    }

    public void setMessage(String message){
        this.detailMessage = message
    }

    @Override
    public String getMessage() {
        if (fileName != null) {
            return super.getMessage() + " at " + fileName + ":" + lineNumber;
        }else{
            return super.getMessage();
        }
    }

    public void findSource(){
        def doCallE = stackTrace.find {it.methodName.equals('doCall')}
        fileName = doCallE.fileName
        lineNumber = doCallE.lineNumber
    }

    public PichataException(String message) {
        super(message);
        findSource()
    }

    public PichataException(Throwable cause) {
        super(cause);
        findSource()
    }

    public PichataException(String message, Throwable cause) {
        super(message, cause);
        findSource()
    }

}