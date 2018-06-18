class AddBelongsToPontodevenda < ActiveRecord::Migration
  def self.up
    add_column :pontosdevenda, :cidade_id, :integer
  end

  def self.down
    remove_column :pontosdevenda, :cidade_id
  end
end
