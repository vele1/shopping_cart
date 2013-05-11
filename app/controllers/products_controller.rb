class ProductsController < ApplicationController
  # List categories
  def list
    @products = Product.find(:all)
  end

  def new
    @categories = Category.find(:all)
  end

  def create
    @categories = Category.find(:all)

    if params[:product]
      @product = Product.new(params[:product]) 
      # save the product.
      if @product.save
#        if params[:image]
#          @image = Image.new(params[:image])
#          @image.product = @product
#          @image.save
#        end

        respond_to do |format|
          format.js do
            responds_to_parent do
              render :update do |page|
                page.show "flash-notice"
                page.visual_effect :highlight, "flash-notice"
                page.replace_html "flash-notice", "#{@product.name} has been created succesfully"
                page.redirect_to :action => 'list'
              end
            end
          end
        end
      else
        respond_to do |format|
          format.js do
            responds_to_parent do
              render :update do |page|
                page.replace_html "form", :partial => "form"
              end
            end
          end
        end
        return
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.find(:all)
  end

  def update
    @categories = Category.find(:all)

    if params[:product]
      @product = Product.find(params[:id])
      # save the product.
      if @product.update_attributes(params[:product])
#        if params[:image]
#          @image = Image.new(params[:image])
#          @image.product = @product
#          @image.save
#        end

        respond_to do |format|
          format.js do
            responds_to_parent do
              render :update do |page|
                page.show "flash-notice"
                page.visual_effect :highlight, "flash-notice"
                page.replace_html "flash-notice", "#{@product.name} has been created succesfully"
                page.redirect_to :action => 'list'
              end
            end
          end
        end
      else
        respond_to do |format|
          format.js do
            responds_to_parent do
              render :update do |page|
                page.replace_html "form", :partial => "form"
              end
            end
          end
        end
        return
      end
    end

  end

  # Delete product.
  def delete
    @product = Product.find(params[:id])
    @product.destroy
    render :update do |page|
      page.show "flash-notice"
      page.visual_effect :highlight, "flash-notice"
      page.replace_html "flash-notice", "#{@product.name} has been deleted succesfully"
      page.redirect_to :action => 'list'
    end
  end

  def view
    @product = Product.find(params[:id])
  end
end