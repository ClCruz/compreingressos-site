class EspetaculosVisor < ActiveRecord::Base
  belongs_to :espetaculo
  belongs_to :visor
  
  before_create :seta_ordem
  
  private
  def seta_ordem
    obj = EspetaculosVisor.find(:all, :conditions => {:visor_id => self.visor_id}, :order => :ordem)
    if obj.size > 0
      self.ordem = obj.last.ordem+1
    else
      self.ordem = 0
    end
  end
end