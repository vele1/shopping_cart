class Image < ActiveRecord::Base
  belongs_to :product

  

  validates_file_format_of :image, :in => ["gif", "jpg"]
  validates_filesize_of :image, :in => 1.kilobytes..5000.kilobytes

  file_column :picture,
#              :store_dir => "public/shopping_cart_images",
              :magick => {:versions => {
              :thumb => {:crop => "1:1",  :size => "86x87!", :name => "peq"},
              :normal => {:crop => "1:1", :size => "289x258!", :name=>"med"}
             }
  }

#  has_attachment :content_type => :image,
#                 :storage => :file_system, :path_prefix => 'public/shopping_cart_images',
#                 :resize_to => '500 x 400',
#                 :processor => 'Rmagick',
#                 :thumbnails => { :thumb => ['85 x 65']},
#                 :max_size => 3000.kilobytes
#
#  # Custome validattion
#  def validate
#    errors.add_to_base("You must choose a file to upload") unless self.filename
#
#    unless self.filename == nil
#
#      # Images should only be GIF, JPEG, or PNG
#      [:content_type].each do |attr_name|
#        enum = attachment_options[attr_name]
#        unless enum.nil? || enum.include?(send(attr_name))
#          errors.add_to_base("You can only upload a(GIF, JPEG, PNG or MsWord Document, please note Msword 2007 is currently not supported, please convert it to Msword 2003 or previous versions.)")
#        end
#      end
#
#      # Images should be less than 5 MB
#      [:size].each do |attr_name|
#        enum = attachment_options[attr_name]
#        unless enum.nil? || enum.include?(send(attr_name))
#          errors.add_to_base("Images should be smaller than 4 MB in size")
#        end
#      end
#    end
#  end
end
