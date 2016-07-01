module EspetaculosHelper

	def preserv_params
		@params = ""
	  	request.query_parameters.each do |key, value|
	      @params += "&" + sanitize(key)  + "=" + sanitize(value)
	  	end
	  	@params
	end
end
