class AddKeywordsToEspetaculo < ActiveRecord::Migration
  def self.up
    add_column :espetaculos, :keywords, :string
    add_column :espetaculos, :description, :string
  end

  def self.down
    remove_column :espetaculos, :description
    remove_column :espetaculos, :keywords
  end
end
