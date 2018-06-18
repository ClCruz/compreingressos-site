class CreateTextos < ActiveRecord::Migration
  def self.up
    create_table :textos do |t|
      t.string :titulo
      t.string :subtitulo
      t.text :texto

      t.timestamps
    end
  end

  def self.down
    drop_table :textos
  end
end
