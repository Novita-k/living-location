class Post < ApplicationRecord
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :images, dependent: :destroy
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
    Post.where('text LIKE(?)', "%#{search}%")
  end
  
end
