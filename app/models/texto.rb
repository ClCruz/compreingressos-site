class Texto < ActiveRecord::Base
  validates_presence_of :titulo,:texto
end
