class Post < ApplicationRecord
  # has_one_attached :image
  mount_uploader :image, ImageUploader

  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :user

  validates :image, presence: true
  validates :title,
    length: { maximum:20, message: "入力は20文字までです。"}
  validates :text,
    length: { maximum:500, message: "入力は500文字までです。"}

  geocoded_by :address
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def self.search(search)
    return Post.all unless search
    Post.where('text LIKE(?)', "%#{search}%")
  end
  
end
