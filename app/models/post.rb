class Post < ApplicationRecord
  # has_one_attached :image
  mount_uploader :image, ImageUploader

  has_many :comments
  belongs_to :user
  validates :image, presence: true

  # def thumbnail
  #   return self.image.variant(resize: '600x600').processed
  # end

  def self.search(search)
    return Post.all unless search
    Post.where('text LIKE(?)', "%#{search}%")
  end
end
