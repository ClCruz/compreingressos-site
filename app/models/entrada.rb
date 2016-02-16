class Entrada < ActiveRecord::Base
  validates_presence_of :atributo,:valor
  
  belongs_to :asset, :polymorphic => true
end
