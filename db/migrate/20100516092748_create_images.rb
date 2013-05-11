class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.column :product_id,  :integer
      t.column :name, :string
      t.column :picture, :string
    end
  end

  def self.down
    drop_table :images
  end
end
