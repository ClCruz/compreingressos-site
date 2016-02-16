class AddKeywordsToTeatro < ActiveRecord::Migration
  def self.up
    add_column :teatros, :keywords, :string
    add_column :teatros, :description, :string
    add_column :teatros, :ativo, :boolean
  end

  def self.down
    remove_column :teatros, :ativo
    remove_column :teatros, :description
    remove_column :teatros, :keywords
  end
end
