class CreateCidadeVisores < ActiveRecord::Migration
  def self.up
    create_table :cidade_visores do |t|
      t.references :cidade
      t.string :link
      t.boolean :blank
      t.integer :ordem

      t.timestamps
    end
  end

  def self.down
    drop_table :cidade_visores
  end
end
