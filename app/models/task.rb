class Task < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 255 }
  validates :price, numericality: true, length: { maximum: 255 }
end
