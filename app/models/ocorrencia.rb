class Ocorrencia < ActiveRecord::Base
  belongs_to :espetaculo
  belongs_to :atendente
  
  validates_presence_of :atendente_id, :adquiridos,:data_compra,:numero_pedido,:nome,:email,:espetaculo_id
  validates_presence_of :data_ingressos,:horario,:lugares,:telefone,:tipo_solicitacao,:concordancia
  
  validates_numericality_of :numero_pedido,:inteira,:meia,:outros
 
  validate :solicitacao
  
  ADQUIRIDOS = ['Site','Call Center', 'Bilheteria']
  SOLICITACAO = ['Troca','Cancelamento']
  STATUS = ['Nova', 'Em Andamento']
  
  def solicitacao
    if tipo_solicitacao == 'Troca'
      errors.add(:nova_data, " não pode ser vazia!") if nova_data.blank?
      errors.add(:novo_horario, " não pode ser vazio!") if novo_horario.blank?
      errors.add(:novo_lugar, " não pode ser vazio!") if novo_lugar.blank?
      errors.add(:valor_servico, " não pode ser vazio!") if valor_servico.blank?
    end
    
    if tipo_solicitacao == 'Cancelamento'
      errors.add(:valor_estorno, " não pode ser vazio!") if valor_estorno.blank?
    end
  end
end
