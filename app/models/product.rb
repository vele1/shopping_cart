class Product < ActiveRecord::Base

  belongs_to :category
  has_one :image
  validates_presence_of :name, :category_id




  protected
    def validate
      errors.add(:price, "can must be numeric and not be 0.00") if price.nil? || price.to_f <= 0
    end 
end
