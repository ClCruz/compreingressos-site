class PacotesEspetaculo < ActiveRecord::Base
  belongs_to :pacote
  belongs_to :espetaculo
  
  validates_presence_of :data
  validate :espetaculo_id_or_nome
  
  private
  
  def espetaculo_id_or_nome
    if self.espetaculo_id.blank? and self.nome_do_espetaculo.blank?
      errors.add(:espetaculo_id, "ou Nome do espetaculo deve ser preenchido")
    elsif !self.espetaculo_id.blank? and !self.nome_do_espetaculo.blank?
      errors.add(:espetaculo_id, "deve ser deixado em branco OU")
      errors.add(:nome_do_espetaculo, " deve ser deixado em branco")
    end
  end
end
