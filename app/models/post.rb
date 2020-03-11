class Post < ApplicationRecord
  has_many :comments
  belongs_to :user
  validates :image, presence: true

  def self.search(search)
    return Post.all unless search
    Post.where('text LIKE(?)', "%#{search}%")
  end
end
