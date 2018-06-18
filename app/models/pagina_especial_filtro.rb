class PaginaEspecialFiltro < ActiveRecord::Base
  has_and_belongs_to_many :espetaculos

  validates_presence_of :nome
  validates_uniqueness_of :nome, :url
  validates_format_of :url, :with => /^[a-z\d-]+$/, :message => "só pode conter letras minúsculas e traços"
end
