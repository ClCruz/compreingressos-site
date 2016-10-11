class Pontodevenda < ActiveRecord::Base
  validates_presence_of :local,:endereco,:funcionamento,:estado_id
  
  belongs_to :estado
end
