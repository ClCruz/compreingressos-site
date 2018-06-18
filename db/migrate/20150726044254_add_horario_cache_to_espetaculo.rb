class AddHorarioCacheToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :horario_cache, :datetime
    # Also could be like this but to keep the migration intention that is change the DB at any time I decided update the timestamp on the model. :)
    #execute "ALTER TABLE orders ADD date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
  end

  def self.down
    remove_column :espetaculos, :horario_cache
  end
end
