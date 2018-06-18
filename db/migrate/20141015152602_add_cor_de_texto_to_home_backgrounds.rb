class AddCorDeTextoToHomeBackgrounds < ActiveRecord::Migration
  def self.up
    add_column :home_backgrounds, :cor_de_texto, :string
  end

  def self.down
    remove_column :home_backgrounds, :cor_de_texto
  end
end
