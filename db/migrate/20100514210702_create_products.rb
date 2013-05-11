class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.column :name, :string
      t.column :price, :float
      t.column :category_id, :integer
      t.column :description, :text
      t.column :product_code, :string
      t.column :available, :boolean, :default => true
    end
  end

  def self.down
    drop_table :products
  end
end
