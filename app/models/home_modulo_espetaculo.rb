class HomeModuloEspetaculo < ActiveRecord::Base
  belongs_to :home_modulo
  belongs_to :espetaculo
  
  before_create :definir_ordem
  
  def definir_ordem
    obj = HomeModuloEspetaculo.find(:last, :conditions => {:home_modulo_id => self.home_modulo_id}, :order => 'ordem')
    if obj
      self.ordem = obj.ordem+1
    else
      self.ordem = 0
    end
  end
end
