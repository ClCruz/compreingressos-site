require 'digest/sha1'

class Admin < ActiveRecord::Base
  validates_presence_of :nome
  validates_uniqueness_of :nome
  attr_accessor :senha_confirmation 
  validates_confirmation_of :senha
  validate :password_non_blank
  
  def self.authenticate(name, password) 
    user = self.find_by_nome(name) 
    if user
      expected_password = encrypted_password(password, user.salt) 
      if user.hashed_password != expected_password
        user = nil 
      end
    end
  user
  end
  
  # 'senha' is a virtual attribute
  def senha 
    @senha
  end
  
  def senha=(pwd) 
    @senha = pwd 
    return if pwd.blank? 
    create_new_salt 
    self.hashed_password = Admin.encrypted_password(self.senha, self.salt)
  end
  
  def after_destroy 
    if Admin.count.zero?
      raise "Não é possível deletar o último administrador."
    end
  end
  
  
  private
  
  def password_non_blank 
    errors.add(:senha, "Senha não pode ser vazia!") if hashed_password.blank?
  end
  
  def create_new_salt 
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.encrypted_password(password, salt) 
    string_to_hash = password + "b1ack1otus" + salt 
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
end