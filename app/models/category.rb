class Category < ActiveRecord::Base
	validates :name, uniqueness: true
	# scope :sub_sub_categories, -> () {where(level:2)} 
	has_many :product_categories
	has_many :products, :through => :product_categories
	belongs_to :parent, class_name: Category.name, foreign_key: :parent_id
  has_many :sub_categories, foreign_key: :parent_id, class_name: Category.name

	before_save :define_level

	  rails_admin do
    list do
      field :name
      field :parent_id do
      	label 'Parent'
        formatted_value do
          Category.find_by_id(value).try :name
        end
      end
    end
    edit do
      field :name do
        required true
        help 'Choose a name'
      end

      field :parent_id, :enum do
        label :Parent
        enum do
          Category.parent_categories_enum
        end
        help 'Choose a parent'
      end
    end
  end


 #  def parent_name
 #  	parent.try(:name)
	# end

	# def has_parent?
	# 	parent.present?
	# end

	# def has_sub_categories?
	# 	sub_categories.exists?
	# end

	# def define_level
	# 	if self.has_parent?
	# 		self.level = self.parent.has_parent? ? 2 : 1
	# 	else
	# 		self.level = 0
	# 	end
	# end

  private

  def self.parent_categories_enum
    Category.where(level: [0,1]).inject([]) { |arr, category| arr << [category.name, category.id] }
  end

  def self.find_by_id(id)
  	categories_by_id[id]
  end

  def self.categories_by_id
  	Category.all.to_a.index_by(&:id)
  end


end
