class ProductsController < ApplicationController

  def index
    if params[:category].present?
      product_ids = get_all_product_ids(params[:category])
      @all_products = Product.where(id: product_ids)
      @selected_checkboxes = params[:category]
      @all_categories = Product.all.includes(:categories).map(&:categories).flatten.uniq
    else
      @all_products = Product.all.includes(:categories)
      @all_categories = @all_products.map(&:categories).flatten.uniq
    end
    @all_products = @all_products.paginate(:page => params[:page], :per_page => 10)
  end


  private

  #gets all the product ids of selected categories, their sub-categories and sub-sub-categories
  def get_all_product_ids(caregories)
    product_ids = []
    product_ids = Category.where(id: caregories).includes(:products).pluck(:product_id)
    subcategories = Category.where(parent: caregories).includes(:products)
    product_ids << subcategories.pluck(:product_id)
    subcategory_ids = subcategories.pluck(:id)
    product_ids << Category.where(parent: subcategory_ids).includes(:products).pluck(:product_id)
    product_ids.flatten.uniq
  end
end
