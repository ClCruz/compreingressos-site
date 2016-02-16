class Genero < ActiveRecord::Base
  validates_presence_of :nome
  
  has_many :espetaculos, :order => 'nome'
  #has_many :espetaculositaucard, :class_name => 'espetaculos'
  
end
