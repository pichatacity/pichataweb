package org.pichata.core

import groovy.sql.Sql
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.hibernate.engine.SessionImplementor
import org.hibernate.id.IdentifierGenerator
import org.pichata.exceptions.PichataException
import org.pichata.util.StringService
/**
 * Created by IntelliJ IDEA.
 * User: yrodriguez
 * Date: 09-08-11
 * Time: 03:24 PM
 */
class PrimaryKeyGenerator implements IdentifierGenerator{

    static final nInstance = 4

    static final nSequence = 12

    public Serializable generate(SessionImplementor session, Object object) throws PichataException{
        if(!object.mapping.mapping.tableName){
            throw new PichataException("You shoul be mapping the table with the string value for ID field")
        }
        if(object.pichataMapping){
            def pichataMapping = object.pichataMapping
            //TODO: verify if is a central or distributed class
            if(pichataMapping.seq){
                try{
                    return pkGeneratedFrom(pichataMapping.type, pichataMapping.seq)
                }catch (Exception e){
                    throw e
                }
            }else{
                throw new PichataException("Sequence for " + object.class.name + " is not defined in pichataMapping")
            }
        }else{
            throw new PichataException("pichataMapping for " + object.class.name + " is not defined")
        }
    }

    public String pkGeneratedFrom(String type, String sequenceName) throws PichataException{
        switch (type.toLowerCase()){
            case 'core':
                return StringService.normalize(InstanciaAplicacion.numeroCore, nInstance) +
                        generateFromSequence(sequenceName)
                break
            default:
                throw new PichataException('THE APPLICATION IS NOT CONFIGURED FOR GENERATE PKs TYPE : ' + type)
        }
    }

    public String generateFromSequence(String sequenceName){
        def dialect = ConfigurationHolder.config.dataSource.dialect.toString().toUpperCase()
        def driverClassName = ConfigurationHolder.config.dataSource.driverClassName.toString().toUpperCase()
        def connector = dialect?: driverClassName?: null
        if(connector.equals(null)){
            throw new PichataException('THE DATA SOURCE SHOULD BE DECLARED AS DIALECT OR DRIVER CLASS NAME')
        }
        def sql = new Sql(ApplicationHolder.application.mainContext.dataSource)
        def seqResult
        def nextVal
        if(connector.indexOf('POSTGRESQL') >= 0){
            seqResult = sql.firstRow("SELECT NEXTVAL('" + sequenceName + "')")
            nextVal = seqResult['nextval'].toInteger()
        }else if(connector.indexOf('ORACLE') >= 0){
            seqResult = sql.firstRow("SELECT " + sequenceName + ".NEXTVAL FROM DUAL")
            nextVal = seqResult['NEXTVAL'].toInteger()
        }else if(connector.indexOf('MYSQL') >= 0){
            //TODO: complete the pk assignation
            seqResult = sql.firstRow('SELECT ID FROM A TABLE ORDER BY ID DESC LIMIT 1')
            nextVal = seqResult['ID'].toInteger()
        }else{
            throw new PichataException('THE APPLICATION IS NOT CONFIGURED FOR A CONNECTOR TYPE : ' + connector)
        }
        return StringService.normalize(nextVal, nSequence)
    }

}