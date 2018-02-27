class AddOrigemToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :origem, :string
  end

  def self.down
    remove_column :espetaculos, :origem
  end
end
