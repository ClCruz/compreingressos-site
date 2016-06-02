class Municipio < ActiveRecord::Base
	has_one :estados
	belongs_to :espetaculo_ausentes
end
