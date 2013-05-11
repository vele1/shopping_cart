class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.column :product_id, :integer
      t.column :quantity, :integer
      t.column :unit_price, :float
      t.column :order_id, :integer
      t.column :status, :integer
    end
  end

  def self.down
    drop_table :line_items
  end
end
