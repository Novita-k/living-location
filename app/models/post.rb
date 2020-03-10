class Post < ApplicationRecord
  has_many :comments
  belongs_to :user
  validates :image, presence: true

  def self.search(search)
    return Tweet.all unless search
    Tweet.where('text LIKE(?)', "%#{search}%")
  end
end
