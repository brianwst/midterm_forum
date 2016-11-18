class AddCategoryIdToIssues < ActiveRecord::Migration[5.0]
  def change
  	add_column :issues, :category_id, :integer
  	add_index :issues, :category_id
  end
end
