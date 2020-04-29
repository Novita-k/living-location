class Post < ApplicationRecord
  # has_one_attached :image
  mount_uploader :image, ImageUploader

  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes, source: :user
  belongs_to :user

  validates :image, presence: true
  geocoded_by :address
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def self.search(search)
    return Post.all unless search
    Post.where('text LIKE(?)', "%#{search}%")
  end

  def add_like(user)
    likes.create(user_id: user.id)
  end

  def del_like(user)
    likes.find(user_id: user.id).destroy
  end

  def like?(user)
    likes.include?(user)
  end
end
