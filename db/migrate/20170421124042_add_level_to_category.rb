class AddLevelToCategory < ActiveRecord::Migration
  def change
  	add_column :categories, :level, :integer, :limit => 1, :default => 0
  end
end
