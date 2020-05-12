class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :text, presence: true
  validates :text,
    length: { maximum:500, message: "入力は500文字までです。"}
end
