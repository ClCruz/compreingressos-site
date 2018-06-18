class EventosRealizados < ActiveRecord::Base
  validates_presence_of :espetaculo_id, :temporada, :ordem
  belongs_to :espetaculo
end
