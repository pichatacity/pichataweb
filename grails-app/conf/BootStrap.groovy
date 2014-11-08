import java.text.NumberFormat
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols

class BootStrap {

    def init = { servletContext ->
        Date.metaClass.toInit = {
            def c = Calendar.getInstance()
            c.set(Calendar.YEAR, delegate.year + 1900)
            c.set(Calendar.MONTH, delegate.month)
            c.set(Calendar.DATE, delegate.date)
            c.set(Calendar.HOUR_OF_DAY, 0)
            c.set(Calendar.MINUTE, 0)
            c.set(Calendar.SECOND, 0)
            c.set(Calendar.MILLISECOND, 0)
            c.getTime()
        }
        
        Date.metaClass.toEnd = {
            def c = Calendar.getInstance()
            c.set(Calendar.YEAR, delegate.year + 1900)
            c.set(Calendar.MONTH, delegate.month)
            c.set(Calendar.DATE, delegate.date)
            c.set(Calendar.HOUR_OF_DAY, 23)
            c.set(Calendar.MINUTE, 59)
            c.set(Calendar.SECOND, 59)
            c.set(Calendar.MILLISECOND, 999)
            c.getTime()
        }
        
        Date.metaClass.toMonthInit = {
            def c = Calendar.getInstance()
            c.set(Calendar.YEAR, delegate.year + 1900)
            c.set(Calendar.MONTH, delegate.month)
            c.set(Calendar.DATE, 1)
            c.getTime().toInit()
        }
        
        Date.metaClass.toMonthEnd = {
            def c = Calendar.getInstance()
            c.set(Calendar.YEAR, delegate.year + 1900)
            c.set(Calendar.MONTH, delegate.month + 1)
            c.set(Calendar.DATE, delegate.date - 1)
            c.getTime().toEnd()
        }
        //Inicio del Año
        Date.metaClass.toYearInit = {
            def c = Calendar.getInstance()
            c.set(Calendar.YEAR, delegate.year + 1900)
            c.set(Calendar.MONTH, 0)
            c.set(Calendar.DATE, 1)
            c.getTime().toInit()
        }
        //Fin del año
        Date.metaClass.toYearEnd = {
            def c = Calendar.getInstance()
            c.set(Calendar.YEAR, delegate.year + 1900)
            c.set(Calendar.MONTH, 11)
            c.set(Calendar.DATE, 31)
            c.getTime().toEnd()
        }

        String.metaClass.toDate = {
            try {
                def len = delegate.size()
                def format = len < 15 ? 'yyyy-MM-dd' :
                    len < 18 ? 'yyyy-MM-dd HH:mm' :
                    len < 22 ? 'yyyy-MM-dd HH:mm:ss' :
                    'yyyy-MM-dd HH:mm:ss SSS'
                return Date.parse(format, delegate)
            } catch (Exception e) {
                return null
            }
        }
        
        GString.metaClass.toDate = {
            try {
                def len = delegate.size()
                def format = len < 15 ? 'yyyy-MM-dd' :
                    len < 18 ? 'yyyy-MM-dd HH:mm' :
                    len < 22 ? 'yyyy-MM-dd HH:mm:ss' :
                    'yyyy-MM-dd HH:mm:ss SSS'
                return Date.parse(format, delegate)
            } catch (Exception e) {
                return null
            }
        }
        
        Date.metaClass.strDate = {
            return delegate.format('yyyy-MM-dd')
        }
        
        Date.metaClass.strDateTime = {
            return delegate.format('yyyy-MM-dd HH:mm:ss')
        }
        
        Date.metaClass.strTime = {
            return delegate.format('HH:mm:ss')
        }
        
        Date.metaClass.strDateTimeFull = {
            return delegate.format('yyyy-MM-dd HH:mm:ss SSS')
        }
        
        Date.metaClass.fd = { opcion ->
            def formato = 'dd/MM/yyyy'
            if (opcion) {
                formato = opcion == 'minute' ? 'dd/MM/yyyy HH:mm' :
                    opcion == 'second' ? 'dd/MM/yyyy HH:mm:ss' :
                    opcion == 'millisecond' ? 'dd/MM/yyyy HH:mm:ss SSS' :
                    opcion == 'month' ? 'MM/yyyy' :
                    opcion == 'year' ? 'yyyy' :
                    'dd/MM/yyyy'
            }
            return delegate.format(formato)
        }
        
        Object.metaClass.clazzName = {
            return delegate.class.name.toString().tokenize('.')[-1]
        }
        
        Object.metaClass.fullClazzName = {
            return delegate.class.name.toString()
        }
        
        String.metaClass.toNumeric = { decimals ->
            try {
                if (!decimals) {
                    decimals = 2
                }
                return delegate.replaceAll(',', '').toBigDecimal().setScale(decimals, BigDecimal.ROUND_HALF_UP)
            } catch (Exception e) {
                return 0.0
            }
        }
        
        GString.metaClass.toNumeric = { decimals ->
            try {
                if (!decimals) {
                    decimals = 2
                }
                return delegate.replaceAll(',', '').toBigDecimal().setScale(decimals, BigDecimal.ROUND_HALF_UP)
            } catch (Exception e) {
                return 0.0
            }
        }
        BigDecimal.metaClass.fd = { decimals ->
            if (!decimals) {
                decimals = 0
            }
            // recupera el numero
            NumberFormat formatter = new DecimalFormat("###,###,###,###,##0" + (decimals > 0 ? ".${'0' * decimals}" : ''))
            DecimalFormatSymbols symbols = new DecimalFormatSymbols()
            symbols.setGroupingSeparator(new Character((char)','))
            symbols.setDecimalSeparator(new Character((char)'.'))
            formatter.setDecimalFormatSymbols(symbols)
            formatter.format(delegate)
        }
        
        BigDecimal.metaClass.rd = { decimals ->
            if (!decimals) {
                decimals = 0
            }
            delegate.setScale(decimals, BigDecimal.ROUND_HALF_UP)
        }

		String.metaClass.encode = {
            return Encoder.encode(delegate)
        }
        
        GString.metaClass.encode = {
            return Encoder.encode(delegate)
        }

		String.metaClass.shorten = { length ->
		    if (!length) {
		        length = 30
		    }
		    def cadenaCorta = delegate.trim()
		    if (cadenaCorta.size() > length) {
		        def ultimoEspacio = cadenaCorta.substring(0, length).lastIndexOf(' ')
                cadenaCorta = cadenaCorta.substring(0, ultimoEspacio < 0 ? length : ultimoEspacio) 
            }
            cadenaCorta
        }
        
        GString.metaClass.shorten = { length ->
		    if (!length) {
		        length = 30
		    }
		    def cadenaCorta = delegate.trim()
		    if (cadenaCorta.size() > length) {
		        def ultimoEspacio = cadenaCorta.substring(0, length).lastIndexOf(' ')
                cadenaCorta = cadenaCorta.substring(0, ultimoEspacio < 0 ? length : ultimoEspacio) 
            }
            cadenaCorta
        }
        String.metaClass.toProper = {
            return delegate.toLowerCase().split(' ').collect { it.capitalize() }.join(' ')
        }
        
        GString.metaClass.toProper = {
            return delegate.toLowerCase().split(' ').collect { it.capitalize() }.join(' ')
        }
        
    }
    def destroy = {
    }
}
