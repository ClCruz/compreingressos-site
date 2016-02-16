class CreatePontosdevenda < ActiveRecord::Migration
  def self.up
    create_table :pontosdevenda do |t|
      t.string :titulo
      t.text :texto

      t.timestamps
    end
  end

  def self.down
    drop_table :pontosdevenda
  end
end
