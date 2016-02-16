class Classificacao < ActiveRecord::Base
  validates_presence_of :nome,:texto,:icone
end
