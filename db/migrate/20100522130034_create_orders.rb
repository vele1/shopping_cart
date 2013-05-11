class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.column :user_id, :integer
      t.column :order_date, :date
      t.column :status, :integer
      t.column :order_no, :string
      t.column :shipping_cost, :float
      t.column :pay_type, :string
    end
  end

  def self.down
    drop_table :orders
  end
end
