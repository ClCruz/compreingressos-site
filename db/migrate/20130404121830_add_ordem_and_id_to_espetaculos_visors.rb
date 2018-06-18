class AddOrdemAndIdToEspetaculosVisors < ActivehomesRecord::Migration
  def self.up
    add_column :espetaculos_visors, :id, :primary_key
    add_column :espetaculos_visors, :ordem, :integer
  end

  def self.down
    remove_column :espetaculos_visors, :id
    remove_column :espetaculos_visors, :ordem
  end
end
#ALTER TABLE espetaculos_visors ADD id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
#ALTER TABLE espetaculos_visors ADD ordem INT(11);