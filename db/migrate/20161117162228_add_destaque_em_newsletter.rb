class AddDestaqueEmNewsletter < ActiveRecord::Migration
  def self.up
  	add_column :espetaculos, :destaque_newsletter, :boolean
  end

  def self.down
  	remove_column :espetaculos, :destaque_newsletter
  end
end
