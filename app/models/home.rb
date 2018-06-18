class Home < ActiveRecord::Base
  validates_presence_of :cidade_id
  validates_uniqueness_of :cidade_id

  belongs_to :cidade
  has_one :visor
  has_one :outras_localidade

  has_many :espetaculos_homes, :order => "ordem ASC"
  has_many :espetaculos, :through => :espetaculos_homes, :order => "ordem ASC"
  #has_and_belongs_to_many :espetaculos
  
  #accepts_nested_attributes_for :visor, :allow_destroy => true
end