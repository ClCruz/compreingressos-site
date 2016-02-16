class OutrasLocalidade < ActiveRecord::Base
  validates_presence_of :home_id
  validates_uniqueness_of :home_id
  
  belongs_to :home
  
  has_many :espetaculos_outras_localidades, :order => "ordem ASC"
  has_many :espetaculos, :through => :espetaculos_outras_localidades, :order => "ordem ASC"
  #has_and_belongs_to_many :espetaculos
end
