module EspetaculosHelper

	def preserv_params
		@params = ""
  	request.query_parameters.each do |key, value|
      @params += "&" + key + "=" + value
  	end
  	@params
	end
end
