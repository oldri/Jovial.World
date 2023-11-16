class RenamePublicToVisibilityInBlogPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :blog_posts, :public, :visibility
  end
end
