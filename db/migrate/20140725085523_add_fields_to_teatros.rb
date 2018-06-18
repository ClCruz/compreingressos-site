class AddFieldsToTeatros < ActiveRecord::Migration
  def self.up
    add_column :teatros, :cor_de_fundo, :string
    add_column :teatros, :altura_de_inicio, :integer
    add_column :teatros, :cor_do_texto, :string
    add_column :teatros, :cor_da_borda_dos_boxes, :string
    add_column :teatros, :cor_do_fundo_dos_boxes, :string
    add_column :teatros, :cor_do_texto_dos_boxes, :string
  end

  def self.down
    remove_column :teatros, :cor_do_texto_dos_boxes
    remove_column :teatros, :cor_do_fundo_dos_boxes
    remove_column :teatros, :cor_da_borda_dos_boxes
    remove_column :teatros, :cor_do_texto
    remove_column :teatros, :altura_de_inicio
    remove_column :teatros, :cor_de_fundo
  end
end
