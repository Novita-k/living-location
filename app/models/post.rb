class Post < ApplicationRecord
  # has_one_attached :image
  mount_uploader :image, ImageUploader
  mount_uploader :longitude, ImageUploader

  has_many :comments
  belongs_to :user
  validates :image, presence: true

  geocoded_by :address
  after_validation :geocode

  def self.search(search)
    return Post.all unless search
    Post.where('text LIKE(?)', "%#{search}%")
  end

  # def self.get_exif(post)
  #   require 'exifr/jpeg'
  #   exif = EXIFR::JPEG::new(post)
  #   longitude = exif.gps.longitude
  #   latitude = exif.gps.latitude
  #   binding.pry
  # end 
end
