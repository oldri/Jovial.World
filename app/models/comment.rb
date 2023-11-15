class Comment < ApplicationRecord
  has_rich_text :content

  belongs_to :user
  belongs_to :blog_post
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true, length: { minimum: 5, maximum: 1000 }
end