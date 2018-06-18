module EspetaculosHelper

	def preserv_params
		@params = ""
	  	request.query_parameters.each do |key, value|
	      @params += "&" + u(key)  + "=" + u(value)
	  	end
	  	@params
	end
end
