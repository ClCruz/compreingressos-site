class CreateIntensivamedcontador < ActiveRecord::Migration
  def self.up
    create_table :intensivamedcontadors do |t|
      t.integer :total
    end
  end

  def self.down
    drop_table :intensivamedcontadors
  end
end
