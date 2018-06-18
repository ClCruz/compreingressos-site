class AddFieldsToEspetaculo < ActiveRecord::Migration
  def self.up
  	add_column :espetaculos, :texto_de_link_do_redirecionamento, :string
  	add_column :espetaculos, :link_do_redirecionamento, :string
  	add_column :espetaculos, :blank_de_link_do_redirecionamento, :boolean
  end

  def self.down
  	remove_column :espetaculos, :texto_de_link_do_redirecionamento
    remove_column :espetaculos, :link_do_redirecionamento
    remove_column :espetaculos, :blank_de_link_do_redirecionamento
  end
end
