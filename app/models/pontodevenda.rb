class Pontodevenda < ActiveRecord::Base
  validates_presence_of :titulo,:texto,:cidade_id
  
  belongs_to :cidade
end
