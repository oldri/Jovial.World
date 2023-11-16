class ChangeVisibilityToBeStringInBlogPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :blog_posts, :visibility, :string
  end
end