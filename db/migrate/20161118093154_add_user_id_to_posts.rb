class AddUserIdToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_column :issues, :user_id, :integer
  	add_index :issues, :user_id
  end
end
