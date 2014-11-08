modules = {

	'jquery' {
		resource url:'js/jquery.js'
	}

	'jquery-theme' {
        resource id:'theme',
            url: [dir: 'js/jquery/themes/turquoise', file: 'jquery-ui-1.10.3.custom.min.css'],
                attrs:[media:'screen, projection'], disposition: 'head'
    }
    'jquery-ui' {
        dependsOn 'jquery', 'jquery-theme'
        resource id:'js', url:[dir:'js/jquery/ui', file:"jquery-ui-1.10.3.custom.min.js"], nominify: true, disposition: 'head'

        //resource id:'i18n-datepicker', url: 'js/jquery/ui/i18n/jquery.ui.datepicker-es.js', disposition: 'head'
    }

    'uiDatepicker' {
        dependsOn 'jquery-ui'
        resource url: 'js/uiDatepicker.js', disposition: 'head', bundle: 'jq_datepicker'
    }

    'bootstrap' {
        dependsOn 'jquery'
        resource url: 'js/bootstrap.min.js', disposition: 'head'
    }

    'jquery-scrollTo' {
        dependsOn 'jquery'
        resource url: 'js/jquery.scrollTo.min.js', disposition: 'head', bundle: 'jq_datepicker'
    }

    'jquery-nicescroll'{
        dependsOn 'jquery'
        resource url: 'js/jquery.nicescroll.js', disposition: 'head', bundle: 'jq_datepicker'
    }
    /*'jquery-1-8'{
        dependsOn 'jquery'
        resource url: 'js/jquery-1.8.3.min.js'
    }*/
}

