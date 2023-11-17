class BlogPost < ApplicationRecord
  has_rich_text :content

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :visibility, presence: true

  scope :draft, -> { where(visibility: 'draft') } 
  scope :published, -> { where('published_at IS NOT NULL AND published_at <= ?', Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def draft?
    visibility == 'draft'
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end
end