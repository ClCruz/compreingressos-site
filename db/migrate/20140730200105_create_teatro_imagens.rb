class CreateTeatroImagens < ActiveRecord::Migration
  def self.up
    create_table :teatro_imagens do |t|
      t.references :teatro
      t.integer :ordem
      t.timestamps
    end
  end

  def self.down
    drop_table :teatro_imagens
  end
end
