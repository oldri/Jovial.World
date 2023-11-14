class AddStatusToLikes < ActiveRecord::Migration[7.1]
  def change
    add_column :likes, :status, :integer
  end
end
