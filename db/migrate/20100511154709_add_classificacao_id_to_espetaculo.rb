class AddClassificacaoIdToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :classificacao_id, :integer
  end

  def self.down
    remove_column :espetaculos, :classificacao_id
  end
end
