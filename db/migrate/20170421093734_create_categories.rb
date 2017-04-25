class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.string :name, :limit => 50
    	t.integer :parent, :limit => 2, :default => nil
      t.timestamps null: false
    end
  end
end
