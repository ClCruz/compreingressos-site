class Estado < ActiveRecord::Base
	belongs_to :municipio
	has_many :pontosdevenda, :order => :local
end
