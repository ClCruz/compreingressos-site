class CreateHorarios < ActiveRecord::Migration
  def self.up
    create_table :horarios, :id => false, :force => true do |t|
      t.date :data
      t.references :espetaculo
    end
    add_index :horarios, [:data]
    add_index :horarios, [:espetaculo_id]
  end

  def self.down
    drop_table :horarios
  end
end
