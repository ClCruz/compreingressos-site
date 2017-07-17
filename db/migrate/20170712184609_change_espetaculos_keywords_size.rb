class ChangeEspetaculosKeywordsSize < ActiveRecord::Migration
  def self.up
    change_column :espetaculos, :keywords, :string, :limit => 2000
  end

  def self.down
    change_column :espetaculos, :keywords, :string, :limit => 255
  end
end
