class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :post
  belongs_to :comment, optional: true

  validates :image, presence: true
end
