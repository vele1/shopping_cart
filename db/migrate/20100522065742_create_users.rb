class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :title, :string
      t.column :firstname, :string
      t.column :lastname, :string
      t.column :email, :string
      t.column :password, :string
      t.column :address1, :string
      t.column :address2, :string
      t.column :address3, :string
      t.column :admin, :boolean, :default => false
    end

    # Add an admin user.
    u = User.new( :title => "Mr",
                  :firstname => 'Carel',
                  :lastname => 'van Royen',
                  :email => 'admin@shoppingcart.co.za',
                  :admin => true
                )
    u.password = 'admin'
    u.save
  end

  def self.down
    drop_table :users
  end
end
