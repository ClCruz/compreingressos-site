class AddFieldsToNewsletter < ActiveRecord::Migration
	def self.up
		add_column :newsletters, :data, :date
		add_column :newsletters, :texto_do_destaque, :string
		add_column :newsletters, :link_do_destaque, :string
    add_column :newsletters, :horario_do_destaque, :string
    add_column :newsletters, :img_destaque_file_name, :string
    add_column :newsletters, :img_destaque_content_type, :string
    add_column :newsletters, :img_destaque_file_size, :integer
    add_column :newsletters, :img_destaque_updated_at, :datetime
  end

  def self.down
  	remove_column :newsletters, :data
  	remove_column :newsletters, :texto_do_destaque
  	remove_column :newsletters, :link_do_destaque
    remove_column :newsletters, :horario_do_destaque
    remove_column :newsletters, :img_destaque_file_name
    remove_column :newsletters, :img_destaque_content_type
    remove_column :newsletters, :img_destaque_file_size
    remove_column :newsletters, :img_destaque_updated_at
  end
end
