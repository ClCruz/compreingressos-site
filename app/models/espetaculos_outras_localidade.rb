class EspetaculosOutrasLocalidade < ActiveRecord::Base
  belongs_to :espetaculo
  belongs_to :outras_localidade
  
  before_create :seta_ordem
  
  private
  def seta_ordem
    obj = EspetaculosOutrasLocalidade.find(:all, :conditions => {:outras_localidade_id => self.outras_localidade_id}, :order => :ordem)
    if obj.size > 0
      self.ordem = obj.last.ordem+1
    else
      self.ordem = 0
    end
  end
end