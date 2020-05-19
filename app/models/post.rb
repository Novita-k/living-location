class Post < ApplicationRecord
  
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :user

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
    Post.joins(:user).where('text LIKE(?) OR title LIKE(?) OR address LIKE(?) OR nickname LIKE(?)', "%#{search}%","%#{search}%","%#{search}%","%#{search}%",)
  end
end
