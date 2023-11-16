class AddPublicToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :blog_posts, :public, :boolean
  end
end
