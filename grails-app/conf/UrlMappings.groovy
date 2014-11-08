class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		//"/"(view:"/index")
		"/"(controller:"portal", action: "index")
		//"/"(controller:"denuncia", action: "index")
		//"/"(controller:"twitterLogin", action: "index")
		"500"(view:'/error')
	}
}
