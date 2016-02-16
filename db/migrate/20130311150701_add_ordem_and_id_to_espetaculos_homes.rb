class AddOrdemAndIdToEspetaculosHomes < ActiveRecord::Migration
  def self.up
    add_column :espetaculos_homes, :id, :primary_key
    add_column :espetaculos_homes, :ordem, :integer
  end

  def self.down
    remove_column :espetaculos_homes, :id
    remove_column :espetaculos_homes, :ordem
  end
end
#ALTER TABLE espetaculos_homes ADD id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
#ALTER TABLE espetaculos_homes ADD ordem INT(11);