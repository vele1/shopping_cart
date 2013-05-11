class CategoriesController < ApplicationController
  # List categories
  def index
    redirect_to :action => :list
  end
  
  def list
    @categories = Category.find(:all)
  end

  # Create a new category
  def create
    @category = Category.new(params[:category])
    # Save object in database.
    if @category.save
      flash[:notice] = "Category created successfully"
      render :update do |page|
        page.redirect_to :action => "list"
      end
    else
      render :update do |page|
        page.replace_html "new-category", :partial => "new"
      end
    end
  end

  # Show form tp update our product.
  def edit
    @category = Category.find(params[:id])
  end

  # Process the update of the product
  def update
    @category = Category.new(params[:id])
    # Save object in database.
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category updated successfully"
      render :update do |page|
        page.redirect_to :action => "list"
      end
    else
      render :update do |page|
        page.replace_html "edit-category", :partial => "new"
      end
    end
  end

end
