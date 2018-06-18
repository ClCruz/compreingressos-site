class EspetaculosHome < ActiveRecord::Base
  belongs_to :espetaculo
  belongs_to :home
  
  before_create :seta_ordem
  
  private
  def seta_ordem
    obj = EspetaculosHome.find(:all, :conditions => {:home_id => self.home_id}, :order => :ordem)
    if obj.size > 0
      self.ordem = obj.last.ordem+1
    else
      self.ordem = 0
    end
  end
end