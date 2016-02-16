class CreateServicos < ActiveRecord::Migration
  def self.up
    create_table :servicos do |t|
      t.string :titulo
      t.string :subtitulo
      t.text :texto

      t.timestamps
    end
  end

  def self.down
    drop_table :servicos
  end
end
