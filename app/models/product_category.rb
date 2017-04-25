class ProductCategory < ActiveRecord::Base

	validates_uniqueness_of :product_id, :scope => :category_id
	validates :product_id, :category_id, presence: true

	belongs_to :product
	belongs_to :category

	rails_admin do
    list do
      field :product
      field :category
    end
    edit do
      field :product
      field :category
    end
  end

end
