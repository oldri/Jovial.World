class AddLikeableToLikes < ActiveRecord::Migration[7.1]
  def change
    add_reference :likes, :likeable, polymorphic: true, index: true
  end
end
