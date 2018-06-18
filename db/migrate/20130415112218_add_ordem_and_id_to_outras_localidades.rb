class AddOrdemAndIdToEspetaculosOutrasLocalidades < ActivehomesRecord::Migration
  def self.up
    add_column :espetaculos_outras_localidades, :id, :primary_key
    add_column :espetaculos_outras_localidades, :ordem, :integer
  end

  def self.down
    remove_column :espetaculos_outras_localidades, :id
    remove_column :espetaculos_outras_localidades, :ordem
  end
end
#ALTER TABLE espetaculos_outras_localidades ADD id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
#ALTER TABLE espetaculos_outras_localidades ADD ordem INT(11);