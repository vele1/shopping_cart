class Category < ActiveRecord::Base
  has_many :products
  
  # Validation
  validates_presence_of :name, :description
end
