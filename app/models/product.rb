class Product < ActiveRecord::Base
	validates :name, :price, presence: true
	validates :name, uniqueness: true
	has_many :product_categories
  has_many :categories, through: :product_categories

	rails_admin do
    list do
      field :name
      field :description
      field :price do 
      	label 'Price (SGD)'
      end
    end
    edit do
      field :name
      field :description do
      	help 'Provide product description'
      end
      field :price do
        help 'Amount in SGD'
      end
    end
  end

end
