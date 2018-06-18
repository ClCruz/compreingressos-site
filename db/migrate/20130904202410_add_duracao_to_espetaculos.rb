class AddDuracaoToEspetaculos < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :duracao, :string
  end

  def self.down
    remove_column :espetaculos, :duracao
  end
end
