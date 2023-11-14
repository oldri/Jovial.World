class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id] }

  enum status: { liked: 0, unliked: 1 }
end